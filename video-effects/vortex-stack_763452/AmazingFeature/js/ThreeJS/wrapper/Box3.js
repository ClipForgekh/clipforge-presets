/**
 * Box3 类 - 三维轴对齐包围盒（AABB）
 * 表示三维空间中的轴对齐包围盒，用于碰撞检测、边界计算等
 */

const { Vector3 } = require('./Vector3');

class Box3 {
  /**
   * 创建包围盒
   * @param {Vector3} [min] - 包围盒的最小点，默认为 (+Infinity, +Infinity, +Infinity)
   * @param {Vector3} [max] - 包围盒的最大点，默认为 (-Infinity, -Infinity, -Infinity)
   */
  constructor(min, max) {
    this.min = (min !== undefined) ? min : new Vector3(Infinity, Infinity, Infinity);
    this.max = (max !== undefined) ? max : new Vector3(-Infinity, -Infinity, -Infinity);
  }

  /**
   * 设置包围盒的边界
   * @param {Vector3} min - 最小点
   * @param {Vector3} max - 最大点
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  set(min, max) {
    this.min.copy(min);
    this.max.copy(max);
    return this;
  }

  /**
   * 将包围盒设置为空
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  makeEmpty() {
    this.min.x = this.min.y = this.min.z = Infinity;
    this.max.x = this.max.y = this.max.z = -Infinity;
    return this;
  }

  /**
   * 检查包围盒是否为空
   * @returns {boolean} 如果包围盒为空则返回 true
   */
  isEmpty() {
    return (this.max.x < this.min.x) || (this.max.y < this.min.y) || (this.max.z < this.min.z);
  }

  /**
   * 获取包围盒的中心点
   * @param {Vector3} [target] - 用于存储结果的向量，如果未提供则创建新向量
   * @returns {Vector3} 包围盒的中心点
   */
  getCenter(target) {
    if (target === undefined) {
      target = new Vector3();
    }
    return this.isEmpty() ? 
      target.set(0, 0, 0) : 
      target.addVectors(this.min, this.max).multiplyScalar(0.5);
  }

  /**
   * 获取包围盒的尺寸
   * @param {Vector3} [target] - 用于存储结果的向量，如果未提供则创建新向量
   * @returns {Vector3} 包围盒的尺寸
   */
  getSize(target) {
    if (target === undefined) {
      target = new Vector3();
    }
    return this.isEmpty() ? 
      target.set(0, 0, 0) : 
      target.subVectors(this.max, this.min);
  }

  /**
   * 扩展包围盒以包含指定的点
   * @param {Vector3} point - 要包含的点
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  expandByPoint(point) {
    this.min.min(point);
    this.max.max(point);
    return this;
  }

  /**
   * 根据一组点设置包围盒
   * @param {Array<Vector3>} points - 点的数组
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  setFromPoints(points) {
    this.makeEmpty();
    for (let i = 0; i < points.length; i++) {
      this.expandByPoint(points[i]);
    }
    return this;
  }

  /**
   * 根据 BufferAttribute 设置包围盒
   * @param {BufferAttribute} attribute - 包含顶点位置数据的 BufferAttribute
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  setFromBufferAttribute(attribute) {
    this.makeEmpty();

    const array = attribute.array;
    const itemSize = attribute.itemSize;
    const count = attribute.count;

    for (let i = 0; i < count; i++) {
      const offset = i * itemSize;
      const x = array[offset];
      const y = array[offset + 1];
      const z = itemSize >= 3 ? array[offset + 2] : 0;

      if (x < this.min.x) this.min.x = x;
      if (y < this.min.y) this.min.y = y;
      if (z < this.min.z) this.min.z = z;

      if (x > this.max.x) this.max.x = x;
      if (y > this.max.y) this.max.y = y;
      if (z > this.max.z) this.max.z = z;
    }

    return this;
  }

  /**
   * 根据 3D 对象设置包围盒
   * @param {Object3D} object - 3D 对象
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  setFromObject(object) {
    this.makeEmpty();
    return this.expandByObject(object);
  }

  /**
   * 扩展包围盒以包含 3D 对象
   * @param {Object3D} object - 3D 对象
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  expandByObject(object) {
    // 更新对象的世界矩阵
    object.updateWorldMatrix(false, false);

    const geometry = object.geometry;

    if (geometry !== undefined) {
      if (geometry.boundingBox === null || geometry.boundingBox === undefined) {
        geometry.computeBoundingBox();
      }

      const box = new Box3();
      box.copy(geometry.boundingBox);

      // 应用对象的世界变换矩阵
      box.applyMatrix4(object.matrixWorld);

      this.union(box);
    }

    // 递归处理子对象
    const children = object.children;
    if (children) {
      for (let i = 0; i < children.length; i++) {
        this.expandByObject(children[i]);
      }
    }

    return this;
  }

  /**
   * 应用 4x4 矩阵变换到包围盒
   * @param {Matrix4} matrix - 变换矩阵
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  applyMatrix4(matrix) {
    if (this.isEmpty()) return this;

    // 计算包围盒的8个角点
    const points = [
      new Vector3(this.min.x, this.min.y, this.min.z).applyMatrix4(matrix),
      new Vector3(this.min.x, this.min.y, this.max.z).applyMatrix4(matrix),
      new Vector3(this.min.x, this.max.y, this.min.z).applyMatrix4(matrix),
      new Vector3(this.min.x, this.max.y, this.max.z).applyMatrix4(matrix),
      new Vector3(this.max.x, this.min.y, this.min.z).applyMatrix4(matrix),
      new Vector3(this.max.x, this.min.y, this.max.z).applyMatrix4(matrix),
      new Vector3(this.max.x, this.max.y, this.min.z).applyMatrix4(matrix),
      new Vector3(this.max.x, this.max.y, this.max.z).applyMatrix4(matrix)
    ];

    this.setFromPoints(points);

    return this;
  }

  /**
   * 将另一个包围盒合并到当前包围盒
   * @param {Box3} box - 要合并的包围盒
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  union(box) {
    this.min.min(box.min);
    this.max.max(box.max);
    return this;
  }

  /**
   * 复制另一个包围盒
   * @param {Box3} box - 源包围盒
   * @returns {Box3} 当前包围盒实例，支持链式调用
   */
  copy(box) {
    this.min.copy(box.min);
    this.max.copy(box.max);
    return this;
  }

  /**
   * 克隆包围盒
   * @returns {Box3} 新的包围盒实例
   */
  clone() {
    return new Box3().copy(this);
  }

  /**
   * 检查包围盒是否包含某个点
   * @param {Vector3} point - 要检查的点
   * @returns {boolean} 如果包含该点则返回 true
   */
  containsPoint(point) {
    return point.x >= this.min.x && point.x <= this.max.x &&
           point.y >= this.min.y && point.y <= this.max.y &&
           point.z >= this.min.z && point.z <= this.max.z;
  }

  /**
   * 检查包围盒是否与另一个包围盒相交
   * @param {Box3} box - 要检查的包围盒
   * @returns {boolean} 如果相交则返回 true
   */
  intersectsBox(box) {
    return !(box.max.x < this.min.x || box.min.x > this.max.x ||
             box.max.y < this.min.y || box.min.y > this.max.y ||
             box.max.z < this.min.z || box.min.z > this.max.z);
  }
}

exports.Box3 = Box3;

