precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump sampler2D u_inputTexture;
uniform float u_height;
uniform float u_causticsStep;
uniform float u_causticsSize;
uniform mediump int u_enable;

varying vec2 v_xy;

vec2 _f0()
{
    return u_ScreenParams.xy;
}

vec2 _f1(vec2 _p0)
{
    return (_p0 / _f0()) + vec2(0.5);
}

float _f3(vec4 _p0)
{
    return ((_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0)) + (_p0.w / 16581375.0);
}

float _f4(vec2 _p0)
{
    vec2 param = _p0;
    vec4 param_1 = texture2D(u_inputTexture, _f1(param));
    return _f3(param_1) * u_height;
}

float _f5(vec2 _p0)
{
    vec2 param = _p0;
    float _126 = _f4(param);
    float _t3 = _126;
    float _t4 = _126;
    float _t5 = _126;
    float _t6 = 1.0;
    for (mediump int _t7 = 1; _t7 <= 1024; _t7++)
    {
        float _153 = float(_t7) * u_causticsStep;
        if (_153 > u_causticsSize)
        {
            break;
        }
        float _t9 = _p0.x + _153;
        for (mediump int _t10 = 1; _t10 <= 1024; _t10++)
        {
            float _178 = float(_t10) * u_causticsStep;
            if (_178 > u_causticsSize)
            {
                break;
            }
            if (length(vec2(_153, _178)) > u_causticsSize)
            {
                break;
            }
            vec2 param_1 = vec2(_t9, _p0.y + _178);
            float _202 = _f4(param_1);
            vec2 param_2 = vec2(_t9, _p0.y - _178);
            float _211 = _f4(param_2);
            _t5 += (_202 + _211);
            _t6 += 2.0;
            _t3 = min(min(_t3, _202), _211);
            _t4 = max(max(_t4, _202), _211);
        }
        _t9 = _p0.x - _153;
        for (mediump int _t14 = 1; _t14 <= 1024; _t14++)
        {
            float _250 = float(_t14) * u_causticsStep;
            if (_250 > u_causticsSize)
            {
                break;
            }
            if (length(vec2(_153, _250)) > u_causticsSize)
            {
                break;
            }
            vec2 param_3 = vec2(_t9, _p0.y + _250);
            float _274 = _f4(param_3);
            vec2 param_4 = vec2(_t9, _p0.y - _250);
            float _283 = _f4(param_4);
            _t5 += (_274 + _283);
            _t6 += 2.0;
            _t3 = min(min(_t3, _274), _283);
            _t4 = max(max(_t4, _274), _283);
        }
    }
    float _308 = _t5;
    float _309 = _308 / _t6;
    _t5 = _309;
    float _315 = _t4 - _t3;
    return mix(0.5, (_309 - _t3) / _315, step(0.20000000298023223876953125, _315));
}

vec4 _f2(inout float _p0)
{
    vec4 _t0 = vec4(0.0);
    _p0 *= 255.0;
    _t0.x = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.y = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.z = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _t0.w = _p0;
    return _t0;
}

void main()
{
    if (u_enable > 0)
    {
        vec2 param = v_xy;
        float param_1 = _f5(param);
        vec4 _342 = _f2(param_1);
        gl_FragData[0] = _342;
    }
    else
    {
        float param_2 = 0.5;
        vec4 _345 = _f2(param_2);
        gl_FragData[0] = _345;
    }
}

