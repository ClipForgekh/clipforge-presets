#version 300 es

uniform vec4 u_ScreenParams;
uniform float u_instanceNumber;
uniform mediump sampler2D u_inputTexture;
uniform int u_twistAxis;
uniform float u_twistAngle;
uniform mat4 u_MVP;

out vec2 v_uv;
layout(location = 1) in vec2 a_texcoord0;
layout(location = 0) in vec2 a_position;
out vec4 screenPos;

float _f0(vec3 _p0)
{
    return ((_p0.x * 0.2989999949932098388671875) + (_p0.y * 0.58700001239776611328125)) + (_p0.z * 0.114000000059604644775390625);
}

vec2 _f1(float _p0, vec2 _p1)
{
    float _46 = (_p0 * 3.141592502593994140625) / 180.0;
    float _51 = cos(_46);
    float _53 = sin(_46);
    return _p1 * mat2(vec2(_51, -_53), vec2(_53, _51));
}

void main()
{
    float _86 = 1.0 / u_instanceNumber;
    vec2 _98 = a_texcoord0 * vec2(_86, 1.0);
    float _114 = (float(gl_InstanceID) - (u_instanceNumber / 2.0)) + 0.5;
    v_uv = ((_98 + vec2(1.0)) / vec2(2.0)) + vec2(_86 * _114, 0.0);
    vec3 param = textureLod(u_inputTexture, v_uv, 0.0).xyz;
    vec2 _t9 = a_position;
    _t9.x = (_114 * _86) * 2.0;
    vec3 _t12 = vec3(_t9 + _98, 0.0);
    float _163 = u_ScreenParams.y / u_ScreenParams.x;
    bool _166 = _163 > 1.0;
    if (_166)
    {
        _t12.x /= _163;
    }
    else
    {
        _t12.y /= _163;
    }
    bool _184 = u_twistAxis == 0;
    if (_184)
    {
        float param_1 = 0.0;
        vec2 param_2 = _t12.xy;
        vec2 _191 = _f1(param_1, param_2);
        _t12.x = _191.x;
        _t12.y = _191.y;
    }
    else
    {
        if (u_twistAxis == 1)
        {
            float param_3 = 90.0;
            vec2 param_4 = _t12.xy;
            vec2 _207 = _f1(param_3, param_4);
            _t12.x = _207.x;
            _t12.y = _207.y;
        }
        else
        {
            if (u_twistAxis == 2)
            {
                float param_5 = 90.0;
                vec2 param_6 = _t12.yz;
                vec2 _222 = _f1(param_5, param_6);
                _t12.y = _222.x;
                _t12.z = _222.y;
                float param_7 = -90.0;
                vec2 param_8 = _t12.xy;
                vec2 _232 = _f1(param_7, param_8);
                _t12.x = _232.x;
                _t12.y = _232.y;
            }
            else
            {
                if (u_twistAxis == 3)
                {
                    float param_9 = 45.0;
                    vec2 param_10 = _t12.xy;
                    vec2 _248 = _f1(param_9, param_10);
                    _t12.x = _248.x;
                    _t12.y = _248.y;
                }
                else
                {
                    if (u_twistAxis == 4)
                    {
                        float param_11 = 45.0;
                        vec2 param_12 = _t12.xz;
                        vec2 _263 = _f1(param_11, param_12);
                        _t12.x = _263.x;
                        _t12.z = _263.y;
                    }
                    else
                    {
                        if (u_twistAxis == 5)
                        {
                            float param_13 = 90.0;
                            vec2 param_14 = _t12.xy;
                            vec2 _278 = _f1(param_13, param_14);
                            _t12.x = _278.x;
                            _t12.y = _278.y;
                            float param_15 = 45.0;
                            vec2 param_16 = _t12.xz;
                            vec2 _287 = _f1(param_15, param_16);
                            _t12.x = _287.x;
                            _t12.z = _287.y;
                        }
                        else
                        {
                            if (u_twistAxis == 6)
                            {
                                float param_17 = 45.0;
                                vec2 param_18 = _t12.xy;
                                vec2 _302 = _f1(param_17, param_18);
                                _t12.x = _302.x;
                                _t12.y = _302.y;
                                float param_19 = 45.0;
                                vec2 param_20 = _t12.xz;
                                vec2 _311 = _f1(param_19, param_20);
                                _t12.x = _311.x;
                                _t12.z = _311.y;
                            }
                        }
                    }
                }
            }
        }
    }
    vec2 _321 = vec2(_t12.yz);
    vec2 _t14 = _321;
    float param_21 = u_twistAngle * (1.0 - _f0(param));
    vec2 param_22 = _321;
    _t14 = _f1(param_21, param_22);
    _t12 = vec3(_t12.x, _t14.x, _t14.y);
    if (_184)
    {
        float param_23 = -0.0;
        vec2 param_24 = _t12.xy;
        vec2 _347 = _f1(param_23, param_24);
        _t12.x = _347.x;
        _t12.y = _347.y;
    }
    else
    {
        if (u_twistAxis == 1)
        {
            float param_25 = -90.0;
            vec2 param_26 = _t12.xy;
            vec2 _361 = _f1(param_25, param_26);
            _t12.x = _361.x;
            _t12.y = _361.y;
        }
        else
        {
            if (u_twistAxis == 2)
            {
                float param_27 = 90.0;
                vec2 param_28 = _t12.xy;
                vec2 _375 = _f1(param_27, param_28);
                _t12.x = _375.x;
                _t12.y = _375.y;
                float param_29 = -90.0;
                vec2 param_30 = _t12.yz;
                vec2 _384 = _f1(param_29, param_30);
                _t12.y = _384.x;
                _t12.z = _384.y;
            }
            else
            {
                if (u_twistAxis == 3)
                {
                    float param_31 = -45.0;
                    vec2 param_32 = _t12.xy;
                    vec2 _399 = _f1(param_31, param_32);
                    _t12.x = _399.x;
                    _t12.y = _399.y;
                }
                else
                {
                    if (u_twistAxis == 4)
                    {
                        float param_33 = -45.0;
                        vec2 param_34 = _t12.xz;
                        vec2 _413 = _f1(param_33, param_34);
                        _t12.x = _413.x;
                        _t12.z = _413.y;
                    }
                    else
                    {
                        if (u_twistAxis == 5)
                        {
                            float param_35 = -45.0;
                            vec2 param_36 = _t12.xz;
                            vec2 _427 = _f1(param_35, param_36);
                            _t12.x = _427.x;
                            _t12.z = _427.y;
                            float param_37 = -90.0;
                            vec2 param_38 = _t12.xy;
                            vec2 _436 = _f1(param_37, param_38);
                            _t12.x = _436.x;
                            _t12.y = _436.y;
                        }
                        else
                        {
                            if (u_twistAxis == 6)
                            {
                                float param_39 = -45.0;
                                vec2 param_40 = _t12.xz;
                                vec2 _450 = _f1(param_39, param_40);
                                _t12.x = _450.x;
                                _t12.z = _450.y;
                                float param_41 = -45.0;
                                vec2 param_42 = _t12.xy;
                                vec2 _459 = _f1(param_41, param_42);
                                _t12.x = _459.x;
                                _t12.y = _459.y;
                            }
                        }
                    }
                }
            }
        }
    }
    if (_166)
    {
        _t12.x *= _163;
    }
    else
    {
        _t12.y *= _163;
    }
    vec4 _493 = u_MVP * vec4(_t12.xy, _t12.z * 6.0, 1.0);
    vec4 _t15 = _493;
    gl_Position = _493;
    screenPos = vec4(a_position, _t15.z, 1.0);
}

