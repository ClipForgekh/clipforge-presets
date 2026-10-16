const { getCurrentScene } = require('./runtime');
const { BufferGeometry } = require('./BufferGeometry');

class CylinderGeometry extends BufferGeometry {
  constructor(radiusTop = 0.5, radiusBottom = 0.5, height = 1.0, radiusSegments = 16, heightSegments = 1) {
    super();
    const scene = getCurrentScene();
    if (scene) { this._amgObject = scene._amgScene.assetMgr.SyncLoad('mesh/Cylinder.mesh'); }
    this.radiusTop = radiusTop; this.radiusBottom = radiusBottom;
    this.width = radiusTop / 0.5; this.height = height; this.depth = radiusTop / 0.5;
    this.radiusSegments = radiusSegments; this.heightSegments = heightSegments;
    this.scale(this.width, this.height, this.depth);
  }
}

exports.CylinderGeometry = CylinderGeometry;


