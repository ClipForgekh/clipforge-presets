#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    spvUnsafeArray<float2, 110> u_controlPoints;
    float u_xCount;
    float u_yCount;
};

struct main0_out
{
    float2 v_uv [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

static inline __attribute__((always_inline))
float2 _f0(thread const int& _p0, constant spvUnsafeArray<float2, 110>& u_controlPoints)
{
    float2 _t0 = float2(0.0);
    for (int _t1 = 0; _t1 < 110; _t1++)
    {
        if (_p0 == _t1)
        {
            _t0 = u_controlPoints[_t1];
            break;
        }
    }
    return _t0;
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float2& _p1, thread const float2& _p2, thread const float2& _p3, thread const float& _p4)
{
    float2 _91 = mix(_p1, _p2, float2(_p4));
    return mix(mix(mix(_p0, _p1, float2(_p4)), _91, float2(_p4)), mix(_91, mix(_p2, _p3, float2(_p4)), float2(_p4)), float2(_p4));
}

static inline __attribute__((always_inline))
float4 _f2(thread const float2& _p0, thread const float2& _p1, thread const float2& _p2, thread const float2& _p3, thread const float2& _p4, thread const float2& _p5, thread const float2& _p6, thread const float2& _p7, thread const float2& _p8, thread const float2& _p9, thread const float2& _p10, thread const float2& _p11, thread const float2& _p12, thread const float2& _p13, thread const float2& _p14, thread const float2& _p15, thread const float2& _p16)
{
    float2 param = _p13;
    float2 param_1 = _p14;
    float2 param_2 = _p15;
    float2 param_3 = _p16;
    float param_4 = _p0.y;
    float2 _130 = _f1(param, param_1, param_2, param_3, param_4);
    float2 _t7 = _130;
    float2 param_5 = _p9;
    float2 param_6 = _p10;
    float2 param_7 = _p11;
    float2 param_8 = _p12;
    float param_9 = _p0.y;
    float2 _143 = _f1(param_5, param_6, param_7, param_8, param_9);
    float2 _t8 = _143;
    float2 _t9 = smoothstep(float2(0.0), float2(1.0), _p0.yy);
    float2 _183 = float2(mix(-mix(_p1.x, _p5.x, _t9.y), 1.0 - mix(_p4.x, _p8.x, _t9.y), _p0.x) + mix(_t8.x, _t7.x - 1.0, _p0.x), 0.0);
    float2 param_10 = _143;
    float2 param_11 = mix(_p2, _p6, float2(_t9.y, _p0.y)) + _183;
    float2 param_12 = mix(_p3, _p7, float2(_t9.y, _p0.y)) + _183;
    float2 param_13 = _130;
    float param_14 = _p0.x;
    float2 param_15 = _p5;
    float2 param_16 = _p6;
    float2 param_17 = _p7;
    float2 param_18 = _p8;
    float param_19 = _p0.x;
    float2 _235 = _f1(param_15, param_16, param_17, param_18, param_19);
    float2 _t17 = _235;
    float2 param_20 = _p1;
    float2 param_21 = _p2;
    float2 param_22 = _p3;
    float2 param_23 = _p4;
    float param_24 = _p0.x;
    float2 _248 = _f1(param_20, param_21, param_22, param_23, param_24);
    float2 _t18 = _248;
    float2 _t19 = smoothstep(float2(0.0), float2(1.0), _p0.xx);
    float2 _286 = float2(0.0, mix(-mix(_p9.y, _p13.y, _t19.x), 1.0 - mix(_p12.y, _p16.y, _t19.x), _p0.y) + mix(_t18.y, _t17.y - 1.0, _p0.y));
    float2 param_25 = _248;
    float2 param_26 = mix(_p10, _p14, float2(_p0.x, _t19.x)) + _286;
    float2 param_27 = mix(_p11, _p15, float2(_p0.x, _t19.x)) + _286;
    float2 param_28 = _235;
    float param_29 = _p0.y;
    return float4(_f1(param_10, param_11, param_12, param_13, param_14), _f1(param_25, param_26, param_27, param_28, param_29));
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float2 _t27 = (in.a_position.xy * 0.5) + float2(0.5);
    float _351 = buffer.u_xCount - 1.0;
    float _357 = fast::min(floor(_t27.x * _351), buffer.u_xCount - 2.0);
    float _360 = _t27.y;
    float _363 = buffer.u_yCount - 1.0;
    float _368 = fast::min(floor(_360 * _363), buffer.u_yCount - 2.0);
    int _375 = int((_357 * buffer.u_yCount) + _368);
    int _383 = _375 + int(buffer.u_yCount);
    int _390 = _375 * 5;
    int _391 = _390 + 0;
    int param = _391;
    int param_1 = _390 + 2;
    int _403 = _383 * 5;
    int param_2 = _403 + 4;
    int _411 = _403 + 0;
    int param_3 = _411;
    int _416 = (_375 + 1) * 5;
    int _417 = _416 + 0;
    int param_4 = _417;
    int param_5 = _416 + 2;
    int _428 = (_383 + 1) * 5;
    int param_6 = _428 + 4;
    int _435 = _428 + 0;
    int param_7 = _435;
    int param_8 = _391;
    int param_9 = _390 + 3;
    int param_10 = _416 + 1;
    int param_11 = _417;
    int param_12 = _411;
    int param_13 = _403 + 3;
    int param_14 = _428 + 1;
    int param_15 = _435;
    _t27.x = (_t27.x - (_357 / _351)) * _351;
    _t27.y = (_t27.y - (_368 / _363)) * _363;
    float2 param_16 = _t27;
    float2 param_17 = _f0(param, buffer.u_controlPoints);
    float2 param_18 = _f0(param_1, buffer.u_controlPoints);
    float2 param_19 = _f0(param_2, buffer.u_controlPoints);
    float2 param_20 = _f0(param_3, buffer.u_controlPoints);
    float2 param_21 = _f0(param_4, buffer.u_controlPoints);
    float2 param_22 = _f0(param_5, buffer.u_controlPoints);
    float2 param_23 = _f0(param_6, buffer.u_controlPoints);
    float2 param_24 = _f0(param_7, buffer.u_controlPoints);
    float2 param_25 = _f0(param_8, buffer.u_controlPoints);
    float2 param_26 = _f0(param_9, buffer.u_controlPoints);
    float2 param_27 = _f0(param_10, buffer.u_controlPoints);
    float2 param_28 = _f0(param_11, buffer.u_controlPoints);
    float2 param_29 = _f0(param_12, buffer.u_controlPoints);
    float2 param_30 = _f0(param_13, buffer.u_controlPoints);
    float2 param_31 = _f0(param_14, buffer.u_controlPoints);
    float2 param_32 = _f0(param_15, buffer.u_controlPoints);
    float4 _t50 = _f2(param_16, param_17, param_18, param_19, param_20, param_21, param_22, param_23, param_24, param_25, param_26, param_27, param_28, param_29, param_30, param_31, param_32);
    out.gl_Position = float4((float2(_t50.x, _t50.w) * 2.0) - float2(1.0), 0.0, 1.0);
    out.v_uv = in.a_texcoord0;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

