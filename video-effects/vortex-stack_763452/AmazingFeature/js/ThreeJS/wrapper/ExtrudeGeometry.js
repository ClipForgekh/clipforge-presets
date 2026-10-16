/**
 * ExtrudeGeometry 类 - 将 2D Shape 挤出为 3D 几何体
 * 支持深度挤出和斜角（bevel）功能
 * 符合 Three.js ExtrudeGeometry 规范
 */

const { BufferGeometry } = require('./BufferGeometry');
const { BufferAttribute } = require('./BufferAttribute');
const { earcut } = require('./Earcut');
const { Vector2 } = require('./Vector2');
const { Vector3 } = require('./Vector3');
const { Box3 } = require('./Box3');

class ExtrudeGeometry extends BufferGeometry {
  constructor(shapes, options = {}) {
    super();

    this.type = 'ExtrudeGeometry';

    // 处理单个 shape 或 shape 数组
    const shapesArray = Array.isArray(shapes) ? shapes : [shapes];

    // 解析参数，使用 Three.js 标准默认值
    this.parameters = {
      shapes: shapes,
      options: options
    };

    const depth = options.depth !== undefined ? options.depth : 1;
    const steps = options.steps !== undefined ? options.steps : 1;
    const bevelEnabled = options.bevelEnabled !== undefined ? options.bevelEnabled : true;
    const bevelThickness = options.bevelThickness !== undefined ? options.bevelThickness : 0.2;
    const bevelSize = options.bevelSize !== undefined ? options.bevelSize : bevelThickness - 0.1;
    const bevelOffset = options.bevelOffset !== undefined ? options.bevelOffset : 0;
    const bevelSegments = options.bevelSegments !== undefined ? options.bevelSegments : 3;
    const curveSegments = options.curveSegments !== undefined ? options.curveSegments : 12;
    const extrudePath = options.extrudePath;
    const UVGenerator = options.UVGenerator;

    // 存储参数供后续使用
    this.depth = depth;
    this.steps = steps;
    this.bevelEnabled = bevelEnabled;
    this.bevelThickness = bevelThickness;
    this.bevelSize = bevelSize;
    this.bevelOffset = bevelOffset;
    this.bevelSegments = bevelSegments;
    this.curveSegments = curveSegments;

    // 顶点、索引、UV 数组
    const vertices = [];
    const indices = [];
    const uvs = [];
    const groups = [];

    // 处理每个 shape
    for (let s = 0; s < shapesArray.length; s++) {
      const shape = shapesArray[s];
      
      // 提取形状点
      const { shape: shapePoints, holes: holePoints } = shape.extractPoints(curveSegments);
      
      if (!shapePoints || shapePoints.length < 3) {
        console.warn('ExtrudeGeometry: 形状点数量不足');
        continue;
      }

      // 生成挤出几何体
      this.addShape(shape, shapePoints, holePoints, vertices, indices, uvs, groups, s);
    }

    // 创建 BufferAttribute
    if (vertices.length > 0) {
      this.setAttribute('position', new BufferAttribute(new Float32Array(vertices), 3));
      this.setAttribute('uv', new BufferAttribute(new Float32Array(uvs), 2));
      
      if (indices.length > 0) {
        this.setIndex(indices);
      }

      // 更新 AMG 对象
      this.updateAMGObject(vertices, indices, uvs);
    }

    // 存储组信息
    this.groups = groups;
  }

  /**
   * 添加一个形状到几何体
   */
  addShape(shape, shapePoints, holePoints, vertices, indices, uvs, groups, materialIndex) {
    const vertexOffset = vertices.length / 3;
    const groupStart = indices.length;

    // 三角化形状（用于前后面）
    const triangulationData = this.prepareTriangulationData(shapePoints, holePoints);
    if (!triangulationData) return;

    const { flatVertices, holeIndices, vertexCount } = triangulationData;
    const triangleIndices = earcut(flatVertices, holeIndices, 2);

    if (!triangleIndices || triangleIndices.length === 0) {
      console.warn('ExtrudeGeometry: 三角化失败');
      return;
    }

    // 计算边界框（用于 UV 映射）
    const bounds = this.calculateBounds(flatVertices);

    // 提取轮廓路径（用于侧面）
    const contour = shapePoints;
    const holes = holePoints || [];

    // 生成挤出几何体
    if (this.bevelEnabled) {
      this.buildWithBevel(contour, holes, flatVertices, triangleIndices, bounds, 
                          vertices, indices, uvs, vertexOffset);
    } else {
      this.buildWithoutBevel(contour, holes, flatVertices, triangleIndices, bounds, 
                             vertices, indices, uvs, vertexOffset);
    }

    // 添加组信息
    const groupCount = indices.length - groupStart;
    if (groupCount > 0) {
      groups.push({
        start: groupStart,
        count: groupCount,
        materialIndex: materialIndex
      });
    }
  }

  /**
   * 不带斜角的挤出
   */
  buildWithoutBevel(contour, holes, flatVertices, triangleIndices, bounds, 
                    vertices, indices, uvs, vertexOffset) {
    const depth = this.depth;
    const steps = this.steps;
    
    const allContours = [contour].concat(holes);
    let currentVertexOffset = vertexOffset;

    // 1. 生成前面（Z = 0）
    for (let i = 0; i < flatVertices.length / 2; i++) {
      const x = flatVertices[i * 2];
      const y = flatVertices[i * 2 + 1];
      vertices.push(x, y, 0);
      
      const u = (x - bounds.minX) / (bounds.maxX - bounds.minX);
      const v = (y - bounds.minY) / (bounds.maxY - bounds.minY);
      uvs.push(u, v);
    }

    // 前面三角形索引
    for (let i = 0; i < triangleIndices.length; i += 3) {
      // 注意顺序：逆时针为正面
      indices.push(
        currentVertexOffset + triangleIndices[i],
        currentVertexOffset + triangleIndices[i + 1],
        currentVertexOffset + triangleIndices[i + 2]
      );
    }

    currentVertexOffset += flatVertices.length / 2;

    // 2. 生成背面（Z = depth）
    for (let i = 0; i < flatVertices.length / 2; i++) {
      const x = flatVertices[i * 2];
      const y = flatVertices[i * 2 + 1];
      vertices.push(x, y, depth);
      
      const u = (x - bounds.minX) / (bounds.maxX - bounds.minX);
      const v = (y - bounds.minY) / (bounds.maxY - bounds.minY);
      uvs.push(u, v);
    }

    const backFaceOffset = currentVertexOffset;

    // 背面三角形索引（顺时针，因为是从背面看）
    for (let i = 0; i < triangleIndices.length; i += 3) {
      indices.push(
        backFaceOffset + triangleIndices[i + 2],
        backFaceOffset + triangleIndices[i + 1],
        backFaceOffset + triangleIndices[i]
      );
    }

    currentVertexOffset += flatVertices.length / 2;

    // 3. 生成侧面（连接前后面的轮廓）
    for (let c = 0; c < allContours.length; c++) {
      const pts = allContours[c];
      this.buildSideFaces(pts, depth, steps, vertices, indices, uvs, currentVertexOffset);
      currentVertexOffset += pts.length * (steps + 1);
    }
  }

  /**
   * 带斜角的挤出（完整实现，视觉效果优化）
   * 
   * 拓扑结构：
   * 前斜角层 (bevelSegments + 1 层) 
   *   ↓ 
   * 主体 (steps + 1 层)
   *   ↓
   * 后斜角层 (bevelSegments + 1 层)
   */
  buildWithBevel(contour, holes, flatVertices, triangleIndices, bounds, 
                 vertices, indices, uvs, vertexOffset) {
    const depth = this.depth;
    const steps = this.steps;
    const bevelThickness = this.bevelThickness;
    const bevelSize = this.bevelSize;
    const bevelSegments = this.bevelSegments;
    
    const allContours = [contour].concat(holes);
    let currentVertexOffset = vertexOffset;

    // 归一化 bevelSize，使其相对于形状大小
    const shapeWidth = bounds.maxX - bounds.minX;
    const shapeHeight = bounds.maxY - bounds.minY;
    const shapeSize = Math.max(shapeWidth, shapeHeight);
    const normalizedBevelSize = bevelSize / shapeSize;

    const verticesPerLayer = flatVertices.length / 2;
    const contourVertCount = contour.length;

    // === 阶段 1: 生成前斜角层顶点 ===
    const frontBevelStartOffset = currentVertexOffset;
    
    for (let b = 0; b <= bevelSegments; b++) {
      const t = b / bevelSegments;  // 0 → 1（从外到内）
      const z = -bevelThickness * (1 - t);  // 从 -bevelThickness → 0
      
      // 缩放: 最外层保持原始，向内层逐渐突出（符合 Three.js 标准）
      // 最外层(t=0): scale = 1.0, 内层(t=1): scale = 1 + bevelSize
      const smoothT = this.smoothBevelCurve(t);
      const scale = 1 + normalizedBevelSize * smoothT;
      
      this.buildBevelLayer(flatVertices, bounds, z, scale, vertices, uvs);
    }

    // 前斜角最外层面（第 0 层）
    for (let i = 0; i < triangleIndices.length; i += 3) {
      indices.push(
        frontBevelStartOffset + triangleIndices[i],
        frontBevelStartOffset + triangleIndices[i + 1],
        frontBevelStartOffset + triangleIndices[i + 2]
      );
    }

    currentVertexOffset += (bevelSegments + 1) * verticesPerLayer;

    // === 阶段 2: 生成主体顶点 ===
    const mainBodyStartOffset = currentVertexOffset;
    
    // 主体应用最大缩放（与斜角内层相同）
    const centerX = (bounds.minX + bounds.maxX) / 2;
    const centerY = (bounds.minY + bounds.maxY) / 2;
    const mainBodyScale = 1 + normalizedBevelSize;
    
    for (let step = 0; step <= steps; step++) {
      const t = step / steps;
      const z = t * depth;

      for (let i = 0; i < verticesPerLayer; i++) {
        const x = flatVertices[i * 2];
        const y = flatVertices[i * 2 + 1];
        
        // 应用缩放，使主体向外突出
        const scaledX = centerX + (x - centerX) * mainBodyScale;
        const scaledY = centerY + (y - centerY) * mainBodyScale;
        
        vertices.push(scaledX, scaledY, z);
        
        const u = (x - bounds.minX) / shapeWidth;
        const v = (y - bounds.minY) / shapeHeight;
        uvs.push(u, v);
      }
    }

    currentVertexOffset += (steps + 1) * verticesPerLayer;

    // === 阶段 3: 生成后斜角层顶点 ===
    const backBevelStartOffset = currentVertexOffset;
    
    for (let b = 0; b <= bevelSegments; b++) {
      const t = b / bevelSegments;  // 0 → 1（从内到外）
      const z = depth + bevelThickness * t;  // 从 depth → depth + bevelThickness
      
      // 缩放: 内层突出，向外层逐渐恢复原始（符合 Three.js 标准）
      // 内层(t=0): scale = 1 + bevelSize, 最外层(t=1): scale = 1.0
      const smoothT = this.smoothBevelCurve(t);
      const scale = 1 + normalizedBevelSize * (1 - smoothT);
      
      this.buildBevelLayer(flatVertices, bounds, z, scale, vertices, uvs);
    }

    // 后斜角最外层面（第 bevelSegments 层）
    for (let i = 0; i < triangleIndices.length; i += 3) {
      const layerOffset = backBevelStartOffset + bevelSegments * verticesPerLayer;
      indices.push(
        layerOffset + triangleIndices[i + 2],
        layerOffset + triangleIndices[i + 1],
        layerOffset + triangleIndices[i]
      );
    }

    currentVertexOffset += (bevelSegments + 1) * verticesPerLayer;

    // === 阶段 4: 生成轮廓侧面（使用独立顶点和正确的 UV）===
    
    // 计算所有层的 Z 坐标信息
    const allLayerInfo = [];
    
    // 前斜角层
    for (let b = 0; b <= bevelSegments; b++) {
      const t = b / bevelSegments;
      const z = -bevelThickness * (1 - t);
      allLayerInfo.push({ z: z, type: 'frontBevel', index: b });
    }
    
    // 主体层
    for (let step = 0; step <= steps; step++) {
      const t = step / steps;
      const z = t * depth;
      allLayerInfo.push({ z: z, type: 'main', index: step });
    }
    
    // 后斜角层
    for (let b = 0; b <= bevelSegments; b++) {
      const t = b / bevelSegments;
      const z = depth + bevelThickness * t;
      allLayerInfo.push({ z: z, type: 'backBevel', index: b });
    }
    
    // 为主轮廓生成侧面（使用独立顶点）
    const totalDepth = depth + 2 * bevelThickness;  // 总高度
    this.buildBevelSideFaces(
      contour, 
      allLayerInfo, 
      totalDepth,
      vertices, 
      indices, 
      uvs, 
      currentVertexOffset
    );
    currentVertexOffset += contour.length * allLayerInfo.length;

    // 注意：孔洞的侧面在这个简化实现中暂不处理
  }

  /**
   * 平滑斜角曲线函数
   * 使用 smoothstep 函数产生更自然的圆弧过渡
   * @param {number} t - 输入值 [0, 1]
   * @returns {number} - 平滑后的值 [0, 1]
   */
  smoothBevelCurve(t) {
    // Smoothstep: 3t² - 2t³
    return t * t * (3 - 2 * t);
  }

  /**
   * 为斜角挤出生成侧面（独立顶点，正确的 UV）
   * @param {Array} contour - 轮廓点数组
   * @param {Array} layerInfo - 所有层的 Z 坐标和缩放信息
   * @param {number} totalDepth - 总深度（包括斜角）
   * @param {Array} vertices - 输出顶点数组
   * @param {Array} indices - 输出索引数组
   * @param {Array} uvs - 输出 UV 数组
   * @param {number} startVertexOffset - 起始顶点偏移
   */
  buildBevelSideFaces(contour, layerInfo, totalDepth, vertices, indices, uvs, startVertexOffset) {
    // 计算轮廓总长度（用于 U 坐标）
    const contourLength = this.calculateContourLength(contour);
    
    // 获取形状中心（用于缩放）
    let minX = Infinity, maxX = -Infinity;
    let minY = Infinity, maxY = -Infinity;
    for (let i = 0; i < contour.length; i++) {
      if (contour[i].x < minX) minX = contour[i].x;
      if (contour[i].x > maxX) maxX = contour[i].x;
      if (contour[i].y < minY) minY = contour[i].y;
      if (contour[i].y > maxY) maxY = contour[i].y;
    }
    const centerX = (minX + maxX) / 2;
    const centerY = (minY + maxY) / 2;

    // 归一化 bevelSize
    const shapeWidth = maxX - minX;
    const shapeHeight = maxY - minY;
    const shapeSize = Math.max(shapeWidth, shapeHeight);
    const normalizedBevelSize = this.bevelSize / shapeSize;

    // 为每个深度层生成轮廓顶点（考虑斜角缩放）
    for (let layerIdx = 0; layerIdx < layerInfo.length; layerIdx++) {
      const layer = layerInfo[layerIdx];
      const z = layer.z;
      const vCoord = (z + this.bevelThickness) / totalDepth;  // V: 0 → 1

      // 计算此层的缩放比例（中间突出，两端保持原始）
      let scale = 1 + normalizedBevelSize;  // 主体层保持最大缩放
      
      if (layer.type === 'frontBevel') {
        const t = layer.index / this.bevelSegments;
        const smoothT = this.smoothBevelCurve(t);
        scale = 1 + normalizedBevelSize * smoothT;  // 从 1.0 到 1+bevelSize
      } else if (layer.type === 'backBevel') {
        const t = layer.index / this.bevelSegments;
        const smoothT = this.smoothBevelCurve(t);
        scale = 1 + normalizedBevelSize * (1 - smoothT);  // 从 1+bevelSize 到 1.0
      }

      let accumulatedLength = 0;
      for (let i = 0; i < contour.length; i++) {
        const pt = contour[i];
        
        // 应用缩放（与 buildBevelLayer 相同的逻辑）
        const scaledX = centerX + (pt.x - centerX) * scale;
        const scaledY = centerY + (pt.y - centerY) * scale;
        
        vertices.push(scaledX, scaledY, z);

        // UV: U = 沿轮廓的长度比例, V = 深度比例
        const uCoord = accumulatedLength / contourLength;
        uvs.push(uCoord, vCoord);

        // 计算到下一个点的距离（使用原始距离）
        if (i < contour.length - 1) {
          const nextPt = contour[i + 1];
          const dx = nextPt.x - pt.x;
          const dy = nextPt.y - pt.y;
          accumulatedLength += Math.sqrt(dx * dx + dy * dy);
        }
      }
    }

    // 生成侧面三角形索引
    const contourVertCount = contour.length;
    for (let layerIdx = 0; layerIdx < layerInfo.length - 1; layerIdx++) {
      for (let i = 0; i < contourVertCount; i++) {
        const current = startVertexOffset + layerIdx * contourVertCount + i;
        const next = startVertexOffset + layerIdx * contourVertCount + ((i + 1) % contourVertCount);
        const currentNext = startVertexOffset + (layerIdx + 1) * contourVertCount + i;
        const nextNext = startVertexOffset + (layerIdx + 1) * contourVertCount + ((i + 1) % contourVertCount);

        // 两个三角形组成一个四边形
        indices.push(current, next, currentNext);
        indices.push(next, nextNext, currentNext);
      }
    }
  }

  /**
   * 构建两层之间的轮廓侧面（已废弃 - 不生成独立 UV）
   * 
   * ⚠️ 此方法重用现有顶点，导致侧面 UV 错误
   * 已被 buildBevelSideFaces 替代
   * 
   * @deprecated 使用 buildBevelSideFaces 替代
   */
  buildLayerSideFaces(contourVertCount, layer1Offset, layer2Offset, indices) {
    for (let i = 0; i < contourVertCount; i++) {
      const i1 = i;
      const i2 = (i + 1) % contourVertCount;

      const v1 = layer1Offset + i1;
      const v2 = layer1Offset + i2;
      const v3 = layer2Offset + i1;
      const v4 = layer2Offset + i2;

      indices.push(v1, v2, v3);
      indices.push(v2, v4, v3);
    }
  }

  /**
   * 构建斜角层
   * @param {Array} flatVertices - 扁平顶点数组 [x0, y0, x1, y1, ...]
   * @param {Object} bounds - 边界框 {minX, minY, maxX, maxY}
   * @param {number} z - Z 坐标
   * @param {number} scale - 缩放比例 (1 = 原始大小)
   * @param {Array} vertices - 输出顶点数组
   * @param {Array} uvs - 输出 UV 数组
   */
  buildBevelLayer(flatVertices, bounds, z, scale, vertices, uvs) {
    const centerX = (bounds.minX + bounds.maxX) / 2;
    const centerY = (bounds.minY + bounds.maxY) / 2;
    const shapeWidth = bounds.maxX - bounds.minX;
    const shapeHeight = bounds.maxY - bounds.minY;

    for (let i = 0; i < flatVertices.length / 2; i++) {
      const x = flatVertices[i * 2];
      const y = flatVertices[i * 2 + 1];
      
      // 从中心点向内/向外缩放
      const scaledX = centerX + (x - centerX) * scale;
      const scaledY = centerY + (y - centerY) * scale;
      
      vertices.push(scaledX, scaledY, z);
      
      // UV 基于原始坐标（缩放前），保持纹理稳定
      const u = (x - bounds.minX) / shapeWidth;
      const v = (y - bounds.minY) / shapeHeight;
      uvs.push(u, v);
    }
  }

  /**
   * 构建侧面
   */
  buildSideFaces(contour, depth, steps, vertices, indices, uvs, startVertexOffset) {
    const contourLength = this.calculateContourLength(contour);
    let accumulatedLength = 0;

    // 为每个深度步骤生成顶点
    for (let step = 0; step <= steps; step++) {
      const z = (step / steps) * depth;
      accumulatedLength = 0;

      for (let i = 0; i < contour.length; i++) {
        const pt = contour[i];
        vertices.push(pt.x, pt.y, z);

        // UV: u = 沿轮廓的长度比例, v = 深度比例
        const u = accumulatedLength / contourLength;
        const v = step / steps;
        uvs.push(u, v);

        // 计算到下一个点的距离
        if (i < contour.length - 1) {
          const nextPt = contour[i + 1];
          const dx = nextPt.x - pt.x;
          const dy = nextPt.y - pt.y;
          accumulatedLength += Math.sqrt(dx * dx + dy * dy);
        }
      }
    }

    // 生成侧面三角形索引
    for (let step = 0; step < steps; step++) {
      for (let i = 0; i < contour.length; i++) {
        const current = startVertexOffset + step * contour.length + i;
        const next = startVertexOffset + step * contour.length + ((i + 1) % contour.length);
        const currentNext = startVertexOffset + (step + 1) * contour.length + i;
        const nextNext = startVertexOffset + (step + 1) * contour.length + ((i + 1) % contour.length);

        // 两个三角形组成一个四边形
        indices.push(current, next, currentNext);
        indices.push(next, nextNext, currentNext);
      }
    }
  }

  /**
   * 计算轮廓总长度
   */
  calculateContourLength(contour) {
    let length = 0;
    for (let i = 0; i < contour.length - 1; i++) {
      const dx = contour[i + 1].x - contour[i].x;
      const dy = contour[i + 1].y - contour[i].y;
      length += Math.sqrt(dx * dx + dy * dy);
    }
    // 闭合路径：加上最后一点到第一点的距离
    const dx = contour[0].x - contour[contour.length - 1].x;
    const dy = contour[0].y - contour[contour.length - 1].y;
    length += Math.sqrt(dx * dx + dy * dy);
    return length;
  }

  /**
   * 计算轮廓法线（用于斜角）
   * 
   * 注意：当前实现使用简单的中心缩放，此方法暂未使用
   * 保留此方法以备将来实现更高级的基于法线的斜角效果
   * 
   * @param {Array} contour - 轮廓点数组
   * @returns {Array} - 法线数组
   */
  calculateContourNormals(contour) {
    const normals = [];
    const n = contour.length;

    for (let i = 0; i < n; i++) {
      const prev = contour[(i - 1 + n) % n];
      const curr = contour[i];
      const next = contour[(i + 1) % n];

      // 计算两个边的方向
      const dx1 = curr.x - prev.x;
      const dy1 = curr.y - prev.y;
      const dx2 = next.x - curr.x;
      const dy2 = next.y - curr.y;

      // 归一化
      const len1 = Math.sqrt(dx1 * dx1 + dy1 * dy1);
      const len2 = Math.sqrt(dx2 * dx2 + dy2 * dy2);

      const nx1 = len1 > 0 ? -dy1 / len1 : 0;
      const ny1 = len1 > 0 ? dx1 / len1 : 0;
      const nx2 = len2 > 0 ? -dy2 / len2 : 0;
      const ny2 = len2 > 0 ? dx2 / len2 : 0;

      // 平均法线
      const nx = (nx1 + nx2) / 2;
      const ny = (ny1 + ny2) / 2;
      const nlen = Math.sqrt(nx * nx + ny * ny);

      normals.push({
        x: nlen > 0 ? nx / nlen : 0,
        y: nlen > 0 ? ny / nlen : 0
      });
    }

    return normals;
  }

  /**
   * 准备三角化数据
   */
  prepareTriangulationData(shapePoints, holePoints) {
    if (!shapePoints || shapePoints.length < 3) {
      return null;
    }

    const flatVertices = [];
    const holeIndices = [];

    // 添加主轮廓点
    for (let i = 0; i < shapePoints.length; i++) {
      flatVertices.push(shapePoints[i].x, shapePoints[i].y);
    }

    let vertexCount = shapePoints.length;

    // 添加孔的点
    if (holePoints && holePoints.length > 0) {
      for (let i = 0; i < holePoints.length; i++) {
        const hole = holePoints[i];
        if (hole && hole.length > 0) {
          holeIndices.push(vertexCount);
          
          for (let j = 0; j < hole.length; j++) {
            flatVertices.push(hole[j].x, hole[j].y);
            vertexCount++;
          }
        }
      }
    }

    return {
      flatVertices: flatVertices,
      holeIndices: holeIndices.length > 0 ? holeIndices : null,
      vertexCount: vertexCount
    };
  }

  /**
   * 计算顶点边界框
   */
  calculateBounds(vertices) {
    let minX = Infinity, minY = Infinity;
    let maxX = -Infinity, maxY = -Infinity;

    for (let i = 0; i < vertices.length; i += 2) {
      const x = vertices[i];
      const y = vertices[i + 1];

      if (x < minX) minX = x;
      if (x > maxX) maxX = x;
      if (y < minY) minY = y;
      if (y > maxY) maxY = y;
    }

    // 防止除以零
    if (maxX === minX) maxX = minX + 1;
    if (maxY === minY) maxY = minY + 1;

    return { minX, minY, maxX, maxY };
  }

  /**
   * 更新 AMG 对象的顶点和索引数据
   */
  updateAMGObject(vertices, indices, uvs) {
    if (!this._amgObject || !this._amgObject.submeshes) return;

    try {
      const submesh = this._amgObject.submeshes.get(0);
      if (!submesh) return;

      // 设置渲染模式为三角形（必须使用 TRIANGLES，不能用 TRIANGLE_FAN）
      submesh.primitive = effect.Amaz.Primitive.TRIANGLES;

      // 更新顶点数据
      const vertexCount = vertices.length / 3;
      const buffer = new effect.Amaz.FloatVector();
      for (let i = 0; i < vertexCount; i++) {
        buffer.pushBack(vertices[i * 3]);
        buffer.pushBack(vertices[i * 3 + 1]);
        buffer.pushBack(vertices[i * 3 + 2]);
      }
      // console.log('═══ ExtrudeGeometry 统计 ═══');
      // console.log('顶点数量:', vertexCount);
      // console.log('索引数量:', indices.length);
      // console.log('三角形数量:', Math.floor(indices.length / 3));
      // console.log('启用斜角:', this.bevelEnabled);
      // if (this.bevelEnabled) {
      //   console.log('  - 斜角厚度:', this.bevelThickness);
      //   console.log('  - 斜角大小:', this.bevelSize);
      //   console.log('  - 斜角分段:', this.bevelSegments);
      // }
      // console.log('═══════════════════════════');
      this._amgObject.setAttributeData(effect.Amaz.VertexAttribType.POSITION, buffer, 0, vertexCount);

      // 更新 UV 数据
      const uvArray = new effect.Amaz.Vec2Vector();
      for (let i = 0; i < vertexCount; i++) {
        const uv = new effect.Amaz.Vector2f(uvs[i * 2], uvs[i * 2 + 1]);
        uvArray.pushBack(uv);
      }
      this._amgObject.setUvArray(0, uvArray);

      // 更新索引数据
      if (indices.length > 0) {
        const indexArray = new effect.Amaz.UInt16Vector();
        for (let i = 0; i < indices.length; i++) {
          indexArray.pushBack(indices[i]);
        }
        submesh.indices16 = indexArray;
        submesh.indicesCount = indices.length;
      }
    } catch (e) {
      console.warn('ExtrudeGeometry: 更新 AMG 对象失败', e);
    }
  }

  /**
   * 将几何体居中
   */
  center() {
    const positionAttribute = this.attributes.position;
    if (!positionAttribute) return this;

    const positions = positionAttribute.array;
    let minX = Infinity, minY = Infinity, minZ = Infinity;
    let maxX = -Infinity, maxY = -Infinity, maxZ = -Infinity;

    // 计算边界框
    for (let i = 0; i < positions.length; i += 3) {
      const x = positions[i];
      const y = positions[i + 1];
      const z = positions[i + 2];

      if (x < minX) minX = x;
      if (x > maxX) maxX = x;
      if (y < minY) minY = y;
      if (y > maxY) maxY = y;
      if (z < minZ) minZ = z;
      if (z > maxZ) maxZ = z;
    }

    // 计算中心点
    const centerX = (minX + maxX) / 2;
    const centerY = (minY + maxY) / 2;
    const centerZ = (minZ + maxZ) / 2;

    // 将所有顶点移动到中心
    for (let i = 0; i < positions.length; i += 3) {
      positions[i] -= centerX;
      positions[i + 1] -= centerY;
      positions[i + 2] -= centerZ;
    }

    // 更新 AMG 对象
    if (this._amgObject) {
      const vertexCount = positions.length / 3;
      const buffer = new effect.Amaz.FloatVector();
      for (let i = 0; i < vertexCount; i++) {
        buffer.pushBack(positions[i * 3]);
        buffer.pushBack(positions[i * 3 + 1]);
        buffer.pushBack(positions[i * 3 + 2]);
      }
      this._amgObject.setAttributeData(effect.Amaz.VertexAttribType.POSITION, buffer, 0, vertexCount);
    }

    return this;
  }

  /**
   * 计算边界框
   */
  computeBoundingBox() {
    const positionAttribute = this.attributes.position;
    if (!positionAttribute) {
      this.boundingBox = new Box3(new Vector3(0, 0, 0), new Vector3(0, 0, 0));
      return;
    }

    const positions = positionAttribute.array;
    let minX = Infinity, minY = Infinity, minZ = Infinity;
    let maxX = -Infinity, maxY = -Infinity, maxZ = -Infinity;

    // 计算边界框
    for (let i = 0; i < positions.length; i += 3) {
      const x = positions[i];
      const y = positions[i + 1];
      const z = positions[i + 2];

      if (x < minX) minX = x;
      if (x > maxX) maxX = x;
      if (y < minY) minY = y;
      if (y > maxY) maxY = y;
      if (z < minZ) minZ = z;
      if (z > maxZ) maxZ = z;
    }

    this.boundingBox = new Box3(new Vector3(minX, minY, minZ), new Vector3(maxX, maxY, maxZ));
  }

  /**
   * 计算包围球
   */
  computeBoundingSphere() {
    const positionAttribute = this.attributes.position;
    if (!positionAttribute) {
      this.boundingSphere = { center: new Vector3(0, 0, 0), radius: 0 };
      return;
    }

    const positions = positionAttribute.array;
    let minX = Infinity, minY = Infinity, minZ = Infinity;
    let maxX = -Infinity, maxY = -Infinity, maxZ = -Infinity;

    // 计算边界框
    for (let i = 0; i < positions.length; i += 3) {
      const x = positions[i];
      const y = positions[i + 1];
      const z = positions[i + 2];

      if (x < minX) minX = x;
      if (x > maxX) maxX = x;
      if (y < minY) minY = y;
      if (y > maxY) maxY = y;
      if (z < minZ) minZ = z;
      if (z > maxZ) maxZ = z;
    }

    // 计算中心点
    const centerX = (minX + maxX) / 2;
    const centerY = (minY + maxY) / 2;
    const centerZ = (minZ + maxZ) / 2;

    // 计算半径（最远点到中心的距离）
    let maxRadiusSq = 0;
    for (let i = 0; i < positions.length; i += 3) {
      const dx = positions[i] - centerX;
      const dy = positions[i + 1] - centerY;
      const dz = positions[i + 2] - centerZ;
      const distSq = dx * dx + dy * dy + dz * dz;
      if (distSq > maxRadiusSq) maxRadiusSq = distSq;
    }

    this.boundingSphere = {
      center: new Vector3(centerX, centerY, centerZ),
      radius: Math.sqrt(maxRadiusSq)
    };
  }

  /**
   * 释放资源
   * 清理几何体占用的所有内存和 GPU 资源
   */
  dispose() {
    // 清理数组资源
    if (this.groups) {
      this.groups.length = 0;
      this.groups = null;
    }

    // 清理参数对象
    this.parameters = null;

    // 清理存储的属性
    this.depth = null;
    this.steps = null;
    this.bevelEnabled = null;
    this.bevelThickness = null;
    this.bevelSize = null;
    this.bevelOffset = null;
    this.bevelSegments = null;
    this.curveSegments = null;

    // 调用父类的 dispose（清理 AMG 对象和 attributes）
    super.dispose();
  }
}

exports.ExtrudeGeometry = ExtrudeGeometry;

