const { getCurrentScene } = require('./runtime');
const { BufferGeometry } = require('./BufferGeometry');
const { BufferAttribute } = require('./BufferAttribute');

class PlaneGeometry extends BufferGeometry {
  constructor(width = 1, height = 1, widthSegments = 1, heightSegments = 1) {
    super();
    this.width = width; this.height = height; this.widthSegments = widthSegments; this.heightSegments = heightSegments;

    const scene = getCurrentScene();
    if (scene) { this._amgObject = scene._amgScene.assetMgr.SyncLoad('mesh/Quad.mesh').clone(); }
    else { console.warn('PlaneGeometry: 无法加载Quad.mesh，scerne未创建'); }

    // add POSITION_OFFSET and TEXCOORD1 to vertexAttribs
    {
      var vertexAttribs = this._amgObject.vertexAttribs;
      
      var attribDesc0 = new effect.Amaz.VertexAttribDesc();
      attribDesc0.semantic = effect.Amaz.VertexAttribType.POSITION_OFFSET;
      attribDesc0.bindingIndex = 0;
      attribDesc0.offset = 36;
      attribDesc0.componentCount = 3;
      vertexAttribs.pushBack(attribDesc0);
      
      var attribDesc1 = new effect.Amaz.VertexAttribDesc();
      attribDesc1.semantic = effect.Amaz.VertexAttribType.TEXCOORD1;
      attribDesc1.bindingIndex = 0;
      attribDesc1.offset = 48;
      attribDesc1.componentCount = 2;
      vertexAttribs.pushBack(attribDesc1);

      this._amgObject.vertexAttribs = vertexAttribs;

      const submesh = this._amgObject.submeshes.get(0);
      if (submesh) {
        // 设置渲染模式为三角形
        submesh.primitive = effect.Amaz.Primitive.TRIANGLES;
      }
    }

    // construct vertices and uvs using width / height / widthSegments / heightSegments
    const gridX = widthSegments;
    const gridY = heightSegments;
    const gridX1 = gridX + 1;
    const gridY1 = gridY + 1;
    const segmentWidth = width / gridX;
    const segmentHeight = height / gridY;

    // 准备数组
    const vertices = [];
    const uvs = [];
    const indices = [];

    // 生成顶点和 UV
    for (let iy = 0; iy < gridY1; iy++) {
      const y = iy * segmentHeight - height / 2;
      for (let ix = 0; ix < gridX1; ix++) {
        const x = ix * segmentWidth - width / 2;
        vertices.push(x, -y, 0);
        uvs.push(ix / gridX, 1 - iy / gridY);
      }
    }

    // 生成索引
    for (let iy = 0; iy < gridY; iy++) {
      for (let ix = 0; ix < gridX; ix++) {
        const a = iy * gridX1 + ix;
        const b = iy * gridX1 + ix + 1;
        const c = (iy + 1) * gridX1 + ix + 1;
        const d = (iy + 1) * gridX1 + ix;
        indices.push(a, b, c, a, c, d);
      }
    }

    // 创建 BufferAttribute
    this.setAttribute('position', new BufferAttribute(new Float32Array(vertices), 3));
    this.setAttribute('uv', new BufferAttribute(new Float32Array(uvs), 2));
    this.setIndex(indices);
  }
}

exports.PlaneGeometry = PlaneGeometry;


