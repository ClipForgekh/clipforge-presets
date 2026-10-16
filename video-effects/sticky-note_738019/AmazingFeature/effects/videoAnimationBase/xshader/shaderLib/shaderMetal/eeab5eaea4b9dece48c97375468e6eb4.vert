#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_OutputWidth;
    float u_OutputHeight;
    float4x4 fitMat;
    float4x4 userMat;
    float4x4 animMat;
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
void transformUV(thread const float4x4& mat, thread float2& uv, constant float& u_OutputWidth, constant float& u_OutputHeight, thread float2& a_texcoord0, constant float4x4& fitMat, constant float4x4& userMat)
{
    float _24 = u_OutputWidth / u_OutputHeight;
    uv = float2(fma(a_texcoord0.x, 2.0, -1.0) * _24, fma(a_texcoord0.y, 2.0, -1.0));
    uv = ((fitMat * userMat) * float4(uv, 0.0, 1.0)).xy;
    uv = float2(((uv.x / _24) + 1.0) * 0.5, (uv.y + 1.0) * 0.5);
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float4x4 param = buffer.animMat;
    float2 param_1;
    transformUV(param, param_1, buffer.u_OutputWidth, buffer.u_OutputHeight, in.a_texcoord0, buffer.fitMat, buffer.userMat);
    out.v_uv = param_1;
    out.gl_Position = float4(in.a_position, 1.0);
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

