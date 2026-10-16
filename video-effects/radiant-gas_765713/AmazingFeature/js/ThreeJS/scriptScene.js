const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(2829099);this.createLightBlobDissolvePlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=3e3;this.sceneObjects={planes:[],materials:[],tweens:[],mainPlane:null,mainMaterial:null};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createLightBlobDissolvePlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="Geometry_基础平面_光斑消散平面1";const material=new THREE.ShaderMaterial({name:"Material_基础平面_光斑消散平面1",transparent:false,side:THREE.DoubleSide,depthWrite:true,depthTest:true,uniforms:{texture1:{value:this.texture1},uvScale:{value:new THREE.Vector2(1,1)},uvOffset:{value:new THREE.Vector2(0,0)},u_brightness:{value:1},u_glowColorA:{value:new THREE.Color(15909198)},u_glowColorB:{value:new THREE.Color(15305237)},u_blobAlpha:{value:1},u_glowStrength:{value:2.4},u_blurRadius:{value:.18},u_noiseThreshold:{value:.12},u_noiseScale:{value:3.2}},vertexShader:`
      varying vec2 vUv;
      uniform vec2 uvScale;
      uniform vec2 uvOffset;

      void main() {
        vUv = uv * uvScale + uvOffset;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;

      uniform sampler2D texture1;
      uniform float u_brightness;
      uniform vec3 u_glowColorA;
      uniform vec3 u_glowColorB;
      uniform float u_blobAlpha;
      uniform float u_glowStrength;
      uniform float u_blurRadius;
      uniform float u_noiseThreshold;
      uniform float u_noiseScale;

      varying vec2 vUv;

      float hash(vec2 p) {
        return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
      }

      float noise(vec2 p) {
        vec2 i = floor(p);
        vec2 f = fract(p);

        float a = hash(i);
        float b = hash(i + vec2(1.0, 0.0));
        float c = hash(i + vec2(0.0, 1.0));
        float d = hash(i + vec2(1.0, 1.0));

        vec2 u = f * f * (3.0 - 2.0 * f);

        return mix(a, b, u.x) +
               (c - a) * u.y * (1.0 - u.x) +
               (d - b) * u.x * u.y;
      }

      float fbm(vec2 p) {
        float value = 0.0;
        float amplitude = 0.5;
        float frequency = 1.0;
        for (int i = 0; i < 5; i++) {
          value += amplitude * noise(p * frequency);
          frequency *= 2.0;
          amplitude *= 0.5;
        }
        return value;
      }

      vec4 sampleBlurred(sampler2D tex, vec2 uv, float radius) {
        vec2 r = vec2(radius);
        vec4 color = vec4(0.0);
        color += texture2D(tex, clamp(uv, 0.0, 1.0)) * 0.20;
        color += texture2D(tex, clamp(uv + vec2( r.x,  0.0), 0.0, 1.0)) * 0.12;
        color += texture2D(tex, clamp(uv + vec2(-r.x,  0.0), 0.0, 1.0)) * 0.12;
        color += texture2D(tex, clamp(uv + vec2( 0.0,  r.y), 0.0, 1.0)) * 0.12;
        color += texture2D(tex, clamp(uv + vec2( 0.0, -r.y), 0.0, 1.0)) * 0.12;
        color += texture2D(tex, clamp(uv + vec2( r.x,  r.y), 0.0, 1.0)) * 0.08;
        color += texture2D(tex, clamp(uv + vec2(-r.x,  r.y), 0.0, 1.0)) * 0.08;
        color += texture2D(tex, clamp(uv + vec2( r.x, -r.y), 0.0, 1.0)) * 0.08;
        color += texture2D(tex, clamp(uv + vec2(-r.x, -r.y), 0.0, 1.0)) * 0.08;
        return color;
      }

      vec3 screenBlend(vec3 base, vec3 blend) {
        return 1.0 - (1.0 - base) * (1.0 - blend);
      }

      void main() {
        vec2 uv = clamp(vUv, 0.0, 1.0);
        vec4 clearTex = texture2D(texture1, uv);
        vec4 blurredTex = sampleBlurred(texture1, uv, u_blurRadius);

        vec2 noiseUv = (uv - 0.5) * u_noiseScale;
        noiseUv.x *= 1.15;

        float n1 = fbm(noiseUv + vec2(0.0, 0.0));
        float n2 = fbm(noiseUv * 1.9 + vec2(2.7, -1.3));
        float n3 = fbm(noiseUv * 0.7 + vec2(-3.1, 1.8));
        float combinedNoise = n1 * 0.55 + n2 * 0.30 + n3 * 0.15;

        float radial = 1.0 - smoothstep(0.10, 0.92, distance(uv, vec2(0.5, 0.54)));
        float blobField = combinedNoise * 0.82 + radial * 0.55;
        float coreMask = smoothstep(u_noiseThreshold, 1.0, blobField);
        float glowMask = smoothstep(u_noiseThreshold - 0.20, 1.0, blobField) - coreMask;

        vec3 warmColor = mix(u_glowColorB, u_glowColorA, clamp(blobField * 1.1, 0.0, 1.0));
        vec3 bloomLayer = warmColor * (coreMask * (0.9 + u_glowStrength * 1.4) + glowMask * (0.6 + u_glowStrength * 2.0));
        vec3 overExpose = warmColor * coreMask * u_glowStrength * 0.85;

        vec3 baseColor = mix(clearTex.rgb, blurredTex.rgb, clamp(u_blobAlpha * 0.85 + u_blurRadius * 2.2, 0.0, 1.0));
        vec3 screened = screenBlend(baseColor, bloomLayer * u_blobAlpha);
        vec3 added = screened + overExpose * u_blobAlpha;
        vec3 finalColor = mix(clearTex.rgb, added, clamp(u_blobAlpha + u_glowStrength * 0.25, 0.0, 1.0));

        finalColor *= u_brightness;

        gl_FragColor = vec4(clamp(finalColor, 0.0, 1.0), 1.0);
      }
    `});const mesh=new THREE.Mesh(geometry,material);mesh.name="基础平面_光斑消散平面1";mesh.position.set(0,0,0);mesh.scale.set(1.03,1.03,1);this.scene.add(mesh);this.sceneObjects.planes.push(mesh);this.sceneObjects.materials.push(material);this.sceneObjects.mainPlane=mesh;this.sceneObjects.mainMaterial=material}setupAnimations(){const plane=this.sceneObjects.mainPlane;const material=this.sceneObjects.mainMaterial;if(!plane||!material)return;const lookTarget=new THREE.Vector3(0,0,0);const planeStartQuat=plane.quaternion.clone();const planeEndQuat=(new THREE.Quaternion).setFromEuler(new THREE.Euler(0,0,0));const scaleState={scale:1.03,rotT:0};const scaleTween=new TWEEN.Tween(scaleState).to({scale:1,rotT:1},1150).delay(50).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{plane.scale.set(obj.scale,obj.scale,1);plane.quaternion.copy(planeStartQuat.clone()).slerp(planeEndQuat,obj.rotT);this.camera.lookAt(lookTarget)}).start();this.sceneObjects.tweens.push(scaleTween);const shaderState1={blobAlpha:1,glowStrength:2.4,blurRadius:.18,noiseThreshold:.12};const shaderTween1=new TWEEN.Tween(shaderState1).to({blobAlpha:.58,glowStrength:1.1,blurRadius:.08,noiseThreshold:.48},850).delay(50).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_blobAlpha.value=obj.blobAlpha;material.uniforms.u_glowStrength.value=obj.glowStrength;material.uniforms.u_blurRadius.value=obj.blurRadius;material.uniforms.u_noiseThreshold.value=obj.noiseThreshold;material.uniforms.u_brightness.value=1;this.camera.lookAt(lookTarget)}).start();this.sceneObjects.tweens.push(shaderTween1);const shaderState2={blobAlpha:.58,glowStrength:1.1,blurRadius:.08,noiseThreshold:.48};const shaderTween2=new TWEEN.Tween(shaderState2).to({blobAlpha:.14,glowStrength:.18,blurRadius:.01,noiseThreshold:.78},1300).delay(900).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_blobAlpha.value=obj.blobAlpha;material.uniforms.u_glowStrength.value=obj.glowStrength;material.uniforms.u_blurRadius.value=obj.blurRadius;material.uniforms.u_noiseThreshold.value=obj.noiseThreshold;material.uniforms.u_brightness.value=1;this.camera.lookAt(lookTarget)}).start();this.sceneObjects.tweens.push(shaderTween2);const shaderState3={blobAlpha:.14,glowStrength:.18,blurRadius:.01,noiseThreshold:.78};const shaderTween3=new TWEEN.Tween(shaderState3).to({blobAlpha:0,glowStrength:0,blurRadius:0,noiseThreshold:.86},750).delay(2200).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_blobAlpha.value=obj.blobAlpha;material.uniforms.u_glowStrength.value=obj.glowStrength;material.uniforms.u_blurRadius.value=obj.blurRadius;material.uniforms.u_noiseThreshold.value=obj.noiseThreshold;material.uniforms.u_brightness.value=1;this.camera.lookAt(lookTarget)}).start();this.sceneObjects.tweens.push(shaderTween3)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;