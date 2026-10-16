const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}addAnimations(){const duration=this.Duration;const tweens=[];const tMin=50;const tMax=Math.max(tMin,duration-50);this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="ChromaticAberrationShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter("offsetX",.1);shaderPass.setParameter("offsetY",.06);shaderPass.setParameter("intensity",0);const p0=Math.min(Math.max(50,tMin),tMax);const p1=Math.min(Math.max(250,tMin),tMax);const p2=Math.min(Math.max(850,tMin),tMax);const p3=Math.min(Math.max(1600,tMin),tMax);const p4=Math.min(Math.max(1950,tMin),tMax);const holdStart=new TWEEN.Tween({intensity:0}).to({intensity:0},Math.max(0,p1-p0)).delay(p0).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{shaderPass.setParameter("intensity",obj.intensity)});const rampUp=new TWEEN.Tween({intensity:0}).to({intensity:.25},Math.max(0,p2-p1)).delay(p1).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{shaderPass.setParameter("intensity",obj.intensity)});const rampDown=new TWEEN.Tween({intensity:.25}).to({intensity:0},Math.max(0,p3-p2)).delay(p2).easing(TWEEN.Easing.Circular.InOut).onUpdate(obj=>{shaderPass.setParameter("intensity",obj.intensity)});const holdEnd=new TWEEN.Tween({intensity:0}).to({intensity:0},Math.max(0,p4-p3)).delay(p3).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{shaderPass.setParameter("intensity",obj.intensity)});tweens.push(holdStart,rampUp,rampDown,holdEnd)}});tweens.forEach(tween=>tween.start());return tweens}initPostProcessing(){if(!this.usePostProcessing)return;const shaderPassConfigs=[{name:"LumiChromaticAberration"}];this.setupPostProcessing(shaderPassConfigs);const tweens=this.addAnimations();if(tweens.length>0){if(!this.sceneObjects.tweens){this.sceneObjects.tweens=[]}this.sceneObjects.tweens.push(...tweens)}}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}_applyTweenInitialState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,0);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,0)}}_applyTweenFinalState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,1);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,1)}}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(1118481);this.createMainPlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=2e3;this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0);this.sceneObjects={mainPlane:null,materials:{},uniforms:{},tweens:[]}}createMainPlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="主平面1_Geometry";const uniforms={texture1:{value:this.texture1},u_time:{value:0},u_particleLayers:{value:3},u_particleSizeMinPx:{value:2},u_particleSizeMaxPx:{value:8},u_glowMinPx:{value:4},u_glowMaxPx:{value:12},u_particleSpeedPxPerSec:{value:200},u_maskProgress:{value:0},u_maskOpacity:{value:0},u_glowIntensity:{value:0},u_chromatic:{value:0}};const vertexShader=`
    varying vec2 vUv;
    void main() {
      vUv = uv;
      gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    }
  `;const fragmentShader=`
    precision highp float;

    uniform sampler2D texture1;
    uniform float u_time;
    uniform float u_particleLayers;
    uniform float u_particleSizeMinPx;
    uniform float u_particleSizeMaxPx;
    uniform float u_glowMinPx;
    uniform float u_glowMaxPx;
    uniform float u_particleSpeedPxPerSec;
    uniform float u_maskProgress;
    uniform float u_maskOpacity;
    uniform float u_glowIntensity;
    uniform float u_chromatic;

    varying vec2 vUv;

    float hash11(float p) {
      p = fract(p * 0.1031);
      p *= p + 33.33;
      p *= p + p;
      return fract(p);
    }

    vec2 hash21(float p) {
      float n = hash11(p);
      return vec2(n, hash11(n + p + 2.17));
    }

    float particleEnvelope(float t) {
      if (t <= 0.5) {
        return clamp(t / 0.5, 0.0, 1.0);
      }
      return clamp(1.0 - (t - 0.5) / 1.45, 0.0, 1.0);
    }

    float glowEnvelope(float t) {
      if (t <= 0.5) {
        return clamp(t / 0.5, 0.0, 1.0);
      }
      return clamp(1.0 - (t - 0.5) / 1.45, 0.0, 1.0);
    }

    vec3 getParticleColor(float seed) {
      vec3 c1 = vec3(0.52, 0.20, 1.00);
      vec3 c2 = vec3(0.10, 0.70, 1.00);
      return mix(c1, c2, hash11(seed + 7.31));
    }

    float starCore(vec2 p, float sizeUv) {
      float d = length(p);
      float cross = min(abs(p.x), abs(p.y));
      float ray = max(abs(p.x), abs(p.y));
      float core = exp(-d / max(sizeUv, 0.00001) * 2.8);
      float rays = exp(-cross / max(sizeUv * 0.45, 0.00001) * 2.2) * 0.9;
      float spokes = exp(-ray / max(sizeUv * 0.7, 0.00001) * 2.6) * 0.55;
      return core + rays + spokes;
    }

    vec3 particleField(vec2 uvCentered, float t) {
      const int PARTICLES_PER_LAYER = 18;
      vec3 accum = vec3(0.0);

      float amount = particleEnvelope(t);
      float glowEnv = glowEnvelope(t) * u_glowIntensity;
      float speedUvPerSec = u_particleSpeedPxPerSec / 1100.0;

      for (int layer = 0; layer < 3; layer++) {
        if (float(layer) >= u_particleLayers) {
          continue;
        }

        float lf = float(layer);
        float layerRadiusBias = 0.03 + lf * 0.05;
        float layerSpeedMul = 0.9 + lf * 0.35;
        float layerTwist = 1.2 + lf * 0.8;

        for (int i = 0; i < PARTICLES_PER_LAYER; i++) {
          float id = lf * 100.0 + float(i);
          vec2 rnd = hash21(id + 1.37);
          float ang0 = rnd.x * 6.2831853;
          float spiralTime = t * (1.4 + rnd.y * 0.6) * layerTwist;
          float ang = ang0 + spiralTime * 3.0;

          float radius = layerRadiusBias + t * speedUvPerSec * layerSpeedMul;
          radius += 0.03 * sin(spiralTime * 4.0 + rnd.x * 9.0);

          vec2 pPos = vec2(cos(ang), sin(ang)) * radius;
          pPos += vec2(
            0.02 * sin(spiralTime * 2.1 + rnd.y * 8.0),
            0.02 * cos(spiralTime * 2.7 + rnd.x * 7.0)
          );

          vec2 rel = uvCentered - pPos;

          float pSizePx = mix(u_particleSizeMinPx, u_particleSizeMaxPx, rnd.y);
          float glowPx = mix(u_glowMinPx, u_glowMaxPx, rnd.x);
          float pSizeUv = pSizePx / 600.0;
          float glowUv = glowPx / 600.0;

          float core = starCore(rel, pSizeUv);
          float glow = exp(-length(rel) / max(glowUv, 0.00001) * 2.0);

          float lifeGate = smoothstep(0.0, 0.25, amount) * (1.0 - smoothstep(0.9, 1.0, amount));
          float strength = (0.28 * core + 0.9 * glow * glowEnv) * amount * (0.7 + 0.3 * lifeGate);

          vec3 pColor = getParticleColor(id);
          accum += pColor * strength;
        }
      }

      return accum;
    }

    float maskFromSpiral(vec2 uvCentered, float t, float progress) {
      float r = length(uvCentered);
      float a = atan(uvCentered.y, uvCentered.x);

      float baseFront = progress * 0.92;
      float spiralPerturb = (1.0 - progress) * 0.08 * sin(9.0 * a + 20.0 * r - t * 8.0);
      float front = baseFront + spiralPerturb;

      float covered = 1.0 - smoothstep(front - 0.02, front + 0.02, r);
      return clamp(covered, 0.0, 1.0);
    }

    vec3 glitchEdgeColor(vec2 uvCentered, float t, float progress, float maskValue) {
      float r = length(uvCentered);
      float front = progress * 0.92;
      float edge = 1.0 - smoothstep(0.0, 0.035, abs(r - front));

      float stripe1 = step(0.55, fract((uvCentered.y + t * 0.45) * 55.0));
      float stripe2 = step(0.65, fract((uvCentered.x - t * 0.37) * 47.0));
      float noise = hash11(floor((uvCentered.x + uvCentered.y + t) * 160.0));

      vec3 cA = vec3(0.95, 0.10, 1.00);
      vec3 cB = vec3(0.00, 0.85, 1.00);
      vec3 cC = vec3(1.00, 0.45, 0.10);
      vec3 g = mix(cA, cB, stripe1);
      g = mix(g, cC, stripe2 * noise);

      float active = edge * (1.0 - step(0.995, maskValue));
      return g * active * 0.65;
    }

    void main() {
      vec2 uv = vUv;
      vec2 uvCentered = uv - vec2(0.5);

      vec4 baseTex = texture2D(texture1, uv);

      vec3 particles = particleField(uvCentered, u_time);
      vec3 addMixed = baseTex.rgb + particles;

      float maskValue = maskFromSpiral(uvCentered, u_time, u_maskProgress);
      float maskAlpha = clamp(maskValue * u_maskOpacity, 0.0, 1.0);

      vec3 edgeGlitch = glitchEdgeColor(uvCentered, u_time, u_maskProgress, maskValue);
      vec3 maskLayer = edgeGlitch;

      vec3 finalColor = mix(addMixed, maskLayer, maskAlpha);
      gl_FragColor = vec4(finalColor, 1.0);
    }
  `;const material=new THREE.ShaderMaterial({uniforms:uniforms,vertexShader:vertexShader,fragmentShader:fragmentShader,transparent:false,side:THREE.DoubleSide});material.name="主平面1_ShaderMaterial";const mesh=new THREE.Mesh(geometry,material);mesh.name="主平面1";mesh.position.set(0,0,0);this.scene.add(mesh);this.sceneObjects.mainPlane=mesh;this.sceneObjects.materials.mainPlaneMaterial=material;this.sceneObjects.uniforms.mainPlaneUniforms=uniforms}setupAnimations(){if(!this.sceneObjects||!this.sceneObjects.uniforms||!this.sceneObjects.uniforms.mainPlaneUniforms)return;const uniforms=this.sceneObjects.uniforms.mainPlaneUniforms;const timeStartState={t:0};const timeEndState={t:1.95};const timeTween=new TWEEN.Tween(timeStartState).to(timeEndState,1900).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_time.value=obj.t}).start();this.sceneObjects.tweens.push(timeTween);const maskStartState={progress:0,opacity:0};const maskEndState={progress:1,opacity:1};const maskTween=new TWEEN.Tween(maskStartState).to(maskEndState,1150).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_maskProgress.value=obj.progress;uniforms.u_maskOpacity.value=obj.opacity}).start();this.sceneObjects.tweens.push(maskTween);const glowRiseStartState={glow:0};const glowRiseEndState={glow:1};const glowRiseTween=new TWEEN.Tween(glowRiseStartState).to(glowRiseEndState,450).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_glowIntensity.value=obj.glow}).start();this.sceneObjects.tweens.push(glowRiseTween);const glowFallStartState={glow:1};const glowFallEndState={glow:0};const glowFallTween=new TWEEN.Tween(glowFallStartState).to(glowFallEndState,1450).delay(500).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_glowIntensity.value=obj.glow}).start();this.sceneObjects.tweens.push(glowFallTween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;