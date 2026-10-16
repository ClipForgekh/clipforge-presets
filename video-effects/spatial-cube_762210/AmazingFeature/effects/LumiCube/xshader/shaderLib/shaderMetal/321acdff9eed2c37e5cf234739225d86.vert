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
    spvUnsafeArray<float4, 12> u_uvScaleC;
    spvUnsafeArray<float, 12> u_uvRotate;
    spvUnsafeArray<float4, 24> u_model;
    float4x4 u_MVP;
};

struct main0_out
{
    float2 v_uv [[user(locn0)]];
    float2 v_id [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float4 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
    float2 a_texcoord1 [[attribute(2)]];
};

static inline __attribute__((always_inline))
float2 _f0(thread float2& _p0, thread const int& _p1, constant spvUnsafeArray<float4, 12>& u_uvScaleC, constant spvUnsafeArray<float, 12>& u_uvRotate)
{
    _p0 -= float2(0.5);
    _p0 -= u_uvScaleC[_p1].zw;
    float _42 = sin(u_uvRotate[_p1]);
    float _47 = cos(u_uvRotate[_p1]);
    _p0 = float2x2(float2(_47, _42), float2(-_42, _47)) * _p0;
    _p0 *= u_uvScaleC[_p1].xy;
    _p0 += float2(0.5);
    return _p0;
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float _83 = in.a_texcoord1.x + 0.5;
    float _88 = in.a_texcoord1.y + 0.5;
    int _91 = int(_83);
    float2 param = in.a_texcoord0;
    int param_1 = (_91 + _91) + int(_88);
    float2 _108 = _f0(param, param_1, buffer.u_uvScaleC, buffer.u_uvRotate);
    out.v_uv = _108;
    out.v_id = float2(_83, _88);
    int _122 = _91 * 4;
    out.gl_Position = (buffer.u_MVP * float4x4(float4(buffer.u_model[_122 + 0]), float4(buffer.u_model[_122 + 1]), float4(buffer.u_model[_122 + 2]), float4(buffer.u_model[_122 + 3]))) * in.a_position;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

