#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_inCornerPosition;
    float2 u_inFoldPosition;
    float u_foldRadius;
    float u_classicUi;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv0 [[user(locn0)]];
};

static inline __attribute__((always_inline))
float3 getLineFrom2Pts(thread const float2& p1, thread const float2& p2)
{
    return float3(p1.y - p2.y, p2.x - p1.x, fma(p1.x, p2.y, -(p1.y * p2.x)));
}

static inline __attribute__((always_inline))
float4 getParallelLineFromDistance(thread const float3& line, thread const float& dist)
{
    float _238 = sqrt(fma(line.x, line.x, line.y * line.y));
    return float4(line.x, line.y, fma(dist, _238, line.z), fma(-dist, _238, line.z));
}

static inline __attribute__((always_inline))
float crossProduct(thread const float2& a, thread const float2& b)
{
    return fma(a.x, b.y, -(a.y * b.x));
}

static inline __attribute__((always_inline))
float distancePtToLine(thread const float2& pt, thread const float3& line)
{
    return abs(fma(line.x, pt.x, line.y * pt.y) + line.z) / sqrt(fma(line.x, line.x, line.y * line.y));
}

static inline __attribute__((always_inline))
float cut(thread const float2& u)
{
    return ((step(0.0, u.x) * step(u.x, 1.0)) * step(0.0, u.y)) * step(u.y, 1.0);
}

static inline __attribute__((always_inline))
float2 symmetryPtByLine(thread const float2& pt, thread const float3& line)
{
    float _130 = line.y * line.y;
    float _155 = fma(line.x, line.x, _130);
    return float2(fma(fma(line.y, line.y, -(line.x * line.x)), pt.x, -((2.0 * line.x) * fma(line.y, pt.y, line.z))) / _155, fma(fma(line.x, line.x, -_130), pt.y, -((2.0 * line.y) * fma(line.x, pt.x, line.z))) / _155);
}

static inline __attribute__((always_inline))
void cylinderMapping(thread const float2& i_uv, thread const float2& cornerPos, thread const float2& foldPos, thread const float& foldRadius, thread const float& classicUi, thread float4& io_res, texture2d<float> u_backTex, sampler u_backTexSmplr, texture2d<float> u_frontTex, sampler u_frontTexSmplr)
{
    float _266 = foldPos.x + 9.9999999392252902907785028219223e-09;
    float _269 = foldPos.y + 9.9999999392252902907785028219223e-09;
    float2 _270 = float2(_266, _269);
    float2 _749;
    if (cornerPos.y >= 1.0)
    {
        float2 _699 = cornerPos;
        _699.y = fast::max(foldPos.y + 0.001000010059215128421783447265625, cornerPos.y);
        _749 = _699;
    }
    else
    {
        _749 = cornerPos;
    }
    float2 _750;
    if (_749.y <= 0.0)
    {
        float2 _704 = _749;
        _704.y = fast::min(foldPos.y + (-0.000999990035779774188995361328125), _749.y);
        _750 = _704;
    }
    else
    {
        _750 = _749;
    }
    float2 _751;
    if (_750.x >= 1.0)
    {
        float2 _709 = _750;
        _709.x = fast::max(foldPos.x + 0.001000010059215128421783447265625, _750.x);
        _751 = _709;
    }
    else
    {
        _751 = _750;
    }
    float2 _752;
    if (_751.x <= 0.0)
    {
        float2 _714 = _751;
        _714.x = fast::min(foldPos.x + (-0.000999990035779774188995361328125), _751.x);
        _752 = _714;
    }
    else
    {
        _752 = _751;
    }
    float _323 = fast::max(foldRadius, 9.9999999392252902907785028219223e-09);
    float2 _334 = (_752 + _270) * 0.5;
    float _339 = _323 * 1.57079637050628662109375;
    float2 param = _752;
    float2 param_1 = _270;
    float3 _345 = getLineFrom2Pts(param, param_1);
    float _348 = _345.y;
    float _350 = _345.x;
    float _351 = -_350;
    float _371 = sign(_348 / (9.9999999392252902907785028219223e-09 - _350));
    float3 _389 = float3(_348, _351, fma(_350, _334.y, -(_348 * _334.x)));
    float3 _753;
    if (classicUi > 0.5)
    {
        float3 param_2 = _389;
        float param_3 = 0.0;
        _753 = getParallelLineFromDistance(param_2, param_3).xyw;
    }
    else
    {
        _753 = float3(_348, _351, fma(_350, _269, -(_348 * _266)));
    }
    float3 param_4 = _389;
    float param_5 = _339;
    float4 _404 = getParallelLineFromDistance(param_4, param_5);
    float3 _405 = _404.xyw;
    float3 param_6 = _405;
    float param_7 = _323;
    float3 _754;
    float _765;
    if (_371 < 0.0)
    {
        bool _423 = (_753.z - _404.w) > 0.0;
        float3 _755;
        if (_423)
        {
            float3 _733 = _405;
            _733.z = _753.z;
            float3 param_8 = _733;
            float param_9 = _323;
            _755 = _733;
        }
        else
        {
            _755 = _405;
        }
        _765 = float(_423);
        _754 = _755;
    }
    else
    {
        bool _441 = (_404.w - _753.z) < 0.0;
        float3 _756;
        if (_441)
        {
            float3 _738 = _405;
            _738.z = _753.z;
            float3 param_10 = _738;
            float param_11 = _323;
            _756 = _738;
        }
        else
        {
            _756 = _405;
        }
        _765 = float(_441);
        _754 = _756;
    }
    float _456 = -_754.z;
    float2 _469 = float2(fma(-_754.y, _752.y, _456) / (_754.x + 9.9999999392252902907785028219223e-09), _752.y);
    float2 _486 = float2(_752.x, fma(-_754.x, _752.x, _456) / (_754.y + 9.9999999392252902907785028219223e-09));
    bool2 _788 = bool2(_371 > 0.0);
    float2 _791 = select(_469, _486, _788);
    float2 param_12 = _791 - select(_486, _469, _788);
    float2 param_13 = _791 - i_uv;
    float _506 = float(crossProduct(param_12, param_13) > 0.0);
    float2 param_14 = i_uv;
    float3 param_15 = _754;
    float _512 = distancePtToLine(param_14, param_15);
    float _521 = step(_512, _323 + 0.001000000047497451305389404296875);
    float2 _542 = fast::clamp(i_uv + (fast::normalize(-fast::normalize(_270 - _752)) * fma(asin(_512 / _323) * _521, _323, -_512)), float2(-10.0), float2(10.0));
    float2 param_16 = _542;
    float4 _560 = u_backTex.sample(u_backTexSmplr, mix(_542 * cut(param_16), i_uv, float2(_506)));
    float2 param_17 = _542;
    float4 _568 = _560 * fast::clamp(_506 + cut(param_17), 0.0, 1.0);
    float4 _578 = _568 * step(_512, _323 + 9.9999997473787516355514526367188e-05);
    float3 _768;
    if (_765 > 0.5)
    {
        float3 param_18 = _754;
        float param_19 = _339;
        _768 = getParallelLineFromDistance(param_18, param_19).xyz;
    }
    else
    {
        _768 = _389;
    }
    float2 param_20 = i_uv;
    float3 param_21 = _768;
    float2 _606 = symmetryPtByLine(param_20, param_21);
    float2 param_22 = _606;
    float2 param_23 = _542;
    float3 param_24 = _768;
    float2 _618 = symmetryPtByLine(param_23, param_24);
    float2 param_25 = _618;
    float _625 = cut(param_25) * (1.0 - _506);
    io_res = mix(u_frontTex.sample(u_frontTexSmplr, mix(_606, _618, float2(_625 * _521))) * fast::clamp(fma(_625, _521, _506 * cut(param_22)), 0.0, 1.0), io_res, float4(io_res.w));
    io_res = mix(mix(_568 * _506, _578, float4(_578.w)), io_res, float4(io_res.w));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_backTex [[texture(0)]], texture2d<float> u_frontTex [[texture(1)]], sampler u_backTexSmplr [[sampler(0)]], sampler u_frontTexSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 param = in.v_uv0;
    float2 param_1 = buffer.u_inCornerPosition;
    float2 param_2 = buffer.u_inFoldPosition;
    float param_3 = buffer.u_foldRadius;
    float param_4 = buffer.u_classicUi;
    float4 param_5 = float4(0.0);
    cylinderMapping(param, param_1, param_2, param_3, param_4, param_5, u_backTex, u_backTexSmplr, u_frontTex, u_frontTexSmplr);
    float2 param_6 = in.v_uv0;
    out.o_fragColor = param_5 * cut(param_6);
    return out;
}

