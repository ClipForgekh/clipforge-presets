#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_blurRadius;
    float3 u_flashColor;
    float u_flashIntensity;
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
float4 verticalBlurSample(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurRadius, constant float& ratio)
{
    float baseStep = blurRadius / 1024.0;
    float2 stepSize = float2(0.0, baseStep / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 color = float4(0.0);
    color += (tex.sample(texSmplr, fast::clamp(uv + (stepSize * (-4.0)), float2(0.0), float2(1.0))) * 0.0500000007450580596923828125);
    color += (tex.sample(texSmplr, fast::clamp(uv + (stepSize * (-3.0)), float2(0.0), float2(1.0))) * 0.0900000035762786865234375);
    color += (tex.sample(texSmplr, fast::clamp(uv + (stepSize * (-2.0)), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    color += (tex.sample(texSmplr, fast::clamp(uv + (stepSize * (-1.0)), float2(0.0), float2(1.0))) * 0.1500000059604644775390625);
    color += (tex.sample(texSmplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.180000007152557373046875);
    color += (tex.sample(texSmplr, fast::clamp(uv + (stepSize * 1.0), float2(0.0), float2(1.0))) * 0.1500000059604644775390625);
    color += (tex.sample(texSmplr, fast::clamp(uv + (stepSize * 2.0), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    color += (tex.sample(texSmplr, fast::clamp(uv + (stepSize * 3.0), float2(0.0), float2(1.0))) * 0.0900000035762786865234375);
    color += (tex.sample(texSmplr, fast::clamp(uv + (stepSize * 4.0), float2(0.0), float2(1.0))) * 0.0500000007450580596923828125);
    return color;
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& baseColor, thread const float3& blendColor)
{
    return float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - blendColor));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_blurRadius;
    float4 texColor = verticalBlurSample(texture1, texture1Smplr, param, param_1, buffer.ratio);
    float3 flashLayer = buffer.u_flashColor * buffer.u_flashIntensity;
    float3 param_2 = texColor.xyz;
    float3 param_3 = flashLayer;
    float3 _198 = screenBlend(param_2, param_3);
    texColor.x = _198.x;
    texColor.y = _198.y;
    texColor.z = _198.z;
    out.gl_FragColor = texColor;
    return out;
}

