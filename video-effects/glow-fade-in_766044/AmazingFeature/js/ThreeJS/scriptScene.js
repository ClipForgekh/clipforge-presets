const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(3025446);this.createMainImagePlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=3e3;this.sceneObjects={mainPlane:null,materials:{},meshes:[],tweens:[],uniforms:{}};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createMainImagePlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="MainImagePlaneGeometry";const material=new THREE.ShaderMaterial({name:"WarmParticleRevealMaterial",transparent:true,side:THREE.DoubleSide,depthWrite:false,uniforms:{texture1:{value:this.texture1},u_time:{value:0},u_textureOpacity:{value:0},u_particleIntensity:{value:0},u_particleDrift:{value:0},u_noiseOctaves:{value:3},u_glowSoftness:{value:.65},u_brightness:{value:1},u_grayscale:{value:0},u_chromatic:{value:0}},vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;

      uniform sampler2D texture1;
      uniform float u_time;
      uniform float u_textureOpacity;
      uniform float u_particleIntensity;
      uniform float u_particleDrift;
      uniform float u_noiseOctaves;
      uniform float u_glowSoftness;
      uniform float u_brightness;
      uniform float u_grayscale;
      uniform float u_chromatic;

      varying vec2 vUv;

      float hash12(vec2 p) {
        vec3 p3 = fract(vec3(p.xyx) * 0.1031);
        p3 += dot(p3, p3.yzx + 33.33);
        return fract((p3.x + p3.y) * p3.z);
      }

      float noise(vec2 p) {
        vec2 i = floor(p);
        vec2 f = fract(p);
        float a = hash12(i);
        float b = hash12(i + vec2(1.0, 0.0));
        float c = hash12(i + vec2(0.0, 1.0));
        float d = hash12(i + vec2(1.0, 1.0));
        vec2 u = f * f * (3.0 - 2.0 * f);
        return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
      }

      float fbm3(vec2 p) {
        float value = 0.0;
        float amplitude = 0.5;
        float frequency = 1.0;
        for (int i = 0; i < 3; i++) {
          value += noise(p * frequency) * amplitude;
          frequency *= 2.0;
          amplitude *= 0.5;
        }
        return value;
      }

      float particleField(vec2 uv, float drift) {
        vec2 driftedUv = uv;
        driftedUv.x -= drift * (0.20 + 0.12 * noise(vec2(uv.y * 11.0, uv.x * 7.0)));
        driftedUv.y += (noise(vec2(uv.x * 13.0 + 4.0, uv.y * 9.0 + 8.0)) - 0.5) * 0.12 * drift;

        float leftWeight = smoothstep(1.15, 0.08, uv.x);
        float n1 = fbm3(driftedUv * 10.0 + vec2(u_time * 0.00025, 0.0));
        float n2 = fbm3(driftedUv * 18.0 + vec2(13.4, 2.7) + vec2(u_time * 0.00033, u_time * 0.00011));
        float n3 = fbm3(driftedUv * 31.0 + vec2(-7.2, 9.1) + vec2(u_time * 0.00041, -u_time * 0.00018));

        float p1 = smoothstep(0.78, 0.98, n1);
        float p2 = smoothstep(0.82, 0.99, n2);
        float p3 = smoothstep(0.86, 0.995, n3);

        float particles = p1 * 0.55 + p2 * 0.30 + p3 * 0.15;
        return particles * leftWeight;
      }

      vec3 screenBlend(vec3 base, vec3 blend) {
        return 1.0 - (1.0 - base) * (1.0 - blend);
      }

      void main() {
        vec2 mappedUv = vUv;
        vec4 texColor = texture2D(texture1, mappedUv);

        float particles = particleField(mappedUv, u_particleDrift);
        float glow = smoothstep(0.0, 1.0, particles) * (0.55 + u_glowSoftness * 0.9);
        glow += smoothstep(0.15, 1.0, particles) * 0.35;

        vec3 warmA = vec3(217.0 / 255.0, 164.0 / 255.0, 65.0 / 255.0);
        vec3 warmB = vec3(200.0 / 255.0, 122.0 / 255.0, 43.0 / 255.0);
        vec3 warmC = vec3(232.0 / 255.0, 216.0 / 255.0, 184.0 / 255.0);

        float colorMix1 = noise(mappedUv * 6.0 + vec2(2.3, 1.7));
        float colorMix2 = noise(mappedUv * 12.0 + vec2(-4.1, 5.2));
        vec3 particleColor = mix(warmA, warmB, colorMix1);
        particleColor = mix(particleColor, warmC, colorMix2 * 0.45);

        float particleStrength = u_particleIntensity * (particles + glow * 0.85);
        vec3 particleLayer = particleColor * particleStrength * 1.35;

        vec3 baseLayer = texColor.rgb * u_textureOpacity;
        vec3 composed = screenBlend(baseLayer, particleLayer);

        vec4 finalColor = vec4(composed, max(u_textureOpacity, clamp(particleStrength, 0.0, 1.0)));

        finalColor.rgb *= u_brightness;

        gl_FragColor = finalColor;
      }
    `});const mesh=new THREE.Mesh(geometry,material);mesh.name="MainImagePlane1";mesh.position.set(0,0,0);this.scene.add(mesh);this.sceneObjects.mainPlane=mesh;this.sceneObjects.meshes.push(mesh);this.sceneObjects.materials.mainPlaneMaterial=material;this.sceneObjects.uniforms.mainPlane=material.uniforms}setupAnimations(){const mainPlane=this.sceneObjects.mainPlane;const material=this.sceneObjects.materials.mainPlaneMaterial;if(!mainPlane||!material)return;const uniforms=material.uniforms;this.camera.lookAt(0,0,0);const timeState={value:0};const timeTween=new TWEEN.Tween(timeState).to({value:this.Duration},this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_time.value=obj.value;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(timeTween);const phase1ParticleStart={value:0};const phase1ParticleTween=new TWEEN.Tween(phase1ParticleStart).to({value:1},450).delay(50).easing(TWEEN.Easing.Exponential.Out).onUpdate(obj=>{uniforms.u_particleIntensity.value=obj.value}).start();this.sceneObjects.tweens.push(phase1ParticleTween);const phase2ParticleStart={value:1};const phase2ParticleTween=new TWEEN.Tween(phase2ParticleStart).to({value:.35},700).delay(500).easing(TWEEN.Easing.Sinusoidal.Out).onUpdate(obj=>{uniforms.u_particleIntensity.value=obj.value}).start();this.sceneObjects.tweens.push(phase2ParticleTween);const phase3ParticleStart={value:.35};const phase3ParticleTween=new TWEEN.Tween(phase3ParticleStart).to({value:0},600).delay(1200).easing(TWEEN.Easing.Exponential.Out).onUpdate(obj=>{uniforms.u_particleIntensity.value=obj.value}).start();this.sceneObjects.tweens.push(phase3ParticleTween);const phase2DriftStart={value:0};const phase2DriftTween=new TWEEN.Tween(phase2DriftStart).to({value:1},700).delay(500).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_particleDrift.value=obj.value}).start();this.sceneObjects.tweens.push(phase2DriftTween);const phase3DriftStart={value:1};const phase3DriftTween=new TWEEN.Tween(phase3DriftStart).to({value:1.4},600).delay(1200).easing(TWEEN.Easing.Sinusoidal.Out).onUpdate(obj=>{uniforms.u_particleDrift.value=obj.value}).start();this.sceneObjects.tweens.push(phase3DriftTween);const phase2OpacityStart={value:0};const phase2OpacityTween=new TWEEN.Tween(phase2OpacityStart).to({value:.8},700).delay(500).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_textureOpacity.value=obj.value}).start();this.sceneObjects.tweens.push(phase2OpacityTween);const phase3OpacityStart={value:.8};const phase3OpacityTween=new TWEEN.Tween(phase3OpacityStart).to({value:1},600).delay(1200).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{uniforms.u_textureOpacity.value=obj.value}).start();this.sceneObjects.tweens.push(phase3OpacityTween);const holdFinalStart={particleIntensity:0,particleDrift:0,textureOpacity:1};const holdFinalTween=new TWEEN.Tween(holdFinalStart).to({particleIntensity:0,particleDrift:0,textureOpacity:1},1150).delay(1800).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{uniforms.u_particleIntensity.value=obj.particleIntensity;uniforms.u_particleDrift.value=obj.particleDrift;uniforms.u_textureOpacity.value=obj.textureOpacity;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(holdFinalTween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;