const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}_applyTweenInitialState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,0);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,0)}}_applyTweenFinalState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,1);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,1)}}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(1710618);this.createPixelHeartDissolvePlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=2700;this.sceneObjects={basePlane:null,materials:{},uniforms:{},tweens:[]};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createPixelHeartDissolvePlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="BasePlaneGeometry_PixelHeartDissolveOut";const uniforms={texture1:{value:this.texture1||null},u_dissolveProgress:{value:0},u_particleProgress:{value:0},u_blackMix:{value:0},u_particleAlpha:{value:1},u_pixelSize:{value:.08},ratio:{value:1},uvScale:{value:new THREE.Vector2(1,1)},uvOffset:{value:new THREE.Vector2(0,0)}};const material=new THREE.ShaderMaterial({uniforms:uniforms,transparent:false,side:THREE.DoubleSide,depthTest:true,depthWrite:true,vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;

      uniform sampler2D texture1;
      uniform float u_dissolveProgress;
      uniform float u_particleProgress;
      uniform float u_blackMix;
      uniform float u_particleAlpha;
      uniform float u_pixelSize;
      uniform float ratio;
      uniform vec2 uvScale;
      uniform vec2 uvOffset;

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

      vec2 getMappedUv(vec2 uv) {
        return uv * uvScale + uvOffset;
      }

      float hash12(vec2 p) {
        vec3 p3 = fract(vec3(p.xyx) * 0.1031);
        p3 += dot(p3, p3.yzx + 33.33);
        return fract((p3.x + p3.y) * p3.z);
      }

      vec2 hash22(vec2 p) {
        float n = hash12(p);
        return vec2(n, hash12(p + n + 17.73));
      }

      float heartSDF(vec2 p) {
        p.x = abs(p.x);
        if (p.y + p.x > 1.0) {
          return sqrt(dot(p - vec2(0.25, 0.75), p - vec2(0.25, 0.75))) - 0.35355339;
        }
        return sqrt(min(
          dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00)),
          dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50))
        )) * sign(p.x - p.y);
      }

      float generatePixelHeart(vec2 localUv) {
        vec2 p = localUv * 2.0 - 1.0;
        p.y = -p.y;
        p *= 1.2;
        p.y += 0.15;
        float d = heartSDF(p);
        return 1.0 - smoothstep(-0.08, 0.08, d);
      }

      void main() {
        vec2 mappedUv = getMappedUv(vUv);
        vec4 texColor = texture2D(texture1, mappedUv);

        vec2 aspectUv = getAspectCorrectUV(vUv);
        vec2 center = getAspectCorrectUV(vec2(0.5, 0.5));
        vec2 delta = aspectUv - center;
        float radial = length(delta);
        vec2 radialDir = normalize(delta + vec2(0.00001, 0.00001));

        float maxRadius = 0.72;
        float dissolveRadius = u_dissolveProgress * maxRadius;
        float pixelSize = max(u_pixelSize, 0.001);

        vec2 cellId = floor(vUv / pixelSize);
        vec2 cellOrigin = cellId * pixelSize;
        vec2 cellCenterUv = cellOrigin + vec2(pixelSize * 0.5);
        vec2 cellAspectUv = getAspectCorrectUV(cellCenterUv);
        vec2 cellDelta = cellAspectUv - center;
        float cellRadial = length(cellDelta);
        vec2 cellDir = normalize(cellDelta + vec2(0.00001, 0.00001));

        vec2 rnd = hash22(cellId);
        float boundaryWidth = pixelSize * 1.75;
        float boundaryMask = 1.0 - smoothstep(boundaryWidth * 0.2, boundaryWidth, abs(cellRadial - dissolveRadius));
        float activationMask = step(cellRadial, dissolveRadius + boundaryWidth);
        float spawnMask = step(0.42, rnd.x) * boundaryMask * activationMask;

        float travel = u_particleProgress * (0.18 + 0.42 * rnd.y);
        vec2 particleUv = cellCenterUv + cellDir * travel;
        vec2 particleLocalUv = (vUv - (particleUv - vec2(pixelSize * 0.5))) / pixelSize;
        float heartMask = generatePixelHeart(particleLocalUv) * spawnMask;

        vec4 particleSample = texture2D(texture1, getMappedUv(clamp(cellCenterUv, 0.0, 1.0)));
        float particleVisible = heartMask * u_particleAlpha * (1.0 - smoothstep(0.85, 1.0, u_particleProgress));

        float dissolvedCell = step(cellRadial, dissolveRadius);
        vec3 baseColor = mix(texColor.rgb, vec3(0.0), dissolvedCell * u_blackMix);

        vec3 finalColor = baseColor;
        finalColor = mix(finalColor, particleSample.rgb, clamp(particleVisible, 0.0, 1.0));

        if (u_blackMix >= 0.999 && u_particleAlpha <= 0.001) {
          finalColor = vec3(0.0);
        }

        gl_FragColor = vec4(finalColor, 1.0);
      }
    `});material.name="PixelHeartDissolveOutMaterial";const mesh=new THREE.Mesh(geometry,material);mesh.name="基础平面1";mesh.position.set(0,0,0);mesh.rotation.set(0,0,0);mesh.scale.set(1,1,1);this.scene.add(mesh);this.sceneObjects.basePlane=mesh;this.sceneObjects.materials.basePlaneMaterial=material;this.sceneObjects.uniforms.basePlaneUniforms=uniforms;const ratioState={value:0};const ratioTween=new TWEEN.Tween(ratioState).to({value:1},this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(()=>{if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){material.uniforms.ratio.value=1}else{material.uniforms.ratio.value=this.texture1.image.width/this.texture1.image.height}}).start();this.sceneObjects.tweens.push(ratioTween)}setupAnimations(){const uniforms=this.sceneObjects.uniforms.basePlaneUniforms;if(!uniforms)return;const stage1Start={dissolve:0,particle:0,blackMix:0,particleAlpha:1};const stage1End={dissolve:.15,particle:0,blackMix:0,particleAlpha:1};const stage1Tween=new TWEEN.Tween(stage1Start).to(stage1End,250).delay(50).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_dissolveProgress.value=obj.dissolve;uniforms.u_particleProgress.value=obj.particle;uniforms.u_blackMix.value=obj.blackMix;uniforms.u_particleAlpha.value=obj.particleAlpha;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(stage1Tween);const stage2Start={dissolve:.15,particle:0,blackMix:0,particleAlpha:1};const stage2End={dissolve:1,particle:1,blackMix:1,particleAlpha:1};const stage2Tween=new TWEEN.Tween(stage2Start).to(stage2End,1500).delay(300).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_dissolveProgress.value=obj.dissolve;uniforms.u_particleProgress.value=obj.particle;uniforms.u_blackMix.value=obj.blackMix;uniforms.u_particleAlpha.value=obj.particleAlpha;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(stage2Tween);const stage3Start={dissolve:1,particle:1,blackMix:1,particleAlpha:1};const stage3End={dissolve:1,particle:1,blackMix:1,particleAlpha:0};const stage3Tween=new TWEEN.Tween(stage3Start).to(stage3End,850).delay(1800).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_dissolveProgress.value=obj.dissolve;uniforms.u_particleProgress.value=obj.particle;uniforms.u_blackMix.value=obj.blackMix;uniforms.u_particleAlpha.value=obj.particleAlpha;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(stage3Tween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;