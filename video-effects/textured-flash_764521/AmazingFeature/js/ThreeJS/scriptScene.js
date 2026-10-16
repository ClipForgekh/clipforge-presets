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
  this.scene.background = new THREE.Color(0x000000);
  this.createExposureBlurPlane();
  this.setupAnimations();
  return this.sceneObjects;
}

initSceneObjects() {
  this.Duration = 3000;
  this.sceneObjects = {
    mainPlane: null,
    materials: {},
    uniforms: {},
    tweens: []
  };

  this.camera.fov = 53.1;
  this.camera.position.set(0.0, 0.0, 10.0);
  this.camera.lookAt(0.0, 0.0, 0.0);
  this.camera.updateProjectionMatrix();
}

createExposureBlurPlane() {
  const geometry = new THREE.PlaneGeometry(10, 10, 1, 1);
  geometry.name = '基础平面1_Geometry';

  const material = new THREE.ShaderMaterial({
    uniforms: {
      texture1: { value: this.texture1 },
      blurRadiusPx: { value: 20.0 },
      exposureGain: { value: 3.0 },
      ratio: { value: 1.0 }
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
      uniform float blurRadiusPx;
      uniform float exposureGain;
      uniform float ratio;
      varying vec2 vUv;

      vec4 gaussianBlur(sampler2D tex, vec2 uv, float blurStrength) {
        vec4 color = vec4(0.0);
        float totalWeight = 0.0;

        float kernel[25];
        kernel[0] = 1.0; kernel[1] = 4.0; kernel[2] = 6.0; kernel[3] = 4.0; kernel[4] = 1.0;
        kernel[5] = 4.0; kernel[6] = 16.0; kernel[7] = 24.0; kernel[8] = 16.0; kernel[9] = 4.0;
        kernel[10] = 6.0; kernel[11] = 24.0; kernel[12] = 36.0; kernel[13] = 24.0; kernel[14] = 6.0;
        kernel[15] = 4.0; kernel[16] = 16.0; kernel[17] = 24.0; kernel[18] = 16.0; kernel[19] = 4.0;
        kernel[20] = 1.0; kernel[21] = 4.0; kernel[22] = 6.0; kernel[23] = 4.0; kernel[24] = 1.0;

        float baseStep = 0.001 * blurStrength;
        vec2 stepSize = vec2(baseStep, baseStep / ratio);

        for (int i = -2; i <= 2; i++) {
          for (int j = -2; j <= 2; j++) {
            float weight = kernel[(i + 2) * 5 + (j + 2)];
            vec2 offset = vec2(float(i) * stepSize.x, float(j) * stepSize.y);
            vec2 sampleUV = clamp(uv + offset, 0.0, 1.0);
            color += texture2D(tex, sampleUV) * weight;
            totalWeight += weight;
          }
        }

        return color / totalWeight;
      }

      void main() {
        vec4 texColor = gaussianBlur(texture1, vUv, blurRadiusPx);
        texColor.rgb *= exposureGain;
        gl_FragColor = vec4(texColor.rgb, texColor.a);
      }
    `,
    transparent: false,
    side: THREE.DoubleSide
  });
  material.name = '基础平面1_Material';

  const plane = new THREE.Mesh(geometry, material);
  plane.name = '基础平面1_平面网格';
  plane.position.set(0.0, 0.0, 0.0);
  plane.scale.set(1.0, 1.0, 1.0);

  this.scene.add(plane);

  this.sceneObjects.mainPlane = plane;
  this.sceneObjects.materials.mainPlaneMaterial = material;
  this.sceneObjects.uniforms.mainPlaneUniforms = material.uniforms;

  const ratioState = { value: 1.0 };
  const ratioTween = new TWEEN.Tween(ratioState)
    .to({ value: 1.0 }, this.Duration)
    .delay(0)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate(() => {
      if(!this.texture1 || !this.texture1.image || !this.texture1.image.width || !this.texture1.image.height){material.uniforms.ratio.value = 1.0}else{material.uniforms.ratio.value = this.texture1.image.width / this.texture1.image.height}
    })
    .start();
  this.sceneObjects.tweens.push(ratioTween);
}

setupAnimations() {
  const plane = this.sceneObjects.mainPlane;
  const uniforms = this.sceneObjects.uniforms.mainPlaneUniforms;
  if (!plane || !uniforms) return;

  const holdStatus = { blurRadiusPx: 20.0, exposureGain: 3.0 };
  const holdTween = new TWEEN.Tween(holdStatus)
    .to({ blurRadiusPx: 20.0, exposureGain: 3.0 }, 450)
    .delay(50)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate((obj) => {
      uniforms.blurRadiusPx.value = obj.blurRadiusPx;
      uniforms.exposureGain.value = obj.exposureGain;
      this.camera.lookAt(0.0, 0.0, 0.0);
    })
    .start();
  this.sceneObjects.tweens.push(holdTween);

  const fadeStatus1 = { blurRadiusPx: 20.0, exposureGain: 3.0 };
  const fadeTween1 = new TWEEN.Tween(fadeStatus1)
    .to({ blurRadiusPx: 8.0, exposureGain: 1.6 }, 700)
    .delay(500)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate((obj) => {
      uniforms.blurRadiusPx.value = obj.blurRadiusPx;
      uniforms.exposureGain.value = obj.exposureGain;
      this.camera.lookAt(0.0, 0.0, 0.0);
    })
    .start();
  this.sceneObjects.tweens.push(fadeTween1);

  const fadeStatus2 = { blurRadiusPx: 8.0, exposureGain: 1.6 };
  const fadeTween2 = new TWEEN.Tween(fadeStatus2)
    .to({ blurRadiusPx: 0.0, exposureGain: 1.0 }, 400)
    .delay(1200)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate((obj) => {
      uniforms.blurRadiusPx.value = obj.blurRadiusPx;
      uniforms.exposureGain.value = obj.exposureGain;
      this.camera.lookAt(0.0, 0.0, 0.0);
    })
    .start();
  this.sceneObjects.tweens.push(fadeTween2);

  const finalStatus = { blurRadiusPx: 0.0, exposureGain: 1.0 };
  const finalHoldTween = new TWEEN.Tween(finalStatus)
    .to({ blurRadiusPx: 0.0, exposureGain: 1.0 }, 1400)
    .delay(1600)
    .easing(TWEEN.Easing.Linear.None)
    .onUpdate((obj) => {
      uniforms.blurRadiusPx.value = obj.blurRadiusPx;
      uniforms.exposureGain.value = obj.exposureGain;
      this.camera.lookAt(0.0, 0.0, 0.0);
    })
    .start();
  this.sceneObjects.tweens.push(finalHoldTween);
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
