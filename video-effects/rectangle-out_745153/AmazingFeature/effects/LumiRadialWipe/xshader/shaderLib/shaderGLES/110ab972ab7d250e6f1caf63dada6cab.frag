precision highp float;
precision highp int;

uniform float u_rotation;
uniform mediump int u_wipeMode;
uniform vec2 u_wipeCenter;
uniform float u_progress;
uniform float u_feather;

varying vec2 v_uv;

mat2 _f0(float _p0)
{
    float _30 = cos(_p0);
    float _32 = sin(_p0);
    return mat2(vec2(_30, -_32), vec2(_32, _30));
}

vec2 _f1(vec2 _p0, float _p1, vec2 _p2)
{
    return (_f0(_p1) * (_p0 - _p2)) + _p2;
}

float _f2(vec2 _p0, vec2 _p1, float _p2, float _p3, float _p4)
{
    vec2 param = _p0;
    float param_1 = radians((-90.0) + u_rotation);
    vec2 param_2 = _p1;
    vec2 _t2 = _f1(param, param_1, param_2) - _p1;
    float _79 = atan(-_t2.y, _t2.x);
    float _85 = atan(_t2.y, _t2.x);
    float _t6 = ((_p3 * 3.1415927410125732421875) * 2.0) - 3.1415927410125732421875;
    float _t7;
    if (u_wipeMode == 0)
    {
        _t7 = _79;
    }
    else
    {
        if (u_wipeMode == 1)
        {
            _t7 = _85;
        }
        else
        {
            if (u_wipeMode == 2)
            {
                _t6 = (_p3 * 3.1415927410125732421875) - 3.1415927410125732421875;
                _t7 = min(_79, _85);
            }
        }
    }
    return mix(0.0, 1.0, step(0.0, _t7 - _t6));
}

void main()
{
    vec2 param = v_uv;
    vec2 param_1 = u_wipeCenter;
    float param_2 = u_rotation;
    float param_3 = u_progress;
    float param_4 = u_feather;
    gl_FragData[0] = vec4(_f2(param, param_1, param_2, param_3, param_4));
}

