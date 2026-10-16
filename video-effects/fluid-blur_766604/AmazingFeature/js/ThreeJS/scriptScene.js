const TWEEN=require("./tween");const customEasings=require("./customEasings").customEasings;const THREE=require("./three-amg-wrapper").THREE;class ScriptScene{constructor(amgScene=null,container=null){if(amgScene){this.scene=new THREE.Scene;this.scene._amgScene=amgScene}else{this.scene=new THREE.Scene}this.effect_type="video_animation";this.camera=null;this.renderer=null;this.scene.background=new THREE.Color(3355443);this.isAnimating=false;this.animationFrameId=null;this.sceneObjects=null;this.texture1=null;this.composer=null;this.renderPass=null;this.usePostProcessing=true;this.initCoreObjects();if(container){this.init(container)}}destroy(){this.isAnimating=false;if(this.animationFrameId!==null&&typeof cancelAnimationFrame!=="undefined"){cancelAnimationFrame(this.animationFrameId);this.animationFrameId=null}if(this.renderer){this.renderer.setAnimationLoop(null);this.renderer.dispose();if(this.renderer.domElement&&this.renderer.domElement.parentNode){this.renderer.domElement.parentNode.removeChild(this.renderer.domElement)}}if(this.scene){this.scene.dispose()}if(typeof window!=="undefined"){window.removeEventListener("resize",this.handleResize)}if(this.sceneObjects&&this.sceneObjects.tweens){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.stop==="function"){tween.stop()}});this.sceneObjects.tweens=[]}if(this.texture1){if(typeof this.texture1.dispose==="function")this.texture1.dispose();this.texture1=null}if(this.texture2){if(typeof this.texture2.dispose==="function")this.texture2.dispose();this.texture2=null}if(this.shaderPasses&&this.shaderPasses.length){this.shaderPasses.forEach(pass=>{if(pass&&typeof pass.dispose==="function"){try{pass.dispose()}catch(e){}}});this.shaderPasses=[]}if(this.shaderPass&&typeof this.shaderPass.dispose==="function"){try{this.shaderPass.dispose()}catch(e){}}this.shaderPass=null;if(this.composer){this.composer.dispose();this.composer=null}this.renderPass=null;this.scene=null;this.camera=null;this.renderer=null;this.sceneObjects=null}initCoreObjects(){window.innerWidth=600;window.innerHeight=600;window.devicePixelRatio=1;this.camera=new THREE.PerspectiveCamera(53.1,window.innerWidth/window.innerHeight,.1,1e4);this.camera.position.z=10;this.scene.add(this.camera);if(this.scene._amgScene==null){this.renderer=new THREE.WebGLRenderer({antialias:true});this.renderer.outputColorSpace=THREE.LinearSRGBColorSpace}if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight);this.renderer.setPixelRatio(window.devicePixelRatio)}this.sliders={};this.Duration=3e3;this.TWEEN=TWEEN;this.customEasings=customEasings}addShaderPass(shaderPassConfigs){if(!Array.isArray(shaderPassConfigs)){shaderPassConfigs=[shaderPassConfigs]}shaderPassConfigs.forEach(config=>{const atomicName=config.name;const className=atomicName.startsWith("Lumi")?atomicName.substring(4):atomicName;const shaderPassModule=require("../pp/Lumi"+className+"/"+className+"ShaderPass.js");const ShaderPassClass=shaderPassModule[className+"ShaderPass"];const shaderPass=new ShaderPassClass;console.log("ShaderPass created:",shaderPass,className);this.composer.addPass(shaderPass);this.shaderPasses.push(shaderPass)})}setupPostProcessing(shaderPassConfigs){const{EffectComposer}=require("./EffectComposer.js");const{RenderPass}=require("./RenderPass.js");this.composer=new EffectComposer(this.renderer);this.renderPass=new RenderPass(this.scene,this.camera);this.composer.addPass(this.renderPass);this.shaderPasses=[];this.addShaderPass(shaderPassConfigs)}initPostProcessing(){}init(container){if(this.renderer){if(container){container.appendChild(this.renderer.domElement)}else if(typeof document!=="undefined"){document.body.appendChild(this.renderer.domElement)}}if(typeof window!=="undefined"){window.addEventListener("resize",()=>this.handleResize())}}start(updateCallback){if(this.isAnimating)return;this.isAnimating=true;if(updateCallback){const animateFrame=()=>{if(!this.isAnimating)return;updateCallback();this.animationFrameId=requestAnimationFrame(animateFrame)};animateFrame()}else{this.renderer.setAnimationLoop(()=>{this.update()})}}updateScene(timestamp){if(!this.isAnimating){this.isAnimating=true}this.defaultUpdate(timestamp)}update(){if(this.usePostProcessing&&this.composer){if(this.renderPass){this.renderPass.camera=this.camera}this.composer.render()}else if(this.renderer){this.renderer.render(this.scene,this.camera)}}onEvent(type,value){console.log("running:scriptScene:onevent");if(type==="lumiai_material_properties"){try{const json=JSON.parse(value);const{key,value:newValue}=json;if(key&&newValue!==undefined){this.handleMaterialPropertyUpdate(key,newValue)}}catch(error){console.error("Error parsing lumiai_material_properties JSON:",error)}}if(this.sliders[type]!==undefined){var oldValue=Math.max(this.sliders[type].min,Math.min(this.sliders[type].max,value));if(this.sliders[type].value!==oldValue){this.sliders[type].value=oldValue}}if(typeof this.updateSliders==="function"){this.updateSliders()}}handleMaterialPropertyUpdate(key,value){if(!this.usePostProcessing)return;this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="CustomShaderPass"){if(typeof shaderPass.setParameter!=="function"){console.error(`${shaderPass.constructor.name} 中没有 setParameter 方法`);return}shaderPass.setParameter(key,value)}})}handleResize(){this.camera.aspect=window.innerWidth/window.innerHeight;this.camera.updateProjectionMatrix();if(this.renderer){this.renderer.setSize(window.innerWidth,window.innerHeight)}if(this.composer){this.composer.setSize(window.innerWidth,window.innerHeight)}if(!this.isAnimating){this.update()}}loadTextures(){const textureLoader=new THREE.TextureLoader;return Promise.all([new Promise(resolve=>{this.texture1=textureLoader.load("image/Sample1.jpg",resolve);this.texture1.colorSpace=THREE.LinearSRGBColorSpace;this.texture1.wrapS=THREE.BackSide;this.texture1.wrapT=THREE.BackSide})])}_applyTweenInitialState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,0);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,0)}}_applyTweenFinalState(tween){if(!tween._propertiesAreSetUp){tween.start(0)}if(!tween._valuesStart||!tween._valuesEnd){return}tween._updateProperties(tween._object,tween._valuesStart,tween._valuesEnd,1);if(typeof tween._onUpdateCallback==="function"){tween._onUpdateCallback(tween._object,1)}}seekToTime(time){if(!this.isAnimating){this.isAnimating=true}if(this.shaderPass){if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){this.shaderPass.setParameter("ratio",1)}else{this.shaderPass.setParameter("ratio",this.texture1.image.width/this.texture1.image.height)}}const clampedTime=Math.max(0,Math.min(time,this.Duration));if(!this.sceneObjects.tweens||this.sceneObjects.tweens.length===0){return}let notStartTweens=[];let runningTweens=[];let finishedTweens=[];for(let i=0;i<=this.sceneObjects.tweens.length-1;i++){const tween=this.sceneObjects.tweens[i];let TweenStartTime=tween._delayTime+10;let TweenEndTime=tween._delayTime+tween._duration;if(clampedTime<=TweenStartTime){notStartTweens.push({time:TweenStartTime,tween:tween})}else if(clampedTime>=TweenEndTime){finishedTweens.push({time:TweenEndTime,tween:tween})}else{runningTweens.push(tween)}}notStartTweens.sort((a,b)=>b.time-a.time);finishedTweens.sort((a,b)=>a.time-b.time);notStartTweens.forEach((item,index)=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+2+index*.04)});finishedTweens.forEach(item=>{let tween=item.tween;tween.stop();tween.start(0);tween.update(tween._delayTime+tween._duration+2)});runningTweens.forEach(tween=>{tween.stop();tween.start(0);tween.update(clampedTime)});this.update()}setupSliders(){}updateSliders(){}updatePipeline(){var videoEntity=this.scene._amgScene.findEntityBy("video");if(!videoEntity){console.warn("Scene: 没有找到视频实体");return}var mat=videoEntity.getComponent("MeshRenderer").material;var outputRt=null;if(this.composer&&typeof this.composer.getOutputTexture==="function"){outputRt=this.composer.getOutputTexture()}if(!outputRt){var outputTexRt=this.scene._amgScene.assetMgr.SyncLoad("rt/outputTex.rt");outputRt=outputTexRt?outputTexRt.inputTexture:null}if(!outputRt){var aiOutputEntity=this.scene._amgScene.findEntityBy("PerspectiveCamera_w");if(aiOutputEntity){var cam=aiOutputEntity.getComponent("Camera");outputRt=cam?cam.inputTexture||cam.renderTexture:null}}if(!outputRt){console.warn("Scene: 没有找到可用的输出纹理");return}mat.setTex("u_videoTex",outputRt)}setupScene(){this.initSceneObjects();this.setupSliders();this.updateSliders();this.scene.background=new THREE.Color(1710618);this.createLayeredFluidPlane();this.setupAnimations();return this.sceneObjects}initSceneObjects(){this.sceneObjects={fluidPlane:null,fluidMaterial:null,tweens:[]};this.Duration=3e3;this.camera.position.set(0,0,10);this.camera.lookAt(0,0,0)}createLayeredFluidPlane(){const geometry=new THREE.PlaneGeometry(10,10,1,1);geometry.name="BasePlaneGeometry_LayeredFluidEntrance";const material=new THREE.ShaderMaterial({name:"LayeredFluidEntranceMaterial",transparent:false,side:THREE.DoubleSide,uniforms:{texture1:{value:this.texture1},ratio:{value:1},u_time:{value:0},u_bgBlur:{value:18},u_bgDistort:{value:.035},u_bgChromatic:{value:.18},u_midBlur:{value:12},u_midDistort:{value:.024},u_midChromatic:{value:.12},u_fgBlur:{value:8},u_fgDistort:{value:.016},u_fgChromatic:{value:.08},u_brightness:{value:1},u_grayscale:{value:0},u_chromatic:{value:0}},vertexShader:`
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,fragmentShader:`
      precision mediump float;

      uniform sampler2D texture1;
      uniform float ratio;
      uniform float u_time;

      uniform float u_bgBlur;
      uniform float u_bgDistort;
      uniform float u_bgChromatic;

      uniform float u_midBlur;
      uniform float u_midDistort;
      uniform float u_midChromatic;

      uniform float u_fgBlur;
      uniform float u_fgDistort;
      uniform float u_fgChromatic;

      uniform float u_brightness;
      uniform float u_grayscale;
      uniform float u_chromatic;

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

      float getLuma(vec3 color) {
        return dot(color, vec3(0.299, 0.587, 0.114));
      }

      vec3 sampleLayer(sampler2D tex, vec2 uv, float blurRadius, float distortStrength, float chromaticStrength, float waveSeed) {
        vec2 center = vec2(0.5, 0.5);
        vec2 aspectUv = getAspectCorrectUV(uv);
        vec2 dir = aspectUv - center;
        float dist = length(dir);

        float wave1 = sin((aspectUv.y + waveSeed) * 18.0 + u_time * 4.2);
        float wave2 = cos((aspectUv.x - waveSeed * 0.7) * 15.0 - u_time * 3.6);
        float wave3 = sin((aspectUv.x + aspectUv.y) * 12.0 + u_time * 2.7 + waveSeed * 6.28318);

        vec2 flow = vec2(wave1 + wave3, wave2 - wave3) * 0.5;
        vec2 distortedUv = clamp(uv + flow * distortStrength * (0.8 + dist * 0.7), 0.0, 1.0);

        float blurStep = blurRadius * 0.0012;
        vec2 blurVecX = vec2(blurStep, 0.0);
        vec2 blurVecY = vec2(0.0, blurStep / max(ratio, 0.0001));
        vec2 blurDiagA = vec2(blurStep * 0.707, blurStep * 0.707 / max(ratio, 0.0001));
        vec2 blurDiagB = vec2(-blurStep * 0.707, blurStep * 0.707 / max(ratio, 0.0001));

        vec2 chromaDir = normalize(dir + vec2(0.0001, 0.0001));
        vec2 chromaOffset = chromaDir * chromaticStrength * 0.018;

        float r = 0.0;
        float g = 0.0;
        float b = 0.0;

        vec2 sampleUv;

        sampleUv = clamp(distortedUv, 0.0, 1.0);
        r += texture2D(tex, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r * 0.20;
        g += texture2D(tex, sampleUv).g * 0.20;
        b += texture2D(tex, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b * 0.20;

        sampleUv = clamp(distortedUv + blurVecX, 0.0, 1.0);
        r += texture2D(tex, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r * 0.10;
        g += texture2D(tex, sampleUv).g * 0.10;
        b += texture2D(tex, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b * 0.10;

        sampleUv = clamp(distortedUv - blurVecX, 0.0, 1.0);
        r += texture2D(tex, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r * 0.10;
        g += texture2D(tex, sampleUv).g * 0.10;
        b += texture2D(tex, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b * 0.10;

        sampleUv = clamp(distortedUv + blurVecY, 0.0, 1.0);
        r += texture2D(tex, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r * 0.10;
        g += texture2D(tex, sampleUv).g * 0.10;
        b += texture2D(tex, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b * 0.10;

        sampleUv = clamp(distortedUv - blurVecY, 0.0, 1.0);
        r += texture2D(tex, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r * 0.10;
        g += texture2D(tex, sampleUv).g * 0.10;
        b += texture2D(tex, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b * 0.10;

        sampleUv = clamp(distortedUv + blurDiagA, 0.0, 1.0);
        r += texture2D(tex, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r * 0.10;
        g += texture2D(tex, sampleUv).g * 0.10;
        b += texture2D(tex, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b * 0.10;

        sampleUv = clamp(distortedUv - blurDiagA, 0.0, 1.0);
        r += texture2D(tex, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r * 0.10;
        g += texture2D(tex, sampleUv).g * 0.10;
        b += texture2D(tex, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b * 0.10;

        sampleUv = clamp(distortedUv + blurDiagB, 0.0, 1.0);
        r += texture2D(tex, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r * 0.10;
        g += texture2D(tex, sampleUv).g * 0.10;
        b += texture2D(tex, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b * 0.10;

        sampleUv = clamp(distortedUv - blurDiagB, 0.0, 1.0);
        r += texture2D(tex, clamp(sampleUv + chromaOffset, 0.0, 1.0)).r * 0.10;
        g += texture2D(tex, sampleUv).g * 0.10;
        b += texture2D(tex, clamp(sampleUv - chromaOffset, 0.0, 1.0)).b * 0.10;

        return vec3(r, g, b);
      }

      void main() {
        vec4 baseTexel = texture2D(texture1, vUv);
        float luma = getLuma(baseTexel.rgb);

        float bgMask = 1.0 - smoothstep(0.25, 0.52, luma);
        float fgMask = smoothstep(0.62, 0.88, luma);
        float midMask = clamp(1.0 - bgMask - fgMask, 0.0, 1.0);

        vec3 bgColor = sampleLayer(texture1, vUv, u_bgBlur, u_bgDistort, u_bgChromatic, 0.17);
        vec3 midColor = sampleLayer(texture1, vUv, u_midBlur, u_midDistort, u_midChromatic, 0.43);
        vec3 fgColor = sampleLayer(texture1, vUv, u_fgBlur, u_fgDistort, u_fgChromatic, 0.79);

        float totalMask = max(bgMask + midMask + fgMask, 0.0001);
        vec3 finalColor = (
          bgColor * bgMask +
          midColor * midMask +
          fgColor * fgMask
        ) / totalMask;

        vec4 texColor = vec4(finalColor, baseTexel.a);
        texColor.rgb *= u_brightness;
        gl_FragColor = texColor;
      }
    `});const mesh=new THREE.Mesh(geometry,material);mesh.name="BasePlane1_LayeredFluidEntrance";mesh.position.set(0,0,0);this.scene.add(mesh);this.sceneObjects.fluidPlane=mesh;this.sceneObjects.fluidMaterial=material}setupAnimations(){const material=this.sceneObjects.fluidMaterial;if(!material)return;const ratioState={progress:0};const ratioTween=new TWEEN.Tween(ratioState).to({progress:1},this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(()=>{if(!this.texture1||!this.texture1.image||!this.texture1.image.width||!this.texture1.image.height){material.uniforms.ratio.value=1}else{material.uniforms.ratio.value=this.texture1.image.width/this.texture1.image.height}}).start();this.sceneObjects.tweens.push(ratioTween);const timeState={value:0};const timeTween=new TWEEN.Tween(timeState).to({value:this.Duration/1e3},this.Duration).delay(0).easing(TWEEN.Easing.Linear.None).onUpdate(obj=>{material.uniforms.u_time.value=obj.value;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(timeTween);const bgStartState={blur:18,distort:.035,chromatic:.18};const bgTween=new TWEEN.Tween(bgStartState).to({blur:0,distort:0,chromatic:0},300).delay(700).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_bgBlur.value=obj.blur;material.uniforms.u_bgDistort.value=obj.distort;material.uniforms.u_bgChromatic.value=obj.chromatic;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(bgTween);const midDecayStartState={blur:12,distort:.024,chromatic:.12};const midDecayTween=new TWEEN.Tween(midDecayStartState).to({blur:3.6,distort:.0072,chromatic:.036},180).delay(880).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_midBlur.value=obj.blur;material.uniforms.u_midDistort.value=obj.distort;material.uniforms.u_midChromatic.value=obj.chromatic;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(midDecayTween);const midReboundStartState={blur:3.6,distort:.0072,chromatic:.036};const midReboundTween=new TWEEN.Tween(midReboundStartState).to({blur:4.8,distort:.0096,chromatic:.048},60).delay(1060).easing(customEasings.OutIn.Back).onUpdate(obj=>{material.uniforms.u_midBlur.value=obj.blur;material.uniforms.u_midDistort.value=obj.distort;material.uniforms.u_midChromatic.value=obj.chromatic;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(midReboundTween);const midSettleStartState={blur:4.8,distort:.0096,chromatic:.048};const midSettleTween=new TWEEN.Tween(midSettleStartState).to({blur:0,distort:0,chromatic:0},80).delay(1120).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_midBlur.value=obj.blur;material.uniforms.u_midDistort.value=obj.distort;material.uniforms.u_midChromatic.value=obj.chromatic;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(midSettleTween);const fgDecayStartState={blur:8,distort:.016,chromatic:.08};const fgDecayTween=new TWEEN.Tween(fgDecayStartState).to({blur:2.4,distort:.0048,chromatic:.024},280).delay(1080).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_fgBlur.value=obj.blur;material.uniforms.u_fgDistort.value=obj.distort;material.uniforms.u_fgChromatic.value=obj.chromatic;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(fgDecayTween);const fgReboundStartState={blur:2.4,distort:.0048,chromatic:.024};const fgReboundTween=new TWEEN.Tween(fgReboundStartState).to({blur:3.2,distort:.0064,chromatic:.032},80).delay(1360).easing(customEasings.OutIn.Back).onUpdate(obj=>{material.uniforms.u_fgBlur.value=obj.blur;material.uniforms.u_fgDistort.value=obj.distort;material.uniforms.u_fgChromatic.value=obj.chromatic;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(fgReboundTween);const fgSettleStartState={blur:3.2,distort:.0064,chromatic:.032};const fgSettleTween=new TWEEN.Tween(fgSettleStartState).to({blur:0,distort:0,chromatic:0},160).delay(1440).easing(TWEEN.Easing.Sinusoidal.InOut).onUpdate(obj=>{material.uniforms.u_fgBlur.value=obj.blur;material.uniforms.u_fgDistort.value=obj.distort;material.uniforms.u_fgChromatic.value=obj.chromatic;this.camera.lookAt(0,0,0)}).start();this.sceneObjects.tweens.push(fgSettleTween)}defaultUpdate(timestamp){if(this.sceneObjects.tweens&&this.sceneObjects.tweens.length>0){this.sceneObjects.tweens.forEach(tween=>{if(tween&&typeof tween.update==="function"){tween.update(timestamp)}})}this.update()}_predef_addTopCenterBottomStyleBorder(parent,offset,texture,cutoutAreaPosition,cutoutAreaSize){const aspectRatio=this.texture1.image.width/this.texture1.image.height;const parentInitScale=parent.scale.y;const parentPosition=parent.position;const textureWidth=texture.image.width;const textureHeight=texture.image.height;const geometry=new THREE.PlaneGeometry(10,10);const textureCenter=texture.clone();textureCenter.repeat.set(1,cutoutAreaSize.y/textureHeight);textureCenter.offset.set(0,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);const materialCenter=new THREE.MeshBasicMaterial({map:textureCenter,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialCenter.name="PlaneCenterMaterial";const planeCenter=new THREE.Mesh(geometry,materialCenter);planeCenter.name="PlaneCenter";planeCenter.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y,parentPosition.z+offset.z);planeCenter.scale.set(parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth),parentInitScale,1);this.scene.add(planeCenter);parent.attach(planeCenter);const textureTop=texture.clone();textureTop.repeat.set(1,cutoutAreaPosition.y/textureHeight);textureTop.offset.set(0,1-cutoutAreaPosition.y/textureHeight);const materialTop=new THREE.MeshBasicMaterial({map:textureTop,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialTop.name="PlaneTopMaterial";const scaleXTop=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYTop=scaleXTop*cutoutAreaPosition.y/textureWidth;const planeTop=new THREE.Mesh(geometry,materialTop);planeTop.name="PlaneTop";planeTop.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y+parentInitScale*10*.5+scaleYTop*10*.5,parentPosition.z+offset.z);planeTop.scale.set(scaleXTop,scaleYTop,1);this.scene.add(planeTop);parent.attach(planeTop);const textureBottom=texture.clone();textureBottom.repeat.set(1,(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureHeight);textureBottom.offset.set(0,0);const materialBottom=new THREE.MeshBasicMaterial({map:textureBottom,transparent:true,opacity:1,premultipliedAlpha:true,side:THREE.DoubleSide});materialBottom.name="PlaneBottomMaterial";const scaleXBottom=parentInitScale*aspectRatio/(cutoutAreaSize.x/textureWidth);const scaleYBottom=scaleXBottom*(textureHeight-cutoutAreaPosition.y-cutoutAreaSize.y)/textureWidth;const planeBottom=new THREE.Mesh(geometry,materialBottom);planeBottom.name="PlaneBottom";planeBottom.position.set(parentPosition.x+offset.x,parentPosition.y+offset.y-parentInitScale*10*.5-scaleYBottom*10*.5,parentPosition.z+offset.z);planeBottom.scale.set(scaleXBottom,scaleYBottom,1);this.scene.add(planeBottom);parent.attach(planeBottom)}_predef_loadVideoTexture(path,loop,playbackRate){if(this.scene._amgScene==null){const video=document.createElement("video");video.src=path;video.muted=true;video.loop=loop;video.load();const videoTexture=new THREE.VideoTexture(video);videoTexture.currentTime=0;videoTexture.playbackRate=playbackRate;this.videoTexture=videoTexture;return videoTexture}else if(typeof this.scene._amgScene==="string"){return new THREE.Texture}else{const texture=new THREE.VideoTexture(path,loop,playbackRate);texture.load();return texture}}_predef_seekVideoTexture(time){if(this.videoTexture!=null){const videoTexture=this.videoTexture;const video=videoTexture.image;if(video.readyState>=2){const textureProperties=this.renderer.properties.get(videoTexture);var newTime=time/1e3*videoTexture.playbackRate;if(newTime<0){newTime=0}else if(newTime>video.duration){if(video.loop){newTime=newTime%video.duration}else{newTime=video.duration}}if(textureProperties.__version==videoTexture.version){videoTexture.currentTime=newTime;video.currentTime=videoTexture.currentTime}}}}_predef_seekShaderPass(time){if(!("shaderPasses"in this)||this.shaderPasses==null){return}this.shaderPasses.forEach(shaderPass=>{if(shaderPass.constructor.name==="AnimSeqLoadAndCropBlendShaderPass"){if(this.texture1&&this.texture1.image){const ratio=this.texture1.image.width/this.texture1.image.height;if(typeof shaderPass.setAspectRatio==="function"){shaderPass.setAspectRatio(ratio)}}}})}}exports.ScriptScene=ScriptScene;