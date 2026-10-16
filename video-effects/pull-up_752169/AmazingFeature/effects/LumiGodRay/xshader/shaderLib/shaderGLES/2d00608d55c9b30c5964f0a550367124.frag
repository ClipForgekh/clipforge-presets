precision highp float;
precision highp int;

uniform mediump int u_lightSource;
uniform mediump sampler2D u_godRayTexture2;
uniform mediump sampler2D u_godRayTexture1;
uniform mediump int u_inverseGammaCorrection;
uniform float u_gamma;
uniform vec4 u_ScreenParams;
uniform float u_minAngle;
uniform float u_maxAngle;
uniform mediump sampler2D u_inputTexture;
uniform vec2 u_center;
uniform float u_intensity;
uniform float u_quality;
uniform float u_sampleScale;
uniform float u_sampleBias;
uniform float u_weightDecay;
uniform float u_normalizationSample;
uniform mediump int u_useAngle;
uniform mediump int u_displayRayOnly;
uniform float u_dither;
uniform float u_noiseIntensity;
uniform float u_colorDecay;
uniform mediump int u_borderType;
uniform float u_brightness;
uniform vec3 u_lightColor;
uniform float u_grayscaleCorrection;
uniform mediump int u_blendMode;

varying vec2 uv0;

vec4 _f2(vec2 _p0)
{
    vec4 _t0 = vec4(0.0);
    if (u_lightSource == 1)
    {
        _t0 = texture2D(u_godRayTexture2, _p0);
    }
    else
    {
        _t0 = texture2D(u_godRayTexture1, _p0);
    }
    if (u_inverseGammaCorrection == 1)
    {
        vec4 _130 = _t0;
        vec3 _136 = pow(_130.xyz, vec3(u_gamma));
        _t0.x = _136.x;
        _t0.y = _136.y;
        _t0.z = _136.z;
    }
    return _t0;
}

float _f3(float _p0, inout float _p1, float _p2, float _p3)
{
    _p1 = sign(_p1) * ((0.89999997615814208984375 * abs(_p1)) + 0.100000001490116119384765625);
    return ((_p2 * _p0) * _p1) + _p3;
}

float _f4(float _p0, float _p1, float _p2)
{
    return pow(pow(_p0, _p1), 1.0 / _p2);
}

float _f6(inout vec2 _p0)
{
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _204 = atan(_p0.y, _p0.x);
    float _t1 = _204;
    if (_204 < u_minAngle)
    {
        _t1 += 6.283185482025146484375;
    }
    else
    {
        if (_t1 > u_maxAngle)
        {
            _t1 -= 6.283185482025146484375;
        }
    }
    return _t1;
}

float _f7(float _p0)
{
    float _t2 = 0.1745329201221466064453125;
    float _233 = u_maxAngle - u_minAngle;
    float _t4 = _233;
    float _237;
    if (_233 < 3.1415927410125732421875)
    {
        _237 = _t4;
    }
    else
    {
        _237 = 6.283185482025146484375 - _t4;
    }
    _t4 = _237;
    float _258 = _t2;
    float _260 = min(_258, _237 * 0.5);
    _t2 = _260;
    float _264 = clamp(_237 * 0.20000000298023223876953125, _260, 0.785398185253143310546875);
    float _t10 = 1.0;
    if ((_p0 <= u_minAngle) || (_p0 >= u_maxAngle))
    {
        _t10 = 0.0;
    }
    else
    {
        if ((_p0 > u_minAngle) && (_p0 < (u_minAngle + _264)))
        {
            _t10 = (_p0 - u_minAngle) / max(_264, 9.9999997473787516355514526367188e-06);
        }
        else
        {
            if ((_p0 > (u_maxAngle - _264)) && (_p0 < u_maxAngle))
            {
                _t10 = (u_maxAngle - _p0) / max(_264, 9.9999997473787516355514526367188e-06);
            }
        }
    }
    float _316 = _t10;
    float _317 = smoothstep(0.0, 1.0, _316);
    _t10 = _317;
    return _317;
}

float _f0(float _p0, float _p1, float _p2, float _p3, float _p4)
{
    return _p3 + (((_p0 - _p1) * (_p4 - _p3)) / (_p2 - _p1));
}

float _f5(vec2 _p0)
{
    return fract(sin(dot(_p0, vec2(41.0, 289.0))) * 45758.546875);
}

float _f8(inout float _p0)
{
    _p0 = abs(_p0);
    return abs((floor(ceil(_p0) / 2.0) * 2.0) - _p0);
}

float _f1(vec3 _p0)
{
    return dot(_p0, vec3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875));
}

vec4 _f10(vec4 _p0, vec4 _p1)
{
    vec4 _t11 = vec4(0.0);
    vec3 _350 = _p0.xyz + _p1.xyz;
    _t11.x = _350.x;
    _t11.y = _350.y;
    _t11.z = _350.z;
    _t11.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t11;
}

vec4 _f11(vec4 _p0, vec4 _p1)
{
    vec4 _t12 = vec4(0.0);
    vec3 _376 = max(_p0.xyz, _p1.xyz);
    _t12.x = _376.x;
    _t12.y = _376.y;
    _t12.z = _376.z;
    _t12.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t12;
}

vec4 _f12(vec4 _p0, vec4 _p1)
{
    vec4 _t13 = vec4(0.0);
    vec3 _401 = _p0.xyz * _p1.xyz;
    _t13.x = _401.x;
    _t13.y = _401.y;
    _t13.z = _401.z;
    _t13.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t13;
}

vec4 _f13(vec4 _p0, vec4 _p1)
{
    vec4 _t14 = vec4(0.0);
    _t14.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    float _448 = _t14.w;
    vec3 _451 = ((_p0.xyz * _p0.w) + (_p1.xyz * ((1.0 - _p0.w) * _p1.w))) / vec3(max(_448, 9.9999997473787516355514526367188e-06));
    _t14.x = _451.x;
    _t14.y = _451.y;
    _t14.z = _451.z;
    return _t14;
}

vec4 _f9(vec4 _p0, vec4 _p1)
{
    return vec4(1.0) - ((vec4(1.0) - _p0) * (vec4(1.0) - _p1));
}

void main()
{
    mediump vec4 _467 = texture2D(u_inputTexture, uv0);
    vec2 param = uv0;
    float _t17 = 1.0;
    float _t18 = 1.0;
    vec4 _t19 = _f2(param) * 1.0;
    vec2 _t20 = uv0;
    vec2 _489 = (uv0 - u_center) * u_intensity;
    float _492 = length(_489);
    float param_1 = u_quality;
    float param_2 = _492;
    float param_3 = u_sampleScale;
    float param_4 = u_sampleBias;
    float _505 = _f3(param_1, param_2, param_3, param_4);
    float _508 = min(_505, 4096.0);
    vec2 _513 = _489 / vec2(_508);
    float param_5 = u_weightDecay;
    float param_6 = u_normalizationSample;
    float param_7 = _508;
    float _523 = _f4(param_5, param_6, param_7);
    float _t26 = 1.0;
    bool _527 = u_useAngle == 1;
    if (_527 && (_492 > 9.9999997473787516355514526367188e-06))
    {
        vec2 param_8 = _489;
        float _536 = _f6(param_8);
        float param_9 = _536;
        _t26 = _f7(param_9);
        if ((_536 < u_minAngle) || (_536 > u_maxAngle))
        {
            vec4 _t28 = _467;
            if (u_displayRayOnly == 1)
            {
                _t28 = vec4(0.0);
            }
            gl_FragData[0] = _t28;
            return;
        }
    }
    float _t29 = smoothstep(0.0, 0.100000001490116119384765625, _492);
    float _568 = u_maxAngle - u_minAngle;
    if (_568 > 1.57079637050628662109375)
    {
        float param_10 = _568;
        float param_11 = 1.57079637050628662109375;
        float param_12 = 3.1415927410125732421875;
        float param_13 = _t29;
        float param_14 = 1.0;
        _t29 = _f0(param_10, param_11, param_12, param_13, param_14);
    }
    float _582 = _t29;
    float _583 = clamp(_582, 0.0, 1.0);
    _t29 = _583;
    float _587 = _t26 * _583;
    float _t32 = 0.0;
    bool _591 = u_dither > 9.9999997473787516355514526367188e-06;
    bool _594 = u_noiseIntensity > 9.9999997473787516355514526367188e-06;
    if (_591 || _594)
    {
        vec2 param_15 = uv0;
        _t32 = _f5(param_15);
    }
    if (_591)
    {
        _t20 += ((_489 * (u_dither * ((_t32 * 2.0) - 1.0))) / vec2(u_normalizationSample));
    }
    float _623 = 1.0 / max(u_colorDecay, 9.9999997473787516355514526367188e-06);
    for (mediump int _t35 = 1; _t35 <= 4096; _t35++)
    {
        mediump float _636 = float(_t35);
        if (_636 > _508)
        {
            break;
        }
        _t17 *= _523;
        vec2 _651 = _t20 - (_513 * _636);
        vec2 _t37 = _651;
        float _662 = smoothstep(0.0, 2.0 * _623, 1.0 / max(distance(_651, u_center), 9.9999997473787516355514526367188e-06));
        bool _665 = _t37.x < 0.0;
        bool _672;
        if (!_665)
        {
            _672 = _t37.y < 0.0;
        }
        else
        {
            _672 = _665;
        }
        bool _679;
        if (!_672)
        {
            _679 = _t37.x > 1.0;
        }
        else
        {
            _679 = _672;
        }
        bool _686;
        if (!_679)
        {
            _686 = _t37.y > 1.0;
        }
        else
        {
            _686 = _679;
        }
        if (_686)
        {
            if (u_borderType == 0)
            {
                float param_16 = _t37.x;
                float _698 = _f8(param_16);
                _t37.x = _698;
                float param_17 = _t37.y;
                float _703 = _f8(param_17);
                _t37.y = _703;
                vec2 param_18 = _t37;
                _t19 += (_f2(param_18) * (_t17 * _662));
                _t18 += _t17;
            }
            else
            {
                _t18 += _t17;
            }
        }
        else
        {
            vec2 param_19 = _t37;
            _t19 += (_f2(param_19) * (_t17 * _662));
            _t18 += _t17;
        }
    }
    _t19 /= vec4(_t18);
    if (_594)
    {
        vec3 param_20 = _t19.xyz;
        vec4 _769 = _t19;
        vec3 _777 = vec3(1.0) - ((vec3(1.0) - _769.xyz) * (1.0 - (((smoothstep(0.0, 5.0 * _623, 1.0 / max(distance(uv0, u_center), 9.9999997473787516355514526367188e-06)) * u_noiseIntensity) * _t26) * _t32)));
        _t19.x = _777.x;
        _t19.y = _777.y;
        _t19.z = _777.z;
    }
    vec4 _799 = _t19;
    vec4 _800 = _799 * (((11.6700000762939453125 * u_brightness) - (19.0 * pow(u_brightness, 2.0))) + (23.0 * pow(u_brightness, 3.0)));
    _t19 = _800;
    float _802 = _t19.w;
    vec3 _805 = _800.xyz * _802;
    _t19.x = _805.x;
    _t19.y = _805.y;
    _t19.z = _805.z;
    vec4 _815 = _t19;
    vec3 _817 = _815.xyz * u_lightColor;
    _t19.x = _817.x;
    _t19.y = _817.y;
    _t19.z = _817.z;
    _t19 = clamp(_t19, vec4(0.0), vec4(1.0));
    if (u_inverseGammaCorrection == 1)
    {
        vec4 _832 = _t19;
        vec3 _837 = pow(_832.xyz, vec3(1.0 / u_gamma));
        _t19.x = _837.x;
        _t19.y = _837.y;
        _t19.z = _837.z;
    }
    vec4 _844 = _t19;
    vec3 _849 = pow(_844.xyz, vec3(u_grayscaleCorrection));
    _t19.x = _849.x;
    _t19.y = _849.y;
    _t19.z = _849.z;
    if (u_weightDecay < 0.800000011920928955078125)
    {
        _t19 = mix(vec4(0.0), _t19, vec4(1.25 * u_weightDecay));
    }
    vec4 _t44 = vec4(0.0);
    bool _869 = u_displayRayOnly == 1;
    if (_869)
    {
        _t44 = _t19;
    }
    else
    {
        if (u_blendMode == 1)
        {
            vec4 param_21 = _t19;
            vec4 param_22 = _467;
            _t44 = _f10(param_21, param_22);
        }
        else
        {
            if (u_blendMode == 2)
            {
                vec4 param_23 = _t19;
                vec4 param_24 = _467;
                _t44 = _f11(param_23, param_24);
            }
            else
            {
                if (u_blendMode == 3)
                {
                    vec4 param_25 = _t19;
                    vec4 param_26 = _467;
                    _t44 = _f12(param_25, param_26);
                }
                else
                {
                    if (u_blendMode == 4)
                    {
                        vec4 param_27 = _t19;
                        vec4 param_28 = _467;
                        _t44 = _f13(param_27, param_28);
                    }
                    else
                    {
                        vec4 param_29 = _t19;
                        vec4 param_30 = _467;
                        _t44 = _f9(param_29, param_30);
                    }
                }
            }
        }
    }
    if (_527)
    {
        if (_869)
        {
            _t44 = mix(_467, _t44, vec4(_587)) * _t26;
        }
        else
        {
            _t44 = mix(_467, _t44, vec4(_587));
        }
    }
    gl_FragData[0] = clamp(_t44, vec4(0.0), vec4(1.0));
}

