precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTex;
uniform float u_angle;
uniform vec4 u_ScreenParams;
uniform mediump int u_steps;
uniform float u_stride;

varying vec2 v_uv;

float _f0(float _p0)
{
    return exp(((-0.5) * (_p0 * _p0)) / 0.0900000035762786865234375);
}

vec3 _f1(mediump int _p0, float _p1, vec2 _p2)
{
    vec3 _t0 = vec3(0.0);
    float _t1 = 0.0;
    for (mediump int _t2 = 0; _t2 < 1000; _t2++)
    {
        if (_t2 >= _p0)
        {
            break;
        }
        mediump float _57 = float(_t2);
        float param = _57 / float(_p0);
        float _64 = _f0(param);
        _t0 += (((texture2D(u_inputTex, v_uv + ((_p2 * _57) * _p1)).xyz + texture2D(u_inputTex, v_uv + ((_p2 * (-_57)) * _p1)).xyz) * _64) / vec3(2.0));
        _t1 += _64;
    }
    return _t0 / max(vec3(_t1), vec3(0.001000000047497451305389404296875));
}

void main()
{
    float _131 = (u_angle / 180.0) * 3.141592502593994140625;
    mediump int param = u_steps;
    float param_1 = u_stride;
    vec2 param_2 = vec2(cos(_131), sin(_131)) / ((u_ScreenParams.xy * 720.0) / vec2(min(u_ScreenParams.x, u_ScreenParams.y)));
    gl_FragData[0] = vec4(_f1(param, param_1, param_2), 1.0);
}

