precision highp float;
precision highp int;

uniform vec2 u_point1;
uniform float u_blend;
uniform vec2 u_point2;
uniform vec2 u_point3;
uniform vec2 u_point4;
uniform vec4 u_colorA;
uniform vec4 u_colorD;
uniform vec4 u_color1;
uniform vec4 u_color2;
uniform vec4 u_color3;
uniform vec4 u_color4;
uniform float u_scale;
uniform mediump sampler2D u_noiseTexture;
uniform float u_dithering;
uniform float u_opacity;
uniform mediump sampler2D u_inputTexture;
uniform mediump int u_blendMode;

varying vec2 v_p;
varying vec2 v_uv;

vec3 _1225;

vec4 _f0(vec2 _p0)
{
    float _101 = 1.0 / pow(length(_p0 - u_point1) + u_blend, 2.0);
    float _111 = 1.0 / pow(length(_p0 - u_point2) + u_blend, 2.0);
    float _121 = 1.0 / pow(length(_p0 - u_point3) + u_blend, 2.0);
    float _131 = 1.0 / pow(length(_p0 - u_point4) + u_blend, 2.0);
    vec4 _172 = (((((u_color1 * _101) + (u_color2 * _111)) + (u_color3 * _121)) + (u_color4 * _131)) / vec4(((_101 + _111) + _121) + _131)) - u_colorA;
    return u_colorA + (_172 * (vec4(1.0) - (pow(smoothstep(vec4(1.0 - u_scale), vec4(1.0), abs(_172) / u_colorD), vec4(1.0)) * mix(0.0, 0.5, u_scale))));
}

float _f1(float _p0, float _p1)
{
    float _203;
    if (_p0 < 0.5)
    {
        _203 = _p1 - (((1.0 - (2.0 * _p0)) * _p1) * (1.0 - _p1));
    }
    else
    {
        float _220;
        if (_p1 < 0.25)
        {
            _220 = _p1 + ((((2.0 * _p0) - 1.0) * _p1) * ((((16.0 * _p1) - 12.0) * _p1) + 3.0));
        }
        else
        {
            _220 = _p1 + (((2.0 * _p0) - 1.0) * (sqrt(_p1) - _p1));
        }
        _203 = _220;
    }
    return _203;
}

vec3 _f2(vec3 _p0, vec3 _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return vec3(_f1(param, param_1), _f1(param_2, param_3), _f1(param_4, param_5));
}

float _f3(float _p0, float _p1)
{
    float _285;
    if (_p0 < 0.5)
    {
        _285 = (2.0 * _p0) * _p1;
    }
    else
    {
        _285 = 1.0 - ((2.0 * (1.0 - _p0)) * (1.0 - _p1));
    }
    return _285;
}

vec3 _f4(vec3 _p0, vec3 _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return vec3(_f3(param, param_1), _f3(param_2, param_3), _f3(param_4, param_5));
}

float _f16(float _p0, float _p1)
{
    if (_p1 <= 0.0)
    {
        return 0.0;
    }
    if (_p0 >= 1.0)
    {
        return 1.0;
    }
    else
    {
        return min(1.0, _p1 / (1.0 - _p0));
    }
}

vec3 _f17(vec3 _p0, vec3 _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return vec3(_f16(param, param_1), _f16(param_2, param_3), _f16(param_4, param_5));
}

float _f14(float _p0, float _p1)
{
    if (_p1 >= 1.0)
    {
        return 1.0;
    }
    else
    {
        if (_p0 <= 0.0)
        {
            return 0.0;
        }
        else
        {
            return 1.0 - min(1.0, (1.0 - _p1) / _p0);
        }
    }
}

vec3 _f15(vec3 _p0, vec3 _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return vec3(_f14(param, param_1), _f14(param_2, param_3), _f14(param_4, param_5));
}

float _f8(vec3 _p0)
{
    return max(_p0.x, max(_p0.y, _p0.z)) - min(_p0.x, min(_p0.y, _p0.z));
}

vec3 _f7(inout vec3 _p0, float _p1)
{
    if (_p0.z > _p0.x)
    {
        _p0.y = ((_p0.y - _p0.x) * _p1) / (_p0.z - _p0.x);
        _p0.z = _p1;
    }
    else
    {
        _p0.y = 0.0;
        _p0.z = 0.0;
    }
    _p0.x = 0.0;
    return _p0;
}

vec3 _f9(inout vec3 _p0, float _p1)
{
    bool _455 = _p0.x <= _p0.y;
    bool _463;
    if (_455)
    {
        _463 = _p0.x <= _p0.z;
    }
    else
    {
        _463 = _455;
    }
    if (_463)
    {
        if (_p0.y <= _p0.z)
        {
            vec3 param = _p0;
            float param_1 = _p1;
            vec3 _477 = _f7(param, param_1);
            _p0 = _477;
        }
        else
        {
            vec3 param_2 = _p0.xzy;
            float param_3 = _p1;
            vec3 _484 = _f7(param_2, param_3);
            _p0 = vec3(_484.x, _484.z, _484.y);
        }
    }
    else
    {
        bool _492 = _p0.y <= _p0.x;
        bool _500;
        if (_492)
        {
            _500 = _p0.y <= _p0.z;
        }
        else
        {
            _500 = _492;
        }
        if (_500)
        {
            if (_p0.x <= _p0.z)
            {
                vec3 param_4 = _p0.yxz;
                float param_5 = _p1;
                vec3 _515 = _f7(param_4, param_5);
                _p0 = vec3(_515.y, _515.x, _515.z);
            }
            else
            {
                vec3 param_6 = _p0.yzx;
                float param_7 = _p1;
                vec3 _524 = _f7(param_6, param_7);
                _p0 = vec3(_524.z, _524.x, _524.y);
            }
        }
        else
        {
            if (_p0.x <= _p0.y)
            {
                vec3 param_8 = _p0.zxy;
                float param_9 = _p1;
                vec3 _540 = _f7(param_8, param_9);
                _p0 = vec3(_540.y, _540.z, _540.x);
            }
            else
            {
                vec3 param_10 = _p0.zyx;
                float param_11 = _p1;
                vec3 _549 = _f7(param_10, param_11);
                _p0 = vec3(_549.z, _549.y, _549.x);
            }
        }
    }
    return _p0;
}

float _f5(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

vec3 _f6(inout vec3 _p0, inout float _p1)
{
    vec3 param = _p0;
    _p0 += vec3(_p1 - _f5(param));
    vec3 param_1 = _p0;
    _p1 = _f5(param_1);
    float _356 = min(_p0.x, min(_p0.y, _p0.z));
    float _359 = _p0.x;
    float _361 = _p0.y;
    float _363 = _p0.z;
    float _365 = max(_359, max(_361, _363));
    if (_356 < 0.0)
    {
        _p0 = mix(vec3(_p1, _p1, _p1), _p0, vec3(_p1 / (_p1 - _356)));
    }
    if (_365 > 1.0)
    {
        _p0 = mix(vec3(_p1, _p1, _p1), _p0, vec3((1.0 - _p1) / (_365 - _p1)));
    }
    return _p0;
}

vec3 _f10(vec3 _p0, vec3 _p1)
{
    vec3 param = _p1;
    vec3 param_1 = _p0;
    float param_2 = _f8(param);
    vec3 _561 = _f9(param_1, param_2);
    vec3 param_3 = _p1;
    vec3 param_4 = _561;
    float param_5 = _f5(param_3);
    vec3 _567 = _f6(param_4, param_5);
    return _567;
}

vec3 _f11(vec3 _p0, vec3 _p1)
{
    vec3 param = _p0;
    vec3 param_1 = _p1;
    float param_2 = _f8(param);
    vec3 _576 = _f9(param_1, param_2);
    vec3 param_3 = _p1;
    vec3 param_4 = _576;
    float param_5 = _f5(param_3);
    vec3 _582 = _f6(param_4, param_5);
    return _582;
}

vec3 _f12(vec3 _p0, vec3 _p1)
{
    vec3 param = _p1;
    vec3 param_1 = _p0;
    float param_2 = _f5(param);
    vec3 _591 = _f6(param_1, param_2);
    return _591;
}

vec3 _f13(vec3 _p0, vec3 _p1)
{
    vec3 param = _p0;
    vec3 param_1 = _p1;
    float param_2 = _f5(param);
    vec3 _600 = _f6(param_1, param_2);
    return _600;
}

void main()
{
    vec2 param = v_p;
    vec4 _694 = _f0(param);
    vec4 _t12 = _694;
    vec3 _728 = _694.xyz + ((texture2D(u_noiseTexture, v_uv).xyz - vec3(0.5)) * (2.0 * u_dithering));
    _t12.x = _728.x;
    _t12.y = _728.y;
    _t12.z = _728.z;
    vec4 _735 = _t12;
    vec3 _739 = clamp(_735.xyz, vec3(0.0), vec3(1.0));
    _t12.x = _739.x;
    _t12.y = _739.y;
    _t12.z = _739.z;
    _t12 = vec4(_t12.xyz, u_opacity);
    mediump vec4 _758 = texture2D(u_inputTexture, v_uv);
    vec4 _t15 = _758;
    float _761 = _t15.w;
    vec3 _767 = _758.xyz / vec3(max(_761, 9.9999997473787516355514526367188e-06));
    _t15.x = _767.x;
    _t15.y = _767.y;
    _t15.z = _767.z;
    if (u_blendMode == 0)
    {
        gl_FragData[0] = (vec4(_t12.xyz, 1.0) * _t15.w) * u_opacity;
        return;
    }
    vec4 _t16 = _t15;
    if (u_blendMode == 1)
    {
        _t16.x = _t12.xyz.x;
        _t16.y = _t12.xyz.y;
        _t16.z = _t12.xyz.z;
    }
    else
    {
        if (u_blendMode == 2)
        {
            vec3 _821 = _t12.xyz + _t15.xyz;
            _t16.x = _821.x;
            _t16.y = _821.y;
            _t16.z = _821.z;
        }
        else
        {
            if (u_blendMode == 3)
            {
                vec3 _838 = _t12.xyz * _t15.xyz;
                _t16.x = _838.x;
                _t16.y = _838.y;
                _t16.z = _838.z;
            }
            else
            {
                if (u_blendMode == 4)
                {
                    vec3 _861 = (_t12.xyz + _t15.xyz) - (_t12.xyz * _t15.xyz);
                    _t16.x = _861.x;
                    _t16.y = _861.y;
                    _t16.z = _861.z;
                }
                else
                {
                    if (u_blendMode == 5)
                    {
                        float _877;
                        if (_t15.x < 0.5)
                        {
                            _877 = (2.0 * _t15.x) * _t12.x;
                        }
                        else
                        {
                            _877 = 1.0 - ((2.0 * (1.0 - _t15.x)) * (1.0 - _t12.x));
                        }
                        float _900;
                        if (_t15.y < 0.5)
                        {
                            _900 = (2.0 * _t15.y) * _t12.y;
                        }
                        else
                        {
                            _900 = 1.0 - ((2.0 * (1.0 - _t15.y)) * (1.0 - _t12.y));
                        }
                        float _923;
                        if (_t15.z < 0.5)
                        {
                            _923 = (2.0 * _t15.z) * _t12.z;
                        }
                        else
                        {
                            _923 = 1.0 - ((2.0 * (1.0 - _t15.z)) * (1.0 - _t12.z));
                        }
                        vec3 _943 = vec3(_877, _900, _923);
                        _t16.x = _943.x;
                        _t16.y = _943.y;
                        _t16.z = _943.z;
                    }
                    else
                    {
                        if (u_blendMode == 6)
                        {
                            vec3 param_1 = _t12.xyz;
                            vec3 param_2 = _t15.xyz;
                            vec3 _962 = _f2(param_1, param_2);
                            _t16.x = _962.x;
                            _t16.y = _962.y;
                            _t16.z = _962.z;
                        }
                        else
                        {
                            if (u_blendMode == 7)
                            {
                                vec3 param_3 = _t12.xyz;
                                vec3 param_4 = _t15.xyz;
                                vec3 _981 = _f4(param_3, param_4);
                                _t16.x = _981.x;
                                _t16.y = _981.y;
                                _t16.z = _981.z;
                            }
                            else
                            {
                                if (u_blendMode == 8)
                                {
                                    vec3 param_5 = _t12.xyz;
                                    vec3 param_6 = _t15.xyz;
                                    vec3 _1000 = _f17(param_5, param_6);
                                    _t16.x = _1000.x;
                                    _t16.y = _1000.y;
                                    _t16.z = _1000.z;
                                }
                                else
                                {
                                    if (u_blendMode == 9)
                                    {
                                        vec3 param_7 = _t12.xyz;
                                        vec3 param_8 = _t15.xyz;
                                        vec3 _1019 = _f15(param_7, param_8);
                                        _t16.x = _1019.x;
                                        _t16.y = _1019.y;
                                        _t16.z = _1019.z;
                                    }
                                    else
                                    {
                                        if (u_blendMode == 10)
                                        {
                                            vec3 _1036 = min(_t12.xyz, _t15.xyz);
                                            _t16.x = _1036.x;
                                            _t16.y = _1036.y;
                                            _t16.z = _1036.z;
                                        }
                                        else
                                        {
                                            if (u_blendMode == 11)
                                            {
                                                vec3 _1053 = max(_t12.xyz, _t15.xyz);
                                                _t16.x = _1053.x;
                                                _t16.y = _1053.y;
                                                _t16.z = _1053.z;
                                            }
                                            else
                                            {
                                                if (u_blendMode == 12)
                                                {
                                                    vec3 _1071 = abs(_t12.xyz - _t15.xyz);
                                                    _t16.x = _1071.x;
                                                    _t16.y = _1071.y;
                                                    _t16.z = _1071.z;
                                                }
                                                else
                                                {
                                                    if (u_blendMode == 13)
                                                    {
                                                        vec3 _1095 = (_t15.xyz + _t12.xyz) - ((_t15.xyz * 2.0) * _t12.xyz);
                                                        _t16.x = _1095.x;
                                                        _t16.y = _1095.y;
                                                        _t16.z = _1095.z;
                                                    }
                                                    else
                                                    {
                                                        if (u_blendMode == 14)
                                                        {
                                                            vec3 param_9 = _t12.xyz;
                                                            vec3 param_10 = _t15.xyz;
                                                            vec3 _1114 = _f10(param_9, param_10);
                                                            _t16.x = _1114.x;
                                                            _t16.y = _1114.y;
                                                            _t16.z = _1114.z;
                                                        }
                                                        else
                                                        {
                                                            if (u_blendMode == 15)
                                                            {
                                                                vec3 param_11 = _t12.xyz;
                                                                vec3 param_12 = _t15.xyz;
                                                                vec3 _1133 = _f11(param_11, param_12);
                                                                _t16.x = _1133.x;
                                                                _t16.y = _1133.y;
                                                                _t16.z = _1133.z;
                                                            }
                                                            else
                                                            {
                                                                if (u_blendMode == 16)
                                                                {
                                                                    vec3 param_13 = _t12.xyz;
                                                                    vec3 param_14 = _t15.xyz;
                                                                    vec3 _1152 = _f12(param_13, param_14);
                                                                    _t16.x = _1152.x;
                                                                    _t16.y = _1152.y;
                                                                    _t16.z = _1152.z;
                                                                }
                                                                else
                                                                {
                                                                    if (u_blendMode == 17)
                                                                    {
                                                                        vec3 param_15 = _t12.xyz;
                                                                        vec3 param_16 = _t15.xyz;
                                                                        vec3 _1171 = _f13(param_15, param_16);
                                                                        _t16.x = _1171.x;
                                                                        _t16.y = _1171.y;
                                                                        _t16.z = _1171.z;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    vec4 _1178 = _t15;
    float _1181 = _t15.w;
    float _1193 = _t15.w;
    float _1200 = _t15.w;
    vec3 _1205 = (((_1178.xyz * _1181) * (1.0 - _t12.w)) + ((_t12.xyz * _t12.w) * (1.0 - _1193))) + (_t16.xyz * (_t12.w * _1200));
    _t15.x = _1205.x;
    _t15.y = _1205.y;
    _t15.z = _1205.z;
    gl_FragData[0] = vec4(_t15.xyz, 1.0) * _t15.w;
}

