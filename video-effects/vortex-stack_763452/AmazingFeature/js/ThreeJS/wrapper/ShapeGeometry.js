/**
 * ShapeGeometry 类 - 将 Shape 转换为 3D 几何体
 * 使用 Earcut 算法进行三角化
 */

const { BufferGeometry } = require('./BufferGeometry');
const { BufferAttribute } = require('./BufferAttribute');
const { earcut } = require('./Earcut');
const { Vector2 } = require('./Vector2');
const { Vector3 } = require('./Vector3');
const { Box3 } = require('./Box3');

class ShapeGeometry extends BufferGeometry {
  constructor(shapes, curveSegments = 12) {
    super();

    this.type = 'ShapeGeometry';
    this.parameters = {
      shapes: shapes,
      curveSegments: curveSegments
    };

    // 处理单个 shape 或 shape 数组
    const shapesArray = Array.isArray(shapes) ? shapes : [shapes];

    const vertices = [];
    const indices = [];
    const uvs = [];
    const groups = [];

    let groupStart = 0;
    let groupCount = 0;

    // 处理每个 shape
    for (let i = 0; i < shapesArray.length; i++) {
      const shape = shapesArray[i];
      
      // 提取形状点
      const { shape: shapePoints, holes: holePoints } = shape.extractPoints(curveSegments);
      
      // 准备三角化数据
      const triangulationData = prepareTriangulationData(shapePoints, holePoints);
      
      if (triangulationData) {
        const { flatVertices, holeIndices, vertexCount } = triangulationData;
        
        // 三角化
        const triangleIndices = earcut(flatVertices, holeIndices, 2);
        
        if (triangleIndices && triangleIndices.length > 0) {
          // 计算边界框用于 UV 映射
          const bounds = calculateBounds(flatVertices);
          
          // 当前顶点索引偏移
          const vertexOffset = vertices.length / 3;
          
          // 添加顶点（Z = 0）和 UV
          for (let j = 0; j < vertexCount; j++) {
            const x = flatVertices[j * 2];
            const y = flatVertices[j * 2 + 1];
            
            vertices.push(x, y, 0);
            
            // 生成 UV（基于边界框归一化）
            const u = (x - bounds.minX) / (bounds.maxX - bounds.minX);
            const v = (y - bounds.minY) / (bounds.maxY - bounds.minY);
            uvs.push(u, v);
          }
          
          // 添加索引（考虑顶点偏移）
          for (let j = 0; j < triangleIndices.length; j++) {
            indices.push(triangleIndices[j] + vertexOffset);
          }
          
          // 添加组信息（用于多材质支持）
          groupCount = triangleIndices.length;
          groups.push({
            start: groupStart,
            count: groupCount,
            materialIndex: i
          });
          groupStart += groupCount;
        }
      }
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

    // test
    // this._amgObject.submeshes.get(0).primitive = effect.Amaz.Primitive.Points;


    // 存储组信息
    this.groups = groups;
  }

  /**
   * 更新 AMG 对象的顶点和索引数据
   */
  updateAMGObject(vertices, indices, uvs) {
    if (!this._amgObject || !this._amgObject.submeshes) return;

    try {
      const submesh = this._amgObject.submeshes.get(0);
      if (!submesh) return;

      // 设置渲染模式为三角形
      submesh.primitive = effect.Amaz.Primitive.TRIANGLES;

      // 更新顶点数据
      const vertexCount = vertices.length / 3;
      const vertexArray = new effect.Amaz.Vec3Vector();

      for (let i = 0; i < vertexCount; i++) {
        const v = new effect.Amaz.Vector3f(
          vertices[i * 3],
          vertices[i * 3 + 1],
          vertices[i * 3 + 2]
        );
        vertexArray.pushBack(v);
      }
      // this._amgObject.setVertexArray(vertexArray);
      // this._amgObject.setAttributeData(effect.Amaz.VertexAttribType.POSITION, vertexArray, 0, vertexCount);
      const buffer = new effect.Amaz.FloatVector();
      for (let i = 0; i < vertexCount; i++) {
        buffer.pushBack(vertices[i * 3]);
        buffer.pushBack(vertices[i * 3 + 1]);
        buffer.pushBack(vertices[i * 3 + 2]);
      }
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
        submesh.primitive = effect.Amaz.Primitive.TRIANGLES;

      }
    } catch (e) {
      console.warn('ShapeGeometry: 更新 AMG 对象失败', e);
    }
  }

  /**
   * 添加形状到现有几何体
   */
  addShape(shape, curveSegments = 1) {
    // 可以在未来扩展支持动态添加形状
    console.warn('ShapeGeometry.addShape: 暂未实现动态添加形状功能');
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
      this.boundingSphere = { center: { x: 0, y: 0, z: 0 }, radius: 0 };
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
      center: { x: centerX, y: centerY, z: centerZ },
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

    // 调用父类的 dispose（清理 AMG 对象和 attributes）
    super.dispose();
  }
}

/**
 * 准备三角化数据
 * @param {Array} shapePoints - 形状轮廓点
 * @param {Array} holePoints - 镂空点数组
 * @returns {Object} 包含 flatVertices（扁平顶点数组）和 holeIndices（孔索引数组）
 */
function prepareTriangulationData(shapePoints, holePoints) {
  if (!shapePoints || shapePoints.length < 3) {
    console.warn('ShapeGeometry: 形状点数量不足');
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
 * @param {Array<number>} vertices - 扁平顶点数组 [x0, y0, x1, y1, ...]
 * @returns {Object} 边界框 {minX, minY, maxX, maxY}
 */
function calculateBounds(vertices) {
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

exports.ShapeGeometry = ShapeGeometry;



