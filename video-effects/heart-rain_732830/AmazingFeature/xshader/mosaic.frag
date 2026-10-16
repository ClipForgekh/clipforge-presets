precision highp float;

uniform sampler2D u_tex;
uniform vec2 u_cell;
uniform vec2 u_origin;

varying vec2 v_uv;


vec4 mosaic1 (sampler2D tex, vec2 uv, vec2 uv0, vec2 uvD) {
    uv0 = floor((uv - uv0) / uvD) * uvD;
    return texture2D(tex, uv0 + uvD * 0.5);
}

void main () {
    gl_FragColor = mosaic1(u_tex, v_uv, u_origin, u_cell);
}