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
addAnimations() {
    const duration = this.Duration;
    const tweens = [];

    // 后处理动画有效时间窗：[50, duration - 50]
    const windowStart = 50;
    const windowEnd = Math.max(50, duration - 50);

    const clampTime = (t) => Math.min(windowEnd, Math.max(windowStart, t));
    const cloneConfig = (cfg) => JSON.parse(JSON.stringify(cfg || {}));

    // 统一参数写入：遍历配置对象并调用 setParameter
    const applyConfig = (shaderPass, obj) => {
      for (const key in obj) {
        shaderPass.setParameter(key, obj[key]);
      }
    };

    // 统一创建“预设 -> 预设”Tween（通过插值配置对象实现平滑过渡）
    const createPresetTween = ({
      shaderPass,
      fromPreset,
      toPreset,
      startTime,
      endTime,
      easing
    }) => {
      const start = clampTime(startTime);
      const end = clampTime(endTime);
      if (end <= start) return null;

      const fromConfigRaw = shaderPass.getPresetConfig(fromPreset);
      const toConfigRaw = shaderPass.getPresetConfig(toPreset);

      if (!fromConfigRaw) {
        console.error(`${shaderPass.constructor.name} 中没有 ${fromPreset} 预设配置`);
        return null;
      }
      if (!toConfigRaw) {
        console.error(`${shaderPass.constructor.name} 中没有 ${toPreset} 预设配置`);
        return null;
      }

      const fromConfig = cloneConfig(fromConfigRaw);
      const toConfig = cloneConfig(toConfigRaw);

      return new TWEEN.Tween(fromConfig)
        .to(toConfig, end - start)
        .delay(start)
        .easing(easing)
        .onUpdate((obj) => {
          applyConfig(shaderPass, obj);
        });
    };

    // 为所有 ShaderPass 添加动画
    this.shaderPasses.forEach(shaderPass => {
      // 只对支持 preset 的后处理做动画
      if (typeof shaderPass.getPresetConfig !== 'function' || typeof shaderPass.setParameter !== 'function') {
        return;
      }

      // LumiGlow -> GlowShaderPass
      if (shaderPass.constructor.name === 'GlowShaderPass') {
        // 初始设为 none（50ms 前保持关闭）
        const initNone = shaderPass.getPresetConfig('none');
        if (!initNone) {
          console.error(`${shaderPass.constructor.name} 中没有 none 预设配置`);
          return;
        }
        applyConfig(shaderPass, cloneConfig(initNone));

        // 时间编排：
        // 150–450: none -> cool (Circular.Out)
        const glowIn = createPresetTween({
          shaderPass,
          fromPreset: 'none',
          toPreset: 'cool',
          startTime: 150,
          endTime: 450,
          easing: TWEEN.Easing.Circular.Out
        });

        // 650–950: cool -> none (Sinusoidal.InOut)
        const glowOut = createPresetTween({
          shaderPass,
          fromPreset: 'cool',
          toPreset: 'none',
          startTime: 650,
          endTime: 950,
          easing: TWEEN.Easing.Sinusoidal.InOut
        });

        if (glowIn) tweens.push(glowIn);
        if (glowOut) tweens.push(glowOut);
      }

      // LumiMotionBlur2D -> MotionBlur2DShaderPass
      if (shaderPass.constructor.name === 'MotionBlur2DShaderPass') {
        // 初始设为 none（50–100ms 关闭）
        const initNone = shaderPass.getPresetConfig('none');
        if (!initNone) {
          console.error(`${shaderPass.constructor.name} 中没有 none 预设配置`);
          return;
        }
        applyConfig(shaderPass, cloneConfig(initNone));

        // 时间编排：
        // 100–400: none -> sideSweep (Exponential.Out)
        const blurIn = createPresetTween({
          shaderPass,
          fromPreset: 'none',
          toPreset: 'sideSweep',
          startTime: 100,
          endTime: 400,
          easing: TWEEN.Easing.Exponential.Out
        });

        // 550–850: sideSweep -> none (Circular.In)
        const blurOut = createPresetTween({
          shaderPass,
          fromPreset: 'sideSweep',
          toPreset: 'none',
          startTime: 550,
          endTime: 850,
          easing: TWEEN.Easing.Circular.In
        });

        if (blurIn) tweens.push(blurIn);
        if (blurOut) tweens.push(blurOut);
      }
    });

    // 启动所有动画
    tweens.forEach(tween => tween.start());

    return tweens;
  }

  /**
   * 初始化后处理效果
   */
  initPostProcessing() {
    if (!this.usePostProcessing) return;

    // 仅使用需求中的后处理能力
    const shaderPassConfigs = [
      { name: 'LumiGlow' },
      { name: 'LumiMotionBlur2D' },
    ];

    // 模板通用初始化（内部会创建 composer / renderPass / shaderPasses）
    this.setupPostProcessing(shaderPassConfigs);

    // 添加后处理 Tween 动画，并挂载到场景对象
    const tweens = this.addAnimations();
    if (tweens.length > 0) {
      if (!this.sceneObjects.tweens) {
        this.sceneObjects.tweens = [];
      }
      this.sceneObjects.tweens.push(...tweens);
    }
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

  setupSliders() {}

  /**
   * 更新滑竿
   */
  updateSliders() {}

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

  this.createMainCard();
  this.createGhostCards();
  this.setupAnimations();

  return this.sceneObjects;
}

initSceneObjects() {
  this.Duration = 1500;
  this.sceneObjects = {
    mainCard: null,
    ghosts: [],
    materials: {
      main: null,
      ghosts: []
    },
    tweens: []
  };

  this.camera.position.set(0.0, 0.8, 10.0);
  this.camera.lookAt(0, 0, 0);
}

createCardMaterial(name, brightness) {
  const material = new THREE.ShaderMaterial({
    name,
    uniforms: {
      texture1: { value: this.texture1 },
      u_brightness: { value: brightness }
    },
    vertexShader: `
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,
    fragmentShader: `
      precision mediump float;
      uniform sampler2D texture1;
      uniform float u_brightness;
      varying vec2 vUv;
      void main() {
        vec4 texColor = texture2D(texture1, vUv);
        texColor.rgb *= u_brightness;
        gl_FragColor = texColor;
      }
    `,
    side: THREE.DoubleSide,
    transparent: false
  });
  return material;
}

createMainCard() {
  const geometry = new THREE.BoxGeometry(10, 10, 0.001);
  geometry.name = 'Geometry_card_main_A';

  const material = this.createCardMaterial('Material_card_main_A', 1.0);
  const card = new THREE.Mesh(geometry, material);
  card.name = 'card_main_A';
  card.position.set(0, 0, 0);
  card.scale.set(0.96, 0.96, 0.96);

  this.scene.add(card);
  this.sceneObjects.mainCard = card;
  this.sceneObjects.materials.main = material;
}

createGhostCards() {
  const ghostConfigs = [
    { name: 'ghost_1', position: [-14, 0, -18], brightness: 0.45 },
    { name: 'ghost_2', position: [-10, 1.5, -15], brightness: 0.51 },
    { name: 'ghost_3', position: [-6, -1, -12], brightness: 0.57 },
    { name: 'ghost_4', position: [-2, 0.8, -9], brightness: 0.63 },
    { name: 'ghost_5', position: [2, -0.8, -6], brightness: 0.69 },
    { name: 'ghost_6', position: [6, 1.0, -3], brightness: 0.75 },
    { name: 'ghost_7', position: [10, 0, -1], brightness: 0.82 }
  ];

  const rotationYRad = -18 * Math.PI / 180;

  ghostConfigs.forEach((cfg, idx) => {
    const geometry = new THREE.BoxGeometry(10, 10, 0.001);
    geometry.name = `Geometry_${cfg.name}`;
    const material = this.createCardMaterial(`Material_${cfg.name}`, cfg.brightness);
    const ghost = new THREE.Mesh(geometry, material);
    ghost.name = cfg.name;
    ghost.position.set(cfg.position[0], cfg.position[1], cfg.position[2]);
    ghost.scale.set(1, 1, 1);

    const quat = new THREE.Quaternion().setFromAxisAngle(new THREE.Vector3(0, 1, 0), rotationYRad);
    ghost.quaternion.copy(quat);

    this.scene.add(ghost);
    this.sceneObjects.ghosts.push(ghost);
    this.sceneObjects.materials.ghosts.push(material);
  });
}

setupAnimations() {
  const easingInOut = TWEEN.Easing.Cubic.Out;

  const recoveryWindows = [
    { start: 50, end: 620 },
    { start: 90, end: 660 },
    { start: 130, end: 700 },
    { start: 170, end: 740 },
    { start: 210, end: 780 },
    { start: 250, end: 820 },
    { start: 290, end: 950 }
  ];

  const qStart = new THREE.Quaternion().setFromAxisAngle(new THREE.Vector3(0, 1, 0), -18 * Math.PI / 180);
  const qEnd = new THREE.Quaternion().setFromAxisAngle(new THREE.Vector3(0, 1, 0), 0);

  this.sceneObjects.ghosts.forEach((ghost, i) => {
    const window = recoveryWindows[i];
    const duration = window.end - window.start;
    const baseY = ghost.position.y;
    const swayAmp = 0.22 + Math.abs(baseY) * 0.12;

    const startStatus = {
      x: ghost.position.x,
      y: ghost.position.y,
      z: ghost.position.z,
      t: 0
    };
    const endStatus = { x: 0, y: 0, z: 0, t: 1 };

    const recoverTween = new TWEEN.Tween(startStatus)
      .to(endStatus, duration)
      .delay(window.start)
      .easing(easingInOut)
      .onUpdate(obj => {
        ghost.position.x = obj.x;
        ghost.position.z = obj.z;
        const sway = swayAmp * (1.0 - obj.t) * Math.sin(obj.t * Math.PI * 2.0);
        ghost.position.y = obj.y + sway;

        const qNow = qStart.clone();
        qNow.slerp(qEnd, obj.t);
        ghost.quaternion.copy(qNow);
      })
      .start();

    this.sceneObjects.tweens.push(recoverTween);
  });

  const exitWindows = [
    { start: 950, end: 1020 },
    { start: 980, end: 1050 },
    { start: 1010, end: 1080 },
    { start: 1040, end: 1110 },
    { start: 1070, end: 1140 },
    { start: 1100, end: 1200 }
  ];

  for (let i = 0; i < 6; i++) {
    const ghost = this.sceneObjects.ghosts[i];
    const window = exitWindows[i];
    const totalDur = window.end - window.start;
    const durA = Math.floor(totalDur * 0.52);
    const durB = totalDur - durA;

    const startZ = 0;
    const midZ = -0.65;
    const endZ = -1.25;

    const startStatusA = { s: 1.0, z: startZ };
    const endStatusA = { s: 0.3, z: midZ };
    const shrinkTweenA = new TWEEN.Tween(startStatusA)
      .to(endStatusA, durA)
      .delay(window.start)
      .easing(TWEEN.Easing.Cubic.Out)
      .onUpdate(obj => {
        ghost.scale.set(obj.s, obj.s, obj.s);
        ghost.position.z = obj.z;
      })
      .start();

    const startStatusB = { s: 0.3, z: midZ };
    const endStatusB = { s: 0.0, z: endZ };
    const shrinkTweenB = new TWEEN.Tween(startStatusB)
      .to(endStatusB, durB)
      .delay(window.start + durA)
      .easing(TWEEN.Easing.Cubic.Out)
      .onUpdate(obj => {
        ghost.scale.set(obj.s, obj.s, obj.s);
        ghost.position.z = obj.z;
      })
      .start();

    this.sceneObjects.tweens.push(shrinkTweenA, shrinkTweenB);
  }

  const ghost7 = this.sceneObjects.ghosts[6];
  const startStatusGhost7 = { s: 1.0, z: 0.0 };
  const endStatusGhost7 = { s: 0.0, z: -1.2 };
  const ghost7Tween = new TWEEN.Tween(startStatusGhost7)
    .to(endStatusGhost7, 250)
    .delay(1200)
    .easing(TWEEN.Easing.Cubic.Out)
    .onUpdate(obj => {
      ghost7.scale.set(obj.s, obj.s, obj.s);
      ghost7.position.z = obj.z;
    })
    .start();
  this.sceneObjects.tweens.push(ghost7Tween);

  const card = this.sceneObjects.mainCard;
  const startStatusCard = { s: 0.96 };
  const endStatusCard = { s: 1.0 };
  const cardScaleTween = new TWEEN.Tween(startStatusCard)
    .to(endStatusCard, 250)
    .delay(1200)
    .easing(TWEEN.Easing.Cubic.Out)
    .onUpdate(obj => {
      card.scale.set(obj.s, obj.s, obj.s);
    })
    .start();
  this.sceneObjects.tweens.push(cardScaleTween);

  const startStatusCam = { x: 0.0, y: 0.8, z: 10.0 };
  const endStatusCam = { x: 0.0, y: 0.0, z: 10.0 };
  const camTween = new TWEEN.Tween(startStatusCam)
    .to(endStatusCam, 1400)
    .delay(50)
    .easing(TWEEN.Easing.Quadratic.Out)
    .onUpdate(obj => {
      this.camera.position.set(obj.x, obj.y, obj.z);
      this.camera.lookAt(0, 0, 0);
    })
    .start();
  this.sceneObjects.tweens.push(camTween);

  const waveEase = this.customEasings.Wave.Breath.Normal;
  const maxPulse = 0.15;
  this.sceneObjects.materials.ghosts.forEach(material => {
    const base = material.uniforms.u_brightness.value;
    const startStatusPulse = { offset: 0.0 };
    const endStatusPulse = { offset: maxPulse };
    const pulseTween = new TWEEN.Tween(startStatusPulse)
      .to(endStatusPulse, 900)
      .delay(100)
      .easing(waveEase)
      .onUpdate(obj => {
        const value = Math.min(base + obj.offset, base + maxPulse);
        material.uniforms.u_brightness.value = value;
      })
      .start();
    this.sceneObjects.tweens.push(pulseTween);
  });
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
