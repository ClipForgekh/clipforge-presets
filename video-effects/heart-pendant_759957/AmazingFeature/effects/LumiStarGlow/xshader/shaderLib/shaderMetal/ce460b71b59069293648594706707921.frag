#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_noiseScale;
    float u_phaseAngle;
    float u_noiseAmplitude;
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
float _f0(thread const float& _p0)
{
    return fract(sin(_p0) * 43758.546875);
}

static inline __attribute__((always_inline))
float2x2 _f1(thread const float& _p0)
{
    float _33 = cos(_p0);
    float _36 = sin(_p0);
    return float2x2(float2(_33, -_36), float2(_36, _33));
}

static inline __attribute__((always_inline))
float _f2(thread float2& _p0, thread const float& _p1)
{
    float _t2 = 0.0;
    float _t3 = 1.0;
    float _t4 = 0.0;
    for (float _t7 = 0.0; _t7 < 4.0; _t7 += 1.0)
    {
        float2 _68 = _p0 * _t3;
        float2 _t8 = _68;
        float2 _70 = floor(_68);
        float param = _70.x + _70.y;
        float2 _83 = _t8;
        float param_1 = _f0(param) * 1000.0;
        float2 _91 = (fract(_83) - float2(0.5)) * _f1(param_1);
        _t8 = _91;
        _t2 += ((sin((_t8.x * 10.0) + _p1) * smoothstep(0.25, 0.0, dot(_91, _91))) / _t3);
        _p0 = (_p0 * float2x2(float2(0.540000021457672119140625, -0.839999973773956298828125), float2(0.839999973773956298828125, 0.540000021457672119140625))) + float2(_t7);
        _t4 += (1.0 / _t3);
        _t3 *= 1.2400000095367431640625;
    }
    return _t2 / _t4;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float2 _t11 = ((in.v_uv - float2(0.5)) * buffer.u_noiseScale) + float2(0.5);
    _t11.y = 1.0;
    float2 param = _t11;
    float param_1 = buffer.u_phaseAngle;
    float _184 = _f2(param, param_1);
    out.o_fragColor = float4(float3(((_184 * buffer.u_noiseAmplitude) * 0.5) + 0.5), 1.0);
    return out;
}

