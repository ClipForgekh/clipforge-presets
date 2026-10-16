const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}_applyTweenInitialState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,0);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,0)}}_applyTweenFinalState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,1);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,1)}}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(1710618);this.createMainScreenPlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=3e3;this.sceneObjects={mainPlane:null,materials:{},meshes:[],tweens:[],uniforms:{}};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createMainScreenPlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="主画面平面几何体";const material=new THREE.ShaderMaterial({name:"主画面平面材质",side:THREE.DoubleSide,transparent:false,uniforms:{texture1:{value:this.texture1},u_time:{value:0},u_progress:{value:0},u_stripCount:{value:12},u_brightness:{value:1},u_grayscale:{value:0},u_chromatic:{value:0}},vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;

      uniform sampler2D texture1;
      uniform float u_time;
      uniform float u_progress;
      uniform float u_stripCount;
      uniform float u_brightness;
      uniform float u_grayscale;
      uniform float u_chromatic;

      varying vec2 vUv;

      float saturateFloat(float x) {
        return clamp(x, 0.0, 1.0);
      }

      vec2 clampUv(vec2 uv) {
        return clamp(uv, vec2(0.001), vec2(0.999));
      }

      float hash11(float p) {
        return fract(sin(p * 127.1) * 43758.5453123);
      }

      float exposurePulse(float x) {
        float a = smoothstep(0.0, 0.35, x);
        float b = 1.0 - smoothstep(0.35, 1.0, x);
        return max(a * b * 2.7, 0.0);
      }

      vec4 sampleDirectionalBlur(vec2 uv, vec2 dir, float radiusPx, float weightBias) {
        vec2 texel = vec2(1.0 / 600.0, 1.0 / 600.0);
        vec2 offset = dir * texel * radiusPx;
        vec4 c0 = texture2D(texture1, clampUv(uv - offset * 1.0));
        vec4 c1 = texture2D(texture1, clampUv(uv - offset * 0.66));
        vec4 c2 = texture2D(texture1, clampUv(uv - offset * 0.33));
        vec4 c3 = texture2D(texture1, clampUv(uv));
        vec4 c4 = texture2D(texture1, clampUv(uv + offset * 0.33));
        vec4 c5 = texture2D(texture1, clampUv(uv + offset * 0.66));
        vec4 c6 = texture2D(texture1, clampUv(uv + offset * 1.0));
        vec4 color =
          c0 * 0.08 +
          c1 * 0.12 +
          c2 * 0.17 +
          c3 * (0.26 + weightBias) +
          c4 * 0.17 +
          c5 * 0.12 +
          c6 * 0.08;
        return color / (1.0 + weightBias);
      }

      void main() {
        vec2 uv = vUv;
        float stripIndex = floor((1.0 - uv.y) * u_stripCount);
        stripIndex = clamp(stripIndex, 0.0, u_stripCount - 1.0);
        float stripT = (stripIndex + 0.5) / u_stripCount;

        float distToEdge = min(stripIndex, (u_stripCount - 1.0) - stripIndex);
        float edgeOrder = floor(distToEdge);
        float recoverDelay = edgeOrder * 0.05;
        float recoverStart = 0.20 + recoverDelay;
        float recoverNorm = saturateFloat((u_time - recoverStart) / 0.60);
        float settleNorm = saturateFloat((u_time - 0.80) / 0.20);

        float isOuter = step(distToEdge, 1.5);
        float baseBlurPx = mix(72.0, 64.0, isOuter);
        float baseDistort = mix(1.2, 1.0, isOuter);

        float blurFade = 1.0 - recoverNorm;
        blurFade *= (1.0 - settleNorm);
        float distortFade = 1.0 - recoverNorm;
        distortFade *= (1.0 - settleNorm);

        float blurPx = baseBlurPx * blurFade;
        float distortStrength = baseDistort * distortFade;

        float startupHold = step(0.05, u_time) * (1.0 - step(0.20, u_time));
        blurPx = max(blurPx, baseBlurPx * startupHold);
        distortStrength = max(distortStrength, baseDistort * startupHold);

        float pulse = exposurePulse(recoverNorm);
        float exposure = mix(1.5, 1.0, saturateFloat((u_time - 0.20) / 0.80));
        exposure = max(exposure, 1.5 * startupHold);
        exposure += 0.7 * pulse * (1.0 - settleNorm);

        float rgbAmount = (0.010 + u_chromatic * 0.02) * (0.35 + distortStrength * 0.65);
        rgbAmount *= (1.0 - settleNorm);

        float neonStrength = (0.15 + pulse * 0.75) * distortFade;
        neonStrength *= (1.0 - settleNorm);

        float parity = mod(stripIndex, 2.0) * 2.0 - 1.0;
        float orient = mix(1.0, 0.0, isOuter);
        float timeWaveA = sin(u_time * 42.0 + stripIndex * 1.7);
        float timeWaveB = cos(u_time * 33.0 + stripIndex * 2.3);
        vec2 glitchOffset = vec2(
          parity * distortStrength * 0.06 * (0.45 + 0.55 * timeWaveA),
          parity * distortStrength * 0.04 * (0.45 + 0.55 * timeWaveB)
        );

        vec2 uvShifted = uv;
        uvShifted.x += glitchOffset.x * mix(0.35, 1.0, orient);
        uvShifted.y += glitchOffset.y * mix(1.0, 0.35, orient);

        vec2 blurDir = mix(vec2(0.0, 1.0), vec2(1.0, 0.0), orient);
        vec4 blurred = sampleDirectionalBlur(uvShifted, blurDir, blurPx, distortStrength * 0.1);

        vec2 centerDir = uvShifted - vec2(0.5);
        float dirLen = max(length(centerDir), 0.0001);
        vec2 dirNorm = centerDir / dirLen;

        float r = texture2D(texture1, clampUv(uvShifted + dirNorm * rgbAmount)).r;
        float g = texture2D(texture1, clampUv(uvShifted)).g;
        float b = texture2D(texture1, clampUv(uvShifted - dirNorm * rgbAmount)).b;
        vec3 chromaColor = vec3(r, g, b);

        vec3 baseColor = mix(blurred.rgb, chromaColor, saturateFloat(0.2 + distortStrength * 0.6));

        vec2 edgeTexel = vec2(1.0 / 600.0, 1.0 / 600.0);
        float lumL = dot(texture2D(texture1, clampUv(uvShifted - vec2(edgeTexel.x, 0.0))).rgb, vec3(0.299, 0.587, 0.114));
        float lumR = dot(texture2D(texture1, clampUv(uvShifted + vec2(edgeTexel.x, 0.0))).rgb, vec3(0.299, 0.587, 0.114));
        float lumD = dot(texture2D(texture1, clampUv(uvShifted - vec2(0.0, edgeTexel.y))).rgb, vec3(0.299, 0.587, 0.114));
        float lumU = dot(texture2D(texture1, clampUv(uvShifted + vec2(0.0, edgeTexel.y))).rgb, vec3(0.299, 0.587, 0.114));
        float edgeMag = abs(lumR - lumL) + abs(lumU - lumD);

        vec3 pink = vec3(1.0, 0.31, 0.85);
        vec3 cyan = vec3(0.33, 0.85, 1.0);
        vec3 neon = mix(pink, cyan, step(0.0, parity));
        baseColor += neon * edgeMag * neonStrength * 2.2;

        baseColor *= exposure;
        baseColor *= u_brightness;

        float gray = dot(baseColor, vec3(0.299, 0.587, 0.114));
        baseColor = mix(baseColor, vec3(gray), u_grayscale);

        gl_FragColor = vec4(baseColor, 1.0);
      }
    `});const mesh=new THREE.Mesh(geometry,material);mesh.name="主画面平面";mesh.position.set(0,0,0);this.scene.add(mesh);this.sceneObjects.mainPlane=mesh;this.sceneObjects.meshes.push(mesh);this.sceneObjects.materials.mainPlaneMaterial=material;this.sceneObjects.uniforms.mainPlaneUniforms=material.uniforms}setupAnimations(){const plane=this.sceneObjects.mainPlane;const material=this.sceneObjects.materials.mainPlaneMaterial;if(!plane||!material)return;const startStatus={time:0,chromatic:.18,brightness:1,grayscale:0,progress:0};const endStatus={time:1,chromatic:0,brightness:1,grayscale:0,progress:1};const shaderTween=new TWEEN.Tween(startStatus).to(endStatus,950).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{material.uniforms.u_time.value=obj.time;material.uniforms.u_chromatic.value=obj.chromatic;material.uniforms.u_brightness.value=obj.brightness;material.uniforms.u_grayscale.value=obj.grayscale;material.uniforms.u_progress.value=obj.progress;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(shaderTween);const holdStartStatus={time:1,chromatic:0,brightness:1,grayscale:0,progress:1};const holdEndStatus={time:1,chromatic:0,brightness:1,grayscale:0,progress:1};const holdTween=new TWEEN.Tween(holdStartStatus).to(holdEndStatus,1950).delay(1e3).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{material.uniforms.u_time.value=obj.time;material.uniforms.u_chromatic.value=obj.chromatic;material.uniforms.u_brightness.value=obj.brightness;material.uniforms.u_grayscale.value=obj.grayscale;material.uniforms.u_progress.value=obj.progress;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(holdTween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;