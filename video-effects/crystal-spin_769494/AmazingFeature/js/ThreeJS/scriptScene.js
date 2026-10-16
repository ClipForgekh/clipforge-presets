const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}addAnimations(){const duration=this.Duration;const tweens=[];const safeStart=50;const safeEnd=Math.max(50,duration-50);const t0=Math.min(Math.max(50,safeStart),safeEnd);const t1=Math.min(Math.max(450,safeStart),safeEnd);const t2=Math.min(Math.max(1200,safeStart),safeEnd);const t3=Math.min(Math.max(1850,safeStart),safeEnd);const t4=Math.min(Math.max(2150,safeStart),safeEnd);this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="ChromaticAberrationShaderPass"){if(typeof shaderPass.getPresetConfig!=="function"||typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 getPresetConfig 或 setParameter 方法`);return}const presetNone=shaderPass.getPresetConfig("none");const presetSubtle=shaderPass.getPresetConfig("subtle_lens");const presetLow=shaderPass.getPresetConfig("low");if(!presetNone||!presetSubtle||!presetLow){console.error(`${shaderPass.constructor.name} 缺少预设：none / subtle_lens / low`);return}const applyParams=obj=>{for(const key in obj){shaderPass.setParameter(key,obj[key])}};applyParams({...presetNone});const seg1From={...presetNone};const seg1To={...presetSubtle};const tween1=new TWEEN.Tween(seg1From).to(seg1To,Math.max(0,t1-t0)).delay(Math.max(0,t0)).easing(TWEEN.Easing.Exponential.Out).onUpdate(obj=>{applyParams(obj)});const seg2From={...presetSubtle};const seg2To={...presetLow};const tween2=new TWEEN.Tween(seg2From).to(seg2To,Math.max(0,t2-t1)).delay(Math.max(0,t1)).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{applyParams(obj)});const seg3From={...presetLow};const seg3To={...presetSubtle};const tween3=new TWEEN.Tween(seg3From).to(seg3To,Math.max(0,t3-t2)).delay(Math.max(0,t2)).easing(TWEEN.Easing.Circular.InOut).onUpdate(obj=>{applyParams(obj)});const seg4From={...presetSubtle};const seg4To={...presetNone};const tween4=new TWEEN.Tween(seg4From).to(seg4To,Math.max(0,t4-t3)).delay(Math.max(0,t3)).easing(TWEEN.Easing.Exponential.In).onUpdate(obj=>{applyParams(obj)});tweens.push(tween1,tween2,tween3,tween4)}});tweens.forEach(tween=>tween.start());return tweens}initPostProcessing(){if(!this.usePostProcessing)return;const shaderPassConfigs=[{name:"LumiChromaticAberration"}];this.setupPostProcessing(shaderPassConfigs);const tweens=this.addAnimations();if(tweens.length>0){if(!this.sceneObjects.tweens){this.sceneObjects.tweens=[]}this.sceneObjects.tweens.push(...tweens)}}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}_applyTweenInitialState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,0);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,0)}}_applyTweenFinalState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,1);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,1)}}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(0);this.createIceSpiralDissolvePlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=2200;this.sceneObjects={iceMainPlane:null,iceMainMaterial:null,tweens:[]};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createIceSpiralDissolvePlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="IceSpiralPlaneGeometry";const material=new THREE.ShaderMaterial({name:"IceSpiralDissolveShaderMaterial",side:THREE.DoubleSide,transparent:false,depthTest:true,depthWrite:true,uniforms:{texture1:{value:this.texture1},u_time:{value:0},u_progress:{value:0},u_particleLayers:{value:3},u_particleSizeMin:{value:1},u_particleSizeMax:{value:5},u_mainColor:{value:new THREE.Color("#7FD4FF")},u_glowColor:{value:new THREE.Color("#B8A8FF")},u_turbulenceFreq:{value:18},u_spiralInward:{value:1},u_dissolveToBlack:{value:1},u_trailFog:{value:.25},u_chromatic:{value:.18},ratio:{value:1},u_resolution:{value:new THREE.Vector2(window.innerWidth,window.innerHeight)}},vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision highp float;

      uniform sampler2D texture1;
      uniform float u_time;
      uniform float u_progress;
      uniform float u_particleLayers;
      uniform float u_particleSizeMin;
      uniform float u_particleSizeMax;
      uniform vec3 u_mainColor;
      uniform vec3 u_glowColor;
      uniform float u_turbulenceFreq;
      uniform float u_spiralInward;
      uniform float u_dissolveToBlack;
      uniform float u_trailFog;
      uniform float u_chromatic;
      uniform float ratio;
      uniform vec2 u_resolution;

      varying vec2 vUv;

      float hash12(vec2 p) {
        vec3 p3 = fract(vec3(p.xyx) * 0.1031);
        p3 += dot(p3, p3.yzx + 33.33);
        return fract((p3.x + p3.y) * p3.z);
      }

      float hexSDF(vec2 p) {
        p = abs(p);
        return max(dot(p, normalize(vec2(1.0, 1.7320508))), p.x) - 1.0;
      }

      vec2 aspectCorrect(vec2 uv) {
        vec2 p = uv - 0.5;
        if (ratio > 1.0) {
          p.y /= ratio;
        } else {
          p.x *= ratio;
        }
        return p;
      }

      vec3 sampleChromatic(vec2 uv, float amount) {
        vec2 dir = uv - vec2(0.5);
        float off = amount * 0.01;
        float r = texture2D(texture1, clamp(uv + dir * off, 0.0, 1.0)).r;
        float g = texture2D(texture1, clamp(uv, 0.0, 1.0)).g;
        float b = texture2D(texture1, clamp(uv - dir * off, 0.0, 1.0)).b;
        return vec3(r, g, b);
      }

      float particleLayer(vec2 uv, float layerId, float progress, float t) {
        vec2 p = aspectCorrect(uv);
        float r = length(p);
        float a = atan(p.y, p.x);

        float edgeDist = max(abs(uv.x - 0.5), abs(uv.y - 0.5));
        float edgeTrigger = smoothstep(0.18 - progress * 0.18, 0.5, edgeDist);

        float turb = (hash12(floor((uv + t * 0.03) * (40.0 + layerId * 9.0))) - 0.5) * 2.0;
        float swirl = a + progress * (7.0 + layerId * 1.5) * u_spiralInward + turb * 0.45;
        float targetR = mix(0.72 + layerId * 0.06, 0.04 + layerId * 0.02, progress);
        float ring = exp(-abs(r - targetR) * (26.0 - layerId * 4.0));

        vec2 flow = vec2(swirl / 6.2831853 + 0.5, r * 9.0 - progress * (8.0 + layerId * 1.3) + turb * 0.8);
        vec2 cell = floor(flow * vec2(48.0, 30.0 + layerId * 4.0));
        float rnd = hash12(cell + layerId * 17.0);
        float appear = step(0.30 - 0.18 * sin(progress * 3.1415926), rnd);

        float pxSize = mix(u_particleSizeMin, u_particleSizeMax, rnd);
        float sizeUv = pxSize / max(u_resolution.y, 1.0) * (110.0 + layerId * 20.0);

        vec2 local = fract(flow * vec2(48.0, 30.0 + layerId * 4.0)) - 0.5;
        float h = hexSDF(local / max(sizeUv, 0.0001));
        float crystal = 1.0 - smoothstep(-0.12, 0.16, h);

        float layerAlpha = mix(0.45, 1.0, layerId / 2.0);
        return crystal * appear * ring * edgeTrigger * layerAlpha;
      }

      void main() {
        float p = clamp(u_progress, 0.0, 1.0);
        float t = u_time * 0.001 * u_turbulenceFreq;

        float rise = smoothstep(0.0, 0.1282, p);
        float decay = 1.0 - smoothstep(0.5897, 1.0, p);
        float particleEnvelope = rise * decay;

        float l0 = particleLayer(vUv, 0.0, p, t * 1.00);
        float l1 = particleLayer(vUv, 1.0, p, t * 1.13);
        float l2 = particleLayer(vUv, 2.0, p, t * 1.27);

        float particles = (l0 + l1 + l2) / 3.0;
        particles *= particleEnvelope;

        float dissolve = clamp((p - 0.1282) / (0.5897 - 0.1282), 0.0, 1.0) * u_dissolveToBlack;
        float baseAlpha = 1.0 - dissolve;

        vec3 baseCol = sampleChromatic(vUv, u_chromatic * particles);
        vec3 fog = u_glowColor * particles * u_trailFog * (1.0 - smoothstep(0.55, 1.0, p));
        vec3 particleCol = (u_mainColor * 1.15 + u_glowColor * 0.85) * particles;

        vec3 color = baseCol * baseAlpha + particleCol + fog;
        color *= (1.0 - smoothstep(0.92, 1.0, p));
        color = max(color, vec3(0.0));

        gl_FragColor = vec4(color, 1.0);
      }
    `});material.uniform=material.uniforms;const plane=new THREE.Mesh(geometry,material);plane.name="冰晶溶解主平面";plane.position.set(0,0,0);this.scene.add(plane);this.sceneObjects.iceMainPlane=plane;this.sceneObjects.iceMainMaterial=material}setupAnimations(){const material=this.sceneObjects.iceMainMaterial;if(!material)return;const shaderStartState={progress:0,timeMs:0};const shaderEndState={progress:1,timeMs:2e3};const shaderTween=new TWEEN.Tween(shaderStartState).to(shaderEndState,1950).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{material.uniforms.u_progress.value=obj.progress;material.uniforms.u_time.value=obj.timeMs;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(shaderTween);const holdBlackStartState={hold:1};const holdBlackEndState={hold:1};const holdBlackTween=new TWEEN.Tween(holdBlackStartState).to(holdBlackEndState,150).delay(2e3).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{material.uniforms.u_progress.value=obj.hold;material.uniforms.u_time.value=2e3;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(holdBlackTween);const ratioStartState={ratioTick:0};const ratioEndState={ratioTick:1};const ratioTween=new TWEEN.Tween(ratioStartState).to(ratioEndState,this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){material.uniform.ratio.value=1}else{material.uniform.ratio.value=this.texture1.image.width/this.texture1.image.height}material.uniforms.u_resolution.value.set(window.innerWidth,window.innerHeight);material.uniforms.u_time.value=obj.ratioTick*this.Duration}).start();this.sceneObjects.tweens.push(ratioTween);const cameraLookStartState={t:0};const cameraLookEndState={t:1};const cameraLookTween=new TWEEN.Tween(cameraLookStartState).to(cameraLookEndState,this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{this.camera.position.set(0,0,10+obj.t*0);this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(cameraLookTween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;