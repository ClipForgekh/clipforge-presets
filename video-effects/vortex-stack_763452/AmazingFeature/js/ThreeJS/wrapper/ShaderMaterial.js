const Material = require('./Material').Material;
const __THREE_CONSTS = require('./Constants');
const getCurrentScene = require('./runtime').getCurrentScene;
const Vector2 = require('./Vector2').Vector2;
const Vector3 = require('./Vector3').Vector3;
const Vector4 = require('./Vector4').Vector4;
const Color = require('./Color').Color;
const Texture = require('./Texture').Texture;

const ARRAY_PROXY_FLAG = Symbol('ShaderMaterialArrayProxy');
const MUTATING_ARRAY_METHODS = new Set(['push','pop','shift','unshift','splice','sort','reverse','fill','copyWithin','copy','set']);

const __uniformBindingMap = new WeakMap();
/**
 * 注册uniform绑定关系
 * 将uniform对象与material和key建立绑定，用于后续通知更新
 * @param {Object} uniform - uniform对象
 * @param {ShaderMaterial} material - 材质实例
 * @param {string} key - uniform的键名
 */
function __registerUniformBinding(uniform, material, key) {
  let list = __uniformBindingMap.get(uniform);
  if (!list) { list = []; __uniformBindingMap.set(uniform, list); }
  if (!list.some(b => b.material === material && b.key === key)) {
    list.push({ material, key });
  }
}
/**
 * 通知所有绑定的材质更新uniform值
 * 当uniform值改变时，通知所有使用该uniform的材质同步更新
 * @param {Object} uniform - uniform对象
 * @param {*} value - 新的uniform值
 */
function __notifyUniformBindings(uniform, value) {
  const list = __uniformBindingMap.get(uniform);
  if (!list) return;
  for (const b of list) {
    if (b && b.material && typeof b.material._syncUniformToAMG === 'function') {
      b.material._syncUniformToAMG(b.key, value);
    }
  }
}

class ShaderMaterial extends Material {
  /**
   * 构造函数
   * 创建ShaderMaterial实例，初始化材质属性、uniforms和shader代码
   * @param {Object} parameters - 材质参数
   * @param {Object} parameters.uniforms - uniforms对象
   * @param {string} parameters.vertexShader - 顶点着色器代码
   * @param {string} parameters.fragmentShader - 片段着色器代码
   * @param {boolean} parameters.transparent - 是否透明
   * @param {number} parameters.opacity - 透明度
   * @param {boolean} parameters.depthTest - 是否深度测试
   * @param {boolean} parameters.depthWrite - 是否深度写入
   * @param {number} parameters.blending - 混合模式
   */
  constructor(parameters = {}) {
    super();
    this.originalVertexShader = parameters.vertexShader;
    this.originalFragmentShader = parameters.fragmentShader;
    this.scene = getCurrentScene();
    this._amgObject = this.scene._amgScene.assetMgr.SyncLoad('material/Unlit/Unlit.material').clone();

    this.transparent = parameters.transparent || false;
    this.opacity = parameters.opacity !== undefined ? parameters.opacity : 1.0;

    // 根据透明属性自动配置深度，允许用户显式覆盖
    this._applyDepthDefaults(
      this.transparent,
      parameters.depthTest,
      parameters.depthWrite
    );

    if (this.transparent == true) {
      this.blending = parameters.blending !== undefined ? parameters.blending : __THREE_CONSTS.NormalBlending;
    }
    else {
      this.blending = parameters.blending !== undefined ? parameters.blending : __THREE_CONSTS.NoBlending;
    }

    this._originalUniforms = parameters.uniforms || {};
    this._uniforms = this._createUniformsProxy(this._originalUniforms);
    this._hookUniforms(this._originalUniforms);

    if (parameters.uniforms) {
      for (const [key, value] of Object.entries(parameters.uniforms)) {
        this._syncUniformToAMG(key, value.value);
      }
    }

    let key = '';
    if (parameters.vertexShader && parameters.fragmentShader) {
      let vertLength = parameters.vertexShader.length;
      let fragLength = parameters.fragmentShader.length;
      if (vertLength > 0 && fragLength > 0) {
        key = 'c_'+vertLength+'_'+fragLength;
      }
    }

    let xshader = this._amgObject.xshader.clone();
    let passes = xshader.passes;
    let pass = passes.get(0);
    let shaders = pass.shaders;
    let gles2 = shaders.get('gles2');
    let glesShader1 = gles2.get(0);
    let glesShader2 = gles2.get(1);

    if (parameters.vertexShader) {
      let shader = parameters.vertexShader;
      shader = shader.replace(/\buv\b/g, 'attTexcoord0');
      shader = shader.replace(/\bnormal\b/g, 'attNormal');
      shader = shader.replace(/\bposition\b/g, 'attPosition');
      shader = shader.replace(/\bnormalMatrix\b/g, 'mat3(u_MV)');
      shader = shader.replace(/\bmodelMatrix\b/g, 'u_Model');
      shader = shader.replace(/\bviewMatrix\b/g, 'u_View');
      shader = shader.replace(/\bmodelViewMatrix\b/g, 'u_MV');
      shader = shader.replace(/\bprojectionMatrix\b/g, 'u_Projection');
      shader = shader.replace(/\bmodelViewProjectionMatrix\b/g, 'u_MVP');
      shader = shader.replace(/\bu_Projection \* u_View \* u_Model\b/g, 'u_MVP');
      shader = shader.replace(/\bu_Projection \* u_MV\b/g, 'u_MVP');
      parameters.vertexShader = 'precision highp float; attribute vec3 attPosition; attribute vec2 attTexcoord0; attribute vec3 attNormal; uniform mat4 u_MVP; uniform mat4 u_MV; uniform mat4 u_Projection; uniform mat4 u_Model; uniform mat4 u_View; ' + shader;
      glesShader1.source = parameters.vertexShader; glesShader1.sourcePath = '';
    }
    if (parameters.fragmentShader) {
      parameters.fragmentShader = 'precision highp float;' + parameters.fragmentShader;
      glesShader2.source = parameters.fragmentShader; glesShader2.sourcePath = '';
    }

    // check the metal file exists.
    var rootDir = this.scene._amgScene.assetMgr.rootDir;
    var vertMetalPath = rootDir+'xshader/'+key+'.vert.metal';
    var fragMetalPath = rootDir+'xshader/'+key+'.frag.metal';

    var metalFileExist = false;
    var swingTemplateUtils = null 
    if (effect.Amaz.SwingTemplateUtils) {
      swingTemplateUtils = new effect.Amaz.SwingTemplateUtils();
    }
    if (swingTemplateUtils && swingTemplateUtils.isFileExist(vertMetalPath) && swingTemplateUtils.isFileExist(fragMetalPath)) {
      metalFileExist = true;
    }
    // console.log("MetalFileExist: ", metalFileExist, "vertMetalPath: ", vertMetalPath, "fragMetalPath: ", fragMetalPath);

    // if the metal file does not exist, remove the metal shader.
    if (metalFileExist == false) {
      let metal = shaders.get('metal');
      if (metal) {
        shaders.remove('metal');
      }
    }
    // if the metal file exists, change the metal shader.
    else {
      let metal = shaders.get('metal');
      let metalShader1 = metal.get(0);
      let metalShader2 = metal.get(1);
      metalShader1.source = ''; metalShader1.sourcePath = 'xshader/'+key+'.vert.metal';
      metalShader2.source = ''; metalShader2.sourcePath = 'xshader/'+key+'.frag.metal';
    }

    // console.log("shaders.size(): ", shaders.size());

    this._amgObject.xshader = xshader;
  }

  /**
   * 创建uniforms代理对象
   * 为每个uniform创建getter/setter代理，保持对原始uniform的引用
   * @param {Object} originalUniforms - 原始uniforms对象
   * @returns {Object} uniforms代理对象
   */
  _createUniformsProxy(originalUniforms) {
    const uniformsProxy = {};
    for (const [key, uniform] of Object.entries(originalUniforms)) {
      uniformsProxy[key] = {
        get value() { return uniform.value; },
        set value(newValue) { uniform.value = newValue; }
      };
    }
    return uniformsProxy;
  }

  /**
   * 为所有uniforms添加钩子
   * 遍历所有uniforms，为每个uniform添加值变化监听
   * @param {Object} originalUniforms - 原始uniforms对象
   */
  _cloneUniforms(sourceUniforms) {
    if (!sourceUniforms) return {};
    const cloned = {};
    for (const [key, uniform] of Object.entries(sourceUniforms)) {
      if (!uniform || typeof uniform !== 'object') continue;
      cloned[key] = {
        value: this._cloneUniformValue(uniform.value)
      };
    }
    return cloned;
  }

  _cloneUniformValue(value) {
    if (value instanceof Texture) {
      return value;
    }
    if (value instanceof Vector2 || value instanceof Vector3 || value instanceof Vector4) {
      return typeof value.clone === 'function' ? value.clone() : value;
    }
    if (value instanceof Color) {
      return new Color(value.r, value.g, value.b);
    }
    if (Array.isArray(value)) {
      return value.map(v => this._cloneUniformValue(v));
    }
    if (value && typeof value === 'object') {
      return { ...value };
    }
    return value;
  }

  _hookUniforms(originalUniforms) {
    if (!originalUniforms) return;
    for (const [key, uniform] of Object.entries(originalUniforms)) {
      this._hookSingleUniform(key, uniform);
    }
  }

  /**
   * 为单个uniform添加钩子
   * 重写uniform.value的getter/setter，实现值变化时的自动同步
   * @param {string} key - uniform的键名
   * @param {Object} uniform - uniform对象
   */
  _hookSingleUniform(key, uniform) {
    if (!uniform || typeof uniform !== 'object') return;
    this._normalizeUniformValue(uniform);
    __registerUniformBinding(uniform, this, key);
    this._attachUniformVectorObserver(uniform);
    this._attachUniformArrayObserver(uniform, key);
    if (uniform._amgUniformHooked) return;
    try {
      let _val = uniform.value;
      Object.defineProperty(uniform, 'value', {
        get: () => _val,
        set: (v) => {
          _val = this._convertUniformValue(v);
          this._attachUniformVectorObserver(uniform, _val);
          const proxied = this._attachUniformArrayObserver(uniform, key, _val);
          if (proxied) {
            _val = proxied;
          }
          __notifyUniformBindings(uniform, _val);
        },
        enumerable: true,
        configurable: true
      });
      const proxied = this._attachUniformArrayObserver(uniform, key, _val);
      if (proxied) {
        _val = proxied;
      }
      Object.defineProperty(uniform, '_amgUniformHooked', { value: true, enumerable: false, configurable: true });
    } catch (e) {}
  }

  /**
   * 检查对象是否具有向量特征
   * 判断对象是否包含指定的组件属性且都是数字类型
   * @param {Object} obj - 待检查的对象
   * @param {string[]} components - 需要检查的组件名称数组，如['x', 'y', 'z']
   * @returns {boolean} 如果对象具有向量特征返回true，否则返回false
   */
  _looksLikeVector(obj, components) {
    if (!obj || typeof obj !== 'object') return false;
    return components.every(c => typeof obj[c] === 'number');
  }

  /**
   * 规范化uniform值
   * 将uniform.value转换为标准格式（如数组转为Vector对象）
   * @param {Object} uniform - uniform对象
   */
  _normalizeUniformValue(uniform) {
    if (!uniform || typeof uniform !== 'object' || !('value' in uniform)) return;
    const converted = this._convertUniformValue(uniform.value);
    if (converted === uniform.value) return;

    const descriptor = Object.getOwnPropertyDescriptor(uniform, 'value');
    if (descriptor && typeof descriptor.set === 'function' && typeof descriptor.get === 'function') {
      descriptor.set.call(uniform, converted);
    } else {
      uniform.value = converted;
    }
  }

  /**
   * 转换uniform值为标准格式
   * 将各种格式的值（数组、对象、Color等）转换为Vector2/Vector3/Vector4对象
   * @param {*} value - 待转换的值，可以是数组、对象、Color、Vector等
   * @returns {Vector2|Vector3|Vector4|*} 转换后的Vector对象，如果无法转换则返回原值
   */
  _convertUniformValue(value) {
    if (value instanceof Vector2 || value instanceof Vector3 || value instanceof Vector4) {
      return value;
    }

    if (value instanceof Color) {
      return new Vector3(value.r, value.g, value.b);
    }

    if (Array.isArray(value)) {
      const nums = value;
      if (nums.length === 2 && nums.every(v => typeof v === 'number')) {
        return new Vector2(nums[0], nums[1]);
      } else if (nums.length === 3 && nums.every(v => typeof v === 'number')) {
        return new Vector3(nums[0], nums[1], nums[2]);
      } else if (nums.length === 4 && nums.every(v => typeof v === 'number')) {
        return new Vector4(nums[0], nums[1], nums[2], nums[3]);
      }
      return value;
    }

    if (this._looksLikeVector(value, ['x', 'y', 'z', 'w'])) {
      return new Vector4(value.x, value.y, value.z, value.w);
    } else if (this._looksLikeVector(value, ['x', 'y', 'z'])) {
      return new Vector3(value.x, value.y, value.z);
    } else if (this._looksLikeVector(value, ['x', 'y'])) {
      return new Vector2(value.x, value.y);
    }
    return value;
  }

  /**
   * 为Vector/Color对象添加观察者
   * 包装Vector/Color的修改方法（set、copy等），使其在值改变时自动通知uniform更新
   * @param {Object} uniform - uniform对象
   * @param {Vector2|Vector3|Vector4|Color} valueOverride - 可选的值覆盖，如果提供则使用此值而不是uniform.value
   */
  _attachUniformVectorObserver(uniform, valueOverride) {
    if (!uniform || typeof uniform !== 'object' || !('value' in uniform)) return;
    const value = valueOverride || uniform.value;
    if (!(value instanceof Vector2 || value instanceof Vector3 || value instanceof Vector4 || value instanceof Color)) {
      return;
    }
    if (value.__amgUniformVectorHooked) return;
    const wrapMethod = (methodName) => {
      if (typeof value[methodName] !== 'function') return;
      const original = value[methodName].bind(value);
      value[methodName] = (...args) => {
        const result = original(...args);
        __notifyUniformBindings(uniform, value);
        return result;
      };
    };
    wrapMethod('set');
    wrapMethod('copy');
    // Color 类有 set, setRGB, setHex, setHexString, setHSL 等方法
    if (value instanceof Color) {
      wrapMethod('setRGB');
      wrapMethod('setHex');
      wrapMethod('setHexString');
      wrapMethod('setHSL');
    }
    Object.defineProperty(value, '__amgUniformVectorHooked', {
      value: true,
      enumerable: false,
      configurable: true
    });
  }

  /**
   * 为数组类型的uniform值添加观察者
   * 为数组或类型化数组创建Proxy代理，监听数组变化并自动同步
   * @param {Object} uniform - uniform对象
   * @param {string} key - uniform的键名
   * @param {*} valueOverride - 可选的值覆盖
   * @returns {Proxy|null} 数组代理对象，如果不是数组则返回null
   */
  _attachUniformArrayObserver(uniform, key, valueOverride) {
    if (!uniform || typeof uniform !== 'object') return null;
    const value = valueOverride || uniform.value;
    const isTyped = this._isTypedArray(value);
    if (!Array.isArray(value) && !isTyped) return null;
    if (value && value[ARRAY_PROXY_FLAG]) return value;
    const notifyArrayChange = () => {
      try { __notifyUniformBindings(uniform, proxy); }
      catch (e) {
        try { this._syncUniformToAMG(key, { value: proxy }); } catch (err) {}
      }
    };
    const proxy = this._getArrayProxy(value, notifyArrayChange);
    // 为数组中的 Vector2/3/4 元素也添加 observer，使其在修改时触发数组同步
    if (Array.isArray(value)) {
      for (let i = 0; i < value.length; i++) {
        const element = value[i];
        if (element instanceof Vector2 || element instanceof Vector3 || element instanceof Vector4) {
          if (!element.__amgArrayElementHooked) {
            const wrapElementMethod = (methodName) => {
              if (typeof element[methodName] !== 'function') return;
              const original = element[methodName].bind(element);
              element[methodName] = (...args) => {
                const result = original(...args);
                notifyArrayChange();
                return result;
              };
            };
            wrapElementMethod('set');
            wrapElementMethod('copy');
            Object.defineProperty(element, '__amgArrayElementHooked', {
              value: true,
              enumerable: false,
              configurable: true
            });
          }
        }
      }
    }
    return proxy;
  }

  /**
   * 获取数组代理对象
   * 为数组创建Proxy代理，拦截数组的修改操作（push、pop、set等）并触发回调
   * @param {Array|TypedArray} arrayTarget - 目标数组
   * @param {Function} onChange - 数组变化时的回调函数
   * @returns {Proxy} 数组代理对象
   */
  _getArrayProxy(arrayTarget, onChange) {
    if (!this._arrayProxyMap) {
      this._arrayProxyMap = new WeakMap();
    }
    if (this._arrayProxyMap.has(arrayTarget)) {
      return this._arrayProxyMap.get(arrayTarget);
    }
    const notifyChange = () => {
      try { onChange(); } catch (e) {}
    };
    const handler = {
      get(target, prop, receiver) {
        const value = Reflect.get(target, prop, receiver);
        if (typeof value === 'function' && MUTATING_ARRAY_METHODS.has(prop)) {
          return function() {
            const result = value.apply(target, arguments);
            notifyChange();
            return result;
          };
        }
        // 如果访问的是数组索引且返回的是 Vector 对象，为其添加 observer
        if (typeof prop === 'string' && /^\d+$/.test(prop) && (value instanceof Vector2 || value instanceof Vector3 || value instanceof Vector4)) {
          if (!value.__amgArrayElementHooked) {
            const wrapElementMethod = (methodName) => {
              if (typeof value[methodName] !== 'function') return;
              const original = value[methodName].bind(value);
              value[methodName] = (...args) => {
                const result = original(...args);
                notifyChange();
                return result;
              };
            };
            wrapElementMethod('set');
            wrapElementMethod('copy');
            Object.defineProperty(value, '__amgArrayElementHooked', {
              value: true,
              enumerable: false,
              configurable: true
            });
          }
        }
        return value;
      },
      set(target, prop, value, receiver) {
        const result = Reflect.set(target, prop, value, receiver);
        // 如果设置的是 Vector 对象，为其添加 observer
        if (typeof prop === 'string' && /^\d+$/.test(prop) && (value instanceof Vector2 || value instanceof Vector3 || value instanceof Vector4)) {
          if (!value.__amgArrayElementHooked) {
            const wrapElementMethod = (methodName) => {
              if (typeof value[methodName] !== 'function') return;
              const original = value[methodName].bind(value);
              value[methodName] = (...args) => {
                const result = original(...args);
                notifyChange();
                return result;
              };
            };
            wrapElementMethod('set');
            wrapElementMethod('copy');
            Object.defineProperty(value, '__amgArrayElementHooked', {
              value: true,
              enumerable: false,
              configurable: true
            });
          }
        }
        notifyChange();
        return result;
      }
    };
    const proxy = new Proxy(arrayTarget, handler);
    Object.defineProperty(proxy, ARRAY_PROXY_FLAG, {
      value: true,
      enumerable: false,
      configurable: false
    });
    this._arrayProxyMap.set(arrayTarget, proxy);
    return proxy;
  }

  /**
   * 检查值是否为类型化数组
   * 判断值是否为TypedArray（如Float32Array、Int32Array等）
   * @param {*} value - 待检查的值
   * @returns {boolean} 如果是类型化数组返回true，否则返回false
   */
  _isTypedArray(value) {
    return typeof ArrayBuffer !== 'undefined'
      && typeof ArrayBuffer.isView === 'function'
      && ArrayBuffer.isView(value);
  }

  /**
   * 解析uniform的值和类型
   * 从uniform对象或值中提取实际的值和类型信息
   * @param {string} key - uniform的键名
   * @param {*} valueOrObject - uniform值或包含value和type的对象
   * @returns {Object} 包含value和type的对象
   */
  _resolveUniformValueAndType(key, valueOrObject) {
    let resolvedValue = valueOrObject;
    let resolvedType = undefined;
    if (valueOrObject && typeof valueOrObject === 'object' && valueOrObject !== null && 'value' in valueOrObject) {
      resolvedValue = valueOrObject.value;
      resolvedType = valueOrObject.type;
    }
    if (!resolvedType && this._originalUniforms && this._originalUniforms[key] && typeof this._originalUniforms[key] === 'object') {
      resolvedType = this._originalUniforms[key].type;
    }
    return { value: resolvedValue, type: resolvedType };
  }

  /**
   * 同步uniform值到AMG引擎
   * 将uniform值转换为AMG引擎所需的格式并设置到材质中
   * 支持的类型：Texture、Vector2/3/4、Color、number、boolean、数组等
   * @param {string} key - uniform的键名
   * @param {*} valueOrObject - uniform值或包含value和type的对象
   */
  _syncUniformToAMG(key, valueOrObject) {
    if (!this._amgObject) return;
    const { value, type } = this._resolveUniformValueAndType(key, valueOrObject);
    if (value === undefined || value === null) return;

    // 先转换值（如 Color 转为 Vector3），但保留数组类型以便后续处理
    const convertedValue = (Array.isArray(value) || this._isTypedArray(value)) ? value : this._convertUniformValue(value);

    let yModified = undefined;
    if (convertedValue instanceof Vector2 || convertedValue instanceof Vector3) {
      if (key === 'videoTextureRepeat') yModified = -convertedValue.y;
      else if (key === 'videoTextureOffset') yModified = -convertedValue.y + 1;
      else yModified = convertedValue.y;
    }

    const toVec2 = (x, y) => new effect.Amaz.Vector2f(x, y);
    const toVec3 = (x, y, z) => new effect.Amaz.Vector3f(x, y, z);
    const toVec4 = (x, y, z, w) => new effect.Amaz.Vector4f(x, y, z, w);
    const numbersOnly = (arr) => Array.isArray(arr) && arr.every(item => typeof item === 'number');

    try {
      if (convertedValue instanceof Texture) {
        this._amgObject.setTex(key, convertedValue._amgObject);
        return;
      }
      if (convertedValue instanceof Vector2) {
        const y = (typeof yModified === 'number') ? yModified : convertedValue.y;
        this._amgObject.setVec2(key, toVec2(convertedValue.x, y));
        return;
      }
      if (convertedValue instanceof Vector3) {
        this._amgObject.setVec3(key, toVec3(convertedValue.x, convertedValue.y, convertedValue.z));
        return;
      }
      if (convertedValue instanceof Vector4) {
        this._amgObject.setVec4(key, toVec4(convertedValue.x, convertedValue.y, convertedValue.z, convertedValue.w));
        return;
      }
      if (typeof convertedValue === 'number') {
        if (type && type === 'i') {
          this._amgObject.setInt(key, convertedValue);
        } else {
          this._amgObject.setFloat(key, convertedValue);
        }
        return;
      }
      if (typeof convertedValue === 'boolean') {
        this._amgObject.setFloat(key, convertedValue ? 1.0 : 0.0);
        return;
      }

      if (Array.isArray(convertedValue) || this._isTypedArray(convertedValue)) {
        let arr = Array.isArray(convertedValue) ? convertedValue.slice() : Array.from(convertedValue);
        if (Array.isArray(arr[0])) {
          arr = arr.flat();
        }
        const allNums = numbersOnly(arr);

        if (!type || type === 'vec2' || type === 'vec3' || type === 'vec4') {
          if (arr.length === 2 && allNums && (!type || type === 'vec2')) {
            this._amgObject.setVec2(key, toVec2(arr[0], arr[1]));
            return;
          }
          if (arr.length === 3 && allNums && (!type || type === 'vec3')) {
            this._amgObject.setVec3(key, toVec3(arr[0], arr[1], arr[2]));
            return;
          }
          if (arr.length === 4 && allNums && (!type || type === 'vec4')) {
            this._amgObject.setVec4(key, toVec4(arr[0], arr[1], arr[2], arr[3]));
            return;
          }
        }

        const setVec2Array = (list) => {
          const vecs = new effect.Amaz.Vec2Vector();
          if (numbersOnly(list)) {
            if (list.length % 2 !== 0) {
              console.warn(`Expected vec2[] for ${key}, got length ${list.length}`);
            }
            for (let i = 0; i < list.length; i += 2) {
              const x = list[i];
              const y = list[i + 1] !== undefined ? list[i + 1] : 0;
              vecs.pushBack(toVec2(x, y));
            }
          } else {
            for (const item of list) {
              if (this._looksLikeVector(item, ['x', 'y'])) {
                vecs.pushBack(toVec2(item.x, item.y));
              } else if (Array.isArray(item) && item.length >= 2) {
                vecs.pushBack(toVec2(item[0], item[1]));
              }
            }
          }
          this._amgObject.setVec2Vector(key, vecs);
        };

        const setVec3Array = (list) => {
          const vecs = new effect.Amaz.Vec3Vector();
          if (numbersOnly(list)) {
            if (list.length % 3 !== 0) {
              console.warn(`Expected vec3[] for ${key}, got length ${list.length}`);
            }
            for (let i = 0; i < list.length; i += 3) {
              vecs.pushBack(toVec3(list[i], list[i + 1] ?? 0, list[i + 2] ?? 0));
            }
          } else {
            for (const item of list) {
              if (item instanceof Color) {
                vecs.pushBack(toVec3(item.r, item.g, item.b));
              } else if (this._looksLikeVector(item, ['x', 'y', 'z'])) {
                vecs.pushBack(toVec3(item.x, item.y, item.z));
              } else if (Array.isArray(item) && item.length >= 3) {
                vecs.pushBack(toVec3(item[0], item[1], item[2]));
              }
            }
          }
          this._amgObject.setVec3Vector(key, vecs);
        };

        const setVec4Array = (list) => {
          const vecs = new effect.Amaz.Vec4Vector();
          if (numbersOnly(list)) {
            if (list.length % 4 !== 0) {
              console.warn(`Expected vec4[] for ${key}, got length ${list.length}`);
            }
            for (let i = 0; i < list.length; i += 4) {
              vecs.pushBack(toVec4(list[i], list[i + 1] ?? 0, list[i + 2] ?? 0, list[i + 3] ?? 0));
            }
          } else {
            for (const item of list) {
              if (this._looksLikeVector(item, ['x', 'y', 'z', 'w'])) {
                vecs.pushBack(toVec4(item.x, item.y, item.z, item.w));
              } else if (Array.isArray(item) && item.length >= 4) {
                vecs.pushBack(toVec4(item[0], item[1], item[2], item[3]));
              }
            }
          }
          this._amgObject.setVec4Vector(key, vecs);
        };

        const setFloatArray = (list) => {
          const floats = new effect.Amaz.FloatVector();
          for (const num of list) {
            if (typeof num === 'number') {
              floats.pushBack(num);
            }
          }
          this._amgObject.setFloatVector(key, floats);
        };

        if (type === 'vec2[]') {
          setVec2Array(arr);
          return;
        }
        if (type === 'vec3[]') {
          setVec3Array(arr);
          return;
        }
        if (type === 'vec4[]') {
          setVec4Array(arr);
          return;
        }
        if (type === 'float[]') {
          setFloatArray(arr);
          return;
        }

        console.warn(`Unsupported array uniform type for ${key}:`, type || typeof convertedValue);
        return;
      }

      console.warn(`Unsupported uniform type for ${key}:`, convertedValue);
    } catch (error) {
      console.error(`Failed to sync uniform ${key} to AMG:`, error);
    }
  }

  /**
   * 获取uniforms代理对象
   * @returns {Object} uniforms代理对象
   */
  get uniforms() { return this._uniforms; }
  /**
   * 设置uniforms
   * 更新uniforms并重新创建代理、添加钩子、同步到AMG引擎
   * @param {Object} newUniforms - 新的uniforms对象
   */
  set uniforms(newUniforms) {
    this._originalUniforms = newUniforms || {};
    this._uniforms = this._createUniformsProxy(this._originalUniforms);
    this._hookUniforms(this._originalUniforms);
    for (const [key, uniform] of Object.entries(this._originalUniforms)) {
      if (uniform && 'value' in uniform) {
        this._syncUniformToAMG(key, uniform.value);
      }
    }
  }

  clone() {
    const clonedUniforms = this._cloneUniforms(this._originalUniforms);
    return new ShaderMaterial({
      uniforms: clonedUniforms,
      vertexShader: this.originalVertexShader,
      fragmentShader: this.originalFragmentShader,
      transparent: this.transparent,
      blending: this.blending,
      depthTest: this.depthTest,
      depthWrite: this.depthWrite,
      opacity: this.opacity
    });
  }

  dispose() {
    this._amgObject = null;
    this._originalUniforms = null;
    this._uniforms = null;
    this._arrayProxyMap = null;
    this._originalVertexShader = null;
    this._originalFragmentShader = null;
    this.scene = null;
  }
}

exports.ShaderMaterial = ShaderMaterial;


