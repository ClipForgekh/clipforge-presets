precision highp float;
precision highp int;

uniform mediump sampler2D u_lens;
uniform float u_rotateWarpDir;
uniform float u_amountRelX;
uniform float u_amountRelY;
uniform mediump int u_wrapModeX;
uniform mediump int u_wrapModeY;
uniform mediump int u_steps;
uniform float u_warpRed;
uniform float u_warpBlue;
uniform mediump sampler2D u_inputTex;
uniform vec4 u_ScreenParams;
uniform float u_amount;
uniform vec3 u_color1;
uniform vec3 u_color2;
uniform vec3 u_color3;
uniform float u_mix;

varying vec2 v_uv;

float _f0(vec4 _p0)
{
    return ((_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0)) + (_p0.w / 16581375.0);
}

vec2 _f5(vec2 _p0, float _p1, vec2 _p2)
{
    vec2 _t10 = vec2(abs(_p1)) / (_p2 * 1080.0);
    vec4 param = texture2D(u_lens, _p0 + vec2(_t10.x, 0.0));
    vec4 param_1 = texture2D(u_lens, _p0 - vec2(_t10.x, 0.0));
    vec4 param_2 = texture2D(u_lens, _p0 + vec2(0.0, _t10.y));
    vec4 param_3 = texture2D(u_lens, _p0 - vec2(0.0, _t10.y));
    return vec2(_f0(param) - _f0(param_1), _f0(param_2) - _f0(param_3));
}

vec2 _f2(vec2 _p0, float _p1)
{
    float _142 = sin(_p1);
    float _145 = cos(_p1);
    return vec2((_p0.x * _145) - (_p0.y * _142), (_p0.x * _142) + (_p0.y * _145));
}

vec2 _f6(vec2 _p0, inout vec2 _p1, float _p2)
{
    vec2 param = _p1;
    float param_1 = radians(u_rotateWarpDir);
    _p1 = _f2(param, param_1);
    return (_p1 * _p2) * vec2(u_amountRelX, u_amountRelY);
}

float _f3(float _p0)
{
    float _169 = fract(_p0);
    float _173 = floor(mod(_p0, 2.0));
    return (_169 + _173) - ((_169 * _173) * 2.0);
}

vec2 _f4(inout vec2 _p0, mediump int _p1, mediump int _p2, vec2 _p3)
{
    if (_p1 == 0)
    {
        _p0.x = clamp(_p0.x, 0.0, 1.0);
    }
    else
    {
        if (_p1 == 1)
        {
            _p0.x = mod(_p0.x, _p3.x);
        }
        else
        {
            if (_p1 == 2)
            {
                float param = _p0.x;
                _p0.x = _f3(param);
            }
        }
    }
    if (_p2 == 0)
    {
        _p0.y = clamp(_p0.y, 0.0, 1.0);
    }
    else
    {
        if (_p2 == 1)
        {
            _p0.y = mod(_p0.y, _p3.y);
        }
        else
        {
            if (_p2 == 2)
            {
                float param_1 = _p0.y;
                _p0.y = _f3(param_1);
            }
        }
    }
    return _p0;
}

vec4 _f7(mediump sampler2D _p0, inout vec2 _p1, vec2 _p2)
{
    vec2 param = _p1;
    mediump int param_1 = u_wrapModeX;
    mediump int param_2 = u_wrapModeY;
    vec2 param_3 = _p2;
    vec2 _354 = _f4(param, param_1, param_2, param_3);
    _p1 = _354;
    return texture2D(_p0, _p1);
}

vec3 _f1(vec3 _p0, vec3 _p1, vec3 _p2, float _p3)
{
    vec3 _t2;
    if (_p3 < 0.5)
    {
        float _108 = 2.0 * (_p3 * 2.0);
        _t2 = (_p0 * clamp(2.0 - _108, 0.0, 1.0)) + (_p1 * clamp(_108, 0.0, 1.0));
    }
    else
    {
        float _126 = 2.0 * ((_p3 - 0.5) * 2.0);
        _t2 = (_p1 * clamp(2.0 - _126, 0.0, 1.0)) + (_p2 * clamp(_126, 0.0, 1.0));
    }
    return _t2;
}

vec4 _f8(vec2 _p0, vec2 _p1)
{
    vec4 _t22 = vec4(0.0);
    vec4 _t23 = vec4(0.0);
    mediump float _368 = float(u_steps);
    for (mediump int _t25 = 0; _t25 < 100; _t25++)
    {
        if (_t25 >= u_steps)
        {
            break;
        }
        float _388 = float(_t25) / _368;
        vec2 param = v_uv + (_p0 * mix(u_warpRed, u_warpBlue, _388));
        vec2 param_1 = _p1;
        vec4 _409 = _f7(u_inputTex, param, param_1);
        vec3 param_2 = vec3(1.0, 0.0, 0.0);
        vec3 param_3 = vec3(0.0, 1.0, 0.0);
        vec3 param_4 = vec3(0.0, 0.0, 1.0);
        float param_5 = _388;
        vec4 _423 = vec4(_f1(param_2, param_3, param_4, param_5), 1.0);
        _t22 += (_409 * _423);
        _t23 += _423;
    }
    vec4 _435 = _t22;
    vec4 _436 = _435 / _t23;
    _t22 = _436;
    return _436;
}

void main()
{
    vec2 _450 = u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 param = v_uv;
    float param_1 = u_amount;
    vec2 param_2 = _450;
    vec2 param_3 = v_uv;
    vec2 param_4 = _f5(param, param_1, param_2) * vec2(u_amountRelX, u_amountRelY);
    float param_5 = u_amount;
    vec2 _471 = _f6(param_3, param_4, param_5);
    vec2 param_6 = _471;
    vec2 param_7 = _450;
    vec4 _477 = _f8(param_6, param_7);
    vec4 _t33 = _477;
    gl_FragData[0] = mix(_477, vec4(_477.xyz * ((u_color1 + u_color2) + u_color3), _t33.w), vec4(u_mix));
}

