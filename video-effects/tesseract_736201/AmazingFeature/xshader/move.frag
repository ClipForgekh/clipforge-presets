#version 300 es
precision highp float;

uniform sampler2D _MainTex;

in vec2 v_uv;

layout(location = 0) out vec4 FragColor;


void main () {
    vec4 base = texture(_MainTex, v_uv);
    FragColor = base;
    if (base.a == 0.0)
        discard;
//    if (base.a == 0.0)
//        gl_FragDepth = 1.0;
}