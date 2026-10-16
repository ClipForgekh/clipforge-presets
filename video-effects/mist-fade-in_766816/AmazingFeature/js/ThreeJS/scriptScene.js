const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}_applyTweenInitialState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,0);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,0)}}_applyTweenFinalState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,1);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,1)}}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(1710618);this.createParticleFlowEntrancePlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=3e3;this.sceneObjects={mainPlane:null,materials:[],tweens:[],uniforms:{}};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createParticleFlowEntrancePlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="ParticleFlowEntrancePlaneGeometry";const material=new THREE.ShaderMaterial({name:"ParticleFlowEntrancePlaneMaterial",transparent:true,side:THREE.DoubleSide,depthWrite:false,uniforms:{texture1:{value:this.texture1||null},texture2:{value:this.texture2||null},u_textureAlpha:{value:0},u_particleAlpha:{value:1},u_glowIntensity:{value:0},u_flowProgress:{value:0},u_brightness:{value:1},ratio:{value:1},u_color1:{value:new THREE.Color(14263361)},u_color2:{value:new THREE.Color(13136938)},u_highlightColor:{value:new THREE.Color(15787730)},u_bgColor:{value:new THREE.Color(1710618)}},vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;

      uniform sampler2D texture1;
      uniform sampler2D texture2;
      uniform float u_textureAlpha;
      uniform float u_particleAlpha;
      uniform float u_glowIntensity;
      uniform float u_flowProgress;
      uniform float u_brightness;
      uniform float ratio;
      uniform vec3 u_color1;
      uniform vec3 u_color2;
      uniform vec3 u_highlightColor;
      uniform vec3 u_bgColor;

      varying vec2 vUv;

      float hash11(float p) {
        p = fract(p * 0.1031);
        p *= p + 33.33;
        p *= p + p;
        return fract(p);
      }

      float hash21(vec2 p) {
        vec3 p3 = fract(vec3(p.xyx) * 0.1031);
        p3 += dot(p3, p3.yzx + 33.33);
        return fract((p3.x + p3.y) * p3.z);
      }

      mat2 rot(float a) {
        float s = sin(a);
        float c = cos(a);
        return mat2(c, -s, s, c);
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

      vec2 swirlWarp(vec2 uv, float progress) {
        vec2 center = vec2(0.52, 0.53);
        vec2 p = uv - center;
        float d = length(p);
        float influence = exp(-d * 4.0);
        float angle = (0.9 - d) * 2.2 * progress * influence;
        return center + rot(angle) * p;
      }

      vec2 particlePath(float t, float id) {
        float startY = 0.18 + 0.54 * hash11(id * 1.173);
        float arc = (hash11(id * 2.417) - 0.5) * 0.42;
        float wave = sin(t * 6.28318 * (1.0 + hash11(id * 3.911) * 1.7) + id * 0.17) * (0.035 + 0.05 * hash11(id * 5.217));
        float x = -0.20 + 1.40 * t + 0.05 * sin(id * 0.31 + t * 5.1);
        float centerBias = exp(-pow((t - 0.56) * 4.6, 2.0));
        float y = mix(startY, 0.58 + arc, smoothstep(0.0, 0.68, t));
        y += wave;
        y += sin(t * 9.0 + id * 0.13) * 0.035 * centerBias;
        y += smoothstep(0.55, 1.0, t) * (0.18 + 0.12 * hash11(id * 6.731));
        return vec2(x, y);
      }

      float particleLayer(vec2 uv, float progress) {
        float acc = 0.0;
        float p = clamp(progress, 0.0, 1.0);
        vec2 warpedUv = swirlWarp(uv, smoothstep(0.18, 0.85, p));

        for (int i = 0; i < 48; i++) {
          float id = float(i) + 1.0;
          float localOffset = hash11(id * 9.137) * 0.22;
          float localTime = clamp((p - localOffset) / (1.0 - localOffset + 0.0001), 0.0, 1.0);
          vec2 pos = particlePath(localTime, id);

          float size = mix(0.006, 0.018, hash11(id * 7.111));
          float centerBoost = 1.0 + 1.8 * exp(-pow((localTime - 0.58) * 7.0, 2.0));
          float d = length(warpedUv - pos);
          float core = exp(-pow(d / size, 2.0) * 2.8);
          float glow = exp(-pow(d / (size * 5.2), 2.0) * 1.05);

          float lifeFadeIn = smoothstep(0.0, 0.08, localTime);
          float lifeFadeOut = 1.0 - smoothstep(0.72, 1.0, localTime);
          float life = lifeFadeIn * lifeFadeOut;

          acc += (core * 1.1 + glow * 0.55 * u_glowIntensity) * life * centerBoost;
        }

        vec2 center = vec2(0.50, 0.56);
        float band = exp(-pow((warpedUv.y - center.y - sin((warpedUv.x + p) * 5.5) * 0.04) / 0.13, 2.0));
        float centerMask = exp(-pow(length((warpedUv - center) * vec2(1.0, 1.55)) / 0.35, 2.0));
        float stream = band * mix(0.2, 1.2, smoothstep(0.15, 0.75, p)) * (0.4 + centerMask * 1.6);

        return acc * 0.045 + stream;
      }

      void main() {
        vec2 uv = getAspectCorrectUV(vUv);
        vec4 texColor = texture2D(texture1, vUv);

        float particleMask = particleLayer(uv, u_flowProgress);
        particleMask *= u_particleAlpha;

        vec3 particleColorBase = mix(u_color2, u_color1, clamp(uv.x * 0.75 + 0.25, 0.0, 1.0));
        vec3 particleColor = mix(particleColorBase, u_highlightColor, clamp(particleMask * 0.85 + u_glowIntensity * 0.2, 0.0, 1.0));

        float revealMask = clamp(
          smoothstep(0.06, 0.75, particleMask * 0.95 + u_flowProgress * 0.65) *
          smoothstep(0.0, 0.25, u_textureAlpha),
          0.0, 1.0
        );
        float finalTextureAlpha = clamp(max(u_textureAlpha * 0.85, revealMask) + u_textureAlpha * 0.15, 0.0, 1.0);

        vec3 baseColor = u_bgColor;
        vec3 screenMix = 1.0 - (1.0 - baseColor) * (1.0 - particleColor * clamp(particleMask * (0.65 + u_glowIntensity * 0.8), 0.0, 1.0));
        vec3 additiveMix = baseColor + particleColor * particleMask * (0.35 + u_glowIntensity * 1.1);
        vec3 glowLayer = mix(screenMix, additiveMix, 0.45);

        vec3 composed = mix(glowLayer, texColor.rgb, finalTextureAlpha);
        composed += particleColor * particleMask * u_glowIntensity * 0.18 * (1.0 - finalTextureAlpha);
        composed *= u_brightness;

        float finalAlpha = max(finalTextureAlpha, clamp(particleMask * 0.6, 0.0, 1.0));
        gl_FragColor = vec4(composed, finalAlpha);
      }
    `});const mesh=new THREE.Mesh(geometry,material);mesh.name="粒子光流入场平面";mesh.position.set(0,0,0);mesh.scale.set(1,1,1);this.scene.add(mesh);this.sceneObjects.mainPlane=mesh;this.sceneObjects.materials.push(material);this.sceneObjects.uniforms=material.uniforms}setupAnimations(){if(!this.sceneObjects.mainPlane||!this.sceneObjects.uniforms)return;const uniforms=this.sceneObjects.uniforms;const ratioState={value:uniforms.ratio.value};const ratioTween=new TWEEN.Tween(ratioState).to({value:1},this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(()=>{if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){uniforms.ratio.value=1}else{uniforms.ratio.value=this.texture1.image.width/this.texture1.image.height}}).start();this.sceneObjects.tweens.push(ratioTween);const stage1FlowState={value:0};const stage1FlowTween=new TWEEN.Tween(stage1FlowState).to({value:.28},700).delay(50).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_flowProgress.value=obj.value}).start();this.sceneObjects.tweens.push(stage1FlowTween);const stage1GlowState={value:0};const stage1GlowTween=new TWEEN.Tween(stage1GlowState).to({value:.55},700).delay(50).easing(TWEEN.Easing.Sinusoidal.In).onUpdate(obj=>{uniforms.u_glowIntensity.value=obj.value}).start();this.sceneObjects.tweens.push(stage1GlowTween);const stage2FlowState={value:.28};const stage2FlowTween=new TWEEN.Tween(stage2FlowState).to({value:.72},1e3).delay(750).easing(TWEEN.Easing.Circular.InOut).onUpdate(obj=>{uniforms.u_flowProgress.value=obj.value}).start();this.sceneObjects.tweens.push(stage2FlowTween);const stage2GlowState={value:.55};const stage2GlowTween=new TWEEN.Tween(stage2GlowState).to({value:1},1e3).delay(750).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_glowIntensity.value=obj.value}).start();this.sceneObjects.tweens.push(stage2GlowTween);const stage2TextureState={value:0};const stage2TextureTween=new TWEEN.Tween(stage2TextureState).to({value:.82},1e3).delay(750).easing(TWEEN.Easing.Exponential.InOut).onUpdate(obj=>{uniforms.u_textureAlpha.value=obj.value}).start();this.sceneObjects.tweens.push(stage2TextureTween);const stage3FlowState={value:.72};const stage3FlowTween=new TWEEN.Tween(stage3FlowState).to({value:1},600).delay(1750).easing(TWEEN.Easing.Sinusoidal.Out).onUpdate(obj=>{uniforms.u_flowProgress.value=obj.value}).start();this.sceneObjects.tweens.push(stage3FlowTween);const stage3ParticleState={value:1};const stage3ParticleTween=new TWEEN.Tween(stage3ParticleState).to({value:.18},600).delay(1750).easing(TWEEN.Easing.Exponential.Out).onUpdate(obj=>{uniforms.u_particleAlpha.value=obj.value}).start();this.sceneObjects.tweens.push(stage3ParticleTween);const stage3GlowState={value:1};const stage3GlowTween=new TWEEN.Tween(stage3GlowState).to({value:.15},600).delay(1750).easing(TWEEN.Easing.Exponential.Out).onUpdate(obj=>{uniforms.u_glowIntensity.value=obj.value}).start();this.sceneObjects.tweens.push(stage3GlowTween);const stage3TextureState={value:.82};const stage3TextureTween=new TWEEN.Tween(stage3TextureState).to({value:1},600).delay(1750).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_textureAlpha.value=obj.value}).start();this.sceneObjects.tweens.push(stage3TextureTween);const stage4ParticleState={value:.18};const stage4ParticleTween=new TWEEN.Tween(stage4ParticleState).to({value:0},600).delay(2350).easing(TWEEN.Easing.Sinusoidal.Out).onUpdate(obj=>{uniforms.u_particleAlpha.value=obj.value}).start();this.sceneObjects.tweens.push(stage4ParticleTween);const stage4GlowState={value:.15};const stage4GlowTween=new TWEEN.Tween(stage4GlowState).to({value:0},600).delay(2350).easing(TWEEN.Easing.Sinusoidal.Out).onUpdate(obj=>{uniforms.u_glowIntensity.value=obj.value}).start();this.sceneObjects.tweens.push(stage4GlowTween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;