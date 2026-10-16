const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}_applyTweenInitialState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,0);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,0)}}_applyTweenFinalState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,1);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,1)}}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(1710618);this.createDiagonalNeonGlitchPlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=3e3;this.sceneObjects={mainPlane:null,mainMaterial:null,tweens:[]};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createDiagonalNeonGlitchPlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="主平面1_基础平面_几何体";const material=new THREE.ShaderMaterial({name:"主平面1_基础平面_材质",side:THREE.DoubleSide,transparent:false,uniforms:{texture1:{value:this.texture1},u_timeMs:{value:50},u_blackMix:{value:1},u_bandCount:{value:5},u_bandAngle:{value:45},u_bandWidth:{value:.2},u_neonColorA:{value:new THREE.Color("#D946EF")},u_neonColorB:{value:new THREE.Color("#8B5CF6")},u_glitchAccent:{value:new THREE.Color("#22D3EE")},u_diagBlurStrength:{value:1},u_rgbSplitStrength:{value:1},u_uvDiagOffset:{value:1},u_noiseDensity:{value:1}},vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision highp float;
      varying vec2 vUv;

      uniform sampler2D texture1;
      uniform float u_timeMs;
      uniform float u_blackMix;
      uniform float u_bandCount;
      uniform float u_bandWidth;
      uniform vec3 u_neonColorA;
      uniform vec3 u_neonColorB;
      uniform vec3 u_glitchAccent;
      uniform float u_diagBlurStrength;
      uniform float u_rgbSplitStrength;
      uniform float u_uvDiagOffset;
      uniform float u_noiseDensity;

      float hash(vec2 p) {
        return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
      }

      vec4 sampleRgbSplit(vec2 uv, float strength) {
        vec2 dir = normalize(vec2(1.0, -1.0));
        float off = 0.012 * strength;
        float r = texture2D(texture1, clamp(uv + dir * off, 0.0, 1.0)).r;
        float g = texture2D(texture1, clamp(uv, 0.0, 1.0)).g;
        float b = texture2D(texture1, clamp(uv - dir * off, 0.0, 1.0)).b;
        return vec4(r, g, b, 1.0);
      }

      vec4 sampleDiagBlur(vec2 uv, float strength) {
        vec2 dir = normalize(vec2(1.0, -1.0));
        float off = 0.01 * strength;
        vec4 c0 = texture2D(texture1, clamp(uv - dir * off * 1.5, 0.0, 1.0));
        vec4 c1 = texture2D(texture1, clamp(uv - dir * off * 0.5, 0.0, 1.0));
        vec4 c2 = texture2D(texture1, clamp(uv + dir * off * 0.5, 0.0, 1.0));
        vec4 c3 = texture2D(texture1, clamp(uv + dir * off * 1.5, 0.0, 1.0));
        return (c0 + c1 + c2 + c3) * 0.25;
      }

      void main() {
        vec2 uv = vUv;
        vec4 clearTex = texture2D(texture1, uv);

        float coordBand = (uv.x - uv.y) * 0.5 + 0.5;     // 45° 平行分区
        float coordMove = (uv.x + uv.y) * 0.5;           // 左上 -> 右下 扫动轴

        float glowMask = 0.0;
        float clearMask = 0.0;
        float localStrength = 0.0;

        for (int i = 0; i < 5; i++) {
          float fi = float(i);
          float b0 = fi / 5.0;
          float b1 = (fi + 1.0) / 5.0;
          float bandMask = step(b0, coordBand) * (1.0 - step(b1, coordBand));

          float startMs = 250.0 + fi * 100.0;
          float p = clamp((u_timeMs - startMs) / 200.0, 0.0, 1.0); // 每条带 200ms
          float center = -0.25 + 1.5 * p;

          float swept = step(coordMove, center);
          clearMask += bandMask * swept;

          float width = mix(0.24, 0.04, p) * u_bandWidth * 5.0;
          float core = 1.0 - smoothstep(0.0, width, abs(coordMove - center));
          glowMask += bandMask * core;
          localStrength += bandMask * (1.0 - p);
        }

        clearMask = clamp(clearMask, 0.0, 1.0);
        glowMask = clamp(glowMask, 0.0, 1.0);
        localStrength = clamp(localStrength, 0.0, 1.0);

        float strengthBlur = u_diagBlurStrength * localStrength;
        float strengthRgb = u_rgbSplitStrength * localStrength;
        float strengthUv = u_uvDiagOffset * localStrength;
        float strengthNoise = u_noiseDensity * localStrength;

        vec2 diagDir = normalize(vec2(1.0, -1.0));
        vec2 uvShifted = uv + diagDir * (0.01 * strengthUv) * glowMask;

        vec4 blurTex = sampleDiagBlur(uvShifted, strengthBlur);
        vec4 rgbTex = sampleRgbSplit(uvShifted, strengthRgb);
        vec3 glitch = mix(blurTex.rgb, rgbTex.rgb, 0.65);

        float n = hash(floor(uv * vec2(960.0, 540.0)) + vec2(u_timeMs * 0.031, u_timeMs * 0.017));
        float noiseGate = step(1.0 - 0.35 * strengthNoise, n);
        glitch += noiseGate * 0.18 * u_glitchAccent;

        vec3 neon = mix(u_neonColorA, u_neonColorB, clamp(coordBand, 0.0, 1.0));
        vec3 glowColor = glitch * 0.7 + neon * 0.45;

        vec3 composed = clearTex.rgb * clearMask + glowColor * glowMask;
        float darkMask = (1.0 - clearMask) * clamp(u_blackMix, 0.0, 1.0);
        vec3 finalColor = mix(composed, vec3(0.0), darkMask);

        gl_FragColor = vec4(finalColor, 1.0);
      }
    `});const mesh=new THREE.Mesh(geometry,material);mesh.name="主平面1_基础平面";mesh.position.set(0,0,0);this.scene.add(mesh);this.sceneObjects.mainPlane=mesh;this.sceneObjects.mainMaterial=material}setupAnimations(){const material=this.sceneObjects.mainMaterial;if(!material)return;const timeState={t:50};const timeTween=new TWEEN.Tween(timeState).to({t:850},800).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{material.uniforms.u_timeMs.value=obj.t;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(timeTween);const blackStage1Start={v:1};const blackStage1End={v:.75};const blackStage1Tween=new TWEEN.Tween(blackStage1Start).to(blackStage1End,200).delay(50).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_blackMix.value=obj.v}).start();this.sceneObjects.tweens.push(blackStage1Tween);const blackStage3Start={v:.75};const blackStage3End={v:0};const blackStage3Tween=new TWEEN.Tween(blackStage3Start).to(blackStage3End,200).delay(650).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_blackMix.value=obj.v}).start();this.sceneObjects.tweens.push(blackStage3Tween);const fxStage3Start={v:1};const fxStage3End={v:0};const fxStage3Tween=new TWEEN.Tween(fxStage3Start).to(fxStage3End,200).delay(650).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_diagBlurStrength.value=obj.v;material.uniforms.u_rgbSplitStrength.value=obj.v;material.uniforms.u_uvDiagOffset.value=obj.v;material.uniforms.u_noiseDensity.value=obj.v}).start();this.sceneObjects.tweens.push(fxStage3Tween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;