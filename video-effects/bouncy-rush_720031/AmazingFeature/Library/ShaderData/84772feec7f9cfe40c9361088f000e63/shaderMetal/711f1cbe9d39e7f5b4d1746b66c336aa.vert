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
    float u_direction;
    float u_step_x;
    float u_step_y;
    float u_intensity;
};

struct main0_out
{
    float2 v_uv_0 [[user(v_uv_0)]];
    float2 v_uv_1 [[user(v_uv_1)]];
    float2 v_uv_2 [[user(v_uv_2)]];
    float2 v_uv_3 [[user(v_uv_3)]];
    float2 v_uv_4 [[user(v_uv_4)]];
    float2 v_uv_5 [[user(v_uv_5)]];
    float2 v_uv_6 [[user(v_uv_6)]];
    float2 v_uv_7 [[user(v_uv_7)]];
    float2 v_uv_8 [[user(v_uv_8)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float4 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    spvUnsafeArray<float2, 9> v_uv = {};
    float _13 = 3.1415927410125732421875 * buffer.u_direction;
    float _16 = sin(_13);
    float _19 = cos(_13);
    float2 _30 = float2(buffer.u_step_x, buffer.u_step_y) * buffer.u_intensity;
    float2x2 _43 = float2x2(float2(_19, _16), float2(-_16, _19));
    v_uv[0] = in.a_texcoord0;
    float2 _61 = _43 * float2(1.40733301639556884765625, 0.0);
    v_uv[1] = fma(_61, _30, in.a_texcoord0);
    v_uv[2] = fma(-_61, _30, in.a_texcoord0);
    float2 _79 = _43 * float2(3.2942149639129638671875, 0.0);
    v_uv[3] = fma(_79, _30, in.a_texcoord0);
    v_uv[4] = fma(-_79, _30, in.a_texcoord0);
    float2 _97 = _43 * float2(5.351806163787841796875, 0.0);
    v_uv[5] = fma(_97, _30, in.a_texcoord0);
    v_uv[6] = fma(-_97, _30, in.a_texcoord0);
    float2 _115 = _43 * float2(7.302939891815185546875, 0.0);
    v_uv[7] = fma(_115, _30, in.a_texcoord0);
    v_uv[8] = fma(-_115, _30, in.a_texcoord0);
    out.gl_Position = in.a_position;
    out.v_uv_0 = v_uv[0];
    out.v_uv_1 = v_uv[1];
    out.v_uv_2 = v_uv[2];
    out.v_uv_3 = v_uv[3];
    out.v_uv_4 = v_uv[4];
    out.v_uv_5 = v_uv[5];
    out.v_uv_6 = v_uv[6];
    out.v_uv_7 = v_uv[7];
    out.v_uv_8 = v_uv[8];
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

