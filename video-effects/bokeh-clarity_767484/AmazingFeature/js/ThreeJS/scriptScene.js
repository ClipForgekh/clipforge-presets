const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}addAnimations(){const duration=this.Duration;const tweens=[];const startTime=50;const focusBuildEnd=300;const fadeMidTime=575;const fadeEndTime=850;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="BokehBlurShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter("bokehMode","Circle");shaderPass.setParameter("bokehSize",1.2);shaderPass.setParameter("regionIns",.7);shaderPass.setParameter("lightIns",1.2);shaderPass.setParameter("darkIns",.18);shaderPass.setParameter("quality",.82);shaderPass.setParameter("sample",56);const buildState={regionIns:.7,lightIns:1.2};const buildTween=new TWEEN.Tween(buildState).to({regionIns:.78,lightIns:1.55},focusBuildEnd-startTime).delay(startTime).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{shaderPass.setParameter("bokehMode","Circle");shaderPass.setParameter("bokehSize",1.2);shaderPass.setParameter("regionIns",obj.regionIns);shaderPass.setParameter("lightIns",obj.lightIns);shaderPass.setParameter("darkIns",.18);shaderPass.setParameter("quality",.82);shaderPass.setParameter("sample",56)});const fadeState1={bokehSize:1.2,regionIns:.78,lightIns:1.55,darkIns:.18,sample:56};const fadeTween1=new TWEEN.Tween(fadeState1).to({bokehSize:.72,regionIns:.39,lightIns:.78,darkIns:.1,sample:28},fadeMidTime-focusBuildEnd).delay(focusBuildEnd).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{shaderPass.setParameter("bokehMode","Circle");shaderPass.setParameter("bokehSize",obj.bokehSize);shaderPass.setParameter("regionIns",obj.regionIns);shaderPass.setParameter("lightIns",obj.lightIns);shaderPass.setParameter("darkIns",obj.darkIns);shaderPass.setParameter("quality",.82);shaderPass.setParameter("sample",Math.max(0,Math.round(obj.sample)))});const fadeState2={bokehSize:.72,regionIns:.39,lightIns:.78,darkIns:.1,sample:28};const fadeTween2=new TWEEN.Tween(fadeState2).to({bokehSize:0,regionIns:0,lightIns:0,darkIns:0,sample:0},fadeEndTime-fadeMidTime).delay(fadeMidTime).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{shaderPass.setParameter("bokehMode","Circle");shaderPass.setParameter("bokehSize",obj.bokehSize);shaderPass.setParameter("regionIns",obj.regionIns);shaderPass.setParameter("lightIns",obj.lightIns);shaderPass.setParameter("darkIns",obj.darkIns);shaderPass.setParameter("quality",.82);shaderPass.setParameter("sample",Math.max(0,Math.round(obj.sample)))});shaderPass.setParameter("quality",.82);tweens.push(buildTween,fadeTween1,fadeTween2)}});tweens.forEach(tween=>tween.start());return tweens}initPostProcessing(){if(!this.usePostProcessing)return;const shaderPassConfigs=[{name:"LumiBokehBlur"}];this.setupPostProcessing(shaderPassConfigs);const tweens=this.addAnimations();if(tweens.length>0){if(!this.sceneObjects.tweens){this.sceneObjects.tweens=[]}this.sceneObjects.tweens.push(...tweens)}}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(2762275);this.createMainScreenPlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=1e3;this.sceneObjects={mainPlane:null,materials:{},uniforms:{},tweens:[]};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createMainScreenPlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="主画面平面_Geometry";const uniforms={texture1:{value:this.texture1},ratio:{value:1},u_bgBlur:{value:1},u_midBlur:{value:1},u_fgBlur:{value:1},u_bgZ:{value:-.6},u_midZ:{value:0},u_fgZ:{value:.6},u_bokehIntensity:{value:.7},u_bokehSize:{value:1},u_bokehDensity:{value:1},u_grainIntensity:{value:0},u_brightness:{value:1},u_grayscale:{value:0},u_chromatic:{value:0}};const vertexShader=`
    varying vec2 vUv;
    void main() {
      vUv = uv;
      gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    }
  `;const fragmentShader=`
    precision mediump float;

    uniform sampler2D texture1;
    uniform float ratio;

    uniform float u_bgBlur;
    uniform float u_midBlur;
    uniform float u_fgBlur;

    uniform float u_bgZ;
    uniform float u_midZ;
    uniform float u_fgZ;

    uniform float u_bokehIntensity;
    uniform float u_bokehSize;
    uniform float u_bokehDensity;
    uniform float u_grainIntensity;

    uniform float u_brightness;
    uniform float u_grayscale;
    uniform float u_chromatic;

    varying vec2 vUv;

    float hash12(vec2 p) {
      vec3 p3 = fract(vec3(p.xyx) * 0.1031);
      p3 += dot(p3, p3.yzx + 33.33);
      return fract((p3.x + p3.y) * p3.z);
    }

    vec2 getAspectCorrectUV(vec2 uv) {
      vec2 aspectUV = uv;
      if (ratio > 1.0) {
        aspectUV.y /= ratio;
        aspectUV.y += (1.0 - 1.0 / ratio) * 0.5;
      } else {
        aspectUV.x *= ratio;
        aspectUV.x += (1.0 - ratio) * 0.5;
      }
      return aspectUV;
    }

    vec4 radialBlurLayer(sampler2D tex, vec2 uv, float blurStrength, float depthBias) {
      vec2 center = vec2(0.5, 0.5);
      vec2 dir = uv - center;
      float dist = length(dir);
      vec2 safeDir = dist > 0.0001 ? normalize(dir) : vec2(0.0, 0.0);

      float blur = blurStrength * (0.02 + abs(depthBias) * 0.015);
      vec4 color = vec4(0.0);

      color += texture2D(tex, clamp(uv + safeDir * blur * -1.20, 0.0, 1.0)) * 0.08;
      color += texture2D(tex, clamp(uv + safeDir * blur * -0.80, 0.0, 1.0)) * 0.12;
      color += texture2D(tex, clamp(uv + safeDir * blur * -0.45, 0.0, 1.0)) * 0.15;
      color += texture2D(tex, clamp(uv + safeDir * blur *  0.00, 0.0, 1.0)) * 0.30;
      color += texture2D(tex, clamp(uv + safeDir * blur *  0.45, 0.0, 1.0)) * 0.15;
      color += texture2D(tex, clamp(uv + safeDir * blur *  0.80, 0.0, 1.0)) * 0.12;
      color += texture2D(tex, clamp(uv + safeDir * blur *  1.20, 0.0, 1.0)) * 0.08;

      return color;
    }

    float circleGlow(vec2 uv, vec2 center, float radius, float softness) {
      float d = length(uv - center);
      return 1.0 - smoothstep(radius, radius + softness, d);
    }

    vec3 generateBokeh(vec2 uv) {
      vec2 aspectUV = getAspectCorrectUV(uv);
      vec2 center = vec2(0.5, 0.5);
      vec2 spreadUv = (aspectUV - center) * (1.0 + (1.0 - u_bokehDensity) * 1.25) + center;

      vec3 warmGold = vec3(0.839, 0.702, 0.416);
      vec3 softBrown = vec3(0.431, 0.384, 0.333);
      vec3 paleGold = vec3(0.902, 0.843, 0.722);

      float s = max(u_bokehSize, 0.0);
      float d = clamp(u_bokehDensity, 0.0, 1.0);

      float accum = 0.0;
      accum += circleGlow(spreadUv, center + vec2(-0.18,  0.10), 0.18 * s, 0.08 * s + 0.01) * (0.95 * d);
      accum += circleGlow(spreadUv, center + vec2( 0.12,  0.06), 0.14 * s, 0.07 * s + 0.01) * (0.90 * d);
      accum += circleGlow(spreadUv, center + vec2(-0.04, -0.12), 0.16 * s, 0.08 * s + 0.01) * (0.85 * d);
      accum += circleGlow(spreadUv, center + vec2( 0.20, -0.08), 0.12 * s, 0.06 * s + 0.01) * (0.75 * d);
      accum += circleGlow(spreadUv, center + vec2( 0.00,  0.00), 0.22 * s, 0.10 * s + 0.01) * (1.00 * d);

      float edgeFade = 1.0 - smoothstep(0.0, 0.75, length(aspectUV - center));
      accum *= edgeFade;

      vec3 bokehColor = mix(softBrown, warmGold, 0.65) * 0.45 + paleGold * 0.55;
      return bokehColor * accum * u_bokehIntensity;
    }

    vec3 applyFilmGrain(vec2 uv, vec3 color) {
      float n1 = hash12(uv * 500.0 + vec2(12.3, 48.7));
      float n2 = hash12(uv * 820.0 + vec2(91.1, 23.4));
      float grain = (n1 * 0.6 + n2 * 0.4 - 0.5) * 2.0;
      return color + grain * u_grainIntensity * 0.12;
    }

    void main() {
      vec2 uv = vUv;

      vec4 bgColor = radialBlurLayer(texture1, uv, u_bgBlur, u_bgZ);
      vec4 midColor = radialBlurLayer(texture1, uv, u_midBlur, u_midZ);
      vec4 fgColor = radialBlurLayer(texture1, uv, u_fgBlur, u_fgZ);

      float bgWeight = 1.0 + abs(u_bgZ) * 0.35;
      float midWeight = 1.0 + abs(u_midZ) * 0.15;
      float fgWeight = 1.0 + abs(u_fgZ) * 0.35;
      float weightSum = bgWeight + midWeight + fgWeight;

      vec4 texColor = (bgColor * bgWeight + midColor * midWeight + fgColor * fgWeight) / weightSum;

      texColor.rgb += generateBokeh(uv);
      texColor.rgb = applyFilmGrain(uv, texColor.rgb);

      texColor.rgb *= u_brightness;

      float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));
      texColor.rgb = mix(texColor.rgb, vec3(gray), u_grayscale);

      vec2 mappedUv = uv;
      vec2 dir = mappedUv - vec2(0.5);
      float offset = u_chromatic * 0.02;
      float r = texture2D(texture1, clamp(mappedUv + dir * offset, 0.0, 1.0)).r;
      float g = texColor.g;
      float b = texture2D(texture1, clamp(mappedUv - dir * offset, 0.0, 1.0)).b;
      vec3 chromaColor = vec3(r, g, b);
      texColor.rgb = mix(texColor.rgb, chromaColor, clamp(u_chromatic, 0.0, 1.0));

      gl_FragColor = vec4(clamp(texColor.rgb, 0.0, 1.0), 1.0);
    }
  `;const material=new THREE.ShaderMaterial({uniforms:uniforms,vertexShader:vertexShader,fragmentShader:fragmentShader,transparent:false,side:THREE.DoubleSide});material.name="主画面平面_Material";const plane=new THREE.Mesh(geometry,material);plane.name="主画面平面";plane.position.set(0,0,0);this.scene.add(plane);this.sceneObjects.mainPlane=plane;this.sceneObjects.materials.mainPlaneMaterial=material;this.sceneObjects.uniforms=uniforms;this.createRatioTween(material)}createRatioTween(material){const startStatus={ratioTick:0};const endStatus={ratioTick:1};const ratioTween=new TWEEN.Tween(startStatus).to(endStatus,this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(()=>{if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){material.uniforms.ratio.value=1}else{material.uniforms.ratio.value=this.texture1.image.width/this.texture1.image.height}this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(ratioTween)}setupAnimations(){const uniforms=this.sceneObjects.uniforms;if(!uniforms)return;const bokehRiseStart={intensity:.7};const bokehRiseEnd={intensity:.9};const bokehRiseTween=new TWEEN.Tween(bokehRiseStart).to(bokehRiseEnd,250).delay(50).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_bokehIntensity.value=obj.intensity;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(bokehRiseTween);const bgBlurStart={blur:1};const bgBlurEnd={blur:.05};const bgBlurTween=new TWEEN.Tween(bgBlurStart).to(bgBlurEnd,350).delay(300).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_bgBlur.value=obj.blur;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(bgBlurTween);const midBlurStart={blur:1};const midBlurEnd={blur:.03};const midBlurTween=new TWEEN.Tween(midBlurStart).to(midBlurEnd,350).delay(450).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_midBlur.value=obj.blur;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(midBlurTween);const fgBlurStart={blur:1};const fgBlurEnd={blur:0};const fgBlurTween=new TWEEN.Tween(fgBlurStart).to(fgBlurEnd,300).delay(600).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_fgBlur.value=obj.blur;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(fgBlurTween);const bokehPhase1Start={size:1,density:1,intensity:.9};const bokehPhase1End={size:.6,density:.5,intensity:.5};const bokehPhase1Tween=new TWEEN.Tween(bokehPhase1Start).to(bokehPhase1End,275).delay(300).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_bokehSize.value=obj.size;uniforms.u_bokehDensity.value=obj.density;uniforms.u_bokehIntensity.value=obj.intensity;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(bokehPhase1Tween);const bokehPhase2Start={size:.6,density:.5,intensity:.5};const bokehPhase2End={size:0,density:0,intensity:0};const bokehPhase2Tween=new TWEEN.Tween(bokehPhase2Start).to(bokehPhase2End,275).delay(575).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_bokehSize.value=obj.size;uniforms.u_bokehDensity.value=obj.density;uniforms.u_bokehIntensity.value=obj.intensity;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(bokehPhase2Tween);const depthMergePhase1Start={bgZ:-.6,fgZ:.6};const depthMergePhase1End={bgZ:-.15,fgZ:.15};const depthMergePhase1Tween=new TWEEN.Tween(depthMergePhase1Start).to(depthMergePhase1End,75).delay(800).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_bgZ.value=obj.bgZ;uniforms.u_fgZ.value=obj.fgZ;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(depthMergePhase1Tween);const depthMergePhase2Start={bgZ:-.15,fgZ:.15};const depthMergePhase2End={bgZ:0,fgZ:0};const depthMergePhase2Tween=new TWEEN.Tween(depthMergePhase2Start).to(depthMergePhase2End,75).delay(875).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_bgZ.value=obj.bgZ;uniforms.u_fgZ.value=obj.fgZ;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(depthMergePhase2Tween);const grainRiseStart={grain:0};const grainRiseEnd={grain:.08};const grainRiseTween=new TWEEN.Tween(grainRiseStart).to(grainRiseEnd,60).delay(820).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_grainIntensity.value=obj.grain;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(grainRiseTween);const grainFallStart={grain:.08};const grainFallEnd={grain:0};const grainFallTween=new TWEEN.Tween(grainFallStart).to(grainFallEnd,60).delay(880).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_grainIntensity.value=obj.grain;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(grainFallTween);const lockFinalStart={bgBlur:.05,midBlur:.03,fgBlur:0,bokehIntensity:0,bokehSize:0,bokehDensity:0,grain:0,bgZ:0,midZ:0,fgZ:0,brightness:1,grayscale:0,chromatic:0};const lockFinalEnd={bgBlur:0,midBlur:0,fgBlur:0,bokehIntensity:0,bokehSize:0,bokehDensity:0,grain:0,bgZ:0,midZ:0,fgZ:0,brightness:1,grayscale:0,chromatic:0};const lockFinalTween=new TWEEN.Tween(lockFinalStart).to(lockFinalEnd,10).delay(940).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_bgBlur.value=obj.bgBlur;uniforms.u_midBlur.value=obj.midBlur;uniforms.u_fgBlur.value=obj.fgBlur;uniforms.u_bokehIntensity.value=obj.bokehIntensity;uniforms.u_bokehSize.value=obj.bokehSize;uniforms.u_bokehDensity.value=obj.bokehDensity;uniforms.u_grainIntensity.value=obj.grain;uniforms.u_bgZ.value=obj.bgZ;uniforms.u_midZ.value=obj.midZ;uniforms.u_fgZ.value=obj.fgZ;uniforms.u_brightness.value=obj.brightness;uniforms.u_grayscale.value=obj.grayscale;uniforms.u_chromatic.value=obj.chromatic;this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(lockFinalTween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;