precision highp float;
precision highp int;

uniform float u_resistance;
uniform float u_velocity;
uniform float u_extra;
uniform float u_gravity;
uniform float u_radiusX;
uniform float u_radiusY;
uniform vec4 u_ScreenParams;
uniform float u_time;
uniform float u_longevity;
uniform float u_birthRate;
uniform float u_producerLongevity;
uniform float u_blobRandomSize;
uniform float u_blobBirthSize;
uniform float u_blobDeathSize;
uniform mediump int u_blobInfluenceInOut;
uniform float u_blobInfluence;
uniform mediump int u_animationType;
uniform vec2 u_producerPosition;
uniform float u_sdfPow;

varying vec2 v_uv;

float _f2(float _p0, float _p1)
{
    vec2 _181 = fract(vec2(_p0, _p1) * 13.5170001983642578125);
    vec2 _t5 = _181 + vec2(dot(_181, _181.yx + vec2(22.5410003662109375)));
    return fract((_t5.x + _t5.y) * _t5.y);
}

float _f3(inout float _p0)
{
    float param = _p0 + 0.23299999535083770751953125;
    float param_1 = 7.190000057220458984375;
    float _210 = _f2(param, param_1);
    float param_2 = _p0 + 0.54100000858306884765625;
    float param_3 = _210;
    _p0 = _f2(param_2, param_3);
    return _210;
}

vec4 _f5(mediump int _p0, inout float _p1, inout float _p2, float _p3)
{
    float param = _p1;
    float param_1 = 0.722999989986419677734375;
    float param_2 = float(_p0) + 1.513000011444091796875;
    float param_3 = _f2(param, param_1);
    _p1 = _f2(param_2, param_3);
    float param_4 = _p1;
    float _259 = _f3(param_4);
    _p1 = param_4;
    float param_5 = _p1;
    float _265 = _f3(param_5);
    _p1 = param_5;
    _p2 /= max(u_resistance, 0.100000001490116119384765625);
    float param_6 = _p1;
    float _278 = _f3(param_6);
    _p1 = param_6;
    float param_7 = _p1;
    float _290 = _f3(param_7);
    _p1 = param_7;
    float _296 = ((_290 - 0.5) * u_velocity) * _p3;
    float _300 = (((_278 - 0.5) * u_velocity) * u_extra) * _p3;
    return vec4((((_259 - 0.5) * u_radiusX) + (_300 * _p2)) * _p3, (((_265 - 0.5) * u_radiusY) + (_296 * _p2)) + (((0.5 * u_gravity) * _p2) * _p2), _300, _296 + (u_gravity * _p2));
}

vec4 _f6(mediump int _p0, inout float _p1, inout float _p2, float _p3)
{
    float param = _p1;
    float param_1 = 0.722999989986419677734375;
    float param_2 = float(_p0) + 1.513000011444091796875;
    float param_3 = _f2(param, param_1);
    _p1 = _f2(param_2, param_3);
    float param_4 = _p1;
    float _355 = _f3(param_4);
    _p1 = param_4;
    float param_5 = _p1;
    float _361 = _f3(param_5);
    _p1 = param_5;
    float _366 = max(u_resistance, 0.100000001490116119384765625);
    _p2 /= _366;
    float param_6 = _p1;
    float _374 = _f3(param_6);
    _p1 = param_6;
    float _383 = (((0.20000000298023223876953125 + (_374 * 0.20000000298023223876953125)) * u_velocity) * u_extra) * 2.0;
    float param_7 = _p1;
    float _388 = _f3(param_7);
    _p1 = param_7;
    float _398 = ((-(0.942477762699127197265625 + ((_388 * 3.141592502593994140625) * 0.5))) * u_velocity) * 20.0;
    float _402 = _383 * _p2;
    float param_8 = _p1;
    float _416 = _f3(param_8);
    _p1 = param_8;
    float _420 = (_398 * (_p2 - (((0.5 * _366) * _p2) * _p2))) + ((2.0 * _416) * 3.141592502593994140625);
    float _427 = cos(_420);
    float _438 = sin(_420);
    return vec4((((_355 - 0.5) * u_radiusX) + (_402 * _427)) * _p3, (((_361 - 0.5) * u_radiusY) + (_402 * _438)) + (((0.5 * u_gravity) * _p2) * _p2), ((_383 * _427) + (_402 * (((-_398) * (1.0 - (_366 * _p2))) * _438))) * _p3, ((_383 * _438) + (_402 * ((_398 * (1.0 - (_366 * _p2))) * _427))) + (u_gravity * _p2));
}

vec4 _f7(mediump int _p0, inout float _p1, inout float _p2, float _p3)
{
    float param = _p1;
    float param_1 = 0.722999989986419677734375;
    float param_2 = float(_p0) + 1.513000011444091796875;
    float param_3 = _f2(param, param_1);
    _p1 = _f2(param_2, param_3);
    float param_4 = _p1;
    float _509 = _f3(param_4);
    _p1 = param_4;
    float param_5 = _p1;
    float _515 = _f3(param_5);
    _p1 = param_5;
    _p2 /= max(u_resistance, 0.100000001490116119384765625);
    float param_6 = _p1;
    float _525 = _f3(param_6);
    _p1 = param_6;
    float _530 = (-(0.100000001490116119384765625 + _525)) * u_velocity;
    float param_7 = _p1;
    float _534 = _f3(param_7);
    _p1 = param_7;
    float _544 = ((((_534 - 0.5) * u_gravity) * _p2) * u_extra) * _p3;
    return vec4((((_509 - 0.5) * u_radiusX) + ((0.5 * _544) * _p2)) * _p3, ((_515 - 0.5) * u_radiusY) + (_530 * _p2), _544, _530);
}

vec4 _f8(mediump int _p0, inout float _p1, inout float _p2, float _p3)
{
    float param = _p1;
    float param_1 = 0.722999989986419677734375;
    float param_2 = float(_p0) + 1.513000011444091796875;
    float param_3 = _f2(param, param_1);
    _p1 = _f2(param_2, param_3);
    float param_4 = _p1;
    float _586 = _f3(param_4);
    _p1 = param_4;
    float _588 = _586 - 0.5;
    float _t34 = _588;
    if (abs(_588) < 0.001000000047497451305389404296875)
    {
        _t34 = 0.001000000047497451305389404296875;
    }
    float param_5 = _p1;
    float _599 = _f3(param_5);
    _p1 = param_5;
    float _601 = _599 - 0.5;
    float _t35 = _601;
    if (abs(_601) < 0.001000000047497451305389404296875)
    {
        _t35 = 0.001000000047497451305389404296875;
    }
    _p2 /= max(u_resistance, 0.100000001490116119384765625);
    float param_6 = _p1;
    float _615 = _f3(param_6);
    _p1 = param_6;
    float _619 = 3.141592502593994140625 * (2.75 + (_615 * 0.5));
    float _624 = sin(_p2 * _619);
    float param_7 = _p1;
    float _633 = _f3(param_7);
    _p1 = param_7;
    float param_8 = _p1;
    float _637 = _f3(param_8);
    _p1 = param_8;
    float param_9 = _p1;
    float _641 = _f3(param_9);
    _p1 = param_9;
    vec3 _t39 = vec3(_633, _637, _641);
    float _649 = (u_extra * u_velocity) * 3.0;
    float _663 = _619 * cos(_p2 * _619);
    float param_10 = _p1;
    float _688 = _f3(param_10);
    _p1 = param_10;
    float _695 = (((u_velocity * 3.0) * ((-u_gravity) * 8.0)) * ((_688 + 0.300000011920928955078125) * 0.20000000298023223876953125)) * _p2;
    return vec4(((((_t34 * u_radiusX) * sqrt(0.25 - (_t35 * _t35))) * 2.0) + (((((_649 * _624) * (_p2 + (_t39.z * 0.0500000007450580596923828125))) * _t39.x) * 0.20000000298023223876953125) * sign(_t39.y - 0.5))) * _p3, (_t35 * u_radiusY) + ((0.5 * _695) * _p2), ((((_649 * _p3) * _t39.x) * 0.20000000298023223876953125) * sign(_t39.y - 0.5)) * (((_663 * (_t39.z * 0.0500000007450580596923828125)) + _624) + (_663 * _p2)), _695);
}

vec4 _f9(mediump int _p0, inout float _p1, inout float _p2, float _p3)
{
    float param = _p1;
    float param_1 = 0.722999989986419677734375;
    float param_2 = float(_p0) + 1.513000011444091796875;
    float param_3 = _f2(param, param_1);
    _p1 = _f2(param_2, param_3);
    float param_4 = _p1;
    float _762 = _f3(param_4);
    _p1 = param_4;
    float param_5 = _p1;
    float _768 = _f3(param_5);
    _p1 = param_5;
    _p2 /= max(u_resistance, 0.100000001490116119384765625);
    float param_6 = _p1;
    float _778 = _f3(param_6);
    _p1 = param_6;
    float param_7 = _p1;
    float _789 = _f3(param_7);
    _p1 = param_7;
    float _796 = (((_789 - 0.5) * u_velocity) * 0.100000001490116119384765625) * _p3;
    float _800 = ((((_778 - 0.5) * u_velocity) * u_extra) * 0.20000000298023223876953125) * _p3;
    return vec4((((_762 - 0.5) * u_radiusX) + (_800 * _p2)) * _p3, (((_768 - 0.5) * u_radiusY) + (_796 * _p2)) + (((0.5 * u_gravity) * _p2) * _p2), _800, _796 + (u_gravity * _p2));
}

float _f1(vec2 _p0, vec2 _p1, vec2 _p2, float _p3, vec2 _p4)
{
    float _120 = length(_p4);
    float _124 = 1.0 / _120;
    vec2 _t1 = mat2(vec2(_p4.x * _124, (-_p4.y) * _124), vec2(_p4.y * _124, _p4.x * _124)) * ((_p0 - _p2) * _p1);
    _t1.x *= (1.0 / (1.0 + _120));
    return ((_t1.x * _t1.x) + (_t1.y * _t1.y)) - (_p3 * _p3);
}

float _f4(float _p0, float _p1, float _p2)
{
    float _229 = clamp(((_p1 - _p0) / _p2) + 0.5, 0.0, 1.0);
    return mix(_p1, _p0, _229) - (((_229 * (1.0 - _229)) * _p2) * 0.5);
}

float _f10(vec2 _p0, mediump int _p1)
{
    float _846 = u_ScreenParams.y / u_ScreenParams.x;
    vec2 _856 = u_ScreenParams.xy / vec2(max(u_ScreenParams.x, u_ScreenParams.y));
    if (_p1 > 0)
    {
        float _t54 = 10000.0;
        for (mediump int _t55 = 1; _t55 < 200; _t55++)
        {
            if (_t55 > _p1)
            {
                break;
            }
            float _885 = max(u_longevity, 0.001000000047497451305389404296875);
            float _892 = (u_time / _885) - (float(_t55) / u_birthRate);
            if ((_892 < 0.0) || (_892 > floor(u_producerLongevity / _885)))
            {
                continue;
            }
            float _916 = (floor(_892) * 0.352999985218048095703125) + float(_t55);
            float _t58 = _916;
            float _919 = fract(_892);
            float _t60 = 0.0;
            float param = _916;
            float _924 = _f3(param);
            _t58 = param;
            float _930 = 1.0 + ((_924 - 0.5) * u_blobRandomSize);
            float _935 = u_blobBirthSize * _930;
            float _940 = u_blobDeathSize * _930;
            if (u_blobInfluenceInOut == 0)
            {
                float param_1 = _t58;
                float _952 = _f3(param_1);
                _t58 = param_1;
                _t60 = (mix(_935, _940, pow(_919, 0.5 + _952)) * u_blobInfluence) * 0.100000001490116119384765625;
            }
            else
            {
                if (_919 < 0.100000001490116119384765625)
                {
                    float param_2 = _t58;
                    float _972 = _f3(param_2);
                    _t58 = param_2;
                    _t60 = (mix(0.0, _935, pow(_919 * 10.0, 0.5 + _972)) * u_blobInfluence) * 0.100000001490116119384765625;
                }
                else
                {
                    if (_919 < 0.89999997615814208984375)
                    {
                        float param_3 = _t58;
                        float _994 = _f3(param_3);
                        _t58 = param_3;
                        _t60 = (mix(_935, _940, pow((_919 - 0.100000001490116119384765625) / 0.800000011920928955078125, 0.5 + _994)) * u_blobInfluence) * 0.100000001490116119384765625;
                    }
                    else
                    {
                        float param_4 = _t58;
                        float _1009 = _f3(param_4);
                        _t58 = param_4;
                        _t60 = (mix(_940, 0.0, pow((_919 - 0.89999997615814208984375) * 10.0, 0.5 + _1009)) * u_blobInfluence) * 0.100000001490116119384765625;
                    }
                }
            }
            vec4 _t64 = vec4(0.0);
            if (u_animationType == 0)
            {
                mediump int param_5 = _t55;
                float param_6 = _t58;
                float param_7 = _919;
                float param_8 = _846;
                vec4 _1033 = _f5(param_5, param_6, param_7, param_8);
                _t64 = _1033;
            }
            else
            {
                if (u_animationType == 1)
                {
                    mediump int param_9 = _t55;
                    float param_10 = _t58;
                    float param_11 = _919;
                    float param_12 = _846;
                    vec4 _1047 = _f6(param_9, param_10, param_11, param_12);
                    _t64 = _1047;
                }
                else
                {
                    if (u_animationType == 2)
                    {
                        mediump int param_13 = _t55;
                        float param_14 = _t58;
                        float param_15 = _919;
                        float param_16 = _846;
                        vec4 _1062 = _f7(param_13, param_14, param_15, param_16);
                        _t64 = _1062;
                    }
                    else
                    {
                        if (u_animationType == 3)
                        {
                            mediump int param_17 = _t55;
                            float param_18 = _t58;
                            float param_19 = _919;
                            float param_20 = _846;
                            vec4 _1077 = _f8(param_17, param_18, param_19, param_20);
                            _t64 = _1077;
                        }
                        else
                        {
                            if (u_animationType == 4)
                            {
                                mediump int param_21 = _t55;
                                float param_22 = _t58;
                                float param_23 = _919;
                                float param_24 = _846;
                                vec4 _1092 = _f9(param_21, param_22, param_23, param_24);
                                _t64 = _1092;
                            }
                        }
                    }
                }
            }
            vec2 param_25 = _p0;
            vec2 param_26 = _856;
            vec2 param_27 = u_producerPosition - _t64.xy;
            float param_28 = _t60;
            vec2 param_29 = _t64.zw * 0.5;
            float param_30 = _t54;
            float param_31 = (_f1(param_25, param_26, param_27, param_28, param_29) * 1.0) / ((_t60 * _t60) + 9.9999997473787516355514526367188e-05);
            float param_32 = u_blobInfluence * 3.0;
            _t54 = _f4(param_30, param_31, param_32);
        }
        return _t54;
    }
    return 0.0;
}

vec3 _f0(inout float _p0)
{
    vec3 _t0 = vec3(0.0);
    _p0 *= 255.0;
    _t0.x = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.y = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.z = floor(_p0) / 255.0;
    return _t0;
}

void main()
{
    vec2 param = v_uv;
    mediump int param_1 = int(min(min(u_time, max(u_longevity, 0.001000000047497451305389404296875)) * u_birthRate, 200.0));
    float _1157 = pow(clamp((-_f10(param, param_1)) * 0.20000000298023223876953125, 0.0, 1.0), u_sdfPow);
    float param_2 = _1157;
    vec3 _1162 = _f0(param_2);
    gl_FragData[0] = vec4(_1162, smoothstep(0.0, 0.100000001490116119384765625, _1157));
}

