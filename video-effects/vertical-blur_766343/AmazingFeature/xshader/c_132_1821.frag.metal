#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maxBlur;
    float progress;
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
float tween(thread const float& progress)
{
    return 1.0 - pow(1.0 - progress, 3.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& maxBlur, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv)
{
    float blurStrength = (1.0 - progress) * maxBlur;
    float2 o1 = float2(0.0, 1.0 * blurStrength);
    float2 o2 = float2(0.0, 2.0 * blurStrength);
    float2 o3 = float2(0.0, 3.0 * blurStrength);
    float2 o4 = float2(0.0, 4.0 * blurStrength);
    float2 param = vUv;
    float4 c0 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param));
    float2 param_1 = vUv + o1;
    float4 c1p = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1));
    float2 param_2 = vUv - o1;
    float4 c1n = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2));
    float2 param_3 = vUv + o2;
    float4 c2p = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3));
    float2 param_4 = vUv - o2;
    float4 c2n = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4));
    float2 param_5 = vUv + o3;
    float4 c3p = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5));
    float2 param_6 = vUv - o3;
    float4 c3n = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6));
    float2 param_7 = vUv + o4;
    float4 c4p = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_7));
    float2 param_8 = vUv - o4;
    float4 c4n = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_8));
    float4 blurred = ((((c0 * 0.23999999463558197021484375) + ((c1p + c1n) * 0.180000007152557373046875)) + ((c2p + c2n) * 0.119999997317790985107421875)) + ((c3p + c3n) * 0.07999999821186065673828125)) + ((c4p + c4n) * 0.0);
    return blurred;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float param = effectProgress;
    effectProgress = tween(param);
    float4 param_1 = texel;
    float param_2 = effectProgress;
    float4 effectColor = effect(param_1, param_2, buffer.maxBlur, tDiffuse, tDiffuseSmplr, in.vUv);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

