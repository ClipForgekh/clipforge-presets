precision highp float;

uniform sampler2D u_baseTex;
uniform sampler2D u_maskTex;

varying vec2 v_uv;
varying vec2 v_uv1;


void main () {
    vec4 base = texture2D(u_baseTex, v_uv);
    vec4 mask = texture2D(u_maskTex, v_uv1);
    base *= 1.0 - mask.r;

    gl_FragColor = base;
}