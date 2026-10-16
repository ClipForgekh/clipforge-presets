const TWEEN=require("./tween");const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipLine(){var videoEntity=this.scene._amgScene.findEntityBy("video");var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(!videoEntity||!aiOutputEntity){console.warn("Scene: 没有找到视频实体或AI输出实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=aiOutputEntity.getComponent("Camera").renderTexture;mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(2763306);this.createRadialRipplePlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=3e3;this.sceneObjects={radialPlane:null,radialMaterial:null,tweens:[],uniforms:{}};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createRadialRipplePlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="RadialRipplePlaneGeometry";const material=new THREE.ShaderMaterial({uniforms:{texture1:{value:this.texture1},u_time:{value:0},u_maxBlurPx:{value:20},u_ringCount:{value:12},u_ringDelay:{value:.1},u_ringFade:{value:.65},u_chromatic:{value:0},ratio:{value:1}},vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;
      uniform sampler2D texture1;
      uniform float u_time;
      uniform float u_maxBlurPx;
      uniform float u_ringCount;
      uniform float u_ringDelay;
      uniform float u_ringFade;
      uniform float u_chromatic;
      uniform float ratio;
      varying vec2 vUv;

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

      vec4 sampleBlurChromatic(vec2 uv, float blurPx, float chromaticAmount) {
        vec2 texel = vec2(1.0 / 600.0, 1.0 / 600.0);
        vec2 blurStep = texel * blurPx;
        vec2 center = vec2(0.5, 0.5);
        vec2 dir = uv - center;
        float dirLen = length(dir);
        vec2 dirNorm = dirLen > 0.0001 ? dir / dirLen : vec2(1.0, 0.0);
        vec2 chromaOffset = dirNorm * texel * blurPx * 0.35 * chromaticAmount;

        vec2 o1 = blurStep * vec2(1.0, 0.0);
        vec2 o2 = blurStep * vec2(0.0, 1.0);
        vec2 o3 = blurStep * vec2(0.7071, 0.7071);
        vec2 o4 = blurStep * vec2(-0.7071, 0.7071);

        float r = 0.0;
        float g = 0.0;
        float b = 0.0;
        float w = 0.0;

        vec2 uv0 = clamp(uv, 0.0, 1.0);
        vec2 uv1 = clamp(uv + o1, 0.0, 1.0);
        vec2 uv2 = clamp(uv - o1, 0.0, 1.0);
        vec2 uv3 = clamp(uv + o2, 0.0, 1.0);
        vec2 uv4 = clamp(uv - o2, 0.0, 1.0);
        vec2 uv5 = clamp(uv + o3, 0.0, 1.0);
        vec2 uv6 = clamp(uv - o3, 0.0, 1.0);
        vec2 uv7 = clamp(uv + o4, 0.0, 1.0);
        vec2 uv8 = clamp(uv - o4, 0.0, 1.0);

        float weights[9];
        weights[0] = 0.24;
        weights[1] = 0.12;
        weights[2] = 0.12;
        weights[3] = 0.12;
        weights[4] = 0.12;
        weights[5] = 0.07;
        weights[6] = 0.07;
        weights[7] = 0.07;
        weights[8] = 0.07;

        vec2 uvs[9];
        uvs[0] = uv0;
        uvs[1] = uv1;
        uvs[2] = uv2;
        uvs[3] = uv3;
        uvs[4] = uv4;
        uvs[5] = uv5;
        uvs[6] = uv6;
        uvs[7] = uv7;
        uvs[8] = uv8;

        for (int i = 0; i < 9; i++) {
          vec2 sampleUv = uvs[i];
          float rr = texture2D(texture1, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r;
          float gg = texture2D(texture1, sampleUv).g;
          float bb = texture2D(texture1, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b;
          r += rr * weights[i];
          g += gg * weights[i];
          b += bb * weights[i];
          w += weights[i];
        }

        return vec4(r / w, g / w, b / w, 1.0);
      }

      void main() {
        vec2 correctedUv = getAspectCorrectUV(vUv);
        vec2 correctedCenter = getAspectCorrectUV(vec2(0.5, 0.5));
        float radius = length(correctedUv - correctedCenter);
        float maxRadius = length(getAspectCorrectUV(vec2(1.0, 1.0)) - correctedCenter);
        float normalizedRadius = clamp(radius / maxRadius, 0.0, 0.999999);
        float ringFloat = floor(normalizedRadius * u_ringCount);
        float ringIndex = clamp(ringFloat, 0.0, u_ringCount - 1.0);

        float ringStart = 0.05 + ringIndex * u_ringDelay;
        float ringProgress = clamp((u_time - ringStart) / u_ringFade, 0.0, 1.0);
        float blurPx = u_maxBlurPx * (1.0 - ringProgress);
        float chromaticAmount = (blurPx / u_maxBlurPx) + u_chromatic;

        vec4 color = sampleBlurChromatic(vUv, blurPx, chromaticAmount);
        gl_FragColor = color;
      }
    `,transparent:true,side:THREE.DoubleSide});material.name="径向波纹平面1_material";const plane=new THREE.Mesh(geometry,material);plane.name="径向波纹平面1_plane";plane.position.set(0,0,0);this.scene.add(plane);this.sceneObjects.radialPlane=plane;this.sceneObjects.radialMaterial=material;this.sceneObjects.uniforms=material.uniforms}setupAnimations(){const plane=this.sceneObjects.radialPlane;const material=this.sceneObjects.radialMaterial;if(!plane||!material)return;const baseQuaternion=plane.quaternion.clone();const shaderTimeStart={time:0};const shaderTimeTween=new TWEEN.Tween(shaderTimeStart).to({time:1.8},1750).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{material.uniforms.u_time.value=obj.time}).start();this.sceneObjects.tweens.push(shaderTimeTween);const chromaPulseInStart={value:0};const chromaPulseInTween=new TWEEN.Tween(chromaPulseInStart).to({value:.18},225).delay(930).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_chromatic.value=obj.value}).start();this.sceneObjects.tweens.push(chromaPulseInTween);const chromaPulseOutStart={value:.18};const chromaPulseOutTween=new TWEEN.Tween(chromaPulseOutStart).to({value:0},225).delay(1155).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_chromatic.value=obj.value}).start();this.sceneObjects.tweens.push(chromaPulseOutTween);const scaleUpStart={scale:1,q:0};const scaleUpTween=new TWEEN.Tween(scaleUpStart).to({scale:1.03,q:1},150).delay(930).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{plane.scale.set(obj.scale,obj.scale,1);plane.quaternion.copy(baseQuaternion).slerp(baseQuaternion,obj.q)}).start();this.sceneObjects.tweens.push(scaleUpTween);const scaleDownStart={scale:1.03,q:0};const scaleDownTween=new TWEEN.Tween(scaleDownStart).to({scale:.99,q:1},150).delay(1080).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{plane.scale.set(obj.scale,obj.scale,1);plane.quaternion.copy(baseQuaternion).slerp(baseQuaternion,obj.q)}).start();this.sceneObjects.tweens.push(scaleDownTween);const scaleRestoreStart={scale:.99,q:0};const scaleRestoreTween=new TWEEN.Tween(scaleRestoreStart).to({scale:1,q:1},150).delay(1230).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{plane.scale.set(obj.scale,obj.scale,1);plane.quaternion.copy(baseQuaternion).slerp(baseQuaternion,obj.q)}).start();this.sceneObjects.tweens.push(scaleRestoreTween);const ratioState={progress:0};const ratioTween=new TWEEN.Tween(ratioState).to({progress:1},this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(()=>{if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){material.uniforms.ratio.value=1}else{material.uniforms.ratio.value=this.texture1.image.width/this.texture1.image.height}}).start();this.sceneObjects.tweens.push(ratioTween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;