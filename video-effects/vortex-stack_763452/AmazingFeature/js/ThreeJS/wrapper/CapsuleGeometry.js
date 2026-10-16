const { getCurrentScene } = require('./runtime');
const { BufferGeometry } = require('./BufferGeometry');

class CapsuleGeometry extends BufferGeometry {
  constructor(radius = 0.5, height = 1.0, radiusSegments = 16, heightSegments = 1) {
    super();
    const scene = getCurrentScene();
    if (scene) { this._amgObject = scene._amgScene.assetMgr.SyncLoad('mesh/Capsule.mesh'); }
    this.radius = radius;
    this.width = radius / 0.5; this.height = height; this.depth = radius / 0.5;
    this.radiusSegments = radiusSegments; this.heightSegments = heightSegments;
    this.scale(this.width, this.height, this.depth);
  }
}

exports.CapsuleGeometry = CapsuleGeometry;


