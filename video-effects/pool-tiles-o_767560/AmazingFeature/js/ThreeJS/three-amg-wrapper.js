/**
 * ThreeJS 到 AMG 的包装器
 * 让基于ThreeJS开发的应用能够在AMG引擎上运行
 * 此包装器将ThreeJS的API转换为AMG引擎的调用，实现无缝迁移
 */

// 获取AMG引擎API
const effect_api = "undefined" != typeof effect ? effect : "undefined" != typeof tt ? tt : "undefined" != typeof lynx ? lynx : {};
const Amaz = effect_api.getAmaz ? effect_api.getAmaz() : null;

// 场景实例存取模块
const { getCurrentScene, setCurrentScene, clearCurrentScene } = require('./wrapper/runtime');

// 模拟浏览器环境中的window对象，使ThreeJS代码能在非浏览器环境中运行
if (typeof window === 'undefined') {
  // 定义模拟的window对象
  const mockWindow = {
    innerWidth: 720,
    innerHeight: 1280,
    devicePixelRatio: 1,
    addEventListener: function(event, callback) {
      // 空函数，模拟事件监听
    },
    requestAnimationFrame: function(callback) {
      // 空实现
      // 在实际环境中应该取消动画帧请求
    },
    cancelAnimationFrame: function(id) {
      // 空实现
      // 在实际环境中应该取消动画帧请求
    },
    removeEventListener: function(event, callback) {
      // 空实现
      // 在实际环境中应该取消事件监听
    }
  };
  
  // 定义模拟的document对象
  const mockDocument = {
    createElement: function(tagName) {
      return {
        style: {},
        setAttribute: function() {},
        appendChild: function() {}
      };
    },
    body: {
      appendChild: function() {}
    }
  };
  
  // 获取全局对象的通用方法
  const getGlobalObject = function() {
    if (typeof global !== 'undefined') return global;
    if (typeof self !== 'undefined') return self;
    if (typeof window !== 'undefined') return window;
    if (typeof this !== 'undefined') return this;
    return {}; // 回退选项
  };
  
  // 将模拟对象挂载到全局
  const globalObj = getGlobalObject();
  globalObj.window = mockWindow;
  globalObj.document = mockDocument;
  globalObj.cancelAnimationFrame = mockWindow.cancelAnimationFrame;
}

// 定义命名空间对象，类似于THREE
const THREE = {};

// 常量定义（从 wrapper/Constants 统一导入，避免重复定义）
const __THREE_CONSTS = require('./wrapper/Constants');

THREE.FrontSide = __THREE_CONSTS.FrontSide;
THREE.BackSide = __THREE_CONSTS.BackSide;
THREE.DoubleSide = __THREE_CONSTS.DoubleSide;
THREE.NoBlending = __THREE_CONSTS.NoBlending;
THREE.NormalBlending = __THREE_CONSTS.NormalBlending;
THREE.AdditiveBlending = __THREE_CONSTS.AdditiveBlending;
THREE.SubtractiveBlending = __THREE_CONSTS.SubtractiveBlending;
THREE.MultiplyBlending = __THREE_CONSTS.MultiplyBlending;
THREE.CustomBlending = __THREE_CONSTS.CustomBlending;
THREE.RepeatWrapping = __THREE_CONSTS.RepeatWrapping;
THREE.ClampToEdgeWrapping = __THREE_CONSTS.ClampToEdgeWrapping;
THREE.MirroredRepeatWrapping = __THREE_CONSTS.MirroredRepeatWrapping;



const Vector2Wrapper = require('./wrapper/Vector2').Vector2;
const Vector3Wrapper = require('./wrapper/Vector3').Vector3;
const Vector4Wrapper = require('./wrapper/Vector4').Vector4;
const EulerWrapper = require('./wrapper/Euler').Euler;
const ColorWrapper = require('./wrapper/Color').Color;
const Matrix4Wrapper = require('./wrapper/Matrix4').Matrix4;
const QuaternionWrapper = require('./wrapper/Quaternion').Quaternion;
const MathUtilsWrapper = require('./wrapper/MathUtils').MathUtils;
const Box3Wrapper = require('./wrapper/Box3').Box3;
const Box2Wrapper = require('./wrapper/Box2').Box2;
const WebGLRendererWrapper = require('./wrapper/WebGLRenderer').WebGLRenderer;

const Vector2 = Vector2Wrapper;
const Vector3 = Vector3Wrapper;
const Vector4 = Vector4Wrapper;
const Euler = EulerWrapper;
const Color = ColorWrapper;
const Matrix4 = Matrix4Wrapper;
const Quaternion = QuaternionWrapper;
const MathUtils = MathUtilsWrapper;
const Box3 = Box3Wrapper;
const Box2 = Box2Wrapper;
const WebGLRenderer = WebGLRendererWrapper;


const BufferGeometryWrapper = require('./wrapper/BufferGeometry').BufferGeometry;
const BufferAttributeWrapper = require('./wrapper/BufferAttribute').BufferAttribute;
const BoxGeometryWrapper = require('./wrapper/BoxGeometry').BoxGeometry;
const PlaneGeometryWrapper = require('./wrapper/PlaneGeometry').PlaneGeometry;
const SphereGeometryWrapper = require('./wrapper/SphereGeometry').SphereGeometry;
const CylinderGeometryWrapper = require('./wrapper/CylinderGeometry').CylinderGeometry;
const CapsuleGeometryWrapper = require('./wrapper/CapsuleGeometry').CapsuleGeometry;
const ShapeWrapper = require('./wrapper/Shape').Shape;
const ShapeGeometryWrapper = require('./wrapper/ShapeGeometry').ShapeGeometry;
const ExtrudeGeometryWrapper = require('./wrapper/ExtrudeGeometry').ExtrudeGeometry;
const CurvePathWrapper = require('./wrapper/CurvePath').CurvePath;
const LineCurveWrapper = require('./wrapper/CurvePath').LineCurve;

const BufferGeometry = BufferGeometryWrapper;
const BufferAttribute = BufferAttributeWrapper;
const BoxGeometry = BoxGeometryWrapper;
const PlaneGeometry = PlaneGeometryWrapper;
const SphereGeometry = SphereGeometryWrapper;
const CylinderGeometry = CylinderGeometryWrapper;
const CapsuleGeometry = CapsuleGeometryWrapper;
const Shape = ShapeWrapper;
const ShapeGeometry = ShapeGeometryWrapper;
const ExtrudeGeometry = ExtrudeGeometryWrapper;
const CurvePath = CurvePathWrapper;
const LineCurve = LineCurveWrapper;

const TextureWrapper = require('./wrapper/Texture').Texture;
const VideoTextureWrapper = require('./wrapper/Texture').VideoTexture;
const TextureLoaderWrapper = require('./wrapper/Texture').TextureLoader;

const Texture = TextureWrapper;
const VideoTexture = VideoTextureWrapper;
const TextureLoader = TextureLoaderWrapper;


const MaterialWrapper = require('./wrapper/Material').Material;
const MeshBasicMaterialWrapper = require('./wrapper/MeshBasicMaterial').MeshBasicMaterial;
const ShaderMaterialWrapper = require('./wrapper/ShaderMaterial').ShaderMaterial;

const Material = MaterialWrapper;
const MeshBasicMaterial = MeshBasicMaterialWrapper;
const ShaderMaterial = ShaderMaterialWrapper;


const Object3DWrapper = require('./wrapper/Object3D').Object3D;
const GroupWrapper = require('./wrapper/Group').Group;
const MeshWrapper = require('./wrapper/Mesh').MeshWrapper;
const PerspectiveCameraWrapper = require('./wrapper/PerspectiveCamera').PerspectiveCamera;

const Object3D = Object3DWrapper;
const Group = GroupWrapper;
const Mesh = MeshWrapper;
const PerspectiveCamera = PerspectiveCameraWrapper;
/**
 * 场景类
 * 管理场景中的所有对象
 */
class Scene {
  constructor() {
    // this._amgScene = new Amaz.Scene();
    this._objects = [];
    
    // 将场景添加到AMG管理器
    // effect.Amaz.AmazingManager.addScene(this._amgScene);
    
    // 设置全局场景实例
    setCurrentScene(this);
    
    console.log('AMG scene created');
  }
  
  /**
   * 添加对象到场景
   * 支持一次添加多个对象，如: scene.add(obj1, obj2, obj3)
   * @param {...Object} objects - 要添加的对象（可变参数）
   */
  add(...objects) {
    // 遍历所有传入的对象
    for (let i = 0; i < objects.length; i++) {
      const object = objects[i];
      
      if (!object) {
        console.warn('Scene: 尝试添加空对象');
        continue;
      }
      
      if (object._amgEntity) {
        if (this._objects.indexOf(object) === -1) {
          this._objects.push(object);
          if (this._amgScene) {
            if (object._transform.parent) {
              object._transform.parent.removeTransform(object._transform);
            }
            object._transform.parent = null;
            this._amgScene.addEntity(object._amgEntity);
          }
          console.log('Scene: added object to scene:', object._amgEntity.name);
        }
        else {
          console.log('Scene: object already exists:', object._amgEntity.name);
        }
      } else {
        console.warn('Scene: 添加到场景的对象没有_amgEntity属性');
      }
    }
  }
  
  /**
   * 从场景中移除对象，不删除AMG实体
   * @param {Object} object - 要移除的对象
   */
  remove(object) {
    const index = this._objects.indexOf(object);
    if (index !== -1) {
      this._objects.splice(index, 1);
      console.log('Scene: removed object from scene, not delete AMG entity.');
    }
  }

  /**
   * 从场景中删除对象，删除AMG实体
   */
  delete(object) {
    const index = this._objects.indexOf(object);
    if (index !== -1) {
      this._objects.splice(index, 1);
      if (object._amgEntity) {
        this._amgScene.removeEntity(object._amgEntity);
      }
      console.log('Scene: delete object from scene, delete AMG entity.');
    }
  }
  
  /**
   * 更新场景中的所有对象
   */
  update() {
    // 更新场景中的所有对象
    this._objects.forEach(obj => obj.update && obj.update());
  }

  seekToTime(time) {
    this._objects.forEach(obj => obj.seekToTime && obj.seekToTime(time));
  }

  /**
   * 析构函数，清理场景资源
   * 在不再需要场景时调用，确保释放所有资源并从AMG管理器中移除
   */
  dispose() {
    console.log('Scene: 开始清理场景资源');
    
    // 清理所有对象
    while (this._objects.length > 0) {
      const object = this._objects[0];
      this.delete(object);
      
      // 如果对象有自己的dispose方法，调用它
      if (object.dispose && typeof object.dispose === 'function') {
        object.dispose();
      }
      
      // 释放几何体和材质
      if (object.geometry && object.geometry.dispose) {
        object.geometry.dispose();
      }
      
      if (object.material) {
        if (Array.isArray(object.material)) {
          object.material.forEach(material => {
            if (material.dispose) material.dispose();
          });
        } else if (object.material.dispose) {
          object.material.dispose();
        }
      }
    }
    
    // 从AMG管理器中移除场景
    if (this._amgScene) {
      this._amgScene = null;
    }
    
    // 清空对象数组
    this._objects = [];
    
    // 如果当前全局场景是这个场景，重置它
    if (getCurrentScene() === this) {
      clearCurrentScene();
    }
    
    console.log('Scene: 场景资源清理完成');
  }
}

class QuadraticBezierCurve3 {
  constructor(p0, p1, p2) {
    this.p0 = p0;
    this.p1 = p1;
    this.p2 = p2;
  }

  getPoint(t) {
    // 二次贝塞尔曲线公式: B(t) = (1-t)²P₀ + 2(1-t)tP₁ + t²P₂
    const u = 1 - t;
    const tt = t * t;
    const uu = u * u;
    const ut2 = 2 * u * t;
    
    return new Vector3(
      uu * this.p0.x + ut2 * this.p1.x + tt * this.p2.x,
      uu * this.p0.y + ut2 * this.p1.y + tt * this.p2.y,
      uu * this.p0.z + ut2 * this.p1.z + tt * this.p2.z
    );
  }

  getPoints(divisions) {
    const points = [];
    for (let i = 0; i <= divisions; i++) {
      points.push(this.getPoint(i / divisions));
    }
    return points;
  }
}


/** #region 基础数学与类型 */
THREE.Vector2 = Vector2;
THREE.Vector3 = Vector3;
THREE.Vector4 = Vector4;
THREE.Euler = Euler;
THREE.Color = Color;
THREE.Matrix4 = Matrix4;
THREE.Quaternion = Quaternion;
THREE.QuadraticBezierCurve3 = QuadraticBezierCurve3;
THREE.Box3 = Box3;
THREE.Box2 = Box2;
THREE.MathUtils = MathUtils;
/** #endregion 基础数学与类型 */

/** #region 场景与相机 */
THREE.Scene = Scene;
/** #endregion 场景与相机 */

/** #region 渲染器 */
THREE.WebGLRenderer = WebGLRenderer;
/** #endregion 渲染器 */

/** #region 几何体与属性 */
THREE.BufferGeometry = BufferGeometry;
THREE.BufferAttribute = BufferAttribute;
THREE.Float32BufferAttribute = BufferAttribute;
THREE.BoxGeometry = BoxGeometry;
THREE.PlaneGeometry = PlaneGeometry;
THREE.SphereGeometry = SphereGeometry;
THREE.CylinderGeometry = CylinderGeometry;
THREE.CapsuleGeometry = CapsuleGeometry;
THREE.Shape = Shape;
THREE.ShapeGeometry = ShapeGeometry;
THREE.ExtrudeGeometry = ExtrudeGeometry;
THREE.CurvePath = CurvePath;
THREE.LineCurve = LineCurve;
/** #endregion 几何体与属性 */

/** #region 材质与着色 */
THREE.Material = Material;
THREE.MeshBasicMaterial = MeshBasicMaterial;
THREE.ShaderMaterial = ShaderMaterial;
/** #endregion 材质与着色 */

/** #region 纹理相关 */
THREE.Texture = Texture;
THREE.VideoTexture = VideoTexture;
THREE.TextureLoader = TextureLoader;
/** #endregion 纹理相关 */

/** #region 物体与层级 */
THREE.Object3D = Group;
THREE.Group = Group;
THREE.Mesh = Mesh;
THREE.PerspectiveCamera = PerspectiveCamera;
/** #endregion 物体与层级 */

// 导出THREE命名空间和工具函数
exports.THREE = THREE;
exports.getCurrentScene = getCurrentScene; 