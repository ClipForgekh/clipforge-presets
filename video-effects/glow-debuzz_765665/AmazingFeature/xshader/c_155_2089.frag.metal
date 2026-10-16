#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float ratio;
    float u_vBlurRadiusPx;
    float u_exposure;
    float u_bottomGlowIntensity;
    float3 u_glowColor;
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
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurRadiusPx, constant float2& u_resolution, constant float& ratio)
{
    float px = fast::max(blurRadiusPx, 0.0);
    float stepY = (px / fast::max(u_resolution.y, 1.0)) / fast::max(ratio, 9.9999997473787516355514526367188e-05);
    float4 color = float4(0.0);
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    color += (tex.sample(texSmplr, uv) * w0);
    color += (tex.sample(texSmplr, float2(uv.x, fast::clamp(uv.y + (1.0 * stepY), 0.0, 1.0))) * w1);
    color += (tex.sample(texSmplr, float2(uv.x, fast::clamp(uv.y - (1.0 * stepY), 0.0, 1.0))) * w1);
    color += (tex.sample(texSmplr, float2(uv.x, fast::clamp(uv.y + (2.0 * stepY), 0.0, 1.0))) * w2);
    color += (tex.sample(texSmplr, float2(uv.x, fast::clamp(uv.y - (2.0 * stepY), 0.0, 1.0))) * w2);
    color += (tex.sample(texSmplr, float2(uv.x, fast::clamp(uv.y + (3.0 * stepY), 0.0, 1.0))) * w3);
    color += (tex.sample(texSmplr, float2(uv.x, fast::clamp(uv.y - (3.0 * stepY), 0.0, 1.0))) * w3);
    color += (tex.sample(texSmplr, float2(uv.x, fast::clamp(uv.y + (4.0 * stepY), 0.0, 1.0))) * w4);
    color += (tex.sample(texSmplr, float2(uv.x, fast::clamp(uv.y - (4.0 * stepY), 0.0, 1.0))) * w4);
    return color;
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& base, thread const float3& blend)
{
    return float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - blend));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float4 baseTex = texture1.sample(texture1Smplr, in.vUv);
    float2 param = in.vUv;
    float param_1 = buffer.u_vBlurRadiusPx;
    float4 blurTex = verticalBlur(texture1, texture1Smplr, param, param_1, buffer.u_resolution, buffer.ratio);
    float spread = mix(0.07999999821186065673828125, 1.0, fast::clamp(buffer.u_exposure, 0.0, 1.0));
    float glowMask = (1.0 - smoothstep(0.0, spread, in.vUv.y)) * buffer.u_bottomGlowIntensity;
    float3 glowLayer = buffer.u_glowColor * glowMask;
    float3 param_2 = blurTex.xyz;
    float3 param_3 = glowLayer;
    float3 mixedColor = screenBlend(param_2, param_3);
    mixedColor *= buffer.u_exposure;
    out.gl_FragColor = float4(mixedColor, baseTex.w);
    return out;
}

