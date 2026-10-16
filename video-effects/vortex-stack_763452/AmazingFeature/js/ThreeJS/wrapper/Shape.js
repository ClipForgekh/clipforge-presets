/**
 * Shape 类 - 用于定义 2D 形状路径
 * 支持直线、曲线、变换等操作
 */

const { Vector2 } = require('./Vector2');

class Shape {
  constructor(points) {
    this.type = 'Shape';
    this.uuid = generateUUID();
    this.currentPoint = new Vector2();
    this.curves = [];
    this.holes = [];
    
    if (points !== undefined) {
      this.moveTo(points[0].x, points[0].y);
      for (let i = 1; i < points.length; i++) {
        this.lineTo(points[i].x, points[i].y);
      }
    }
  }

  /**
   * 移动画笔到新位置（不绘制）
   */
  moveTo(x, y) {
    this.currentPoint.set(x, y);
    return this;
  }

  /**
   * 从当前点绘制直线到指定点
   */
  lineTo(x, y) {
    const line = new LineCurve(
      this.currentPoint.clone(),
      new Vector2(x, y)
    );
    this.curves.push(line);
    this.currentPoint.set(x, y);
    return this;
  }

  /**
   * 二次贝塞尔曲线
   */
  quadraticCurveTo(cpX, cpY, x, y) {
    const curve = new QuadraticBezierCurve(
      this.currentPoint.clone(),
      new Vector2(cpX, cpY),
      new Vector2(x, y)
    );
    this.curves.push(curve);
    this.currentPoint.set(x, y);
    return this;
  }

  /**
   * 三次贝塞尔曲线
   */
  bezierCurveTo(cp1X, cp1Y, cp2X, cp2Y, x, y) {
    const curve = new CubicBezierCurve(
      this.currentPoint.clone(),
      new Vector2(cp1X, cp1Y),
      new Vector2(cp2X, cp2Y),
      new Vector2(x, y)
    );
    this.curves.push(curve);
    this.currentPoint.set(x, y);
    return this;
  }

  /**
   * 样条曲线
   */
  splineThru(points) {
    const npts = [this.currentPoint.clone()].concat(points);
    const curve = new SplineCurve(npts);
    this.curves.push(curve);
    this.currentPoint.copy(points[points.length - 1]);
    return this;
  }

  /**
   * 相对圆弧
   */
  arc(aX, aY, aRadius, aStartAngle, aEndAngle, aClockwise) {
    const x0 = this.currentPoint.x;
    const y0 = this.currentPoint.y;
    this.absarc(aX + x0, aY + y0, aRadius, aStartAngle, aEndAngle, aClockwise);
    return this;
  }

  /**
   * 绝对圆弧
   */
  absarc(aX, aY, aRadius, aStartAngle, aEndAngle, aClockwise) {
    this.absellipse(aX, aY, aRadius, aRadius, aStartAngle, aEndAngle, aClockwise, 0);
    return this;
  }

  /**
   * 椭圆
   */
  ellipse(aX, aY, xRadius, yRadius, aStartAngle, aEndAngle, aClockwise, aRotation) {
    const x0 = this.currentPoint.x;
    const y0 = this.currentPoint.y;
    this.absellipse(aX + x0, aY + y0, xRadius, yRadius, aStartAngle, aEndAngle, aClockwise, aRotation);
    return this;
  }

  /**
   * 绝对椭圆
   */
  absellipse(aX, aY, xRadius, yRadius, aStartAngle, aEndAngle, aClockwise, aRotation) {
    const curve = new EllipseCurve(
      aX, aY,
      xRadius, yRadius,
      aStartAngle, aEndAngle,
      aClockwise,
      aRotation
    );
    
    if (this.curves.length > 0) {
      const firstPoint = curve.getPoint(0);
      if (!firstPoint.equals(this.currentPoint)) {
        this.lineTo(firstPoint.x, firstPoint.y);
      }
    }

    this.curves.push(curve);
    const lastPoint = curve.getPoint(1);
    this.currentPoint.copy(lastPoint);
    return this;
  }

  /**
   * 闭合路径
   */
  closePath() {
    if (this.curves.length > 0) {
      const firstPoint = this.curves[0].getPoint(0);
      if (!this.currentPoint.equals(firstPoint)) {
        this.lineTo(firstPoint.x, firstPoint.y);
      }
    }
    return this;
  }

  /**
   * 获取路径上的点
   */
  getPoints(divisions = 12) {
    const points = [];
    const epsilon = 1e-10; // 用于浮点数比较的容差
    
    for (let i = 0; i < this.curves.length; i++) {
      const curve = this.curves[i];
      const pts = curve.getPoints(divisions);
      
      for (let j = 0; j < pts.length; j++) {
        const point = pts[j];
        // 第一条曲线的所有点都添加
        // 后续曲线的第一个点如果与上一个点相同则跳过（去重）
        // 其他点都添加
        if (i === 0 || j > 0 || (points.length === 0 || !point.equals(points[points.length - 1], epsilon))) {
          points.push(point);
        }
      }
    }
    
    return points;
  }

  /**
   * 提取形状和孔的所有点
   */
  extractPoints(divisions) {
    return {
      shape: this.getPoints(divisions),
      holes: this.holes.map(hole => hole.getPoints(divisions))
    };
  }

  /**
   * 平移所有点
   */
  translate(x, y) {
    for (let i = 0; i < this.curves.length; i++) {
      this.curves[i].translate(x, y);
    }
    return this;
  }

  /**
   * 缩放所有点
   */
  scale(x, y) {
    for (let i = 0; i < this.curves.length; i++) {
      this.curves[i].scale(x, y);
    }
    return this;
  }

  /**
   * 旋转所有点（绕原点）
   */
  rotate(angle) {
    const cos = Math.cos(angle);
    const sin = Math.sin(angle);
    
    for (let i = 0; i < this.curves.length; i++) {
      this.curves[i].rotate(cos, sin);
    }
    return this;
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

  /**
   * 获取细分的累计长度数组（用于精确的长度参数化）
   * @param {number} divisions - 每条曲线的细分数
   */
  getLengths(divisions = 40) {
    if (!this.cacheLengths || this.cacheDivisions !== divisions) {
      const lengths = [];
      let sum = 0;
      
      for (let i = 0; i < this.curves.length; i++) {
        const curve = this.curves[i];
        if (curve && typeof curve.getPoint === 'function') {
          // 对每条曲线进行细分，构建更精确的长度查找表
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
      }
      
      this.cacheLengths = lengths;
      this.cacheDivisions = divisions;
    }
    
    return this.cacheLengths;
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
    // 现在 lengths 有 curves.length * divisions 个元素
    // 每个元素对应一个细分段
    const t = (i + segmentFraction) / (this.curves.length * divisions);
    
    return t;
  }

  /**
   * 根据整体的 t 参数 (0-1) 获取点
   * @param {number} t - 整体的曲线参数
   */
  getPoint(t) {
    const divisions = this.cacheDivisions || 40;
    // t 现在是基于细分的参数：t * curves.length * divisions 给出细分段索引
    const d = t * this.curves.length * divisions;
    const segmentIndex = Math.floor(d);
    const segmentT = d - segmentIndex;
    
    // 将细分段索引转换为曲线索引和曲线内参数
    const curveIndex = Math.floor(segmentIndex / divisions);
    const divisionIndex = segmentIndex % divisions;
    const curveT = (divisionIndex + segmentT) / divisions;
    
    // 边界检查
    if (curveIndex < 0) {
      return this.curves[0].getPoint(0);
    }
    
    if (curveIndex >= this.curves.length) {
      return this.curves[this.curves.length - 1].getPoint(1);
    }
    
    return this.curves[curveIndex].getPoint(curveT);
  }

  /**
   * 获取沿路径等间距分布的点
   * @param {number} divisions - 要生成的点数（不包括起点，总共会返回 divisions + 1 个点）
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
   * 释放资源
   * 清理 Shape 对象占用的所有内存
   */
  dispose() {
    // 清理曲线数组
    if (this.curves) {
      // 清理每条曲线（如果曲线也有 dispose 方法）
      for (let i = 0; i < this.curves.length; i++) {
        if (this.curves[i] && typeof this.curves[i].dispose === 'function') {
          this.curves[i].dispose();
        }
        // 清理曲线对象的引用
        this.curves[i] = null;
      }
      this.curves.length = 0;
      this.curves = null;
    }

    // 清理孔洞数组
    if (this.holes) {
      for (let i = 0; i < this.holes.length; i++) {
        if (this.holes[i] && typeof this.holes[i].dispose === 'function') {
          this.holes[i].dispose();
        }
        this.holes[i] = null;
      }
      this.holes.length = 0;
      this.holes = null;
    }

    // 清理缓存
    if (this.cacheLengths) {
      this.cacheLengths.length = 0;
      this.cacheLengths = null;
    }
    this.cacheDivisions = null;

    // 清理当前点
    this.currentPoint = null;

    // 清理类型和 UUID
    this.type = null;
    this.uuid = null;
  }
}

// 辅助曲线类

/**
 * 直线
 */
class LineCurve {
  constructor(v1, v2) {
    this.v1 = v1;
    this.v2 = v2;
  }

  getPoint(t) {
    const x = this.v1.x + t * (this.v2.x - this.v1.x);
    const y = this.v1.y + t * (this.v2.y - this.v1.y);
    return new Vector2(x, y);
  }

  getPoints(divisions = 1) {
    const points = [];
    for (let i = 0; i <= divisions; i++) {
      points.push(this.getPoint(i / divisions));
    }
    return points;
  }

  translate(x, y) {
    this.v1.x += x; this.v1.y += y;
    this.v2.x += x; this.v2.y += y;
  }

  scale(x, y) {
    this.v1.x *= x; this.v1.y *= y;
    this.v2.x *= x; this.v2.y *= y;
  }

  rotate(cos, sin) {
    let x = this.v1.x, y = this.v1.y;
    this.v1.x = x * cos - y * sin;
    this.v1.y = x * sin + y * cos;
    
    x = this.v2.x; y = this.v2.y;
    this.v2.x = x * cos - y * sin;
    this.v2.y = x * sin + y * cos;
  }

  getLength() {
    const dx = this.v2.x - this.v1.x;
    const dy = this.v2.y - this.v1.y;
    return Math.sqrt(dx * dx + dy * dy);
  }
}

/**
 * 二次贝塞尔曲线
 */
class QuadraticBezierCurve {
  constructor(v0, v1, v2) {
    this.v0 = v0;
    this.v1 = v1;
    this.v2 = v2;
  }

  getPoint(t) {
    const u = 1 - t;
    const tt = t * t;
    const uu = u * u;
    const ut2 = 2 * u * t;
    
    const x = uu * this.v0.x + ut2 * this.v1.x + tt * this.v2.x;
    const y = uu * this.v0.y + ut2 * this.v1.y + tt * this.v2.y;
    
    return new Vector2(x, y);
  }

  getPoints(divisions = 12) {
    const points = [];
    for (let i = 0; i <= divisions; i++) {
      points.push(this.getPoint(i / divisions));
    }
    return points;
  }

  translate(x, y) {
    this.v0.x += x; this.v0.y += y;
    this.v1.x += x; this.v1.y += y;
    this.v2.x += x; this.v2.y += y;
  }

  scale(x, y) {
    this.v0.x *= x; this.v0.y *= y;
    this.v1.x *= x; this.v1.y *= y;
    this.v2.x *= x; this.v2.y *= y;
  }

  rotate(cos, sin) {
    let x = this.v0.x, y = this.v0.y;
    this.v0.x = x * cos - y * sin;
    this.v0.y = x * sin + y * cos;
    
    x = this.v1.x; y = this.v1.y;
    this.v1.x = x * cos - y * sin;
    this.v1.y = x * sin + y * cos;
    
    x = this.v2.x; y = this.v2.y;
    this.v2.x = x * cos - y * sin;
    this.v2.y = x * sin + y * cos;
  }

  getLength() {
    // 使用数值积分方法计算曲线长度
    const divisions = 200;
    let length = 0;
    let lastPoint = this.getPoint(0);
    
    for (let i = 1; i <= divisions; i++) {
      const point = this.getPoint(i / divisions);
      const dx = point.x - lastPoint.x;
      const dy = point.y - lastPoint.y;
      length += Math.sqrt(dx * dx + dy * dy);
      lastPoint = point;
    }
    
    return length;
  }
}

/**
 * 三次贝塞尔曲线
 */
class CubicBezierCurve {
  constructor(v0, v1, v2, v3) {
    this.v0 = v0;
    this.v1 = v1;
    this.v2 = v2;
    this.v3 = v3;
  }

  getPoint(t) {
    const u = 1 - t;
    const tt = t * t;
    const uu = u * u;
    const uuu = uu * u;
    const ttt = tt * t;
    
    const x = uuu * this.v0.x + 3 * uu * t * this.v1.x + 3 * u * tt * this.v2.x + ttt * this.v3.x;
    const y = uuu * this.v0.y + 3 * uu * t * this.v1.y + 3 * u * tt * this.v2.y + ttt * this.v3.y;
    
    return new Vector2(x, y);
  }

  getPoints(divisions = 12) {
    const points = [];
    for (let i = 0; i <= divisions; i++) {
      points.push(this.getPoint(i / divisions));
    }
    return points;
  }

  translate(x, y) {
    this.v0.x += x; this.v0.y += y;
    this.v1.x += x; this.v1.y += y;
    this.v2.x += x; this.v2.y += y;
    this.v3.x += x; this.v3.y += y;
  }

  scale(x, y) {
    this.v0.x *= x; this.v0.y *= y;
    this.v1.x *= x; this.v1.y *= y;
    this.v2.x *= x; this.v2.y *= y;
    this.v3.x *= x; this.v3.y *= y;
  }

  rotate(cos, sin) {
    let x = this.v0.x, y = this.v0.y;
    this.v0.x = x * cos - y * sin;
    this.v0.y = x * sin + y * cos;
    
    x = this.v1.x; y = this.v1.y;
    this.v1.x = x * cos - y * sin;
    this.v1.y = x * sin + y * cos;
    
    x = this.v2.x; y = this.v2.y;
    this.v2.x = x * cos - y * sin;
    this.v2.y = x * sin + y * cos;
    
    x = this.v3.x; y = this.v3.y;
    this.v3.x = x * cos - y * sin;
    this.v3.y = x * sin + y * cos;
  }

  getLength() {
    // 使用数值积分方法计算曲线长度
    const divisions = 200;
    let length = 0;
    let lastPoint = this.getPoint(0);
    
    for (let i = 1; i <= divisions; i++) {
      const point = this.getPoint(i / divisions);
      const dx = point.x - lastPoint.x;
      const dy = point.y - lastPoint.y;
      length += Math.sqrt(dx * dx + dy * dy);
      lastPoint = point;
    }
    
    return length;
  }
}

/**
 * 样条曲线
 */
class SplineCurve {
  constructor(points) {
    this.points = points;
  }

  getPoint(t) {
    const points = this.points;
    const point = (points.length - 1) * t;
    const intPoint = Math.floor(point);
    const weight = point - intPoint;

    const p0 = points[intPoint === 0 ? intPoint : intPoint - 1];
    const p1 = points[intPoint];
    const p2 = points[intPoint > points.length - 2 ? points.length - 1 : intPoint + 1];
    const p3 = points[intPoint > points.length - 3 ? points.length - 1 : intPoint + 2];

    const x = catmullRom(weight, p0.x, p1.x, p2.x, p3.x);
    const y = catmullRom(weight, p0.y, p1.y, p2.y, p3.y);

    return new Vector2(x, y);
  }

  getPoints(divisions = 12) {
    const points = [];
    for (let i = 0; i <= divisions; i++) {
      points.push(this.getPoint(i / divisions));
    }
    return points;
  }

  translate(x, y) {
    for (let i = 0; i < this.points.length; i++) {
      this.points[i].x += x;
      this.points[i].y += y;
    }
  }

  scale(x, y) {
    for (let i = 0; i < this.points.length; i++) {
      this.points[i].x *= x;
      this.points[i].y *= y;
    }
  }

  rotate(cos, sin) {
    for (let i = 0; i < this.points.length; i++) {
      const x = this.points[i].x;
      const y = this.points[i].y;
      this.points[i].x = x * cos - y * sin;
      this.points[i].y = x * sin + y * cos;
    }
  }

  getLength() {
    // 使用数值积分方法计算曲线长度
    const divisions = 200;
    let length = 0;
    let lastPoint = this.getPoint(0);
    
    for (let i = 1; i <= divisions; i++) {
      const point = this.getPoint(i / divisions);
      const dx = point.x - lastPoint.x;
      const dy = point.y - lastPoint.y;
      length += Math.sqrt(dx * dx + dy * dy);
      lastPoint = point;
    }
    
    return length;
  }
}

/**
 * 椭圆曲线
 */
class EllipseCurve {
  constructor(aX, aY, xRadius, yRadius, aStartAngle, aEndAngle, aClockwise, aRotation) {
    this.aX = aX;
    this.aY = aY;
    this.xRadius = xRadius;
    this.yRadius = yRadius;
    this.aStartAngle = aStartAngle;
    this.aEndAngle = aEndAngle;
    this.aClockwise = aClockwise !== undefined ? aClockwise : false;
    this.aRotation = aRotation !== undefined ? aRotation : 0;
  }

  getPoint(t) {
    const twoPi = Math.PI * 2;
    let deltaAngle = this.aEndAngle - this.aStartAngle;
    const samePoints = Math.abs(deltaAngle) < Number.EPSILON;

    while (deltaAngle < 0) deltaAngle += twoPi;
    while (deltaAngle > twoPi) deltaAngle -= twoPi;

    if (deltaAngle < Number.EPSILON) {
      if (samePoints) {
        deltaAngle = 0;
      } else {
        deltaAngle = twoPi;
      }
    }

    if (this.aClockwise === true && !samePoints) {
      if (deltaAngle === twoPi) {
        deltaAngle = -twoPi;
      } else {
        deltaAngle = deltaAngle - twoPi;
      }
    }

    const angle = this.aStartAngle + t * deltaAngle;
    let x = this.aX + this.xRadius * Math.cos(angle);
    let y = this.aY + this.yRadius * Math.sin(angle);

    if (this.aRotation !== 0) {
      const cos = Math.cos(this.aRotation);
      const sin = Math.sin(this.aRotation);

      const tx = x - this.aX;
      const ty = y - this.aY;

      x = tx * cos - ty * sin + this.aX;
      y = tx * sin + ty * cos + this.aY;
    }

    return new Vector2(x, y);
  }

  getPoints(divisions = 12) {
    const points = [];
    for (let i = 0; i <= divisions; i++) {
      points.push(this.getPoint(i / divisions));
    }
    return points;
  }

  translate(x, y) {
    this.aX += x;
    this.aY += y;
  }

  scale(x, y) {
    this.xRadius *= x;
    this.yRadius *= y;
    this.aX *= x;
    this.aY *= y;
  }

  rotate(cos, sin) {
    const x = this.aX;
    const y = this.aY;
    this.aX = x * cos - y * sin;
    this.aY = x * sin + y * cos;
    this.aRotation += Math.atan2(sin, cos);
  }

  getLength() {
    // 使用数值积分方法计算椭圆弧长度
    const divisions = 200;
    let length = 0;
    let lastPoint = this.getPoint(0);
    
    for (let i = 1; i <= divisions; i++) {
      const point = this.getPoint(i / divisions);
      const dx = point.x - lastPoint.x;
      const dy = point.y - lastPoint.y;
      length += Math.sqrt(dx * dx + dy * dy);
      lastPoint = point;
    }
    
    return length;
  }
}

// 辅助函数

function catmullRom(t, p0, p1, p2, p3) {
  const v0 = (p2 - p0) * 0.5;
  const v1 = (p3 - p1) * 0.5;
  const t2 = t * t;
  const t3 = t * t2;
  return (2 * p1 - 2 * p2 + v0 + v1) * t3 + (-3 * p1 + 3 * p2 - 2 * v0 - v1) * t2 + v0 * t + p1;
}

function generateUUID() {
  const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
  const uuid = new Array(36);
  let rnd = 0;

  for (let i = 0; i < 36; i++) {
    if (i === 8 || i === 13 || i === 18 || i === 23) {
      uuid[i] = '-';
    } else if (i === 14) {
      uuid[i] = '4';
    } else {
      if (rnd <= 0x02) rnd = 0x2000000 + (Math.random() * 0x1000000) | 0;
      const r = rnd & 0xf;
      rnd = rnd >> 4;
      uuid[i] = chars[(i === 19) ? (r & 0x3) | 0x8 : r];
    }
  }

  return uuid.join('');
}

exports.Shape = Shape;



