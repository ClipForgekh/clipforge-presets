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
uniform float u_showLine;
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
    for (mediump int _t6 = 0; _t6 < 7; _t6++)
    {
        if (_t6 >= u_splitCount)
        {
            break;
        }
        mediump int param = _t6;
        vec4 _t7 = _f0(param);
        float _166 = (((((_t7.x * _t0.x) + (_t7.y * _t0.y)) + _t7.z) * u_ScreenParams.x) * u_ScreenParams.y) / max(sqrt((((_t7.x * _t7.x) * u_ScreenParams.y) * u_ScreenParams.y) + (((_t7.y * _t7.y) * u_ScreenParams.x) * u_ScreenParams.x)), 9.9999997473787516355514526367188e-05);
        float _176 = 3.0 * (min(u_ScreenParams.x, u_ScreenParams.y) / 720.0);
        _t4 *= mix(smoothstep(-_176, 0.0, _166), 1.0 - smoothstep(0.0, _176, _166), _t7.w);
        float _202 = u_lineWidth * 0.5;
        _t5 = max(_t5, 1.0 - smoothstep(_202, _202 + _176, abs(_166)));
    }
    _t5 *= _t1.w;
    float _t20;
    float _t23;
    if (u_maskType == 1)
    {
        float _243 = (_t0.x - u_maskCenter.x) * u_ScreenParams.z;
        float _249 = _t0.y - u_maskCenter.y;
        _t20 = sqrt((_243 * _243) + (_249 * _249));
        float _270 = max(abs(u_maskCenter.x - 0.0), abs(u_maskCenter.x - 1.0)) * u_ScreenParams.z;
        float _280 = max(abs(u_maskCenter.y - 0.0), abs(u_maskCenter.y - 1.0));
        _t23 = sqrt((_270 * _270) + (_280 * _280));
    }
    else
    {
        _t20 = abs(((u_maskA * _t0.x) + (u_maskB * _t0.y)) + u_maskC) / max(sqrt((u_maskA * u_maskA) + (u_maskB * u_maskB)), 9.9999997473787516355514526367188e-05);
        _t23 = 0.75;
    }
    _t5 *= (1.0 - (1.0 - step(u_lineMaskProgress * _t23, _t20)));
    if (u_showLine < 0.5)
    {
        gl_FragData[0] = vec4(_82.xyz, _t1.w * _t4);
    }
    else
    {
        vec4 _t26 = mix(vec4(_82.xyz, _t1.w * _t4), u_lineColor, vec4(_t5));
        _t26.w *= u_alpha;
        gl_FragData[0] = _t26;
    }
}

