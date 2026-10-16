#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int u_lightSource;
    int u_inverseGammaCorrection;
    float u_gamma;
    float4 u_ScreenParams;
    float u_minAngle;
    float u_maxAngle;
    float2 u_center;
    float u_intensity;
    float u_quality;
    float u_sampleScale;
    float u_sampleBias;
    float u_weightDecay;
    float u_normalizationSample;
    int u_useAngle;
    int u_displayRayOnly;
    float u_dither;
    float u_noiseIntensity;
    float u_colorDecay;
    int u_borderType;
    float u_brightness;
    float3 u_lightColor;
    float u_grayscaleCorrection;
    int u_blendMode;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

static inline __attribute__((always_inline))
float4 _f2(thread const float2& _p0, constant int& u_lightSource, texture2d<float> u_godRayTexture2, sampler u_godRayTexture2Smplr, texture2d<float> u_godRayTexture1, sampler u_godRayTexture1Smplr, constant int& u_inverseGammaCorrection, constant float& u_gamma)
{
    float4 _t0 = float4(0.0);
    if (u_lightSource == 1)
    {
        _t0 = u_godRayTexture2.sample(u_godRayTexture2Smplr, _p0);
    }
    else
    {
        _t0 = u_godRayTexture1.sample(u_godRayTexture1Smplr, _p0);
    }
    if (u_inverseGammaCorrection == 1)
    {
        float4 _130 = _t0;
        float3 _136 = pow(_130.xyz, float3(u_gamma));
        _t0.x = _136.x;
        _t0.y = _136.y;
        _t0.z = _136.z;
    }
    return _t0;
}

static inline __attribute__((always_inline))
float _f3(thread const float& _p0, thread float& _p1, thread const float& _p2, thread const float& _p3)
{
    _p1 = sign(_p1) * ((0.89999997615814208984375 * abs(_p1)) + 0.100000001490116119384765625);
    return ((_p2 * _p0) * _p1) + _p3;
}

static inline __attribute__((always_inline))
float _f4(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    return pow(pow(_p0, _p1), 1.0 / _p2);
}

static inline __attribute__((always_inline))
float _f6(thread float2& _p0, constant float4& u_ScreenParams, constant float& u_minAngle, constant float& u_maxAngle)
{
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _204 = precise::atan2(_p0.y, _p0.x);
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

static inline __attribute__((always_inline))
float _f7(thread const float& _p0, constant float& u_minAngle, constant float& u_maxAngle)
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
    float _260 = fast::min(_258, _237 * 0.5);
    _t2 = _260;
    float _264 = fast::clamp(_237 * 0.20000000298023223876953125, _260, 0.785398185253143310546875);
    float _t10 = 1.0;
    if ((_p0 <= u_minAngle) || (_p0 >= u_maxAngle))
    {
        _t10 = 0.0;
    }
    else
    {
        if ((_p0 > u_minAngle) && (_p0 < (u_minAngle + _264)))
        {
            _t10 = (_p0 - u_minAngle) / fast::max(_264, 9.9999997473787516355514526367188e-06);
        }
        else
        {
            if ((_p0 > (u_maxAngle - _264)) && (_p0 < u_maxAngle))
            {
                _t10 = (u_maxAngle - _p0) / fast::max(_264, 9.9999997473787516355514526367188e-06);
            }
        }
    }
    float _316 = _t10;
    float _317 = smoothstep(0.0, 1.0, _316);
    _t10 = _317;
    return _317;
}

static inline __attribute__((always_inline))
float _f0(thread const float& _p0, thread const float& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4)
{
    return _p3 + (((_p0 - _p1) * (_p4 - _p3)) / (_p2 - _p1));
}

static inline __attribute__((always_inline))
float _f5(thread const float2& _p0)
{
    return fract(sin(dot(_p0, float2(41.0, 289.0))) * 45758.546875);
}

static inline __attribute__((always_inline))
float _f8(thread float& _p0)
{
    _p0 = abs(_p0);
    return abs((floor(ceil(_p0) / 2.0) * 2.0) - _p0);
}

static inline __attribute__((always_inline))
float _f1(thread const float3& _p0)
{
    return dot(_p0, float3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875));
}

static inline __attribute__((always_inline))
float4 _f10(thread const float4& _p0, thread const float4& _p1)
{
    float4 _t11 = float4(0.0);
    float3 _350 = _p0.xyz + _p1.xyz;
    _t11.x = _350.x;
    _t11.y = _350.y;
    _t11.z = _350.z;
    _t11.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t11;
}

static inline __attribute__((always_inline))
float4 _f11(thread const float4& _p0, thread const float4& _p1)
{
    float4 _t12 = float4(0.0);
    float3 _376 = fast::max(_p0.xyz, _p1.xyz);
    _t12.x = _376.x;
    _t12.y = _376.y;
    _t12.z = _376.z;
    _t12.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t12;
}

static inline __attribute__((always_inline))
float4 _f12(thread const float4& _p0, thread const float4& _p1)
{
    float4 _t13 = float4(0.0);
    float3 _401 = _p0.xyz * _p1.xyz;
    _t13.x = _401.x;
    _t13.y = _401.y;
    _t13.z = _401.z;
    _t13.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t13;
}

static inline __attribute__((always_inline))
float4 _f13(thread const float4& _p0, thread const float4& _p1)
{
    float4 _t14 = float4(0.0);
    _t14.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    float _448 = _t14.w;
    float3 _451 = ((_p0.xyz * _p0.w) + (_p1.xyz * ((1.0 - _p0.w) * _p1.w))) / float3(fast::max(_448, 9.9999997473787516355514526367188e-06));
    _t14.x = _451.x;
    _t14.y = _451.y;
    _t14.z = _451.z;
    return _t14;
}

static inline __attribute__((always_inline))
float4 _f9(thread const float4& _p0, thread const float4& _p1)
{
    return float4(1.0) - ((float4(1.0) - _p0) * (float4(1.0) - _p1));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_godRayTexture2 [[texture(0)]], texture2d<float> u_godRayTexture1 [[texture(1)]], texture2d<float> u_inputTexture [[texture(2)]], sampler u_godRayTexture2Smplr [[sampler(0)]], sampler u_godRayTexture1Smplr [[sampler(1)]], sampler u_inputTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 _467 = u_inputTexture.sample(u_inputTextureSmplr, in.uv0);
    float2 param = in.uv0;
    float _t17 = 1.0;
    float _t18 = 1.0;
    float4 _t19 = _f2(param, buffer.u_lightSource, u_godRayTexture2, u_godRayTexture2Smplr, u_godRayTexture1, u_godRayTexture1Smplr, buffer.u_inverseGammaCorrection, buffer.u_gamma) * 1.0;
    float2 _t20 = in.uv0;
    float2 _489 = (in.uv0 - buffer.u_center) * buffer.u_intensity;
    float _492 = length(_489);
    float param_1 = buffer.u_quality;
    float param_2 = _492;
    float param_3 = buffer.u_sampleScale;
    float param_4 = buffer.u_sampleBias;
    float _505 = _f3(param_1, param_2, param_3, param_4);
    float _508 = fast::min(_505, 4096.0);
    float2 _513 = _489 / float2(_508);
    float param_5 = buffer.u_weightDecay;
    float param_6 = buffer.u_normalizationSample;
    float param_7 = _508;
    float _523 = _f4(param_5, param_6, param_7);
    float _t26 = 1.0;
    bool _527 = buffer.u_useAngle == 1;
    if (_527 && (_492 > 9.9999997473787516355514526367188e-06))
    {
        float2 param_8 = _489;
        float _536 = _f6(param_8, buffer.u_ScreenParams, buffer.u_minAngle, buffer.u_maxAngle);
        float param_9 = _536;
        _t26 = _f7(param_9, buffer.u_minAngle, buffer.u_maxAngle);
        if ((_536 < buffer.u_minAngle) || (_536 > buffer.u_maxAngle))
        {
            float4 _t28 = _467;
            if (buffer.u_displayRayOnly == 1)
            {
                _t28 = float4(0.0);
            }
            out.o_fragColor = _t28;
            return out;
        }
    }
    float _t29 = smoothstep(0.0, 0.100000001490116119384765625, _492);
    float _568 = buffer.u_maxAngle - buffer.u_minAngle;
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
    float _583 = fast::clamp(_582, 0.0, 1.0);
    _t29 = _583;
    float _587 = _t26 * _583;
    float _t32 = 0.0;
    bool _591 = buffer.u_dither > 9.9999997473787516355514526367188e-06;
    bool _594 = buffer.u_noiseIntensity > 9.9999997473787516355514526367188e-06;
    if (_591 || _594)
    {
        float2 param_15 = in.uv0;
        _t32 = _f5(param_15);
    }
    if (_591)
    {
        _t20 += ((_489 * (buffer.u_dither * ((_t32 * 2.0) - 1.0))) / float2(buffer.u_normalizationSample));
    }
    float _623 = 1.0 / fast::max(buffer.u_colorDecay, 9.9999997473787516355514526367188e-06);
    for (int _t35 = 1; _t35 <= 4096; _t35++)
    {
        float _636 = float(_t35);
        if (_636 > _508)
        {
            break;
        }
        _t17 *= _523;
        float2 _651 = _t20 - (_513 * _636);
        float2 _t37 = _651;
        float _662 = smoothstep(0.0, 2.0 * _623, 1.0 / fast::max(distance(_651, buffer.u_center), 9.9999997473787516355514526367188e-06));
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
            if (buffer.u_borderType == 0)
            {
                float param_16 = _t37.x;
                float _698 = _f8(param_16);
                _t37.x = _698;
                float param_17 = _t37.y;
                float _703 = _f8(param_17);
                _t37.y = _703;
                float2 param_18 = _t37;
                _t19 += (_f2(param_18, buffer.u_lightSource, u_godRayTexture2, u_godRayTexture2Smplr, u_godRayTexture1, u_godRayTexture1Smplr, buffer.u_inverseGammaCorrection, buffer.u_gamma) * (_t17 * _662));
                _t18 += _t17;
            }
            else
            {
                _t18 += _t17;
            }
        }
        else
        {
            float2 param_19 = _t37;
            _t19 += (_f2(param_19, buffer.u_lightSource, u_godRayTexture2, u_godRayTexture2Smplr, u_godRayTexture1, u_godRayTexture1Smplr, buffer.u_inverseGammaCorrection, buffer.u_gamma) * (_t17 * _662));
            _t18 += _t17;
        }
    }
    _t19 /= float4(_t18);
    if (_594)
    {
        float3 param_20 = _t19.xyz;
        float4 _769 = _t19;
        float3 _777 = float3(1.0) - ((float3(1.0) - _769.xyz) * (1.0 - (((smoothstep(0.0, 5.0 * _623, 1.0 / fast::max(distance(in.uv0, buffer.u_center), 9.9999997473787516355514526367188e-06)) * buffer.u_noiseIntensity) * _t26) * _t32)));
        _t19.x = _777.x;
        _t19.y = _777.y;
        _t19.z = _777.z;
    }
    float4 _799 = _t19;
    float4 _800 = _799 * (((11.6700000762939453125 * buffer.u_brightness) - (19.0 * pow(buffer.u_brightness, 2.0))) + (23.0 * pow(buffer.u_brightness, 3.0)));
    _t19 = _800;
    float _802 = _t19.w;
    float3 _805 = _800.xyz * _802;
    _t19.x = _805.x;
    _t19.y = _805.y;
    _t19.z = _805.z;
    float4 _815 = _t19;
    float3 _817 = _815.xyz * buffer.u_lightColor;
    _t19.x = _817.x;
    _t19.y = _817.y;
    _t19.z = _817.z;
    _t19 = fast::clamp(_t19, float4(0.0), float4(1.0));
    if (buffer.u_inverseGammaCorrection == 1)
    {
        float4 _832 = _t19;
        float3 _837 = pow(_832.xyz, float3(1.0 / buffer.u_gamma));
        _t19.x = _837.x;
        _t19.y = _837.y;
        _t19.z = _837.z;
    }
    float4 _844 = _t19;
    float3 _849 = pow(_844.xyz, float3(buffer.u_grayscaleCorrection));
    _t19.x = _849.x;
    _t19.y = _849.y;
    _t19.z = _849.z;
    if (buffer.u_weightDecay < 0.800000011920928955078125)
    {
        _t19 = mix(float4(0.0), _t19, float4(1.25 * buffer.u_weightDecay));
    }
    float4 _t44 = float4(0.0);
    bool _869 = buffer.u_displayRayOnly == 1;
    if (_869)
    {
        _t44 = _t19;
    }
    else
    {
        if (buffer.u_blendMode == 1)
        {
            float4 param_21 = _t19;
            float4 param_22 = _467;
            _t44 = _f10(param_21, param_22);
        }
        else
        {
            if (buffer.u_blendMode == 2)
            {
                float4 param_23 = _t19;
                float4 param_24 = _467;
                _t44 = _f11(param_23, param_24);
            }
            else
            {
                if (buffer.u_blendMode == 3)
                {
                    float4 param_25 = _t19;
                    float4 param_26 = _467;
                    _t44 = _f12(param_25, param_26);
                }
                else
                {
                    if (buffer.u_blendMode == 4)
                    {
                        float4 param_27 = _t19;
                        float4 param_28 = _467;
                        _t44 = _f13(param_27, param_28);
                    }
                    else
                    {
                        float4 param_29 = _t19;
                        float4 param_30 = _467;
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
            _t44 = mix(_467, _t44, float4(_587)) * _t26;
        }
        else
        {
            _t44 = mix(_467, _t44, float4(_587));
        }
    }
    out.o_fragColor = fast::clamp(_t44, float4(0.0), float4(1.0));
    return out;
}

