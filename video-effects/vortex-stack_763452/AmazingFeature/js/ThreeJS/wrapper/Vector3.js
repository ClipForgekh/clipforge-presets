// 获取AMG引擎API（与three-amg-wrapper一致）
const effect_api = typeof effect !== 'undefined' ? effect : (typeof tt !== 'undefined' ? tt : (typeof lynx !== 'undefined' ? lynx : {}));
const Amaz = effect_api.getAmaz ? effect_api.getAmaz() : null;

const Quaternion = require('./Quaternion').Quaternion;

/**
 * 三维向量类
 * 表示3D空间中的点、方向或尺寸
 */
class Vector3 {
  /**
   * 创建三维向量
   * @param {number} [x=0] - X坐标
   * @param {number} [y=0] - Y坐标
   * @param {number} [z=0] - Z坐标
   */
  constructor(x = 0, y = 0, z = 0) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  /**
   * 设置向量的x、y和z值
   * @param {number} x - 新的X坐标
   * @param {number} y - 新的Y坐标
   * @param {number} z - 新的Z坐标
   * @returns {Vector3} 当前向量实例，支持链式调用
   */
  set(x, y, z) {
    this.x = x;
    this.y = y;
    this.z = z;
    return this;
  }

  /**
   * 创建向量的一个副本
   * @returns {Vector3} 新的向量实例，包含相同的x、y、z值
   */
  clone() {
    return new Vector3(this.x, this.y, this.z);
  }

  /**
   * 计算向量的长度（模）
   * @returns {number} 向量的长度
   */
  length() {
    return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
  }

  lengthSq() {
    return this.x * this.x + this.y * this.y + this.z * this.z;
  }

  addScaledVector(v, s) {
    this.x += v.x * s;
    this.y += v.y * s;
    this.z += v.z * s;
    return this;
  }

  divideScalar(scalar) {
    this.x /= scalar;
    this.y /= scalar;
    this.z /= scalar;
    return this;
  }

  /**
   * 将向量归一化为单位向量（长度为1）
   * @returns {Vector3} 归一化后的向量实例，支持链式调用
   */
  normalize() {
    const length = this.length();
    if (length > 0) {
      this.x /= length;
      this.y /= length;
      this.z /= length;
    }
    return this;
  }

  /**
   * 将向量的每个分量乘以一个标量值
   * @param {number} scalar - 乘数
   * @returns {Vector3} 当前向量实例，支持链式调用
   */
  multiplyScalar(scalar) {
    this.x *= scalar;
    this.y *= scalar;
    this.z *= scalar;
    return this;
  }

  /**
   * 将另一个向量的分量添加到当前向量
   * @param {Vector3} v - 要添加的向量
   * @returns {Vector3} 当前向量实例，支持链式调用
   */
  add(v) {
    this.x += v.x;
    this.y += v.y;
    this.z += v.z;
    return this;
  }

  /**
   * 计算当前向量与另一个向量的点积
   * @param {Vector3} v - 要计算点积的向量
   * @returns {number} 两个向量的点积
   */
  dot(v) {
    return this.x * v.x + this.y * v.y + this.z * v.z;
  }

  /**
   * 计算当前向量与另一个向量的叉积
   * @param {Vector3} v - 要计算叉积的向量
   * @param {Vector3} [target] - 可选的目标向量，用于存储结果。如果不提供，结果将存储在当前向量中
   * @returns {Vector3} 存储结果的向量（target 或 this），支持链式调用
   */
  cross(v, target) {
    const ax = this.x, ay = this.y, az = this.z;
    const bx = v.x, by = v.y, bz = v.z;
    
    if (target) {
      target.x = ay * bz - az * by;
      target.y = az * bx - ax * bz;
      target.z = ax * by - ay * bx;
      return target;
    } else {
      this.x = ay * bz - az * by;
      this.y = az * bx - ax * bz;
      this.z = ax * by - ay * bx;
      return this;
    }
  }

  /**
   * 从当前向量中减去另一个向量
   * @param {Vector3} v - 要减去的向量
   * @returns {Vector3} 当前向量实例，支持链式调用
   */
  sub(v) {
    this.x -= v.x;
    this.y -= v.y;
    this.z -= v.z;
    return this;
  }

  /**
   * 将另一个向量的值复制到当前向量
   * @param {Vector3} v - 要复制的向量
   * @returns {Vector3} 当前向量实例，支持链式调用
   */
  copy(v) {
    this.x = v.x;
    this.y = v.y;
    this.z = v.z;
    return this;
  }

  lerp(v, t) {
    this.x = this.x + (v.x - this.x) * t;
    this.y = this.y + (v.y - this.y) * t;
    this.z = this.z + (v.z - this.z) * t;
    return this;
  }

  lerpVectors(vec1, vec2, t) {
    this.x = vec1.x + (vec2.x - vec1.x) * t;
    this.y = vec1.y + (vec2.y - vec1.y) * t;
    this.z = vec1.z + (vec2.z - vec1.z) * t;
    return this;
  }

  applyQuaternion(quat){
    const qx = quat.x;
    const qy = quat.y;
    const qz = quat.z;
    const qw = quat.w;

    const vx = this.x;
    const vy = this.y;
    const vz = this.z;

    const x = (qw * qw + qx * qx - qy * qy - qz * qz) * vx +
              (2 * (qx * qy - qw * qz)) * vy +
              (2 * (qx * qz + qw * qy)) * vz;

    const y = (2 * (qx * qy + qw * qz)) * vx +
              (qw * qw - qx * qx + qy * qy - qz * qz) * vy +
              (2 * (qy * qz - qw * qx)) * vz;

    const z = (2 * (qx * qz - qw * qy)) * vx +
              (2 * (qy * qz + qw * qx)) * vy +
              (qw * qw - qx * qx - qy * qy + qz * qz) * vz;

    this.x = x;
    this.y = y;
    this.z = z;
    return this;
  }

  applyMatrix4(matrix) {
    const e = matrix.elements;
    const x = this.x, y = this.y, z = this.z;

    const w = e[3] * x + e[7] * y + e[11] * z + e[15];
    this.x = e[0] * x + e[4] * y + e[8] * z + e[12];
    this.y = e[1] * x + e[5] * y + e[9] * z + e[13];
    this.z = e[2] * x + e[6] * y + e[10] * z + e[14];

    if (w !== 1 && w !== 0) {
      this.x /= w; this.y /= w; this.z /= w;
    }
    return this;
  }

  applyAxisAngle(vector, angle){
    const axis = vector.clone().normalize();
    const q = new Quaternion().setFromAxisAngle(axis, angle);
    this.applyQuaternion(q);
    return this;
  }

  applyEuler(euler){
    const q = new Quaternion().setFromEuler(euler);
    this.applyQuaternion(q);
    return this;
  }

  addVectors(a, b) {
    this.x = a.x + b.x;
    this.y = a.y + b.y;
    this.z = a.z + b.z;
    return this;
  }

  subVectors(a, b) {
    this.x = a.x - b.x;
    this.y = a.y - b.y;
    this.z = a.z - b.z;
    return this;
  }

	subScalar( s ) {
		this.x -= s;
		this.y -= s;
		this.z -= s;
		return this;
	}

  addScalar( s ) {
    this.x += s;
    this.y += s;
    this.z += s;
    return this;
  }

  toAMGVector3() {
    return new Amaz.Vector3f(this.x, this.y, this.z);
  }

  multiplyScalar( s) {
    this.x *= s;
    this.y *= s;
    this.z *= s;
    return this;
  }

  divideScalar( s) {
    this.x /= s;
    this.y /= s;
    this.z /= s;
    return this;
  }

  /**
   * 将当前向量的每个分量设置为自身和另一个向量对应分量的最小值
   * @param {Vector3} v - 要比较的向量
   * @returns {Vector3} 当前向量实例，支持链式调用
   */
  min(v) {
    this.x = Math.min(this.x, v.x);
    this.y = Math.min(this.y, v.y);
    this.z = Math.min(this.z, v.z);
    return this;
  }

  /**
   * 将当前向量的每个分量设置为自身和另一个向量对应分量的最大值
   * @param {Vector3} v - 要比较的向量
   * @returns {Vector3} 当前向量实例，支持链式调用
   */
  max(v) {
    this.x = Math.max(this.x, v.x);
    this.y = Math.max(this.y, v.y);
    this.z = Math.max(this.z, v.z);
    return this;
  }

    /**
   * 计算当前向量到另一个向量的欧几里得距离
   * @param {Vector3} v - 目标向量
   * @returns {number} 两个向量之间的距离
   */
    distanceTo(v) {
      const dx = this.x - v.x;
      const dy = this.y - v.y;
      const dz = this.z - v.z;
      return Math.sqrt(dx * dx + dy * dy + dz * dz);
    }

  equals(v, epsilon = Number.EPSILON)
  {
    return Math.abs(this.x - v.x) < epsilon && Math.abs(this.y - v.y) < epsilon && Math.abs(this.z - v.z) < epsilon;
  }
}

exports.Vector3 = Vector3;


