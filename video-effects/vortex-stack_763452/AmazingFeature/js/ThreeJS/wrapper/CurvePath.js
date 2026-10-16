/**
 * CurvePath 类 - 曲线路径管理器
 * 用于管理多个曲线段的集合，符合 Three.js 规范
 */

const { Vector2 } = require('./Vector2');

class CurvePath {
  constructor() {
    this.type = 'CurvePath';
    this.curves = [];
    this.autoClose = false;
    this.cacheLengths = null;
    this.cacheDivisions = null;
  }

  /**
   * 添加曲线到路径
   * @param {Object} curve - 曲线对象（需要有 getPoint 方法）
   */
  add(curve) {
    this.curves.push(curve);
    this.cacheLengths = null; // 添加新曲线后清除缓存
  }

  /**
   * 闭合路径
   */
  closePath() {
    if (this.curves.length > 0) {
      const firstPoint = this.curves[0].getPoint(0);
      const lastCurve = this.curves[this.curves.length - 1];
      const lastPoint = lastCurve.getPoint(1);
      
      if (!lastPoint.equals(firstPoint)) {
        this.add(new LineCurve(lastPoint, firstPoint));
      }
    }
    this.autoClose = true;
  }

  /**
   * 获取路径上的点
   * @param {number} divisions - 每条曲线的细分数
   */
  getPoints(divisions = 12) {
    const points = [];
    const epsilon = 1e-10;
    
    for (let i = 0; i < this.curves.length; i++) {
      const curve = this.curves[i];
      const pts = curve.getPoints ? curve.getPoints(divisions) : [curve.getPoint(0), curve.getPoint(1)];
      
      for (let j = 0; j < pts.length; j++) {
        const point = pts[j];
        // 去重：跳过与上一个点重复的点
        if (i === 0 || j > 0 || points.length === 0 || !point.equals(points[points.length - 1], epsilon)) {
          points.push(point);
        }
      }
    }
    
    // 如果设置了自动闭合但最后一个点与第一个点不重合，则添加闭合点
    if (this.autoClose && points.length > 1 && !points[points.length - 1].equals(points[0], epsilon)) {
      points.push(points[0].clone());
    }
    
    return points;
  }

  /**
   * 获取细分的累计长度数组（用于精确的长度参数化）
   * @param {number} divisions - 每条曲线的细分数
   */
  getLengths(divisions = 40) {
    if (this.cacheLengths && this.cacheDivisions === divisions) {
      return this.cacheLengths;
    }
    
    const lengths = [];
    let sum = 0;
    
    for (let i = 0; i < this.curves.length; i++) {
      const curve = this.curves[i];
      
      // 对每条曲线进行细分
      let last = curve.getPoint(0);
      for (let j = 1; j <= divisions; j++) {
        const current = curve.getPoint(j / divisions);
        const dx = current.x - last.x;
        const dy = current.y - last.y;
        sum += Math.sqrt(dx * dx + dy * dy);
        lengths.push(sum);
        last = current;
      }
    }
    
    this.cacheLengths = lengths;
    this.cacheDivisions = divisions;
    
    return lengths;
  }

  /**
   * 获取整个路径的总长度
   */
  getLength() {
    const lengths = this.getLengths();
    return lengths.length > 0 ? lengths[lengths.length - 1] : 0;
  }

  /**
   * 根据归一化的长度参数 (0-1) 获取对应位置的点
   * @param {number} u - 归一化的长度参数，范围 0-1
   */
  getPointAt(u) {
    const t = this.getUtoTmapping(u);
    return this.getPoint(t);
  }

  /**
   * 将归一化的长度参数 u (0-1) 映射到曲线参数 t (0-1)
   * @param {number} u - 归一化的长度参数
   */
  getUtoTmapping(u) {
    const divisions = this.cacheDivisions || 40;
    const lengths = this.getLengths(divisions);
    
    // 边界情况处理
    if (u === 0) return 0;
    if (u === 1) return 1;
    if (lengths.length === 0) return 0;
    
    const targetLength = u * lengths[lengths.length - 1];
    
    // 二分查找定位目标长度所在的细分段
    let low = 0;
    let high = lengths.length - 1;
    let comparison;
    
    while (low <= high) {
      const i = Math.floor(low + (high - low) / 2);
      comparison = lengths[i] - targetLength;
      
      if (comparison < 0) {
        low = i + 1;
      } else if (comparison > 0) {
        high = i - 1;
      } else {
        high = i;
        break;
      }
    }
    
    let i = high;
    
    // 确保 i 在有效范围内
    if (i < 0) i = 0;
    if (i >= lengths.length) i = lengths.length - 1;
    
    // 在找到的细分段内进行插值
    const lengthBefore = i > 0 ? lengths[i - 1] : 0;
    const lengthAfter = lengths[i];
    const segmentLength = lengthAfter - lengthBefore;
    
    // 计算在当前细分段内的相对位置
    const segmentFraction = segmentLength === 0 ? 0 : (targetLength - lengthBefore) / segmentLength;
    
    // 将细分段索引转换为整体的 t 参数
    const t = (i + segmentFraction) / (this.curves.length * divisions);
    
    return t;
  }

  /**
   * 根据整体的 t 参数 (0-1) 获取点
   * @param {number} t - 整体的曲线参数
   */
  getPoint(t) {
    const divisions = this.cacheDivisions || 40;
    const d = t * this.curves.length * divisions;
    const segmentIndex = Math.floor(d);
    const segmentT = d - segmentIndex;
    
    // 将细分段索引转换为曲线索引和曲线内参数
    const curveIndex = Math.floor(segmentIndex / divisions);
    const divisionIndex = segmentIndex % divisions;
    const curveT = (divisionIndex + segmentT) / divisions;
    
    // 边界检查
    if (curveIndex < 0 || this.curves.length === 0) {
      return this.curves.length > 0 ? this.curves[0].getPoint(0) : new Vector2();
    }
    
    if (curveIndex >= this.curves.length) {
      return this.curves[this.curves.length - 1].getPoint(1);
    }
    
    return this.curves[curveIndex].getPoint(curveT);
  }

  /**
   * 获取沿路径等间距分布的点
   * @param {number} divisions - 要生成的点数（总共会返回 divisions + 1 个点）
   */
  getSpacedPoints(divisions = 5) {
    const points = [];
    
    // 如果没有曲线，返回空数组
    if (this.curves.length === 0) {
      return points;
    }
    
    for (let i = 0; i <= divisions; i++) {
      points.push(this.getPointAt(i / divisions));
    }
    
    return points;
  }

  /**
   * 获取路径上某点的切线方向
   * @param {number} t - 参数 t (0-1)
   */
  getTangent(t) {
    const delta = 0.0001;
    let t1 = t - delta;
    let t2 = t + delta;

    if (t1 < 0) t1 = 0;
    if (t2 > 1) t2 = 1;

    const pt1 = this.getPoint(t1);
    const pt2 = this.getPoint(t2);

    const tangent = new Vector2().subVectors(pt2, pt1);
    return tangent.normalize();
  }

  /**
   * 根据长度参数获取切线
   * @param {number} u - 归一化的长度参数 (0-1)
   */
  getTangentAt(u) {
    const t = this.getUtoTmapping(u);
    return this.getTangent(t);
  }

  /**
   * 获取边界框
   */
  getBounds() {
    const points = this.getPoints();
    let minX = Infinity, minY = Infinity;
    let maxX = -Infinity, maxY = -Infinity;
    
    for (let i = 0; i < points.length; i++) {
      const p = points[i];
      if (p.x < minX) minX = p.x;
      if (p.x > maxX) maxX = p.x;
      if (p.y < minY) minY = p.y;
      if (p.y > maxY) maxY = p.y;
    }
    
    return { minX, minY, maxX, maxY };
  }
}

/**
 * LineCurve 类 - 直线曲线
 * 从 v1 到 v2 的直线段
 */
class LineCurve {
  constructor(v1, v2) {
    this.type = 'LineCurve';
    this.v1 = v1;
    this.v2 = v2;
  }

  /**
   * 获取曲线上的点
   * @param {number} t - 参数 t，范围 0-1
   */
  getPoint(t) {
    if (t === 1) {
      return this.v2.clone();
    } else {
      const x = this.v1.x + t * (this.v2.x - this.v1.x);
      const y = this.v1.y + t * (this.v2.y - this.v1.y);
      return new Vector2(x, y);
    }
  }

  /**
   * 获取多个点
   * @param {number} divisions - 细分数
   */
  getPoints(divisions = 1) {
    const points = [];
    for (let i = 0; i <= divisions; i++) {
      points.push(this.getPoint(i / divisions));
    }
    return points;
  }

  /**
   * 获取切线（对于直线，切线方向恒定）
   * @param {number} t - 参数 t（对直线无影响）
   */
  getTangent(t) {
    const tangent = new Vector2().subVectors(this.v2, this.v1);
    return tangent.normalize();
  }

  /**
   * 获取长度
   */
  getLength() {
    return this.v1.distanceTo(this.v2);
  }

  /**
   * 平移
   */
  translate(x, y) {
    this.v1.x += x;
    this.v1.y += y;
    this.v2.x += x;
    this.v2.y += y;
    return this;
  }

  /**
   * 缩放
   */
  scale(x, y) {
    this.v1.x *= x;
    this.v1.y *= y;
    this.v2.x *= x;
    this.v2.y *= y;
    return this;
  }

  /**
   * 旋转
   */
  rotate(cos, sin) {
    let x = this.v1.x, y = this.v1.y;
    this.v1.x = x * cos - y * sin;
    this.v1.y = x * sin + y * cos;
    
    x = this.v2.x;
    y = this.v2.y;
    this.v2.x = x * cos - y * sin;
    this.v2.y = x * sin + y * cos;
    
    return this;
  }

  /**
   * 克隆
   */
  clone() {
    return new LineCurve(this.v1.clone(), this.v2.clone());
  }

  /**
   * 复制
   */
  copy(source) {
    this.v1.copy(source.v1);
    this.v2.copy(source.v2);
    return this;
  }
}

// 导出
exports.CurvePath = CurvePath;
exports.LineCurve = LineCurve;
