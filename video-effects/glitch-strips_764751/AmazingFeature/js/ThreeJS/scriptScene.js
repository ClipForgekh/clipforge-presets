const TWEEN=require("./tween");const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(2369584);this.createCyberGlitchPlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.Duration=1e3;this.sceneObjects={mainPlane:null,materials:{},meshes:[],tweens:[]};this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createCyberGlitchPlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);const material=this.createCyberGlitchMaterial();const plane=new THREE.Mesh(geometry,material);plane.name="BasePlane1";plane.position.set(0,0,0);this.scene.add(plane);this.sceneObjects.mainPlane=plane;this.sceneObjects.meshes.push(plane);this.sceneObjects.materials.cyberGlitchMaterial=material}createCyberGlitchMaterial(){const material=new THREE.ShaderMaterial({name:"CyberGlitchSegmentSweepMaterial",transparent:false,side:THREE.DoubleSide,uniforms:{texture1:{value:this.texture1},u_segmentCount:{value:7},u_exposureGain:{value:0},u_verticalBlurRadius:{value:0},u_uvYOffset:{value:0},u_glitchNoiseIntensity:{value:0},u_glowIntensity:{value:0},u_scanProgress:{value:0}},vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;

      uniform sampler2D texture1;
      uniform float u_segmentCount;
      uniform float u_exposureGain;
      uniform float u_verticalBlurRadius;
      uniform float u_uvYOffset;
      uniform float u_glitchNoiseIntensity;
      uniform float u_glowIntensity;
      uniform float u_scanProgress;

      varying vec2 vUv;

      float saturate(float v) {
        return clamp(v, 0.0, 1.0);
      }

      vec3 screenBlend(vec3 base, vec3 blend) {
        return 1.0 - (1.0 - base) * (1.0 - blend);
      }

      vec3 overlayBlend(vec3 base, vec3 blend) {
        vec3 lowPart = 2.0 * base * blend;
        vec3 highPart = 1.0 - 2.0 * (1.0 - base) * (1.0 - blend);
        return mix(lowPart, highPart, step(vec3(0.5), base));
      }

      float random(vec2 st) {
        return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
      }

      vec2 clampUv(vec2 uv) {
        return clamp(uv, vec2(0.001), vec2(0.999));
      }

      vec4 sampleVerticalBlur(sampler2D tex, vec2 uv, float radiusUv) {
        vec4 color = vec4(0.0);
        float total = 0.0;

        for (int i = -4; i <= 4; i++) {
          float fi = float(i);
          float weight = 1.0 - abs(fi) / 4.5;
          vec2 sampleUv = clampUv(uv + vec2(0.0, radiusUv * fi));
          color += texture2D(tex, sampleUv) * weight;
          total += weight;
        }

        return color / max(total, 0.0001);
      }

      void main() {
        vec2 uv = vUv;
        float segH = 1.0 / u_segmentCount;
        float topIndex = floor((1.0 - uv.y) * u_segmentCount);
        topIndex = clamp(topIndex, 0.0, u_segmentCount - 1.0);

        float segTop = 1.0 - topIndex * segH;
        float segBottom = segTop - segH;
        float localY = saturate((uv.y - segBottom) / segH);

        float isOdd = 1.0 - mod(topIndex, 2.0);
        float directionDown = isOdd;
        float sweepPos = mix(u_scanProgress, 1.0 - u_scanProgress, directionDown);

        float restoredMask = 0.0;
        if (directionDown > 0.5) {
          restoredMask = step(sweepPos, localY);
        } else {
          restoredMask = step(localY, sweepPos);
        }

        float unresolvedMask = 1.0 - restoredMask;
        float blurPx = mix(u_verticalBlurRadius, 0.0, restoredMask);
        float offsetAmount = mix(u_uvYOffset, 0.0, restoredMask);
        float noiseAmount = mix(u_glitchNoiseIntensity, 0.0, restoredMask);

        float offsetSign = mod(topIndex, 2.0) < 0.5 ? 1.0 : -1.0;
        vec2 shiftedUv = uv;
        shiftedUv.y += offsetSign * offsetAmount * unresolvedMask;
        shiftedUv = clampUv(shiftedUv);

        float blurUv = blurPx / 600.0;
        vec4 blurredBase = sampleVerticalBlur(texture1, shiftedUv, blurUv);

        float noiseSeed = random(vec2(floor(uv.y * 220.0) + topIndex * 3.1, floor(uv.x * 180.0) + u_scanProgress * 97.0));
        float noiseBand = random(vec2(topIndex * 17.0, floor(uv.y * 96.0)));
        float glitchShift = (noiseSeed - 0.5) * 0.03 * noiseAmount * unresolvedMask + offsetSign * offsetAmount * 0.35 * unresolvedMask;

        vec2 dir = vec2(1.0, 0.15);
        vec2 rUv = clampUv(shiftedUv + dir * glitchShift);
        vec2 gUv = clampUv(shiftedUv);
        vec2 bUv = clampUv(shiftedUv - dir * glitchShift);

        vec3 glitchColor = vec3(
          sampleVerticalBlur(texture1, rUv, blurUv).r,
          sampleVerticalBlur(texture1, gUv, blurUv).g,
          sampleVerticalBlur(texture1, bUv, blurUv).b
        );

        float gray = dot(glitchColor, vec3(0.299, 0.587, 0.114));
        vec3 saturatedBlocks = mix(vec3(gray), glitchColor, 1.75 + 0.3 * unresolvedMask);
        float poster = 5.0 + 6.0 * unresolvedMask;
        saturatedBlocks = floor(saturatedBlocks * poster) / poster;
        saturatedBlocks *= (1.0 + u_exposureGain * (0.55 + 0.45 * unresolvedMask));

        float lineWidth = 0.075;
        float glowDist = abs(localY - sweepPos);
        float glowCore = 1.0 - smoothstep(0.0, lineWidth, glowDist);
        float glowSoft = 1.0 - smoothstep(lineWidth, lineWidth * 3.5, glowDist);
        float glowMask = max(glowCore, glowSoft * 0.5) * unresolvedMask * u_glowIntensity;

        vec3 glowColorA = vec3(0.215686, 0.901961, 0.815686);
        vec3 glowColorB = vec3(0.603922, 0.301961, 1.0);
        float glowMix = 0.5 + 0.5 * sin(uv.x * 22.0 + topIndex * 1.7);
        vec3 glowColor = mix(glowColorA, glowColorB, glowMix);

        vec3 color = saturatedBlocks;
        color = screenBlend(color, glowColor * glowMask);
        color += glowColor * glowMask * 0.38;

        vec3 overlayNoise = vec3(
          0.5 + (noiseSeed - 0.5) * noiseAmount,
          0.5 + (noiseBand - 0.5) * noiseAmount * 0.75,
          0.5 + (random(vec2(noiseSeed * 11.0, noiseBand * 7.0)) - 0.5) * noiseAmount
        );
        color = mix(color, overlayBlend(color, overlayNoise), saturate(noiseAmount * 0.6 * unresolvedMask));

        vec3 original = texture2D(texture1, clampUv(uv)).rgb;
        color = mix(color, original, restoredMask);

        color = mix(color, blurredBase.rgb, 0.05 * unresolvedMask);
        color = clamp(color, 0.0, 1.0);

        gl_FragColor = vec4(color, 1.0);
      }
    `});return material}setupAnimations(){const plane=this.sceneObjects.mainPlane;const material=this.sceneObjects.materials.cyberGlitchMaterial;if(!plane||!material)return;this.camera.lookAt(0,0,0);const stage1State={exposure:0,blur:0,offset:0,noise:0,glow:0,scan:0};const stage1Tween=new TWEEN.Tween(stage1State).to({exposure:2.2,blur:22,offset:.12,noise:1.2,glow:1,scan:0},180).delay(50).easing(TWEEN.Easing.Exponential.Out).onUpdate(obj=>{material.uniforms.u_exposureGain.value=obj.exposure;material.uniforms.u_verticalBlurRadius.value=obj.blur;material.uniforms.u_uvYOffset.value=obj.offset;material.uniforms.u_glitchNoiseIntensity.value=obj.noise;material.uniforms.u_glowIntensity.value=obj.glow;material.uniforms.u_scanProgress.value=obj.scan;this.camera.lookAt(0,0,0)}).start();const stage2State={exposure:2.2,blur:22,offset:.12,noise:1.2,glow:1,scan:0};const stage2Tween=new TWEEN.Tween(stage2State).to({exposure:1,blur:3,offset:.01,noise:.3,glow:0,scan:1},450).delay(230).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_exposureGain.value=obj.exposure;material.uniforms.u_verticalBlurRadius.value=obj.blur;material.uniforms.u_uvYOffset.value=obj.offset;material.uniforms.u_glitchNoiseIntensity.value=obj.noise;material.uniforms.u_glowIntensity.value=obj.glow;material.uniforms.u_scanProgress.value=obj.scan;this.camera.lookAt(0,0,0)}).start();const stage3State={exposure:1,blur:3,offset:.01,noise:.3,glow:0,scan:1};const stage3Tween=new TWEEN.Tween(stage3State).to({exposure:0,blur:0,offset:0,noise:0,glow:0,scan:1},270).delay(680).easing(TWEEN.Easing.Circular.Out).onUpdate(obj=>{material.uniforms.u_exposureGain.value=obj.exposure;material.uniforms.u_verticalBlurRadius.value=obj.blur;material.uniforms.u_uvYOffset.value=obj.offset;material.uniforms.u_glitchNoiseIntensity.value=obj.noise;material.uniforms.u_glowIntensity.value=obj.glow;material.uniforms.u_scanProgress.value=obj.scan;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(stage1Tween);this.sceneObjects.tweens.push(stage2Tween);this.sceneObjects.tweens.push(stage3Tween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;