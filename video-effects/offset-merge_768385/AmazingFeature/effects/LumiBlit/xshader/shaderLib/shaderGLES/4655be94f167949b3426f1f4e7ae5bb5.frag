precision highp float;
precision highp int;

uniform vec4 u_split0;
uniform vec4 u_split1;
uniform vec4 u_split2;
uniform vec4 u_split3;
uniform vec4 u_split4;
uniform vec4 u_split5;
uniform vec4 u_split6;
uniform float u_loveAngle0;
uniform float u_loveAngle1;
uniform float u_loveAngle2;
uniform float u_loveAngle3;
uniform float u_loveAngle4;
uniform float u_loveAngle5;
uniform float u_loveAngle6;
uniform mediump sampler2D u_inputTexture;
uniform vec4 u_ScreenParams;
uniform mediump int u_splitCount;
uniform mediump int u_splitType;
uniform float u_lineWidth;
uniform mediump int u_maskType;
uniform vec2 u_maskCenter;
uniform float u_maskA;
uniform float u_maskB;
uniform float u_maskC;
uniform float u_lineMaskProgress;
uniform float u_showLine;
uniform float u_alpha;
uniform vec4 u_lineColor;

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

float _f1(mediump int _p0)
{
    if (_p0 == 0)
    {
        return u_loveAngle0;
    }
    if (_p0 == 1)
    {
        return u_loveAngle1;
    }
    if (_p0 == 2)
    {
        return u_loveAngle2;
    }
    if (_p0 == 3)
    {
        return u_loveAngle3;
    }
    if (_p0 == 4)
    {
        return u_loveAngle4;
    }
    if (_p0 == 5)
    {
        return u_loveAngle5;
    }
    return u_loveAngle6;
}

void main()
{
    vec2 _t0 = v_uv;
    mediump vec4 _133 = texture2D(u_inputTexture, v_uv);
    vec4 _t1 = _133;
    float _t4 = 1.0;
    float _t5 = 0.0;
    float _t6 = 1.0;
    float _t15;
    for (mediump int _t7 = 0; _t7 < 7; _t7++)
    {
        if (_t7 >= u_splitCount)
        {
            break;
        }
        mediump int param = _t7;
        vec4 _t8 = _f0(param);
        if (u_splitType == 1)
        {
            float _181 = _t0.x - _t8.x;
            float _187 = _t0.y - _t8.y;
            _t15 = sqrt(max((((_181 * _181) * u_ScreenParams.x) * u_ScreenParams.x) + (((_187 * _187) * u_ScreenParams.y) * u_ScreenParams.y), 0.0)) - (sqrt(max(_t8.z, 0.0)) * min(u_ScreenParams.x, u_ScreenParams.y));
        }
        else
        {
            if (u_splitType == 2)
            {
                float _265 = min(u_ScreenParams.x, u_ScreenParams.y);
                float _271 = ((_t0.x - _t8.x) * u_ScreenParams.x) / _265;
                float _277 = ((_t0.y - _t8.y) * u_ScreenParams.y) / _265;
                mediump int param_1 = _t7;
                float _281 = _f1(param_1);
                float _284 = cos(_281);
                float _287 = sin(_281);
                float _308 = max(_t8.z, 0.001000000047497451305389404296875);
                float _312 = ((_271 * _284) - (_277 * _287)) / _308;
                float _316 = ((_271 * _287) + (_277 * _284)) / _308;
                float _320 = _312 * _312;
                float _327 = (_320 + (_316 * _316)) - 1.0;
                float _342 = ((_327 * _327) * _327) - (((_320 * _316) * _316) * _316);
                _t15 = sign(_342) * (((abs(_342) * _308) * _265) * 0.20000000298023223876953125);
            }
            else
            {
                _t15 = (((((_t8.x * _t0.x) + (_t8.y * _t0.y)) + _t8.z) * u_ScreenParams.x) * u_ScreenParams.y) / max(sqrt((((_t8.x * _t8.x) * u_ScreenParams.y) * u_ScreenParams.y) + (((_t8.y * _t8.y) * u_ScreenParams.x) * u_ScreenParams.x)), 9.9999997473787516355514526367188e-05);
            }
        }
        float _409 = min(u_ScreenParams.x, u_ScreenParams.y) / 720.0;
        float _410 = 3.0 * _409;
        _t4 *= mix(smoothstep(-_410, 0.0, _t15), 1.0 - smoothstep(0.0, _410, _t15), _t8.w);
        float _437 = 9.0 * _409;
        _t6 *= mix(smoothstep(-_437, 0.0, _t15), 1.0 - smoothstep(0.0, _437, _t15), _t8.w);
        float _462 = u_lineWidth * 0.5;
        _t5 = max(_t5, 1.0 - smoothstep(_462, _462 + _410, abs(_t15)));
    }
    _t5 *= (_t1.w * _t6);
    float _t45;
    float _t48;
    if (u_maskType == 1)
    {
        float _505 = (_t0.x - u_maskCenter.x) * u_ScreenParams.z;
        float _511 = _t0.y - u_maskCenter.y;
        _t45 = sqrt((_505 * _505) + (_511 * _511));
        float _532 = max(abs(u_maskCenter.x - 0.0), abs(u_maskCenter.x - 1.0)) * u_ScreenParams.z;
        float _542 = max(abs(u_maskCenter.y - 0.0), abs(u_maskCenter.y - 1.0));
        _t48 = sqrt((_532 * _532) + (_542 * _542));
    }
    else
    {
        _t45 = abs(((u_maskA * _t0.x) + (u_maskB * _t0.y)) + u_maskC) / max(sqrt((u_maskA * u_maskA) + (u_maskB * u_maskB)), 9.9999997473787516355514526367188e-05);
        _t48 = 0.75;
    }
    _t5 *= (1.0 - (1.0 - step(u_lineMaskProgress * _t48, _t45)));
    if (u_showLine < 0.5)
    {
        gl_FragData[0] = vec4(_133.xyz, (_t1.w * _t4) * u_alpha);
    }
    else
    {
        vec4 _t51 = mix(vec4(_133.xyz, _t1.w * _t4), u_lineColor, vec4(_t5));
        _t51.w *= u_alpha;
        gl_FragData[0] = _t51;
    }
}

