/**
 * Box2 类 - 二维轴对齐包围盒（AABB）
 * 表示二维空间中的轴对齐包围盒，用于碰撞检测、边界计算等
 */

const { Vector2 } = require('./Vector2');

class Box2 {
  /**
   * 创建包围盒
   * @param {Vector2} [min] - 包围盒的最小点，默认为 (+Infinity, +Infinity)
   * @param {Vector2} [max] - 包围盒的最大点，默认为 (-Infinity, -Infinity)
   */
  constructor(min, max) {
    this.min = (min !== undefined) ? min : new Vector2(Infinity, Infinity);
    this.max = (max !== undefined) ? max : new Vector2(-Infinity, -Infinity);
  }

  /**
   * 设置包围盒的边界
   * @param {Vector2} min - 最小点
   * @param {Vector2} max - 最大点
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  set(min, max) {
    this.min.copy(min);
    this.max.copy(max);
    return this;
  }

  /**
   * 将包围盒设置为空
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  makeEmpty() {
    this.min.x = this.min.y = Infinity;
    this.max.x = this.max.y = -Infinity;
    return this;
  }

  /**
   * 检查包围盒是否为空
   * @returns {boolean} 如果包围盒为空则返回 true
   */
  isEmpty() {
    return (this.max.x < this.min.x) || (this.max.y < this.min.y);
  }

  /**
   * 获取包围盒的中心点
   * @param {Vector2} [target] - 用于存储结果的向量，如果未提供则创建新向量
   * @returns {Vector2} 包围盒的中心点
   */
  getCenter(target) {
    if (target === undefined) {
      target = new Vector2();
    }
    if (this.isEmpty()) {
      return target.set(0, 0);
    }
    // 计算中心点：(min + max) * 0.5
    target.x = (this.min.x + this.max.x) * 0.5;
    target.y = (this.min.y + this.max.y) * 0.5;
    return target;
  }

  /**
   * 获取包围盒的尺寸
   * @param {Vector2} [target] - 用于存储结果的向量，如果未提供则创建新向量
   * @returns {Vector2} 包围盒的尺寸
   */
  getSize(target) {
    if (target === undefined) {
      target = new Vector2();
    }
    if (this.isEmpty()) {
      return target.set(0, 0);
    }
    // 计算尺寸：max - min
    target.x = this.max.x - this.min.x;
    target.y = this.max.y - this.min.y;
    return target;
  }

  /**
   * 扩展包围盒以包含指定的点
   * @param {Vector2} point - 要包含的点
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  expandByPoint(point) {
    // 更新最小点
    if (point.x < this.min.x) this.min.x = point.x;
    if (point.y < this.min.y) this.min.y = point.y;
    // 更新最大点
    if (point.x > this.max.x) this.max.x = point.x;
    if (point.y > this.max.y) this.max.y = point.y;
    return this;
  }

  /**
   * 根据一组点设置包围盒
   * @param {Array<Vector2>} points - 点的数组
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  setFromPoints(points) {
    this.makeEmpty();
    for (let i = 0; i < points.length; i++) {
      this.expandByPoint(points[i]);
    }
    return this;
  }

  /**
   * 在每个方向上扩展包围盒指定的距离
   * @param {Vector2} vector - 扩展的距离
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  expandByVector(vector) {
    this.min.x -= vector.x;
    this.min.y -= vector.y;
    this.max.x += vector.x;
    this.max.y += vector.y;
    return this;
  }

  /**
   * 在每个方向上扩展包围盒指定的标量值
   * @param {number} scalar - 扩展的距离
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  expandByScalar(scalar) {
    this.min.x -= scalar;
    this.min.y -= scalar;
    this.max.x += scalar;
    this.max.y += scalar;
    return this;
  }

  /**
   * 将另一个包围盒合并到当前包围盒
   * @param {Box2} box - 要合并的包围盒
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  union(box) {
    if (box.min.x < this.min.x) this.min.x = box.min.x;
    if (box.min.y < this.min.y) this.min.y = box.min.y;
    if (box.max.x > this.max.x) this.max.x = box.max.x;
    if (box.max.y > this.max.y) this.max.y = box.max.y;
    return this;
  }

  /**
   * 计算当前包围盒与另一个包围盒的交集
   * @param {Box2} box - 另一个包围盒
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  intersect(box) {
    this.min.x = Math.max(this.min.x, box.min.x);
    this.min.y = Math.max(this.min.y, box.min.y);
    this.max.x = Math.min(this.max.x, box.max.x);
    this.max.y = Math.min(this.max.y, box.max.y);
    // 如果没有交集，设置为空
    if (this.isEmpty()) this.makeEmpty();
    return this;
  }

  /**
   * 平移包围盒
   * @param {Vector2} offset - 平移的偏移量
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  translate(offset) {
    this.min.x += offset.x;
    this.min.y += offset.y;
    this.max.x += offset.x;
    this.max.y += offset.y;
    return this;
  }

  /**
   * 复制另一个包围盒
   * @param {Box2} box - 源包围盒
   * @returns {Box2} 当前包围盒实例，支持链式调用
   */
  copy(box) {
    this.min.copy(box.min);
    this.max.copy(box.max);
    return this;
  }

  /**
   * 克隆包围盒
   * @returns {Box2} 新的包围盒实例
   */
  clone() {
    return new Box2().copy(this);
  }

  /**
   * 检查包围盒是否包含某个点
   * @param {Vector2} point - 要检查的点
   * @returns {boolean} 如果包含该点则返回 true
   */
  containsPoint(point) {
    return point.x >= this.min.x && point.x <= this.max.x &&
           point.y >= this.min.y && point.y <= this.max.y;
  }

  /**
   * 检查包围盒是否完全包含另一个包围盒
   * @param {Box2} box - 要检查的包围盒
   * @returns {boolean} 如果完全包含则返回 true
   */
  containsBox(box) {
    return this.min.x <= box.min.x && box.max.x <= this.max.x &&
           this.min.y <= box.min.y && box.max.y <= this.max.y;
  }

  /**
   * 检查包围盒是否与另一个包围盒相交
   * @param {Box2} box - 要检查的包围盒
   * @returns {boolean} 如果相交则返回 true
   */
  intersectsBox(box) {
    return !(box.max.x < this.min.x || box.min.x > this.max.x ||
             box.max.y < this.min.y || box.min.y > this.max.y);
  }

  /**
   * 将点限制在包围盒内
   * @param {Vector2} point - 要限制的点
   * @param {Vector2} [target] - 用于存储结果的向量，如果未提供则创建新向量
   * @returns {Vector2} 限制后的点
   */
  clampPoint(point, target) {
    if (target === undefined) {
      target = new Vector2();
    }
    target.x = Math.max(this.min.x, Math.min(this.max.x, point.x));
    target.y = Math.max(this.min.y, Math.min(this.max.y, point.y));
    return target;
  }

  /**
   * 计算点到包围盒的最短距离
   * @param {Vector2} point - 目标点
   * @returns {number} 距离值
   */
  distanceToPoint(point) {
    const clampedPoint = new Vector2();
    this.clampPoint(point, clampedPoint);
    return clampedPoint.distanceTo(point);
  }

  /**
   * 检查包围盒是否与另一个包围盒相等
   * @param {Box2} box - 要比较的包围盒
   * @returns {boolean} 如果相等则返回 true
   */
  equals(box) {
    return box.min.equals(this.min) && box.max.equals(this.max);
  }
}

exports.Box2 = Box2;


