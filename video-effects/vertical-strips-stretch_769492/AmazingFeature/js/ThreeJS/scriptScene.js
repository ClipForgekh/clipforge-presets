const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}_applyTweenInitialState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,0);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,0)}}_applyTweenFinalState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,1);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,1)}}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(1710618);this.createGlitchStripPlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=1100;this.sceneObjects={glitchStripPlane:null,glitchStripMaterial:null,tweens:[]};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createGlitchStripPlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="GlitchStripExitPlaneGeometry";const material=new THREE.ShaderMaterial({name:"GlitchStripExitMaterial",transparent:false,side:THREE.DoubleSide,uniforms:{texture1:{value:this.texture1},u_progress:{value:0},u_stripCount:{value:12},u_stage1Offset:{value:.15},u_stage2Offset:{value:.35},u_stage1BlurPx:{value:6},u_stage2BlurPx:{value:18},u_stagger:{value:.05},u_centerWidthStart:{value:1},u_centerWidthMid:{value:.1},u_centerWidthEnd:{value:0},u_edgeChromatic:{value:.18},u_flickerAmount:{value:.08},u_backgroundColor:{value:new THREE.Color(1710618)},ratio:{value:1}},vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;

      uniform sampler2D texture1;
      uniform float u_progress;
      uniform float u_stripCount;
      uniform float u_stage1Offset;
      uniform float u_stage2Offset;
      uniform float u_stage1BlurPx;
      uniform float u_stage2BlurPx;
      uniform float u_stagger;
      uniform float u_centerWidthStart;
      uniform float u_centerWidthMid;
      uniform float u_centerWidthEnd;
      uniform float u_edgeChromatic;
      uniform float u_flickerAmount;
      uniform vec3 u_backgroundColor;
      uniform float ratio;

      varying vec2 vUv;

      float saturateFloat(float x) {
        return clamp(x, 0.0, 1.0);
      }

      float remap(float v, float inMin, float inMax) {
        return saturateFloat((v - inMin) / max(inMax - inMin, 0.0001));
      }

      vec4 sampleHorizontalBlur(vec2 uv, float blurUv) {
        vec4 color = vec4(0.0);
        float total = 0.0;

        float w0 = 0.227027;
        float w1 = 0.1945946;
        float w2 = 0.1216216;
        float w3 = 0.054054;
        float w4 = 0.016216;

        color += texture2D(texture1, clamp(uv, 0.0, 1.0)) * w0;
        total += w0;

        color += texture2D(texture1, clamp(uv + vec2(1.0 * blurUv, 0.0), 0.0, 1.0)) * w1;
        color += texture2D(texture1, clamp(uv - vec2(1.0 * blurUv, 0.0), 0.0, 1.0)) * w1;
        total += w1 * 2.0;

        color += texture2D(texture1, clamp(uv + vec2(2.0 * blurUv, 0.0), 0.0, 1.0)) * w2;
        color += texture2D(texture1, clamp(uv - vec2(2.0 * blurUv, 0.0), 0.0, 1.0)) * w2;
        total += w2 * 2.0;

        color += texture2D(texture1, clamp(uv + vec2(3.0 * blurUv, 0.0), 0.0, 1.0)) * w3;
        color += texture2D(texture1, clamp(uv - vec2(3.0 * blurUv, 0.0), 0.0, 1.0)) * w3;
        total += w3 * 2.0;

        color += texture2D(texture1, clamp(uv + vec2(4.0 * blurUv, 0.0), 0.0, 1.0)) * w4;
        color += texture2D(texture1, clamp(uv - vec2(4.0 * blurUv, 0.0), 0.0, 1.0)) * w4;
        total += w4 * 2.0;

        return color / max(total, 0.0001);
      }

      vec3 sampleChromatic(vec2 uv, float chromaUv) {
        vec2 leftUv = clamp(uv - vec2(chromaUv, 0.0), 0.0, 1.0);
        vec2 rightUv = clamp(uv + vec2(chromaUv, 0.0), 0.0, 1.0);
        float r = texture2D(texture1, rightUv).r;
        float g = texture2D(texture1, uv).g;
        float b = texture2D(texture1, leftUv).b;
        return vec3(r, g, b);
      }

      void main() {
        vec2 uv = vUv;
        float stripWidth = 1.0 / u_stripCount;
        float rawIndex = floor(uv.x / stripWidth);
        float stripIndex = clamp(rawIndex, 0.0, u_stripCount - 1.0);
        float localX = fract(uv.x / stripWidth);
        float centerDist = abs(localX - 0.5) * 2.0;

        float stage1 = remap(u_progress, 0.0, 0.25);
        float stage2 = remap(u_progress, 0.25, 0.65);
        float stage3Base = remap(u_progress, 0.65, 1.0);

        float direction = mod(stripIndex, 2.0) < 0.5 ? 1.0 : -1.0;

        float offsetAmount = mix(0.0, u_stage1Offset, stage1);
        offsetAmount = mix(offsetAmount, u_stage2Offset, stage2);

        float blurPx = mix(0.0, u_stage1BlurPx, stage1);
        blurPx = mix(blurPx, u_stage2BlurPx, stage2);
        blurPx = mix(blurPx, u_stage2BlurPx * 1.35, stage3Base);

        float centerWidth = mix(u_centerWidthStart, u_centerWidthMid, stage2);

        float staggerNorm = (u_stagger * stripIndex) / 1.1;
        float stage3 = saturateFloat((u_progress - 0.65 - staggerNorm) / max(0.35 - staggerNorm, 0.0001));
        centerWidth = mix(centerWidth, u_centerWidthEnd, stage3);

        float centerMask = 1.0 - smoothstep(centerWidth, centerWidth + 0.08, centerDist);
        float edgeMask = 1.0 - centerMask;

        vec2 shiftedUv = uv;
        shiftedUv.x += direction * offsetAmount;

        float blurUv = blurPx / 600.0;
        vec4 blurred = sampleHorizontalBlur(shiftedUv, blurUv);
        vec3 chromatic = sampleChromatic(shiftedUv, blurUv * u_edgeChromatic * 6.0);

        float flickerSeed = sin((uv.y * 140.0) + stripIndex * 7.13 + u_progress * 90.0);
        float flicker = 1.0 + flickerSeed * u_flickerAmount * stage2;

        vec4 sharp = texture2D(texture1, clamp(uv, 0.0, 1.0));
        vec3 edgeColor = mix(blurred.rgb, chromatic, 0.75) * flicker;
        vec3 combined = mix(edgeColor, sharp.rgb, centerMask);

        float visibility = max(centerMask, edgeMask * (1.0 - stage3 * 0.92));
        float finalFade = smoothstep(0.0, 1.0, 1.0 - remap(u_progress, 0.92, 1.0));
        visibility *= finalFade;

        vec3 finalColor = mix(u_backgroundColor, combined, visibility);
        gl_FragColor = vec4(finalColor, 1.0);
      }
    `});const mesh=new THREE.Mesh(geometry,material);mesh.name="故障竖条出场平面";mesh.position.set(0,0,0);this.scene.add(mesh);this.sceneObjects.glitchStripPlane=mesh;this.sceneObjects.glitchStripMaterial=material}setupAnimations(){const plane=this.sceneObjects.glitchStripPlane;const material=this.sceneObjects.glitchStripMaterial;if(!plane||!material)return;this.camera.lookAt(0,0,0);const ratioState={value:0};const ratioTween=new TWEEN.Tween(ratioState).to({value:1},this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(()=>{if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){material.uniforms.ratio.value=1}else{material.uniforms.ratio.value=this.texture1.image.width/this.texture1.image.height}}).start();this.sceneObjects.tweens.push(ratioTween);const startStatus={progress:0};const endStatus={progress:1};const progressTween=new TWEEN.Tween(startStatus).to(endStatus,1e3).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{material.uniforms.u_progress.value=obj.progress;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(progressTween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;