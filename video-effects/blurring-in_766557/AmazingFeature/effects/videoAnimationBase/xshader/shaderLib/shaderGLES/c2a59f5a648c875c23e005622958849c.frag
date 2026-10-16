precision highp float;
precision highp int;

uniform mediump sampler2D baseTex;
uniform mediump sampler2D _MainTex;
uniform float _alpha;

varying vec2 uv1;
varying vec2 uv0;

void main()
{
    mediump vec4 _19 = texture2D(baseTex, uv1);
    vec4 _t0 = _19;
    mediump vec4 _25 = texture2D(_MainTex, uv0);
    vec4 _t1 = _25;
    gl_FragData[0] = vec4((_19.xyz * (1.0 - (_t1.w * _alpha))) + (_25.xyz * _alpha), max(_t0.w, _t1.w));
}

