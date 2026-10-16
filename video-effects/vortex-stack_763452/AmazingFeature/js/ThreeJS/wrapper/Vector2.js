// 获取AMG引擎API（与three-amg-wrapper一致）
const effect_api = typeof effect !== 'undefined' ? effect : (typeof tt !== 'undefined' ? tt : (typeof lynx !== 'undefined' ? lynx : {}));
const Amaz = effect_api.getAmaz ? effect_api.getAmaz() : null;

/**
 * 二维向量类
 * 表示2D空间中的点或方向
 */
class Vector2 {
  /**
   * 创建二维向量
   * @param {number} [x=0] - X坐标
   * @param {number} [y=0] - Y坐标
   */
  constructor(x = 0, y = 0) {
    this.x = x;
    this.y = y;
  }

  /**
   * 设置向量的x和y值
   * @param {number} x - 新的X坐标
   * @param {number} y - 新的Y坐标
   * @returns {Vector2} 当前向量实例，支持链式调用
   */
  set(x, y) {
    this.x = x;
    this.y = y;
    return this;
  }

  /**
   * 转换为AMG向量格式
   * @returns {Amaz.Vector2f} AMG引擎兼容的二维向量
   */
  toAMGVector2() {
    return new Amaz.Vector2f(this.x, this.y);
  }

  copy(v) {
    this.x = v.x;
    this.y = v.y;
    return this;
  }

  lerpVectors(vec1, vec2, t) {
    this.x = vec1.x + (vec2.x - vec1.x) * t;
    this.y = vec1.y + (vec2.y - vec1.y) * t;
    return this;
  }

  clone() {
    return new Vector2(this.x, this.y);
  }

  lengthSq(){
    return this.x * this.x + this.y * this.y;
  }

  length(){
    return Math.sqrt(this.x * this.x + this.y * this.y);
  }

  normalize(){
    const length = this.length();
    if (length > 0) {
      this.x /= length;
      this.y /= length;
    }
    return this;
  }

  subScalar( s ) {
    this.x -= s;
    this.y -= s;
    return this;
  }

  addScalar( s ) {
    this.x += s;
    this.y += s;
    return this;
  }

  multiplyScalar( s) {
    this.x *= s;
    this.y *= s;
    return this;
  }

  divideScalar( s) {
    this.x /= s;
    this.y /= s;
    return this;
  }

  /**
   * 计算当前向量到另一个向量的欧几里得距离
   * @param {Vector2} v - 目标向量
   * @returns {number} 两个向量之间的距离
   */
  distanceTo(v) {
    const dx = this.x - v.x;
    const dy = this.y - v.y;
    return Math.sqrt(dx * dx + dy * dy);
  }

  equals(v, epsilon = Number.EPSILON)
  {
    return Math.abs(this.x - v.x) < epsilon && Math.abs(this.y - v.y) < epsilon;
  }

}

exports.Vector2 = Vector2;


