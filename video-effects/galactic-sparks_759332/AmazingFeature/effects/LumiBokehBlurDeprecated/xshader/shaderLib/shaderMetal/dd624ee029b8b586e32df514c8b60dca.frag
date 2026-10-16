#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float u_intensity;
    float u_angle;
    float u_scaleX;
    float u_scaleY;
    float u_quality;
    float u_regionIns;
    float u_lightIns;
    float u_baseTexWidth;
    float u_baseTexHeight;
    float u_blurSize;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float2x2 _f0(thread const float& _p0)
{
    float _35 = sin(_p0);
    float _38 = cos(_p0);
    return float2x2(float2(_38, -_35), float2(_35, _38));
}

static inline __attribute__((always_inline))
float _f1(thread const float2& _p0)
{
    return (_p0.x * _p0.x) + pow((_p0.y + 1.5) - (2.2999999523162841796875 * sqrt(abs(_p0.x))), 2.0);
}

static inline __attribute__((always_inline))
float _f2(thread const float2& _p0)
{
    float2 param = _p0;
    return step(_f1(param), 75.0);
}

static inline __attribute__((always_inline))
float4 _f3(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float& _p2, thread const float2& _p3, constant float& u_intensity, constant float& u_angle, constant float& u_scaleX, constant float& u_scaleY, constant float& u_quality, constant float& u_regionIns, constant float& u_lightIns)
{
    bool _87 = u_intensity < 0.00999999977648258209228515625;
    if (_87)
    {
        return _p0.sample(_p0Smplr, _p1);
    }
    float4 _t4 = float4(0.0);
    float4 _t6 = float4(0.0);
    float4 _t7 = float4(0.4000000059604644775390625);
    float param = u_angle;
    float2x2 _121 = _f0(param);
    float2 _134 = (float2(2.4444444179534912109375, 1.83333337306976318359375) * float2(u_scaleX, u_scaleY)) * float2(_p2);
    float2 _138 = float2(1.0) / _p3;
    float _146 = mix(2.0, 0.5, u_intensity) * mix(2.0, 1.0, u_quality);
    float _157 = fast::max(5.0, (10.0 / _146) * mix(0.699999988079071044921875, 1.0, u_quality));
    float _161 = mix(0.699999988079071044921875, 1.0, u_regionIns);
    for (float _t14 = 0.0; _t14 < 30.0; _t14 += 1.0)
    {
        if ((_t14 > _157) || (u_intensity < 0.300000011920928955078125))
        {
            break;
        }
        for (float _t15 = 0.0; _t15 < 30.0; _t15 += 1.0)
        {
            if (_t15 > _157)
            {
                break;
            }
            float2 _207 = float2(mix(-9.0, 9.0, _t14 / _157), mix(-7.0, 11.0, _t15 / _157));
            float2 _t16 = _207;
            float2 param_1 = _207;
            if (_f2(param_1) < 0.5)
            {
                continue;
            }
            float2 _216 = _t16;
            float2 _217 = _216 - float2(0.0, 1.5);
            _t16 = _217;
            float4 _232 = _p0.sample(_p0Smplr, (_p1 - ((((_217 * 0.5) * _134) * _121) * _138)));
            _t4 = fast::max(_t4, _232 * _161);
            float4 _246 = ((pow(_232, float4(9.0)) * 539.45001220703125) + float4(0.4000000059604644775390625)) * u_regionIns;
            _t6 += (_246 * _232);
            _t7 += _246;
        }
    }
    float _271 = fast::max(floor((24.0 / _146) * mix(0.300000011920928955078125, 1.0, fast::clamp(u_quality * 1.5, 0.0, 1.0))), 7.0);
    float _276 = _271 + (mod(_271, 2.0) + 1.0);
    for (float _t20 = 0.0; _t20 < 70.0; _t20 += 1.0)
    {
        if ((_t20 > _276) || _87)
        {
            break;
        }
        float _298 = _t20 / _276;
        float _t21 = _298;
        if (_298 < 0.1500000059604644775390625)
        {
            _t21 = mix(0.0, 0.0500000007450580596923828125, _t21 / 0.1500000059604644775390625);
        }
        else
        {
            if (_t21 < 0.85000002384185791015625)
            {
                _t21 = mix(0.0500000007450580596923828125, 0.949999988079071044921875, (_t21 - 0.1500000059604644775390625) / 0.699999988079071044921875);
            }
            else
            {
                _t21 = mix(0.949999988079071044921875, 1.0, (_t21 - 0.85000002384185791015625) / 0.1500000059604644775390625);
            }
        }
        float _328 = mix(-8.659999847412109375, 8.659999847412109375, _t21);
        float _332 = 75.0 - (_328 * _328);
        if (_332 < 0.0)
        {
            continue;
        }
        float4 _368 = _p0.sample(_p0Smplr, (_p1 - ((((float2(_328, ((sqrt(_332) - 1.5) + (2.2999999523162841796875 * sqrt(abs(_328)))) - 1.5) * 0.5) * _134) * _121) * _138)));
        _t4 = fast::max(_t4, _368);
        float4 _377 = (pow(_368, float4(9.0)) * 539.45001220703125) + float4(0.4000000059604644775390625);
        _t6 += (_377 * _368);
        _t7 += _377;
    }
    for (float _t27 = 0.0; _t27 < 70.0; _t27 += 1.0)
    {
        if ((_t27 > _276) || _87)
        {
            break;
        }
        float _408 = _t27 / _276;
        float _t28 = _408;
        if (_408 < 0.1500000059604644775390625)
        {
            _t28 = mix(0.0, 0.0500000007450580596923828125, _t28 / 0.1500000059604644775390625);
        }
        else
        {
            if (_t28 < 0.85000002384185791015625)
            {
                _t28 = mix(0.0500000007450580596923828125, 0.949999988079071044921875, (_t28 - 0.1500000059604644775390625) / 0.699999988079071044921875);
            }
            else
            {
                _t28 = mix(0.949999988079071044921875, 1.0, (_t28 - 0.85000002384185791015625) / 0.1500000059604644775390625);
            }
        }
        float _432 = mix(-8.659999847412109375, 8.659999847412109375, _t28);
        float _436 = 75.0 - (_432 * _432);
        if (_436 < 0.0)
        {
            continue;
        }
        float _450 = abs(_432);
        float4 _479 = _p0.sample(_p0Smplr, (_p1 - ((((float2(_432, ((((-sqrt(_436)) - 1.5) + (2.2999999523162841796875 * sqrt(_450))) + (smoothstep(1.2999999523162841796875, 0.0, _450) * 0.699999988079071044921875)) - 1.5) * 0.5) * _134) * _121) * _138)));
        _t4 = fast::max(_t4, _479);
        float4 _488 = (pow(_479, float4(9.0)) * 539.45001220703125) + float4(0.4000000059604644775390625);
        _t6 += (_488 * _479);
        _t7 += _488;
    }
    float4 _505 = fast::clamp(_t6 / _t7, float4(0.0), float4(1.0));
    return float4(mix(_505, _t4, fast::clamp(_505 * u_lightIns, float4(0.0), float4(1.0))));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.v_uv;
    float param_1 = buffer.u_blurSize;
    float2 param_2 = (float2(buffer.u_baseTexWidth, buffer.u_baseTexHeight) / float2(fast::min(buffer.u_baseTexWidth, buffer.u_baseTexHeight))) * 720.0;
    out.o_fragColor = _f3(u_inputTex, u_inputTexSmplr, param, param_1, param_2, buffer.u_intensity, buffer.u_angle, buffer.u_scaleX, buffer.u_scaleY, buffer.u_quality, buffer.u_regionIns, buffer.u_lightIns);
    return out;
}

