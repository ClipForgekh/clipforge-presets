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
    vec4 bgCol = _19;
    mediump vec4 _25 = texture2D(_MainTex, uv0);
    vec4 modelCol = _25;
    gl_FragData[0] = vec4((_19.xyz * ((-modelCol.w) * _alpha + 1.0)) + (_25.xyz * _alpha), max(bgCol.w, modelCol.w));
}

