precision highp float;
precision highp int;

uniform float u_rotation;
uniform mediump int u_wipeMode;
uniform vec2 u_center;
uniform vec2 u_wh;
uniform vec2 u_wipeCenter;
uniform mediump int u_maskType;
uniform float u_time;
uniform float u_feather;
uniform mediump sampler2D u_inputTexture2;

varying vec2 v_uv;

mat2 _f0(float _p0)
{
    float _56 = cos(_p0);
    float _58 = sin(_p0);
    return mat2(vec2(_56, -_58), vec2(_58, _56));
}

vec2 _f1(vec2 _p0, float _p1)
{
    return ((_p0 - vec2(0.5)) * _f0(_p1)) + vec2(0.5);
}

vec4 _f4(vec2 _p0, inout float _p1, float _p2, float _p3)
{
    _p1 *= (1.0 + _p3);
    vec2 param = _p0;
    float param_1 = radians(_p2);
    vec2 _t10 = _f1(param, param_1);
    return vec4(0.0, 0.0, 0.0, mix(0.0, 1.0, smoothstep(_p1 - _p3, _p1 + _p3, _t10.y)));
}

vec4 _f5(vec2 _p0, vec2 _p1, float _p2, float _p3, float _p4)
{
    float _205 = distance(_p0, _p1);
    float _209 = min(_205, _p3);
    float _218 = smoothstep(_p2 + _209, _p2 - _209, _205);
    return vec4(0.0, 0.0, 0.0, 1.0 - mix(_218, 1.0 - _218, _p4));
}

vec4 _f6(vec2 _p0, inout float _p1, float _p2, float _p3)
{
    _p1 = (-_p1) / 2.0;
    vec2 param = _p0;
    float param_1 = _p3;
    vec2 _240 = _f1(param, param_1);
    vec2 _t17 = _240 + vec2(0.0, _p1);
    vec2 _t18 = _240 - vec2(0.0, _p1);
    return clamp(vec4(0.0, 0.0, 0.0, 1.0) * (smoothstep(0.5 - _p2, 0.5 + _p2, _t17.y) + (1.0 - smoothstep(0.5 - _p2, 0.5 + _p2, _t18.y))), vec4(0.0), vec4(1.0));
}

vec2 _f2(vec2 _p0, float _p1, vec2 _p2)
{
    return (_f0(_p1) * (_p0 - _p2)) + _p2;
}

vec4 _f3(vec2 _p0, vec2 _p1, float _p2, float _p3, float _p4)
{
    vec2 param = _p0;
    float param_1 = radians((-90.0) + u_rotation);
    vec2 param_2 = _p1;
    vec2 _t3 = _f2(param, param_1, param_2) - _p1;
    float _119 = atan(-_t3.y, _t3.x);
    float _125 = atan(_t3.y, _t3.x);
    float _t7 = ((_p3 * 3.1415927410125732421875) * 2.0) - 3.1415927410125732421875;
    float _t8;
    if (u_wipeMode == 0)
    {
        _t8 = _119;
    }
    else
    {
        if (u_wipeMode == 1)
        {
            _t8 = _125;
        }
        else
        {
            if (u_wipeMode == 2)
            {
                _t7 = (_p3 * 3.1415927410125732421875) - 3.1415927410125732421875;
                _t8 = min(_119, _125);
            }
        }
    }
    return vec4(0.0, 0.0, 0.0, smoothstep(_t7 - _p4, _t7, _t8));
}

void main()
{
    vec2 _t24 = u_center;
    _t24.y = 1.0 - _t24.y;
    _t24 -= vec2(0.5);
    float _309 = u_wh.x / u_wh.y;
    _t24.y /= _309;
    _t24 += vec2(0.5);
    vec2 _t25 = u_wipeCenter - vec2(0.5);
    _t25.y /= _309;
    _t25 += vec2(0.5);
    vec2 _t22 = vec2(v_uv.x, 1.0 - v_uv.y) - vec2(0.5);
    _t22.y /= _309;
    _t22 += vec2(0.5);
    vec4 _t26 = vec4(0.0);
    if (u_maskType == 0)
    {
        vec2 param = v_uv;
        float param_1 = (u_time * 2.0) - 0.5;
        float param_2 = u_rotation * 360.0;
        float param_3 = u_feather;
        vec4 _370 = _f4(param, param_1, param_2, param_3);
        _t26 = _370;
    }
    else
    {
        if (u_maskType == 1)
        {
            vec2 param_4 = _t22;
            vec2 param_5 = _t24;
            float param_6 = u_time * 1.0499999523162841796875;
            float param_7 = (u_feather * max(u_wh.x, u_wh.y)) / 720.0;
            float param_8 = 0.0;
            _t26 = _f5(param_4, param_5, param_6, param_7, param_8);
        }
        else
        {
            if (u_maskType == 2)
            {
                vec2 param_9 = v_uv;
                float param_10 = (u_time * 2.0) - 0.5;
                float param_11 = u_feather;
                float param_12 = u_rotation * 3.141592502593994140625;
                vec4 _413 = _f6(param_9, param_10, param_11, param_12);
                _t26 = _413;
            }
            else
            {
                if (u_maskType == 3)
                {
                    vec2 param_13 = _t22;
                    vec2 param_14 = _t25;
                    float param_15 = u_rotation * 360.0;
                    float param_16 = (u_time * 2.0) - 0.5;
                    float param_17 = u_feather;
                    _t26 = _f3(param_13, param_14, param_15, param_16, param_17);
                }
                else
                {
                    _t26 = vec4(0.0);
                }
            }
        }
    }
    vec4 _t27 = texture2D(u_inputTexture2, _t22);
    gl_FragData[0] = _t26 * (1.0 - smoothstep(0.5, 0.89999997615814208984375, _t27.x));
}

