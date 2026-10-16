const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}_applyTweenInitialState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,0);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,0)}}_applyTweenFinalState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,1);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,1)}}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(1710618);this.createMainStripedExposurePlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=1e3;this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0);this.sceneObjects={mainPlane:null,materials:[],meshes:[],tweens:[],sharedUniforms:{}}}createMainStripedExposurePlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="Geometry_基础平面_主平面1";const material=new THREE.ShaderMaterial({name:"Material_基础平面_主平面1",side:THREE.DoubleSide,transparent:false,uniforms:{texture1:{value:this.texture1},u_time:{value:0},u_stripeCount:{value:8},u_baseBrightness:{value:1},u_grainBaseIntensity:{value:.3},u_rgBaseOffsetPx:{value:1},u_globalBlurPx:{value:0},u_globalExposure:{value:1},u_oddRecovery:{value:0},u_evenRecovery:{value:0},u_tailRecovery:{value:0},u_grainIntensity:{value:0},u_rgOffsetPx:{value:0},u_resolution:{value:new THREE.Vector2(window.innerWidth||600,window.innerHeight||600)}},vertexShader:`
      varying vec2 vUv;

      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision highp float;

      uniform sampler2D texture1;
      uniform float u_time;
      uniform float u_stripeCount;
      uniform float u_baseBrightness;
      uniform float u_grainBaseIntensity;
      uniform float u_rgBaseOffsetPx;
      uniform float u_globalBlurPx;
      uniform float u_globalExposure;
      uniform float u_oddRecovery;
      uniform float u_evenRecovery;
      uniform float u_tailRecovery;
      uniform float u_grainIntensity;
      uniform float u_rgOffsetPx;
      uniform vec2 u_resolution;

      varying vec2 vUv;

      float saturateFloat(float v) {
        return clamp(v, 0.0, 1.0);
      }

      float hash12(vec2 p) {
        vec3 p3 = fract(vec3(p.xyx) * 0.1031);
        p3 += dot(p3, p3.yzx + 33.33);
        return fract((p3.x + p3.y) * p3.z);
      }

      float getStripeRecovery(float stripeIndex) {
        float normalizedIndex = stripeIndex / max(u_stripeCount - 1.0, 1.0);
        float leftToRightAttenuation = 1.0 - normalizedIndex;
        float parityRecovery = mod(stripeIndex, 2.0) < 0.5 ? u_evenRecovery : u_oddRecovery;
        float recovery = max(parityRecovery * (0.55 + 0.45 * leftToRightAttenuation), u_tailRecovery);
        return saturateFloat(recovery);
      }

      vec4 sampleVerticalBlur(vec2 uv, float radiusPx, float chromaPx) {
        vec2 texel = vec2(1.0 / max(u_resolution.x, 1.0), 1.0 / max(u_resolution.y, 1.0));
        float radiusY = radiusPx * texel.y;
        float chroma = chromaPx * texel.x;

        vec2 centerDir = uv - vec2(0.5);
        if (length(centerDir) < 0.0001) {
          centerDir = vec2(1.0, 0.0);
        } else {
          centerDir = normalize(centerDir);
        }

        vec2 rgShift = centerDir * chroma;

        vec4 accum = vec4(0.0);
        float total = 0.0;

        for (int i = -4; i <= 4; i++) {
          float fi = float(i);
          float w = exp(-0.5 * (fi * fi) / 4.0);
          float feather = 1.0 + abs(fi) * 0.08;
          vec2 offset = vec2(0.0, fi * radiusY * 0.35 * feather);
          vec2 sampleUv = clamp(uv + offset, 0.0, 1.0);

          float r = texture2D(texture1, clamp(sampleUv + rgShift, 0.0, 1.0)).r;
          float g = texture2D(texture1, sampleUv).g;
          float b = texture2D(texture1, clamp(sampleUv - rgShift, 0.0, 1.0)).b;
          accum += vec4(r, g, b, 1.0) * w;
          total += w;
        }

        return accum / max(total, 0.0001);
      }

      void main() {
        vec2 uv = vUv;
        float stripeWidth = 1.0 / u_stripeCount;
        float stripeIndex = floor(uv.x / stripeWidth);
        stripeIndex = clamp(stripeIndex, 0.0, u_stripeCount - 1.0);

        float recovery = getStripeRecovery(stripeIndex);
        float stripeBlurBase = mix(25.0, 5.0, recovery);
        float stripeExposure = mix(2.5, 1.0, recovery);

        float blurPx = max(mix(u_globalBlurPx, stripeBlurBase, step(0.0001, max(u_oddRecovery, u_evenRecovery))), 0.0);
        blurPx = mix(blurPx, 0.0, u_tailRecovery);

        float exposure = mix(u_globalExposure, stripeExposure, step(0.0001, max(u_oddRecovery, u_evenRecovery)));
        exposure = mix(exposure, 1.0, u_tailRecovery);

        vec4 color = sampleVerticalBlur(uv, blurPx, u_rgOffsetPx);

        float edgeBlend = abs(fract(uv.x * u_stripeCount) - 0.5);
        float overlapGlow = smoothstep(0.50, 0.0, edgeBlend) * (1.0 - recovery) * 0.10;
        exposure += overlapGlow;

        color.rgb *= exposure;

        float grain = (hash12(uv * vec2(813.17, 451.73) + vec2(u_time * 17.31, u_time * 29.17)) - 0.5) * 2.0;
        color.rgb += grain * (u_grainBaseIntensity * u_grainIntensity);

        color.rgb = max(color.rgb, vec3(0.0));
        gl_FragColor = vec4(color.rgb, 1.0);
      }
    `});const mesh=new THREE.Mesh(geometry,material);mesh.name="基础平面_主平面1";mesh.position.set(0,0,0);this.scene.add(mesh);this.sceneObjects.mainPlane=mesh;this.sceneObjects.materials.push(material);this.sceneObjects.meshes.push(mesh)}setupAnimations(){const mainPlane=this.sceneObjects.mainPlane;if(!mainPlane)return;const material=mainPlane.material;const uniforms=material.uniforms;const startStatusTime0={value:0};const endStatusTime0={value:.3};const tweenTime0=new TWEEN.Tween(startStatusTime0).to(endStatusTime0,250).delay(50).easing(TWEEN.Easing.Exponential.Out).onUpdate(obj=>{uniforms.u_time.value=obj.value;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(tweenTime0);const startStatusGlobal0={blur:0,exposure:1,grain:0,chroma:0};const endStatusGlobal0={blur:30,exposure:2.5,grain:1,chroma:1};const tweenGlobal0=new TWEEN.Tween(startStatusGlobal0).to(endStatusGlobal0,250).delay(50).easing(TWEEN.Easing.Exponential.Out).onUpdate(obj=>{uniforms.u_globalBlurPx.value=obj.blur;uniforms.u_globalExposure.value=obj.exposure;uniforms.u_grainIntensity.value=obj.grain;uniforms.u_rgOffsetPx.value=obj.chroma;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(tweenGlobal0);const startStatusOdd={value:0};const endStatusOdd={value:1};const tweenOdd=new TWEEN.Tween(startStatusOdd).to(endStatusOdd,400).delay(300).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_oddRecovery.value=obj.value;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(tweenOdd);const startStatusEven={value:0};const endStatusEven={value:1};const tweenEven=new TWEEN.Tween(startStatusEven).to(endStatusEven,300).delay(400).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_evenRecovery.value=obj.value;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(tweenEven);const startStatusDecay={grain:1,chroma:1};const endStatusDecay={grain:0,chroma:0};const tweenDecay=new TWEEN.Tween(startStatusDecay).to(endStatusDecay,400).delay(300).easing(TWEEN.Easing.Sinusoidal.Out).onUpdate(obj=>{uniforms.u_grainIntensity.value=obj.grain;uniforms.u_rgOffsetPx.value=obj.chroma;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(tweenDecay);const startStatusTail={value:0};const endStatusTail={value:1};const tweenTail=new TWEEN.Tween(startStatusTail).to(endStatusTail,250).delay(700).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_tailRecovery.value=obj.value;uniforms.u_time.value=.7+.25*obj.value;uniforms.u_grainIntensity.value=Math.max(0,1-obj.value);uniforms.u_rgOffsetPx.value=Math.max(0,1-obj.value);uniforms.u_globalExposure.value=1;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(tweenTail);const startStatusResolution={tick:0};const endStatusResolution={tick:1};const tweenResolution=new TWEEN.Tween(startStatusResolution).to(endStatusResolution,this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(()=>{uniforms.u_resolution.value.set(window.innerWidth||600,window.innerHeight||600)}).start();this.sceneObjects.tweens.push(tweenResolution)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;