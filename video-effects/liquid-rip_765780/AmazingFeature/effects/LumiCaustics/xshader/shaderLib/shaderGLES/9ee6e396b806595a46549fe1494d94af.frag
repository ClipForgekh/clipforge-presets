precision highp float;
precision highp int;

uniform float u_stride;
uniform mediump sampler2D u_inputTexture;
uniform vec4 u_ScreenParams;
uniform float u_angle;
uniform mediump int u_steps;

varying vec2 v_uv;

float _f2(float _p0)
{
    return exp(((-0.5) * (_p0 * _p0)) / 0.0900000035762786865234375);
}

float _f1(vec4 _p0)
{
    return ((_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0)) + (_p0.w / 16581375.0);
}

float _f3(mediump int _p0, vec2 _p1)
{
    float _t2 = 0.0;
    float _t3 = 0.0;
    for (mediump int _t4 = 0; _t4 < 128; _t4++)
    {
        if (_t4 >= _p0)
        {
            break;
        }
        mediump float _120 = float(_t4);
        float param = _120 / float(_p0);
        float _127 = _f2(param);
        vec4 param_1 = texture2D(u_inputTexture, v_uv + ((_p1 * _120) * u_stride));
        vec4 param_2 = texture2D(u_inputTexture, v_uv + ((_p1 * (-_120)) * u_stride));
        _t2 += (((_f1(param_1) + _f1(param_2)) * _127) / 2.0);
        _t3 += _127;
    }
    return _t2 / max(_t3, 0.001000000047497451305389404296875);
}

vec4 _f0(inout float _p0)
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
    mediump int param = u_steps;
    vec2 param_1 = vec2(cos(u_angle), sin(u_angle)) / ((u_ScreenParams.xy * 720.0) / vec2(min(u_ScreenParams.x, u_ScreenParams.y)));
    float param_2 = _f3(param, param_1);
    vec4 _222 = _f0(param_2);
    gl_FragData[0] = _222;
}

