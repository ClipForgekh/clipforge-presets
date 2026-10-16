#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_vatPos_texelSize;
    float u_frameCount;
    float u_timePosition;
    float4x4 u_MVP;
};

struct main0_out
{
    float3 v_posWS [[user(locn0)]];
    float3 v_nDirWS [[user(locn1)]];
    float3 v_tDirWS [[user(locn2)]];
    float3 v_bDirWS [[user(locn3)]];
    float2 v_uv0 [[user(locn4)]];
    float2 v_uv1 [[user(locn5)]];
    float4 v_vertexColor [[user(locn6)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 a_position [[attribute(0)]];
    float2 a_uv0 [[attribute(2)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_posTex [[texture(0)]], texture2d<float> u_normTex [[texture(1)]], sampler u_posTexSmplr [[sampler(0)]], sampler u_normTexSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 _36 = float2(((buffer.u_frameCount - 1.0) * buffer.u_timePosition) * (1.0 / buffer.u_vatPos_texelSize.x), 0.0) + in.a_uv0;
    out.gl_Position = buffer.u_MVP * float4(in.a_position + u_posTex.sample(u_posTexSmplr, _36, level(0.0)).xyz, 1.0);
    out.v_uv0 = float2(in.a_uv0.x, in.a_uv0.y);
    out.v_nDirWS = u_normTex.sample(u_normTexSmplr, _36, level(0.0)).xyz;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

