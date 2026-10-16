/**
 * 场景核心模块
 *
 * 包含Three.js核心对象的创建和管理
 * 提供场景管理的核心功能：初始化、配置和更新
 */

// ThreeJS Env
// 导入TWEEN库
// const TWEEN = require('../lib/tween');
// 导入Three.js库
// const THREE = require('three');


// Effect Env
// 导入TWEEN库
const TWEEN = require('./tween');
// 导入自定义缓动函数库（OutIn 模式等官方未提供的组合）
const customEasings = require('./customEasings').customEasings;
// 导入Three.js 的 wrapper库
const THREE = require('./three-amg-wrapper').THREE;
/**
 * ScriptScene类 - 3D场景管理器
 * 负责创建和管理Three.js场景、相机、渲染器及场景对象
 */
class ScriptScene {
  /**
   * 构造函数，创建场景管理器
   * @param {effect.Amaz.Scene} [amgScene] - AMG场景对象，可选参数
   * @param {HTMLElement} [container] - 放置渲染器的DOM容器，可选参数
   */
  constructor(amgScene = null, container = null) {
    // 核心对象初始化
    if (amgScene) {
      this.scene = new THREE.Scene();
      this.scene._amgScene = amgScene;
    } else {
      this.scene = new THREE.Scene();
    }
    this.effect_type = 'video_animation';
    this.camera = null;
    this.renderer = null;
    this.scene.background = new THREE.Color(0x333333);
    this.isAnimating = false;
    this.animationFrameId = null;
    this.sceneObjects = null;

    this.texture1 = null;

    // 后处理相关属性
    this.composer = null;
    this.renderPass = null;
    this.usePostProcessing = true; // 是否启用后处理效果

    // 初始化核心对象和基本场景
    this.initCoreObjects();
    if (container) {
      this.init(container);
    }
  }

  /**
   * 析构函数，清理场景并释放资源
   * 在不再需要场景时调用，确保正确释放内存和停止动画循环
   */
  destroy() {
    // 停止动画循环
    this.isAnimating = false;

    // 取消动画帧请求
    if (this.animationFrameId !== null &&
      typeof cancelAnimationFrame !== 'undefined') {
      cancelAnimationFrame(this.animationFrameId);
      this.animationFrameId = null;
    }

    // 清理渲染器
    if (this.renderer) {
      this.renderer.setAnimationLoop(null);
      this.renderer.dispose();

      // 移除渲染器的DOM元素
      if (this.renderer.domElement && this.renderer.domElement.parentNode) {
        this.renderer.domElement.parentNode.removeChild(
          this.renderer.domElement);
      }
    }

    // 清理场景中的对象
    if (this.scene) {
      this.scene.dispose();
    }

    // 移除窗口事件监听器
    if (typeof window !== 'undefined') {
      window.removeEventListener('resize', this.handleResize);
    }

    // 清理TWEEN动画
    if (this.sceneObjects && this.sceneObjects.tweens) {
      this.sceneObjects.tweens.forEach(tween => {
        if (tween && typeof tween.stop === 'function') {
          tween.stop();
        }
      });
      this.sceneObjects.tweens = [];
    }

    // 清理自有纹理
    if (this.texture1) {
      if (typeof this.texture1.dispose === 'function') this.texture1.dispose();
      this.texture1 = null;
    }
    if (this.texture2) {
      if (typeof this.texture2.dispose === 'function') this.texture2.dispose();
      this.texture2 = null;
    }

    // 清理自有 ShaderPass 列表与单个引用
    if (this.shaderPasses && this.shaderPasses.length) {
      this.shaderPasses.forEach(pass => {
        if (pass && typeof pass.dispose === 'function') {
          try {
            pass.dispose();
          } catch (e) { /* noop */
          }
        }
      });
      this.shaderPasses = [];
    }
    if (this.shaderPass && typeof this.shaderPass.dispose === 'function') {
      try {
        this.shaderPass.dispose();
      } catch (e) { /* noop */
      }
    }
    this.shaderPass = null;


    // 清理后处理效果
    if (this.composer) {
      this.composer.dispose();
      this.composer = null;
    }

    this.renderPass = null;

    // 清理引用
    this.scene = null;
    this.camera = null;
    this.renderer = null;
    this.sceneObjects = null;
  }

  /**
   * 初始化Three.js核心对象
   * 包括场景、相机和渲染器
   */
  initCoreObjects() {
    window.innerWidth = 600;
    window.innerHeight = 600;
    window.devicePixelRatio = 1;
    // 创建透视相机
    this.camera = new THREE.PerspectiveCamera(
      53.1, // 视场角
      window.innerWidth / window.innerHeight, // 纵横比
      0.1, // 近平面
      10000                                    // 远平面
    );
    this.camera.position.z = 10; // 设置默认相机位置
    this.scene.add(this.camera);

    // 创建渲染器，启用抗锯齿
    // 当amgScene为null时，创建渲染器
    if (this.scene._amgScene == null) {
      this.renderer = new THREE.WebGLRenderer({ antialias: true });
      this.renderer.outputColorSpace = THREE.LinearSRGBColorSpace;
    }
    if (this.renderer) {
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.renderer.setPixelRatio(window.devicePixelRatio);
    }

    // 滑竿列表
    this.sliders = {};

    // 时长 毫秒
    this.Duration = 3000;

    // 创建TWEEN实例
    this.TWEEN = TWEEN;
    // 自定义缓动函数库：使用方式 this.customEasings.OutIn.Back 等
    this.customEasings = customEasings;
  }

  /**
   * 添加ShaderPass
   * @param {Array} shaderPassConfigs - ShaderPass配置数组
   * @return {void}
   */
  addShaderPass(shaderPassConfigs) {
    if (!Array.isArray(shaderPassConfigs)) {
      shaderPassConfigs = [shaderPassConfigs];
    }

    shaderPassConfigs.forEach(config => {
      const atomicName = config.name;
      const className =
        atomicName.startsWith('Lumi') ? atomicName.substring(4) : atomicName;
      const shaderPassModule =
        require('../pp/Lumi' + className + '/' + className + 'ShaderPass.js');
      const ShaderPassClass = shaderPassModule[className + 'ShaderPass'];
      const shaderPass = new ShaderPassClass();
      console.log('ShaderPass created:', shaderPass, className);
      // 统一单Pass和多Pass的添加逻辑
      this.composer.addPass(shaderPass);
      this.shaderPasses.push(shaderPass);
    });
  }

  /**
   * 设置后处理
   * @param {Array} shaderPassConfigs - ShaderPass配置数组
   * @return {void}
   */
  setupPostProcessing(shaderPassConfigs) {
    const { EffectComposer } = require('./EffectComposer.js');
    const { RenderPass } = require('./RenderPass.js');

    // 创建后处理渲染目标
    this.composer = new EffectComposer(this.renderer);
    this.renderPass = new RenderPass(this.scene, this.camera);
    this.composer.addPass(this.renderPass);
    this.shaderPasses = [];

    this.addShaderPass(shaderPassConfigs);
  }

  //===begin_pp===
initPostProcessing() {
}
//===end_pp===

  /**
   * 初始化场景
   * 设置基本的Three.js环境，添加渲染器到DOM
   * @param {HTMLElement} container - 放置渲染器的DOM容器
   */
  init(container) {
    if (this.renderer) {
      if (container) {
        container.appendChild(this.renderer.domElement);
      } else if (typeof document !== 'undefined') {
        document.body.appendChild(this.renderer.domElement);
      }
    }
    if (typeof window !== 'undefined') {
      window.addEventListener('resize', () => this.handleResize());
    }
  }

  /**
   * 开始场景动画循环
   * @param {Function} updateCallback - 每帧调用的更新函数
   */
  start(updateCallback) {
    if (this.isAnimating) return;

    this.isAnimating = true;

    // 如果提供了更新回调，使用requestAnimationFrame
    if (updateCallback) {
      const animateFrame = () => {
        if (!this.isAnimating) return;
        updateCallback();
        this.animationFrameId = requestAnimationFrame(animateFrame);
      };

      animateFrame();
    } else {
      // 否则使用Three.js的setAnimationLoop，直接调用update渲染场景
      this.renderer.setAnimationLoop(() => {
        this.update();
      });
    }
  }

  /**
   * 更新场景（由外部动画循环调用）
   * @param {number} timestamp - 当前时间戳
   */
  updateScene(timestamp) {
    // 标记动画开始
    if (!this.isAnimating) {
      this.isAnimating = true;
    }

    // 直接调用默认更新函数，传入时间戳
    this.defaultUpdate(timestamp);
  }

  /**
   * 更新并渲染场景
   * 在每一帧调用，将当前场景通过渲染器绘制到屏幕
   */
  update() {
    if (this.usePostProcessing && this.composer) {
      // 确保composer使用当前活动的相机
      if (this.renderPass) {
        this.renderPass.camera = this.camera;
      }

      // 使用后处理效果渲染
      this.composer.render();
    } else if (this.renderer) {
      // 直接渲染场景
      this.renderer.render(this.scene, this.camera);
    }
  }

  /**
   * 事件处理
   * @param {string} type - 事件类型
   * @param {*} value - 事件值
   */
  onEvent(type, value) {
    console.log('running:scriptScene:onevent');
    if (type === 'lumiai_material_properties') {
      // 解析传入参数value。value为json格式，包含key和value字段
      try {
        const json = JSON.parse(value);
        const { key, value: newValue } = json;
        if (key && newValue !== undefined) {
          // 处理材质属性更新
          this.handleMaterialPropertyUpdate(key, newValue);
        }
      } catch (error) {
        console.error('Error parsing lumiai_material_properties JSON:', error);
      }
    }
    if (this.sliders[type] !== undefined) {
      var oldValue = Math.max(
        this.sliders[type].min, Math.min(this.sliders[type].max, value))
      if (this.sliders[type].value !== oldValue) {
        this.sliders[type].value = oldValue;
      }
    }
    if (typeof this.updateSliders === 'function') {
      this.updateSliders();
    }
  }

  handleMaterialPropertyUpdate(key, value) {
    if (!this.usePostProcessing) return;

    this.shaderPasses.forEach(shaderPass => {
      if (shaderPass.constructor.name === 'CustomShaderPass') {
        // 应用参数配置检查：如果没有设置参数函数，则打印错误并返回
        if (typeof shaderPass.setParameter !== 'function') {
          console.error(
            `${shaderPass.constructor.name} 中没有 setParameter 方法`);
          return;
        }
        // 调用setParameter设置材质属性, FIX_IN_FUTURE:
        // 纹理类型暂不支持；如果是纹理，value为地址，需要先加载纹理
        shaderPass.setParameter(key, value);
      }
    });
  }

  /**
   * 窗口大小调整处理
   * 在窗口大小变化时调整相机和渲染器
   */
  handleResize() {
    this.camera.aspect = window.innerWidth / window.innerHeight;
    this.camera.updateProjectionMatrix();
    if (this.renderer) {
      this.renderer.setSize(window.innerWidth, window.innerHeight);
    }

    // 调整后处理效果的大小
    if (this.composer) {
      this.composer.setSize(window.innerWidth, window.innerHeight);
    }

    // 如果不在动画循环中，触发一次渲染以更新视图
    if (!this.isAnimating) {
      this.update();
    }
  }

  loadTextures() {
    const textureLoader = new THREE.TextureLoader();
    return Promise.all([new Promise(resolve => {
      this.texture1 = textureLoader.load('image/Sample1.jpg', resolve);
      this.texture1.colorSpace = THREE.LinearSRGBColorSpace;
      this.texture1.wrapS = THREE.BackSide;
      this.texture1.wrapT = THREE.BackSide;
    })]);
  }

  _applyTweenInitialState(tween) {
    if (!tween._propertiesAreSetUp) {
      tween.start(0);
    }
    if (!tween._valuesStart || !tween._valuesEnd) {
      return;
    }
    tween._updateProperties(tween._object, tween._valuesStart, tween._valuesEnd, 0);
    if (typeof tween._onUpdateCallback === 'function') {
      tween._onUpdateCallback(tween._object, 0);
    }
  }

  _applyTweenFinalState(tween) {
    if (!tween._propertiesAreSetUp) {
      tween.start(0);
    }
    if (!tween._valuesStart || !tween._valuesEnd) {
      return;
    }
    tween._updateProperties(tween._object, tween._valuesStart, tween._valuesEnd, 1);
    if (typeof tween._onUpdateCallback === 'function') {
      tween._onUpdateCallback(tween._object, 1);
    }
  }

  /**
   * 根据时间直接设置动画状态（用于时间跳转）
   * @param {number} time - 动画时间（毫秒）
   */
  seekToTime(time) {
    // 标记动画开始
    if (!this.isAnimating) {
      this.isAnimating = true;
    }
    if (this.shaderPass) {
      if (!this.texture1 || !this.texture1.image ||
        !this.texture1.image.width || !this.texture1.image.height) {
        this.shaderPass.setParameter('ratio', 1.0)
      } else {
        this.shaderPass.setParameter(
          'ratio', this.texture1.image.width / this.texture1.image.height)
      }
    }
    const clampedTime = Math.max(0, Math.min(time, this.Duration));

    if (!this.sceneObjects.tweens || this.sceneObjects.tweens.length === 0) {
      return;
    }

    // 使用逆序遍历 TWEEN，确保正确的属性覆盖优先级
    // 逆序处理：让开始时间晚的tween先处理，开始时间早的tween后处理并覆盖

    let notStartTweens = [];
    let runningTweens = [];
    let finishedTweens = [];

    for (let i = 0; i <= this.sceneObjects.tweens.length - 1; i++) {
      const tween = this.sceneObjects.tweens[i];

      let TweenStartTime = tween._delayTime + 10;
      let TweenEndTime = tween._delayTime + tween._duration;

      // 将tween分为三种，未开始，进行中，已结束
      // 分到3个列表中

      if (clampedTime <= TweenStartTime) {
        notStartTweens.push({ time: TweenStartTime, tween: tween });
      } else if (clampedTime >= TweenEndTime) {
        finishedTweens.push({ time: TweenEndTime, tween: tween });
      } else {
        runningTweens.push(tween);
      }
    }

    // 按照开始时间排序
    notStartTweens.sort((a, b) => b.time - a.time);
    // 按照结束时间排序
    finishedTweens.sort((a, b) => a.time - b.time);

    notStartTweens.forEach((item, index) => {
      let tween = item.tween;
      tween.stop();
      tween.start(0);
      tween.update(tween._delayTime + 2 + index * 0.04);
    });

    finishedTweens.forEach(item => {
      let tween = item.tween;
      tween.stop();
      tween.start(0);
      tween.update(tween._delayTime + tween._duration + 2);
    });

    runningTweens.forEach(tween => {
      tween.stop();
      tween.start(0);
      tween.update(clampedTime);
    });

    this.update();
  }

  setupSliders() { }

  /**
   * 更新滑竿
   */
  updateSliders() { }

  /**
   更新渲染输入输出
   */
  updatePipeline() {
    var videoEntity = this.scene._amgScene.findEntityBy('video');
    if (!videoEntity) {
      console.warn('Scene: 没有找到视频实体');
      return;
    }
    var mat = videoEntity.getComponent('MeshRenderer').material;
    var outputRt = null;

    if (this.composer && typeof this.composer.getOutputTexture === 'function') {
      outputRt = this.composer.getOutputTexture();
    }

    if (!outputRt) {
      var outputTexRt =
        this.scene._amgScene.assetMgr.SyncLoad('rt/outputTex.rt');
      outputRt = outputTexRt ? outputTexRt.inputTexture : null;
    }

    if (!outputRt) {
      var aiOutputEntity = this.scene._amgScene.findEntityBy('PerspectiveCamera_w');
      if (aiOutputEntity) {
        var cam = aiOutputEntity.getComponent('Camera');
        outputRt = cam ? cam.inputTexture || cam.renderTexture : null;
      }
    }

    if (!outputRt) {
      console.warn('Scene: 没有找到可用的输出纹理');
      return;
    }

    mat.setTex('u_videoTex', outputRt);
  }

  //===begin===
setupScene() {
  this.initSceneObjects();
  this.setupSliders();
  this.updateSliders();
  this.scene.background = new THREE.Color(0x1a1a1a);
  this.createGlitchStripePlane();
  this.setupAnimations();
  return this.sceneObjects;
}

initSceneObjects() {
  this.Duration = 1000;
  this.sceneObjects = {
    glitchStripePlane: null,
    materials: {},
    uniforms: {},
    tweens: [],
    stripePeakBlur: [],
    stripePeakOffset: []
  };

  this.camera.position.set(0.0, 0.0, 10.0);
  this.camera.lookAt(0.0, 0.0, 0.0);

  const stripeCount = 12;
  const peakBlur = [];
  const peakOffset = [];
  for (let i = 0; i < stripeCount; i++) {
    peakBlur.push(28 + ((i * 7 + 3) % 9));
    peakOffset.push(0.6 + ((i * 13 + 5) % 31) / 100);
  }
  this.sceneObjects.stripePeakBlur = peakBlur;
  this.sceneObjects.stripePeakOffset = peakOffset;
}

createGlitchStripePlane() {
  const geometry = new THREE.PlaneGeometry(10, 10, 1, 1);
  geometry.name = 'GlitchStripePlaneGeometry';

  const uniforms = {
    texture1: { value: this.texture1 },
    uExposure: { value: 1.0 },
    uTime: { value: 0.0 },
    uResolution: {
      value: new THREE.Vector2(window.innerWidth || 600, window.innerHeight || 600)
    },
    uStripeCount: { value: 12.0 },
    uBlackMask: { value: 1.0 },
    uStripeBlur0: { value: 0.0 },
    uStripeBlur1: { value: 0.0 },
    uStripeBlur2: { value: 0.0 },
    uStripeBlur3: { value: 0.0 },
    uStripeBlur4: { value: 0.0 },
    uStripeBlur5: { value: 0.0 },
    uStripeBlur6: { value: 0.0 },
    uStripeBlur7: { value: 0.0 },
    uStripeBlur8: { value: 0.0 },
    uStripeBlur9: { value: 0.0 },
    uStripeBlur10: { value: 0.0 },
    uStripeBlur11: { value: 0.0 },
    uStripeGlow0: { value: 0.0 },
    uStripeGlow1: { value: 0.0 },
    uStripeGlow2: { value: 0.0 },
    uStripeGlow3: { value: 0.0 },
    uStripeGlow4: { value: 0.0 },
    uStripeGlow5: { value: 0.0 },
    uStripeGlow6: { value: 0.0 },
    uStripeGlow7: { value: 0.0 },
    uStripeGlow8: { value: 0.0 },
    uStripeGlow9: { value: 0.0 },
    uStripeGlow10: { value: 0.0 },
    uStripeGlow11: { value: 0.0 },
    uStripeOffset0: { value: 0.0 },
    uStripeOffset1: { value: 0.0 },
    uStripeOffset2: { value: 0.0 },
    uStripeOffset3: { value: 0.0 },
    uStripeOffset4: { value: 0.0 },
    uStripeOffset5: { value: 0.0 },
    uStripeOffset6: { value: 0.0 },
    uStripeOffset7: { value: 0.0 },
    uStripeOffset8: { value: 0.0 },
    uStripeOffset9: { value: 0.0 },
    uStripeOffset10: { value: 0.0 },
    uStripeOffset11: { value: 0.0 },
    uStripeChromatic0: { value: 0.0 },
    uStripeChromatic1: { value: 0.0 },
    uStripeChromatic2: { value: 0.0 },
    uStripeChromatic3: { value: 0.0 },
    uStripeChromatic4: { value: 0.0 },
    uStripeChromatic5: { value: 0.0 },
    uStripeChromatic6: { value: 0.0 },
    uStripeChromatic7: { value: 0.0 },
    uStripeChromatic8: { value: 0.0 },
    uStripeChromatic9: { value: 0.0 },
    uStripeChromatic10: { value: 0.0 },
    uStripeChromatic11: { value: 0.0 },
    uStripeNoise0: { value: 0.0 },
    uStripeNoise1: { value: 0.0 },
    uStripeNoise2: { value: 0.0 },
    uStripeNoise3: { value: 0.0 },
    uStripeNoise4: { value: 0.0 },
    uStripeNoise5: { value: 0.0 },
    uStripeNoise6: { value: 0.0 },
    uStripeNoise7: { value: 0.0 },
    uStripeNoise8: { value: 0.0 },
    uStripeNoise9: { value: 0.0 },
    uStripeNoise10: { value: 0.0 },
    uStripeNoise11: { value: 0.0 }
  };

  const vertexShader = `
    varying vec2 vUv;
    void main() {
      vUv = uv;
      gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    }
  `;

  const fragmentShader = `
    uniform sampler2D texture1;
    uniform float uExposure;
    uniform float uTime;
    uniform vec2 uResolution;
    uniform float uStripeCount;
    uniform float uBlackMask;

    uniform float uStripeBlur0; uniform float uStripeBlur1; uniform float uStripeBlur2; uniform float uStripeBlur3;
    uniform float uStripeBlur4; uniform float uStripeBlur5; uniform float uStripeBlur6; uniform float uStripeBlur7;
    uniform float uStripeBlur8; uniform float uStripeBlur9; uniform float uStripeBlur10; uniform float uStripeBlur11;

    uniform float uStripeGlow0; uniform float uStripeGlow1; uniform float uStripeGlow2; uniform float uStripeGlow3;
    uniform float uStripeGlow4; uniform float uStripeGlow5; uniform float uStripeGlow6; uniform float uStripeGlow7;
    uniform float uStripeGlow8; uniform float uStripeGlow9; uniform float uStripeGlow10; uniform float uStripeGlow11;

    uniform float uStripeOffset0; uniform float uStripeOffset1; uniform float uStripeOffset2; uniform float uStripeOffset3;
    uniform float uStripeOffset4; uniform float uStripeOffset5; uniform float uStripeOffset6; uniform float uStripeOffset7;
    uniform float uStripeOffset8; uniform float uStripeOffset9; uniform float uStripeOffset10; uniform float uStripeOffset11;

    uniform float uStripeChromatic0; uniform float uStripeChromatic1; uniform float uStripeChromatic2; uniform float uStripeChromatic3;
    uniform float uStripeChromatic4; uniform float uStripeChromatic5; uniform float uStripeChromatic6; uniform float uStripeChromatic7;
    uniform float uStripeChromatic8; uniform float uStripeChromatic9; uniform float uStripeChromatic10; uniform float uStripeChromatic11;

    uniform float uStripeNoise0; uniform float uStripeNoise1; uniform float uStripeNoise2; uniform float uStripeNoise3;
    uniform float uStripeNoise4; uniform float uStripeNoise5; uniform float uStripeNoise6; uniform float uStripeNoise7;
    uniform float uStripeNoise8; uniform float uStripeNoise9; uniform float uStripeNoise10; uniform float uStripeNoise11;

    varying vec2 vUv;

    float getStripeValue(int idx, float v0, float v1, float v2, float v3, float v4, float v5, float v6, float v7, float v8, float v9, float v10, float v11) {
      if (idx == 0) return v0;
      if (idx == 1) return v1;
      if (idx == 2) return v2;
      if (idx == 3) return v3;
      if (idx == 4) return v4;
      if (idx == 5) return v5;
      if (idx == 6) return v6;
      if (idx == 7) return v7;
      if (idx == 8) return v8;
      if (idx == 9) return v9;
      if (idx == 10) return v10;
      return v11;
    }

    float random(vec2 st) {
      return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
    }

    vec3 screenBlend(vec3 base, vec3 blend) {
      return 1.0 - (1.0 - base) * (1.0 - blend);
    }

    vec4 sampleVerticalBlur(sampler2D tex, vec2 uv, float radiusPx) {
      vec2 texel = 1.0 / uResolution;
      vec2 stepUv = vec2(0.0, texel.y * radiusPx);
      vec4 color = vec4(0.0);
      color += texture2D(tex, clamp(uv + stepUv * -2.0, 0.0, 1.0)) * 0.12;
      color += texture2D(tex, clamp(uv + stepUv * -1.0, 0.0, 1.0)) * 0.22;
      color += texture2D(tex, clamp(uv, 0.0, 1.0)) * 0.32;
      color += texture2D(tex, clamp(uv + stepUv * 1.0, 0.0, 1.0)) * 0.22;
      color += texture2D(tex, clamp(uv + stepUv * 2.0, 0.0, 1.0)) * 0.12;
      return color;
    }

    void main() {
      float stripeHeight = 1.0 / uStripeCount;
      float stripeFloat = floor(clamp(vUv.y * uStripeCount, 0.0, uStripeCount - 0.0001));
      int stripeIndex = int(stripeFloat);

      float blurRadius = getStripeValue(
        stripeIndex,
        uStripeBlur0, uStripeBlur1, uStripeBlur2, uStripeBlur3, uStripeBlur4, uStripeBlur5,
        uStripeBlur6, uStripeBlur7, uStripeBlur8, uStripeBlur9, uStripeBlur10, uStripeBlur11
      );
      float glowStrength = getStripeValue(
        stripeIndex,
        uStripeGlow0, uStripeGlow1, uStripeGlow2, uStripeGlow3, uStripeGlow4, uStripeGlow5,
        uStripeGlow6, uStripeGlow7, uStripeGlow8, uStripeGlow9, uStripeGlow10, uStripeGlow11
      );
      float stripeOffset = getStripeValue(
        stripeIndex,
        uStripeOffset0, uStripeOffset1, uStripeOffset2, uStripeOffset3, uStripeOffset4, uStripeOffset5,
        uStripeOffset6, uStripeOffset7, uStripeOffset8, uStripeOffset9, uStripeOffset10, uStripeOffset11
      );
      float chromatic = getStripeValue(
        stripeIndex,
        uStripeChromatic0, uStripeChromatic1, uStripeChromatic2, uStripeChromatic3, uStripeChromatic4, uStripeChromatic5,
        uStripeChromatic6, uStripeChromatic7, uStripeChromatic8, uStripeChromatic9, uStripeChromatic10, uStripeChromatic11
      );
      float noiseAmount = getStripeValue(
        stripeIndex,
        uStripeNoise0, uStripeNoise1, uStripeNoise2, uStripeNoise3, uStripeNoise4, uStripeNoise5,
        uStripeNoise6, uStripeNoise7, uStripeNoise8, uStripeNoise9, uStripeNoise10, uStripeNoise11
      );

      vec2 localUv = vUv;
      localUv.x += stripeOffset;
      localUv = clamp(localUv, 0.0, 1.0);

      float edgeBlend = 1.0 - smoothstep(0.18, 0.48, min(localUv.y - stripeFloat * stripeHeight, (stripeFloat + 1.0) * stripeHeight - localUv.y) / stripeHeight);
      float edgeMask = 1.0 - smoothstep(0.0, 0.12, min(vUv.y - stripeFloat * stripeHeight, (stripeFloat + 1.0) * stripeHeight - vUv.y) / stripeHeight);

      vec2 dir = vec2(sign(stripeOffset + 0.0001), 0.0);
      float chromaUv = chromatic * 0.015;
      vec2 chromaShift = dir * chromaUv;

      vec4 blurredBase = sampleVerticalBlur(texture1, localUv, blurRadius);
      float r = sampleVerticalBlur(texture1, clamp(localUv + chromaShift * edgeMask, 0.0, 1.0), blurRadius).r;
      float g = blurredBase.g;
      float b = sampleVerticalBlur(texture1, clamp(localUv - chromaShift * edgeMask, 0.0, 1.0), blurRadius).b;
      vec3 baseColor = vec3(r, g, b);

      float luma = dot(baseColor, vec3(0.299, 0.587, 0.114));
      float highlight = smoothstep(0.55, 0.95, luma);
      vec3 neonColor = mix(vec3(0.9569, 0.4471, 0.7137), vec3(0.8510, 0.2745, 0.9373), clamp(vUv.y + float(stripeIndex) * 0.03, 0.0, 1.0));
      vec3 glowColor = neonColor * highlight * glowStrength * (0.75 + edgeBlend * 0.8);
      vec3 colorWithGlow = screenBlend(baseColor, glowColor);

      float noise = random(vUv * uResolution.xy * 0.25 + vec2(float(stripeIndex) * 13.17, uTime * 0.021));
      float signedNoise = (noise - 0.5) * 2.0;
      colorWithGlow += signedNoise * noiseAmount * highlight * 0.18;

      colorWithGlow *= uExposure;
      colorWithGlow *= (1.0 - uBlackMask);

      gl_FragColor = vec4(clamp(colorWithGlow, 0.0, 1.0), 1.0);
    }
  `;

  const material = new THREE.ShaderMaterial({
    uniforms,
    vertexShader,
    fragmentShader,
    transparent: false,
    side: THREE.DoubleSide
  });
  material.name = 'GlitchStripePlaneMaterial';

  const mesh = new THREE.Mesh(geometry, material);
  mesh.name = '故障条带平面1';
  mesh.position.set(0.0, 0.0, 0.0);
  mesh.scale.set(1.0, 1.0, 1.0);

  this.scene.add(mesh);
  this.sceneObjects.glitchStripePlane = mesh;
  this.sceneObjects.materials.glitchStripePlaneMaterial = material;
  this.sceneObjects.uniforms.glitchStripePlaneUniforms = uniforms;
}

setupAnimations() {
  const plane = this.sceneObjects.glitchStripePlane;
  if (!plane) return;

  const material = this.sceneObjects.materials.glitchStripePlaneMaterial;
  const uniforms = this.sceneObjects.uniforms.glitchStripePlaneUniforms;
  const stripeCount = 12;
  const peakBlur = this.sceneObjects.stripePeakBlur;
  const peakOffset = this.sceneObjects.stripePeakOffset;

  const lookTarget = new THREE.Vector3(0.0, 0.0, 0.0);
  const baseQuat = this.camera.quaternion.clone();
  const cameraQuatState = { t: 0 };
  const cameraQuatTween = new TWEEN.Tween(cameraQuatState)
    .to({ t: 1 }, this.Duration)
    .delay(0)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate(obj => {
      this.camera.quaternion.copy(baseQuat);
      this.camera.quaternion.slerp(baseQuat, obj.t);
      this.camera.lookAt(lookTarget);
    })
    .start();
  this.sceneObjects.tweens.push(cameraQuatTween);

  const timeState = { time: 0 };
  const timeTween = new TWEEN.Tween(timeState)
    .to({ time: this.Duration }, this.Duration)
    .delay(0)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate(obj => {
      uniforms.uTime.value = obj.time;
      uniforms.uResolution.value.set(window.innerWidth || 600, window.innerHeight || 600);
    })
    .start();
  this.sceneObjects.tweens.push(timeTween);

  const blackStartState = { mask: 1.0 };
  const blackStartTween = new TWEEN.Tween(blackStartState)
    .to({ mask: 0.0 }, 250)
    .delay(50)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate(obj => {
      uniforms.uBlackMask.value = obj.mask;
    })
    .start();
  this.sceneObjects.tweens.push(blackStartTween);

  const blackEndState = { mask: 0.0 };
  const blackEndTween = new TWEEN.Tween(blackEndState)
    .to({ mask: 0.0 }, 200)
    .delay(300)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate(obj => {
      uniforms.uBlackMask.value = obj.mask;
    })
    .start();
  this.sceneObjects.tweens.push(blackEndTween);

  const exposureState1 = { value: 1.0 };
  const exposureTween1 = new TWEEN.Tween(exposureState1)
    .to({ value: 2.5 }, 250)
    .delay(50)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate(obj => {
      uniforms.uExposure.value = obj.value;
    })
    .start();
  this.sceneObjects.tweens.push(exposureTween1);

  const exposureState2 = { value: 2.5 };
  const exposureTween2 = new TWEEN.Tween(exposureState2)
    .to({ value: 1.2 }, 400)
    .delay(300)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate(obj => {
      uniforms.uExposure.value = obj.value;
    })
    .start();
  this.sceneObjects.tweens.push(exposureTween2);

  const exposureState3 = { value: 1.2 };
  const exposureTween3 = new TWEEN.Tween(exposureState3)
    .to({ value: 1.0 }, 250)
    .delay(700)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate(obj => {
      uniforms.uExposure.value = obj.value;
    })
    .start();
  this.sceneObjects.tweens.push(exposureTween3);

  for (let i = 0; i < stripeCount; i++) {
    const stripeDelay = 50 + i * 50;
    const direction = i % 2 === 0 ? -1.0 : 1.0;
    const blurPeak = peakBlur[i];
    const offsetPeak = peakOffset[i] * direction;

    const blurKey = `uStripeBlur${i}`;
    const glowKey = `uStripeGlow${i}`;
    const offsetKey = `uStripeOffset${i}`;
    const chromaKey = `uStripeChromatic${i}`;
    const noiseKey = `uStripeNoise${i}`;

    const stage1State = {
      blur: 0.0,
      glow: 0.0,
      offset: offsetPeak,
      chroma: 0.0,
      noise: 0.0
    };
    const stage1Tween = new TWEEN.Tween(stage1State)
      .to({
        blur: blurPeak,
        glow: 1.0,
        offset: offsetPeak * 0.35,
        chroma: 1.0,
        noise: 1.0
      }, 250)
      .delay(stripeDelay)
      .easing(TWEEN.Easing.Linear.None)
      .onUpdate(obj => {
        uniforms[blurKey].value = obj.blur;
        uniforms[glowKey].value = obj.glow;
        uniforms[offsetKey].value = obj.offset;
        uniforms[chromaKey].value = obj.chroma;
        uniforms[noiseKey].value = obj.noise;
      })
      .start();
    this.sceneObjects.tweens.push(stage1Tween);

    const stage2State = {
      blur: blurPeak,
      glow: 1.0,
      offset: offsetPeak * 0.35,
      chroma: 1.0,
      noise: 1.0
    };
    const stage2Tween = new TWEEN.Tween(stage2State)
      .to({
        blur: 4.0,
        glow: 0.2,
        offset: 0.0,
        chroma: 0.2,
        noise: 0.2
      }, 400)
      .delay(Math.max(300, stripeDelay))
      .easing(TWEEN.Easing.Linear.None)
      .onUpdate(obj => {
        uniforms[blurKey].value = obj.blur;
        uniforms[glowKey].value = obj.glow;
        uniforms[offsetKey].value = obj.offset;
        uniforms[chromaKey].value = obj.chroma;
        uniforms[noiseKey].value = obj.noise;
      })
      .start();
    this.sceneObjects.tweens.push(stage2Tween);

    const stage3State = {
      blur: 4.0,
      glow: 0.2,
      offset: 0.0,
      chroma: 0.2,
      noise: 0.2
    };
    const stage3Tween = new TWEEN.Tween(stage3State)
      .to({
        blur: 0.0,
        glow: 0.0,
        offset: 0.0,
        chroma: 0.0,
        noise: 0.0
      }, 250)
      .delay(700)
      .easing(TWEEN.Easing.Linear.None)
      .onUpdate(obj => {
        uniforms[blurKey].value = obj.blur;
        uniforms[glowKey].value = obj.glow;
        uniforms[offsetKey].value = obj.offset;
        uniforms[chromaKey].value = obj.chroma;
        uniforms[noiseKey].value = obj.noise;
      })
      .start();
    this.sceneObjects.tweens.push(stage3Tween);
  }
}
//===end===

  /**
   * 默认的场景更新函数，实现轨道交错动画
   */
  defaultUpdate(timestamp) {
    // 更新所有TWEEN动画
    if (this.sceneObjects.tweens && this.sceneObjects.tweens.length > 0) {
      this.sceneObjects.tweens.forEach(tween => {
        if (tween && typeof tween.update === 'function') {
          tween.update(timestamp);
        }
      });
    }

    this.update();
  }

  //===Predefined Function Begin===
_predef_addTopCenterBottomStyleBorder(parent, offset, texture, cutoutAreaPosition, cutoutAreaSize) {
    const aspectRatio = this.texture1.image.width / this.texture1.image.height;
    const parentInitScale = parent.scale.y;
    const parentPosition = parent.position;
    const textureWidth = texture.image.width;
    const textureHeight = texture.image.height;
    const geometry = new THREE.PlaneGeometry(10, 10);

    // center
    const textureCenter = texture.clone();
    textureCenter.repeat.set(1, cutoutAreaSize.y / textureHeight);
    textureCenter.offset.set(0, (textureHeight - cutoutAreaPosition.y - cutoutAreaSize.y) / textureHeight);
    
    const materialCenter = new THREE.MeshBasicMaterial({
        map: textureCenter,
        transparent: true,
        opacity: 1,
        premultipliedAlpha: true,
        side: THREE.DoubleSide
    });
    materialCenter.name = 'PlaneCenterMaterial';
    
    const planeCenter = new THREE.Mesh(geometry, materialCenter);
    planeCenter.name = 'PlaneCenter';
    planeCenter.position.set(parentPosition.x + offset.x, parentPosition.y + offset.y, parentPosition.z + offset.z);
    planeCenter.scale.set(parentInitScale * aspectRatio / (cutoutAreaSize.x / textureWidth), parentInitScale, 1);
    
    this.scene.add(planeCenter);
    parent.attach(planeCenter);

    // top
    const textureTop = texture.clone();
    textureTop.repeat.set(1, cutoutAreaPosition.y / textureHeight);
    textureTop.offset.set(0, 1 - cutoutAreaPosition.y / textureHeight);
    
    const materialTop = new THREE.MeshBasicMaterial({
        map: textureTop,
        transparent: true,
        opacity: 1,
        premultipliedAlpha: true,
        side: THREE.DoubleSide
    });
    materialTop.name = 'PlaneTopMaterial';
    
    const scaleXTop = parentInitScale * aspectRatio / (cutoutAreaSize.x / textureWidth);
    const scaleYTop = scaleXTop * cutoutAreaPosition.y / textureWidth;
    
    const planeTop = new THREE.Mesh(geometry, materialTop);
    planeTop.name = 'PlaneTop';
    planeTop.position.set(parentPosition.x + offset.x, parentPosition.y + offset.y + parentInitScale * 10 * 0.5 + scaleYTop * 10 * 0.5, parentPosition.z + offset.z);
    planeTop.scale.set(scaleXTop, scaleYTop, 1);
    
    this.scene.add(planeTop);
    parent.attach(planeTop);

    // bottom
    const textureBottom = texture.clone();
    textureBottom.repeat.set(1, (textureHeight - cutoutAreaPosition.y - cutoutAreaSize.y) / textureHeight);
    textureBottom.offset.set(0, 0);
    
    const materialBottom = new THREE.MeshBasicMaterial({
        map: textureBottom,
        transparent: true,
        opacity: 1,
        premultipliedAlpha: true,
        side: THREE.DoubleSide
    });
    materialBottom.name = 'PlaneBottomMaterial';
    
    const scaleXBottom = parentInitScale * aspectRatio / (cutoutAreaSize.x / textureWidth);
    const scaleYBottom = scaleXBottom * (textureHeight - cutoutAreaPosition.y - cutoutAreaSize.y) / textureWidth;
    
    const planeBottom = new THREE.Mesh(geometry, materialBottom);
    planeBottom.name = 'PlaneBottom';
    planeBottom.position.set(parentPosition.x + offset.x, parentPosition.y + offset.y - parentInitScale * 10 * 0.5 - scaleYBottom * 10 * 0.5, parentPosition.z + offset.z);
    planeBottom.scale.set(scaleXBottom, scaleYBottom, 1);
    
    this.scene.add(planeBottom);
    parent.attach(planeBottom);
}
_predef_loadVideoTexture(path, loop, playbackRate) {
    if (this.scene._amgScene == null) {
        const video = document.createElement('video');
        video.src = path;
        video.muted = true;
        video.loop = loop;
        //video.play();
        video.load();

        // video.style.position = 'absolute';
        // video.style.top = '400px';
        // video.style.left = '0px';
        // video.style.width = '480px';
        // video.style.height = '360px';
        // video.style.zIndex = '100';
        // document.body.appendChild(video);

        const videoTexture = new THREE.VideoTexture(video);
        videoTexture.currentTime = 0;
        videoTexture.playbackRate = playbackRate;

        this.videoTexture = videoTexture;

        return videoTexture;
    } else if (typeof this.scene._amgScene === 'string') {
      return new THREE.Texture();
    } else {
        const texture = new THREE.VideoTexture(path, loop, playbackRate);
        texture.load();
        return texture;
    }
}
_predef_seekVideoTexture(time) {
  if (this.videoTexture != null) {
    const videoTexture = this.videoTexture;
    const video = videoTexture.image;
    if (video.readyState >= 2) {
      const textureProperties = this.renderer.properties.get(videoTexture);
      var newTime = time / 1000 * videoTexture.playbackRate;
      if (newTime < 0) {
        newTime = 0;
      } else if (newTime > video.duration) {
        if (video.loop) {
          newTime = newTime % video.duration;
        } else {
          newTime = video.duration;
        }
      }
      if (textureProperties.__version == videoTexture.version) {
        videoTexture.currentTime = newTime;
        video.currentTime = videoTexture.currentTime;
      }
    }
  }
}
_predef_seekShaderPass(time) {
  if (!('shaderPasses' in this) || this.shaderPasses == null) {
    return;
  }
  this.shaderPasses.forEach(shaderPass => {
    if (shaderPass.constructor.name === 'AnimSeqLoadAndCropBlendShaderPass') {
      if (this.texture1 && this.texture1.image) {
        const ratio = this.texture1.image.width / this.texture1.image.height;
        if (typeof shaderPass.setAspectRatio === 'function') {
          shaderPass.setAspectRatio(ratio);
        }
      }
    }
  })
}//===Predefined Function End===
}

// 导入Three.js库
// module.exports = ScriptScene;

// 导入Three.js 的 wrapper库
exports.ScriptScene = ScriptScene;
