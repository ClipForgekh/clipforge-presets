precision highp float;

uniform sampler2D u_base;
uniform sampler2D u_src0;
uniform float u_opacity0;

varying vec2 v_uv;
varying vec2 m_uv;

void main () {

    vec4 base = texture2D(u_base, m_uv);
    vec4 src1 = texture2D(u_src0, m_uv);

    src1 = src1 * u_opacity0;
    base = src1 + base * (1.0 - src1.a);
    gl_FragColor = base;
}