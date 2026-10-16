precision highp float;

uniform sampler2D u_baseTex;
uniform sampler2D u_maskTex;
uniform float u_maskEnabled;
uniform vec2 u_cell;
uniform vec2 u_origin;
uniform float u_opacity;

varying vec2 v_uv;
varying vec2 v_uv1;


vec4 mosaic1 (sampler2D tex, vec2 uv, vec2 uv0, vec2 uvD) {
    uv0 = floor((uv - uv0) / uvD) * uvD;
    return texture2D(tex, uv0 + uvD * 0.5);
}

void main () {
    vec4 base = texture2D(u_baseTex, v_uv);

    vec4 src1 = mosaic1(u_baseTex, v_uv, u_origin, u_cell) * u_opacity;
    base = src1 + base * (1.0 - src1.a);

    vec4 mask = texture2D(u_maskTex, v_uv1) * u_maskEnabled;
    base *= mask.r;

    gl_FragColor = base;
}