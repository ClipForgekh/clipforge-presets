// 获取AMG引擎API（与three-amg-wrapper一致）
const effect_api = typeof effect !== 'undefined' ? effect : (typeof tt !== 'undefined' ? tt : (typeof lynx !== 'undefined' ? lynx : {}));
const Amaz = effect_api.getAmaz ? effect_api.getAmaz() : null;

const Vector3 = require('./Vector3').Vector3;

/**
 * 颜色类
 */
class Color {
  constructor(r = 1, g = 1, b = 1) {
    // 如果第一个参数是字符串（如 '#FFFFFF'），解析十六进制颜色
    if (typeof r === 'string') {
      this.setHexString(r);
    }
    // 如果只有一个数字参数，可能是十六进制数字（如 0xFFFFFF）
    else if (typeof r === 'number' && arguments.length === 1) {
      this.setHex(r);
    }
    // 否则使用 RGB 值
    else {
      // 如果值大于1，假设是0-255范围，转换为0-1
      this.r = r > 1 ? r / 255 : r;
      this.g = g > 1 ? g / 255 : g;
      this.b = b > 1 ? b / 255 : b;
    }
  }

  set(r, g, b) {
    if(typeof r === 'number' && typeof g === 'number' && typeof b === 'number') {
      this.r = r;
      this.g = g;
      this.b = b;
    } else if (r instanceof Vector3) {
      this.r = r.x;
      this.g = r.y;
      this.b = r.z;
    } else if (r instanceof Color) {
      this.r = r.r;
      this.g = r.g;
      this.b = r.b;
    } else if (Array.isArray(r) && r.length >= 3) {
      this.r = r[0];
      this.g = r[1];
      this.b = r[2];
    } else {
      console.warn('set: Unsupported color format', r, g, b);
    }
    return this;
  }

  setHex(hex) {
    hex = Math.floor(hex);
    this.r = (hex >> 16 & 255) / 255;
    this.g = (hex >> 8 & 255) / 255;
    this.b = (hex & 255) / 255;
    return this;
  }

  setHexString(hexString) {
    // 移除 # 前缀（如果存在）
    hexString = hexString.replace(/^#/, '');
    
    // 如果是3位十六进制（如 'FFF'），扩展为6位（'FFFFFF'）
    if (hexString.length === 3) {
      hexString = hexString.split('').map(char => char + char).join('');
    }
    
    // 解析十六进制字符串为数字
    const hex = parseInt(hexString, 16);
    
    if (isNaN(hex)) {
      console.warn(`Invalid hex color string: ${hexString}, using white`);
      this.setRGB(1, 1, 1);
      return this;
    }
    
    // 转换为 RGB 值（0-1 范围）
    this.r = (hex >> 16 & 255) / 255;
    this.g = (hex >> 8 & 255) / 255;
    this.b = (hex & 255) / 255;
    return this;
  }

  setRGB(r, g, b) {
    this.r = r;
    this.g = g;
    this.b = b;
    return this;
  }

  setHSL(h, s, l) {
    let r, g, b;
    if (s === 0) {
      r = g = b = l;
    } else {
      const hue2rgb = function(p, q, t) {
        if (t < 0) t += 1;
        if (t > 1) t -= 1;
        if (t < 1/6) return p + (q - p) * 6 * t;
        if (t < 1/2) return q;
        if (t < 2/3) return p + (q - p) * (2/3 - t) * 6;
        return p;
      };
      const q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      const p = 2 * l - q;
      r = hue2rgb(p, q, h + 1/3);
      g = hue2rgb(p, q, h);
      b = hue2rgb(p, q, h - 1/3);
    }
    this.r = r;
    this.g = g;
    this.b = b;
    return this;
  }

  toAMGColor() {
    const color = new Amaz.Vector4f();
    color.x = this.r;
    color.y = this.g;
    color.z = this.b;
    color.w = 1.0;
    return color;
  }
}

exports.Color = Color;


