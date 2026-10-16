const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(0);this.createDepthLayerOpticalPlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=3e3;this.sceneObjects={mainPlane:null,materials:{},tweens:[],groups:{},uniforms:{}};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createDepthLayerOpticalPlane(){const geometry=new THREE.PlaneGeometry(10,10);geometry.name="景深分层光学入场平面几何体";const uniforms={texture1:{value:this.texture1},u_time:{value:0},u_depthLayerMask:{value:1},u_bgBlurRadius:{value:60},u_bgExposure:{value:4.2},u_mgBlurRadius:{value:50},u_mgExposure:{value:3.2},u_fgBlurRadius:{value:40},u_fgExposure:{value:2.6},u_bokehStarStrength:{value:1},u_brightness:{value:1},ratio:{value:1}};const material=new THREE.ShaderMaterial({uniforms:uniforms,side:THREE.DoubleSide,transparent:false,depthTest:true,depthWrite:true,vertexShader:`
      varying vec2 vUv;
      void main() {
          vUv = uv;
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;

      uniform sampler2D texture1;
      uniform float u_time;
      uniform float u_depthLayerMask;
      uniform float u_bgBlurRadius;
      uniform float u_bgExposure;
      uniform float u_mgBlurRadius;
      uniform float u_mgExposure;
      uniform float u_fgBlurRadius;
      uniform float u_fgExposure;
      uniform float u_bokehStarStrength;
      uniform float u_brightness;
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

      float hash21(vec2 p) {
          p = fract(p * vec2(123.34, 456.21));
          p += dot(p, p + 45.32);
          return fract(p.x * p.y);
      }

      float getLuma(vec3 c) {
          return dot(c, vec3(0.299, 0.587, 0.114));
      }

      float estimateDepthMask(vec2 uv) {
          vec2 aspectUV = getAspectCorrectUV(uv);
          vec2 centered = aspectUV - vec2(0.5);
          float radial = clamp(length(centered) * 1.6, 0.0, 1.0);
          float vertical = smoothstep(-0.2, 0.8, 1.0 - uv.y);
          float depth = clamp(mix(radial, vertical, 0.35), 0.0, 1.0);
          return depth;
      }

      vec4 layeredBlurSample(vec2 uv, float radiusPx) {
          vec2 texel = vec2(1.0 / 600.0, 1.0 / 600.0);
          texel.y /= max(ratio, 0.0001);
          vec2 blur = texel * radiusPx;

          vec4 color = vec4(0.0);
          float total = 0.0;

          vec2 offsets[9];
          offsets[0] = vec2(0.0, 0.0);
          offsets[1] = vec2(1.0, 0.0);
          offsets[2] = vec2(-1.0, 0.0);
          offsets[3] = vec2(0.0, 1.0);
          offsets[4] = vec2(0.0, -1.0);
          offsets[5] = vec2(0.7, 0.7);
          offsets[6] = vec2(-0.7, 0.7);
          offsets[7] = vec2(0.7, -0.7);
          offsets[8] = vec2(-0.7, -0.7);

          float weights[9];
          weights[0] = 0.24;
          weights[1] = 0.11;
          weights[2] = 0.11;
          weights[3] = 0.11;
          weights[4] = 0.11;
          weights[5] = 0.08;
          weights[6] = 0.08;
          weights[7] = 0.08;
          weights[8] = 0.08;

          for (int i = 0; i < 9; i++) {
              vec2 sampleUV = clamp(uv + offsets[i] * blur, 0.0, 1.0);
              vec4 texelColor = texture2D(texture1, sampleUV);
              color += texelColor * weights[i];
              total += weights[i];
          }

          return color / max(total, 0.0001);
      }

      float starShape(vec2 p) {
          p = abs(p);
          float a = max(p.x, p.y);
          float b = min(p.x, p.y);
          float cross = smoothstep(0.06, 0.0, b) * smoothstep(0.42, 0.0, a);
          float diag = smoothstep(0.05, 0.0, abs(p.x - p.y)) * smoothstep(0.48, 0.0, a);
          return clamp(cross + diag * 0.8, 0.0, 1.0);
      }

      float generateStarBokeh(vec2 uv, float exposureAmount, float depthMask) {
          vec2 aspectUV = getAspectCorrectUV(uv);
          vec2 gridUV = aspectUV * 10.0;
          vec2 cell = floor(gridUV);
          vec2 local = fract(gridUV) - 0.5;

          float sparkle = 0.0;
          for (int y = -1; y <= 1; y++) {
              for (int x = -1; x <= 1; x++) {
                  vec2 neighbor = cell + vec2(float(x), float(y));
                  float rnd = hash21(neighbor);
                  vec2 jitter = vec2(hash21(neighbor + 1.31), hash21(neighbor + 2.73)) - 0.5;
                  vec2 p = local - vec2(float(x), float(y)) - jitter * 0.55;
                  float size = mix(0.08, 0.22, rnd);
                  float star = starShape(p / max(size, 0.0001));
                  float intensity = smoothstep(0.55, 1.0, rnd);
                  sparkle += star * intensity;
              }
          }

          float depthWeighted = smoothstep(0.2, 1.0, depthMask);
          return sparkle * exposureAmount * u_bokehStarStrength * depthWeighted * 0.35;
      }

      void main() {
          vec2 uv = vUv;
          vec4 originalTexel = texture2D(texture1, uv);

          float depthMask = estimateDepthMask(uv) * u_depthLayerMask;

          float bgWeight = smoothstep(0.55, 1.0, depthMask);
          float fgWeight = 1.0 - smoothstep(0.2, 0.45, depthMask);
          float mgWeight = clamp(1.0 - bgWeight - fgWeight, 0.0, 1.0);

          float blurRadius =
              bgWeight * u_bgBlurRadius +
              mgWeight * u_mgBlurRadius +
              fgWeight * u_fgBlurRadius;

          float exposure =
              bgWeight * u_bgExposure +
              mgWeight * u_mgExposure +
              fgWeight * u_fgExposure;

          vec4 blurredTexel = layeredBlurSample(uv, blurRadius);
          vec4 texColor = mix(originalTexel, blurredTexel, clamp(blurRadius / 60.0, 0.0, 1.0));

          texColor.rgb *= exposure;

          float luma = getLuma(texColor.rgb);
          float bloomGate = smoothstep(0.55, 0.95, luma);
          float starBokeh = generateStarBokeh(uv, (exposure - 1.0) * bloomGate, depthMask);
          texColor.rgb += vec3(starBokeh);

          texColor.rgb = mix(texColor.rgb, originalTexel.rgb, step(0.0001, 0.0001) * 0.0);
          texColor.rgb *= u_brightness;

          gl_FragColor = vec4(clamp(texColor.rgb, 0.0, 1.0), originalTexel.a);
      }
    `});material.name="景深分层光学入场材质";const plane=new THREE.Mesh(geometry,material);plane.name="景深分层光学入场平面";plane.position.set(0,0,0);this.scene.add(plane);this.sceneObjects.mainPlane=plane;this.sceneObjects.materials.opticalMaterial=material;this.sceneObjects.uniforms=uniforms}setupAnimations(){const plane=this.sceneObjects.mainPlane;const material=this.sceneObjects.materials.opticalMaterial;const uniforms=this.sceneObjects.uniforms;if(!plane||!material||!uniforms)return;this.camera.lookAt(0,0,0);const ratioState={value:0};const ratioTween=new TWEEN.Tween(ratioState).to({value:1},this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(()=>{if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){material.uniforms.ratio.value=1}else{material.uniforms.ratio.value=this.texture1.image.width/this.texture1.image.height}material.uniforms.u_time.value=ratioState.value*this.Duration*.001;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(ratioTween);const stage1Start={bgBlur:60,bgExposure:4.2,bokeh:1};const stage1End={bgBlur:15,bgExposure:1.6,bokeh:.72};const stage1Tween=new TWEEN.Tween(stage1Start).to(stage1End,550).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_bgBlurRadius.value=obj.bgBlur;uniforms.u_bgExposure.value=obj.bgExposure;uniforms.u_bokehStarStrength.value=obj.bokeh;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(stage1Tween);const stage2Start={bgBlur:15,bgExposure:1.6,mgBlur:50,mgExposure:3.2,bokeh:.72};const stage2End={bgBlur:6,bgExposure:1.15,mgBlur:8,mgExposure:1.3,bokeh:.32};const stage2Tween=new TWEEN.Tween(stage2Start).to(stage2End,600).delay(600).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_bgBlurRadius.value=obj.bgBlur;uniforms.u_bgExposure.value=obj.bgExposure;uniforms.u_mgBlurRadius.value=obj.mgBlur;uniforms.u_mgExposure.value=obj.mgExposure;uniforms.u_bokehStarStrength.value=obj.bokeh;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(stage2Tween);const stage3Start={bgBlur:6,bgExposure:1.15,mgBlur:8,mgExposure:1.3,fgBlur:40,fgExposure:2.6,bokeh:.32};const stage3End={bgBlur:0,bgExposure:1,mgBlur:0,mgExposure:1,fgBlur:0,fgExposure:1,bokeh:0};const stage3Tween=new TWEEN.Tween(stage3Start).to(stage3End,400).delay(1200).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_bgBlurRadius.value=obj.bgBlur;uniforms.u_bgExposure.value=obj.bgExposure;uniforms.u_mgBlurRadius.value=obj.mgBlur;uniforms.u_mgExposure.value=obj.mgExposure;uniforms.u_fgBlurRadius.value=obj.fgBlur;uniforms.u_fgExposure.value=obj.fgExposure;uniforms.u_bokehStarStrength.value=obj.bokeh;uniforms.u_brightness.value=1;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(stage3Tween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;