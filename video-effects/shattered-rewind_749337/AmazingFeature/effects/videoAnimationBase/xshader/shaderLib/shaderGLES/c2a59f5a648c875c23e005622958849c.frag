precision highp float;
precision highp int;

uniform float u_lastBlend;
uniform mediump sampler2D baseTex;
uniform mediump sampler2D _MainTex;
uniform float _alpha;

varying vec2 uv1;
varying vec2 uv0;

void main()
{
    if (u_lastBlend == 1.0)
    {
        gl_FragData[0] = mix(texture2D(_MainTex, uv0), texture2D(baseTex, uv1), vec4(_alpha));
    }
    else
    {
        mediump vec4 _49 = texture2D(baseTex, uv1);
        vec4 _t3 = _49;
        mediump vec4 _53 = texture2D(_MainTex, uv0);
        vec4 _t4 = _53;
        gl_FragData[0] = vec4((_49.xyz * (1.0 - (_t4.w * _alpha))) + (_53.xyz * _alpha), max(_t3.w, _t4.w));
    }
}

