/**
 * 欧拉角类，表示物体在3D空间中的旋转
 * 通过绕x、y、z轴的旋转角度来表示方向
 */
class Euler {
  /**
   * 创建欧拉角
   * @param {number} [x=0] - 绕X轴的旋转角度（弧度）
   * @param {number} [y=0] - 绕Y轴的旋转角度（弧度）
   * @param {number} [z=0] - 绕Z轴的旋转角度（弧度）
   * @param {string} [order='XYZ'] - 旋转轴的应用顺序
   */
  constructor(x = 0, y = 0, z = 0, order = 'XYZ') {
    this.x = x;
    this.y = y;
    this.z = z;
    this.order = order;
  }

  set(x, y, z, order) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.order = order || this.order;
    return this;
  }

  setFromUnitVectors(vFrom, vTo) {
    const from = vFrom.clone().normalize();
    const to = vTo.clone().normalize();

    const pitch = Math.asin(to.y);
    const yaw = Math.atan2(to.x, to.z);
    const roll = 0;

    this.x = pitch;
    this.y = -yaw;
    this.z = roll;
    return this;
  }

  setFromQuaternion(q, order) {
    this.x = q.x;
    this.y = q.y;
    this.z = q.z;
    this.order = order || this.order;
    return this;
  }

  clone() {
    return new Euler(this.x, this.y, this.z, this.order);
  }
}

exports.Euler = Euler;


