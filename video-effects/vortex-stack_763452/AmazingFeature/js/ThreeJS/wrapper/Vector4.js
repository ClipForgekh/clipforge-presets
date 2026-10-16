// 获取AMG引擎API（与three-amg-wrapper一致）
const effect_api = typeof effect !== 'undefined' ? effect : (typeof tt !== 'undefined' ? tt : (typeof lynx !== 'undefined' ? lynx : {}));
const Amaz = effect_api.getAmaz ? effect_api.getAmaz() : null;

/**
 * 四维向量类
 * 表示4D空间中的点、方向或颜色（RGBA）
 */
class Vector4 {
  /**
   * 创建四维向量
   * @param {number} [x=0] - X坐标
   * @param {number} [y=0] - Y坐标
   * @param {number} [z=0] - Z坐标
   * @param {number} [w=0] - W坐标
   */
  constructor(x = 0, y = 0, z = 0, w = 0) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
  }

  set(x, y, z, w) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    return this;
  }

  clone() {
    return new Vector4(this.x, this.y, this.z, this.w);
  }

  length() {
    return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w);
  }

  normalize() {
    const length = this.length();
    if (length > 0) {
      this.x /= length;
      this.y /= length;
      this.z /= length;
      this.w /= length;
    }
    return this;
  }

  multiplyScalar(scalar) {
    this.x *= scalar;
    this.y *= scalar;
    this.z *= scalar;
    this.w *= scalar;
    return this;
  }

  add(v) {
    this.x += v.x;
    this.y += v.y;
    this.z += v.z;
    this.w += v.w;
    return this;
  }

  dot(v) {
    return this.x * v.x + this.y * v.y + this.z * v.z + this.w * v.w;
  }

  sub(v) {
    this.x -= v.x;
    this.y -= v.y;
    this.z -= v.z;
    this.w -= v.w;
    return this;
  }

  copy(v) {
    this.x = v.x;
    this.y = v.y;
    this.z = v.z;
    this.w = v.w;
    return this;
  }

	subScalar( s ) {
		this.x -= s;
		this.y -= s;
		this.z -= s;
		this.w -= s;
		return this;
	}

  addScalar( s ) {
    this.x += s;
    this.y += s;
    this.z += s;
    this.w += s;
    return this;
  }

  multiplyScalar( s) {
    this.x *= s;
    this.y *= s;
    this.z *= s;
    this.w *= s;
    return this;
  }

  divideScalar( s) {
    this.x /= s;
    this.y /= s;
    this.z /= s;
    this.w /= s;
    return this;
  }

  equals(v, epsilon = Number.EPSILON)
  {
    return Math.abs(this.x - v.x) < epsilon && Math.abs(this.y - v.y) < epsilon && Math.abs(this.z - v.z) < epsilon && Math.abs(this.w - v.w) < epsilon;
  }

  toAMGVector4() {
    return new Amaz.Vector4f(this.x, this.y, this.z, this.w);
  }
}

exports.Vector4 = Vector4;


