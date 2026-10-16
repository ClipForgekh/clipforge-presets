const TWEEN=require("./tween");const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(0);this.createMainPlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=1e3;this.sceneObjects={mainPlane:null,materials:{},tweens:[],uniforms:{}};this.camera.fov=53.1;this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0);this.camera.updateProjectionMatrix()}createMainPlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="基础平面1_几何体";const uniforms={texture1:{value:this.texture1},u_verticalBlurRadiusPx:{value:0},u_glowIntensity:{value:0},u_glowColorBottom:{value:new THREE.Color(8378111)},u_glowColorTop:{value:new THREE.Color(11463679)},u_glowFeather:{value:.18},u_glowRiseProgress:{value:0},u_glowAlphaFade:{value:1},u_resolution:{value:new THREE.Vector2(typeof window!=="undefined"?window.innerWidth:600,typeof window!=="undefined"?window.innerHeight:600)}};const material=new THREE.ShaderMaterial({name:"基础平面1_材质",uniforms:uniforms,side:THREE.DoubleSide,transparent:true,vertexShader:`
      varying vec2 vUv;
      void main() {
          vUv = uv;
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;
      uniform sampler2D texture1;
      uniform float u_verticalBlurRadiusPx;
      uniform float u_glowIntensity;
      uniform vec3 u_glowColorBottom;
      uniform vec3 u_glowColorTop;
      uniform float u_glowFeather;
      uniform float u_glowRiseProgress;
      uniform float u_glowAlphaFade;
      uniform vec2 u_resolution;
      varying vec2 vUv;

      vec3 screenBlend(vec3 base, vec3 blend) {
          return 1.0 - (1.0 - base) * (1.0 - blend);
      }

      vec4 sampleVerticalBlur(vec2 uv, float blurRadiusPx) {
          if (blurRadiusPx <= 0.0001) {
              return texture2D(texture1, uv);
          }

          float pixelStep = 1.0 / max(u_resolution.y, 1.0);
          float radiusUv = blurRadiusPx * pixelStep;

          vec4 color = vec4(0.0);
          float totalWeight = 0.0;

          float offsets[9];
          offsets[0] = -4.0;
          offsets[1] = -3.0;
          offsets[2] = -2.0;
          offsets[3] = -1.0;
          offsets[4] = 0.0;
          offsets[5] = 1.0;
          offsets[6] = 2.0;
          offsets[7] = 3.0;
          offsets[8] = 4.0;

          float weights[9];
          weights[0] = 0.05;
          weights[1] = 0.09;
          weights[2] = 0.12;
          weights[3] = 0.15;
          weights[4] = 0.18;
          weights[5] = 0.15;
          weights[6] = 0.12;
          weights[7] = 0.09;
          weights[8] = 0.05;

          for (int i = 0; i < 9; i++) {
              vec2 sampleUv = uv + vec2(0.0, offsets[i] * radiusUv / 4.0);
              sampleUv = clamp(sampleUv, 0.0, 1.0);
              color += texture2D(texture1, sampleUv) * weights[i];
              totalWeight += weights[i];
          }

          return color / max(totalWeight, 0.0001);
      }

      void main() {
          vec2 uv = vUv;
          vec4 originalTexel = texture2D(texture1, uv);
          vec4 blurredTexel = sampleVerticalBlur(uv, u_verticalBlurRadiusPx);

          float blurMix = clamp(u_verticalBlurRadiusPx / 220.0, 0.0, 1.0);
          vec4 imageTexel = mix(originalTexel, blurredTexel, blurMix);

          float riseMask = smoothstep(
              0.0,
              max(u_glowRiseProgress, 0.0001),
              uv.y
          );

          float bottomMask = 1.0 - smoothstep(
              0.0,
              max(0.0001, u_glowRiseProgress + u_glowFeather),
              uv.y
          );

          float glowGradient = mix(1.0, 0.0, clamp(uv.y, 0.0, 1.0));
          vec3 glowColor = mix(u_glowColorBottom, u_glowColorTop, clamp(uv.y, 0.0, 1.0));

          float glowCoverage = (1.0 - riseMask) + bottomMask * 0.65;
          glowCoverage = clamp(glowCoverage, 0.0, 1.0);

          float featherAlpha = smoothstep(0.0, 1.0, glowCoverage);
          float glowAlpha = u_glowIntensity * glowGradient * featherAlpha * u_glowAlphaFade;

          vec3 glowLayer = glowColor * glowAlpha;
          vec3 finalRgb = screenBlend(imageTexel.rgb, glowLayer);

          gl_FragColor = vec4(finalRgb, 1.0);
      }
    `});const mesh=new THREE.Mesh(geometry,material);mesh.name="基础平面1";mesh.position.set(0,0,0);mesh.scale.set(1,1,1);this.scene.add(mesh);this.sceneObjects.mainPlane=mesh;this.sceneObjects.materials.mainPlaneMaterial=material;this.sceneObjects.uniforms.mainPlaneUniforms=uniforms}setupAnimations(){const plane=this.sceneObjects.mainPlane;const material=this.sceneObjects.materials.mainPlaneMaterial;if(!plane||!material)return;const lookAtTarget=new THREE.Vector3(0,0,0);const phase1State={blur:0,glow:0,rise:0};const phase1Tween=new TWEEN.Tween(phase1State).to({blur:220,glow:1,rise:1},150).delay(50).easing(TWEEN.Easing.Cubic.Out).onUpdate(obj=>{material.uniforms.u_verticalBlurRadiusPx.value=obj.blur;material.uniforms.u_glowIntensity.value=obj.glow;material.uniforms.u_glowRiseProgress.value=obj.rise;this.camera.lookAt(lookAtTarget)}).start();this.sceneObjects.tweens.push(phase1Tween);const phase2State={blur:220,glow:1};const phase2Tween=new TWEEN.Tween(phase2State).to({blur:5,glow:.1},600).delay(200).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_verticalBlurRadiusPx.value=obj.blur;material.uniforms.u_glowIntensity.value=obj.glow;material.uniforms.u_glowRiseProgress.value=1;this.camera.lookAt(lookAtTarget)}).start();this.sceneObjects.tweens.push(phase2Tween);const phase3State={blur:5,glow:.1,alphaFade:1};const phase3Tween=new TWEEN.Tween(phase3State).to({blur:0,glow:0,alphaFade:0},150).delay(800).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_verticalBlurRadiusPx.value=obj.blur;material.uniforms.u_glowIntensity.value=obj.glow;material.uniforms.u_glowAlphaFade.value=obj.alphaFade;material.uniforms.u_glowRiseProgress.value=1;this.camera.lookAt(lookAtTarget)}).start();this.sceneObjects.tweens.push(phase3Tween);const holdState={hold:0};const holdTween=new TWEEN.Tween(holdState).to({hold:1},50).delay(950).easing(TWEEN.Easing.Linear.None).onUpdate(()=>{material.uniforms.u_verticalBlurRadiusPx.value=0;material.uniforms.u_glowIntensity.value=0;material.uniforms.u_glowAlphaFade.value=0;material.uniforms.u_glowRiseProgress.value=1;this.camera.lookAt(lookAtTarget)}).start();this.sceneObjects.tweens.push(holdTween)}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(this.sceneObjects&&this.sceneObjects.materials&&this.sceneObjects.materials.mainPlaneMaterial){this.sceneObjects.materials.mainPlaneMaterial.uniforms.u_resolution.value.set(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;