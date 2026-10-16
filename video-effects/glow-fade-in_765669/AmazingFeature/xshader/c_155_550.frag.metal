#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_contrast;
    float u_brightness;
    float u_opacity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUv [[user(vUv)]];
};

static inline __attribute__((always_inline))
float3 applyContrast(thread const float3& color, thread const float& contrast)
{
    return ((color - float3(0.5)) * contrast) + float3(0.5);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texColor = texture1.sample(texture1Smplr, in.vUv);
    float3 param = texColor.xyz;
    float param_1 = buffer.u_contrast;
    float3 _45 = applyContrast(param, param_1);
    texColor.x = _45.x;
    texColor.y = _45.y;
    texColor.z = _45.z;
    float4 _58 = texColor;
    float3 _60 = _58.xyz * buffer.u_brightness;
    texColor.x = _60.x;
    texColor.y = _60.y;
    texColor.z = _60.z;
    out.gl_FragColor = float4(texColor.xyz, texColor.w * buffer.u_opacity);
    return out;
}

