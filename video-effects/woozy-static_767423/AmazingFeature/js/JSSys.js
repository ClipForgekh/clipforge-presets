const effect_api = "undefined" != typeof effect ? effect : "undefined" != typeof tt ? tt : "undefined" != typeof lynx ? lynx : {};
const Amaz = effect_api.getAmaz();

class JSSys {
  constructor() {
    this.name = "JSSys";
    this.comps = {}
    this.compsdirty = true
    this.time = 0;
    this.startTime = 0;
    this.curTime = 0;
    this.endTime = 0;
    this.speed = 0.5;
    this.scriptScene = null;
  }

  onComponentAdded(comp) {
    // console.log("running:JSSys:onComponentAdded");
  }
  onComponentRemoved(comp) {
    // console.log("running:JSSys:onComponentRemoved");
  }

  onStart() {
    console.log("running:JSSys:onStart");
    const { ScriptScene } = require('./ThreeJS/scriptScene');
    const THREE = require('./ThreeJS/three-amg-wrapper').THREE; 
    this.input = Amaz.AmazingManager.getSingleton('Input');
    const inputTexture = this.scene.assetMgr.SyncLoad('share://input.texture');

    if (inputTexture) {
        console.log('inputTexture.width', inputTexture.width);
        console.log('inputTexture.height', inputTexture.height);

        this.renderTexture = this.scene.assetMgr.SyncLoad('rt/outputTex.rt');

        // 添加光源到场景
        // console.log('JSSys: 创建ScriptScene实例');
        this.scriptScene = new ScriptScene(this.scene);
        this.scriptScene.texture1 = new THREE.Texture();
        this.scriptScene.texture1.setImage(inputTexture);
        this.scriptScene.texture2 = new THREE.Texture();
        this.scriptScene.texture2.setImage(inputTexture);
        console.log("JSSys: 获取到纹理");

        if (this.scriptScene.setupScene != null) {
            this.scriptScene.setupScene();
        }
        // 初始化后处理效果
        if (this.scriptScene.initPostProcessing != null) {
            this.scriptScene.initPostProcessing();
        }
        if (this.scriptScene.updatePipeline != null) {
            this.scriptScene.updatePipeline();
        }
    }
  }

  onUpdate(deltaTime) {
    var lua_table_comp = this.scene.findEntityBy("TimeEntity").getComponent("TableComponent");
    var animDuration = 1.0
    this.animDuration = 1.0
    if (lua_table_comp)
    {
        this.time = lua_table_comp.table.get('curTime');
        animDuration = lua_table_comp.table.get('duration') + 0.001;
        this.animDuration = animDuration;
    }
    this.time = this.time % this.animDuration;
    this.scriptScene.seekToTime(this.time /this.animDuration*this.scriptScene.Duration);
  }
  onLateUpdate(deltaTime) {
    // console.log("running:JSSys:onLateUpdate");
    this.scriptScene.scene.seekToTime(this.time/this.animDuration*this.scriptScene.Duration);
  }

  onEvent(event) {
    // console.log("running:JSSys:onEvent");
    if (event.type === Amaz.AppEventType.SetEffectIntensity) {
      var type = event.args.get(0);
      var value = event.args.get(1);
      this.scriptScene.onEvent(type, value);
      // if (type == 'effects_adjust_speed'){
            // this.speed = value; // 0.0 - 1.0,  默认 0.5
      // }
      this.onUpdate(0);
    }
  }

  onDestroy() {
    // console.log("running:JSSys:onDestroy");
    this.scriptScene.destroy();
  }
}

exports.JSSys = JSSys;