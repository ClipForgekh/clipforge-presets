precision highp float;
precision highp int;

uniform vec4 u_split0;
uniform vec4 u_split1;
uniform vec4 u_split2;
uniform vec4 u_split3;
uniform vec4 u_split4;
uniform vec4 u_split5;
uniform vec4 u_split6;
uniform mediump sampler2D u_inputTexture;
uniform vec4 u_ScreenParams;
uniform mediump int u_splitCount;
uniform float u_lineWidth;
uniform mediump int u_maskType;
uniform vec2 u_maskCenter;
uniform float u_maskA;
uniform float u_maskB;
uniform float u_maskC;
uniform float u_lineMaskProgress;
uniform vec4 u_lineColor;
uniform float u_alpha;

varying vec2 v_uv;

vec4 _f0(mediump int _p0)
{
    if (_p0 == 0)
    {
        return u_split0;
    }
    if (_p0 == 1)
    {
        return u_split1;
    }
    if (_p0 == 2)
    {
        return u_split2;
    }
    if (_p0 == 3)
    {
        return u_split3;
    }
    if (_p0 == 4)
    {
        return u_split4;
    }
    if (_p0 == 5)
    {
        return u_split5;
    }
    return u_split6;
}

void main()
{
    vec2 _t0 = v_uv;
    mediump vec4 _82 = texture2D(u_inputTexture, v_uv);
    vec4 _t1 = _82;
    float _t4 = 1.0;
    float _t5 = 0.0;
    float _t6 = 1.0;
    for (mediump int _t7 = 0; _t7 < 7; _t7++)
    {
        if (_t7 >= u_splitCount)
        {
            break;
        }
        mediump int param = _t7;
        vec4 _t8 = _f0(param);
        float _167 = (((((_t8.x * _t0.x) + (_t8.y * _t0.y)) + _t8.z) * u_ScreenParams.x) * u_ScreenParams.y) / max(sqrt((((_t8.x * _t8.x) * u_ScreenParams.y) * u_ScreenParams.y) + (((_t8.y * _t8.y) * u_ScreenParams.x) * u_ScreenParams.x)), 9.9999997473787516355514526367188e-05);
        float _176 = min(u_ScreenParams.x, u_ScreenParams.y) / 720.0;
        float _177 = 3.0 * _176;
        _t4 *= mix(smoothstep(-_177, 0.0, _167), 1.0 - smoothstep(0.0, _177, _167), _t8.w);
        float _204 = 9.0 * _176;
        _t6 *= mix(smoothstep(-_204, 0.0, _167), 1.0 - smoothstep(0.0, _204, _167), _t8.w);
        float _229 = u_lineWidth * 0.5;
        _t5 = max(_t5, 1.0 - smoothstep(_229, _229 + _177, abs(_167)));
    }
    _t5 *= (_t1.w * _t6);
    float _t24;
    float _t27;
    if (u_maskType == 1)
    {
        float _272 = (_t0.x - u_maskCenter.x) * u_ScreenParams.z;
        float _278 = _t0.y - u_maskCenter.y;
        _t24 = sqrt((_272 * _272) + (_278 * _278));
        float _299 = max(abs(u_maskCenter.x - 0.0), abs(u_maskCenter.x - 1.0)) * u_ScreenParams.z;
        float _309 = max(abs(u_maskCenter.y - 0.0), abs(u_maskCenter.y - 1.0));
        _t27 = sqrt((_299 * _299) + (_309 * _309));
    }
    else
    {
        _t24 = abs(((u_maskA * _t0.x) + (u_maskB * _t0.y)) + u_maskC) / max(sqrt((u_maskA * u_maskA) + (u_maskB * u_maskB)), 9.9999997473787516355514526367188e-05);
        _t27 = 0.75;
    }
    float _358 = _t5;
    float _359 = _358 * (1.0 - (1.0 - step(u_lineMaskProgress * _t27, _t24)));
    _t5 = _359;
    vec4 _t30 = mix(vec4(_82.xyz, _t1.w * _t4), u_lineColor, vec4(_359));
    _t30.w *= u_alpha;
    gl_FragData[0] = _t30;
}

