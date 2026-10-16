#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float stripCount;
    float staggerStep;
    float sweepWidth;
    float maxBlurUV;
    float startBrightness;
    float startContrast;
    float sweepIntensity;
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
float tween(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 2.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius)
{
    float4 c = float4(0.0);
    float2 param = uv + float2(0.0, (-4.0) * radius);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.0500000007450580596923828125);
    float2 param_1 = uv + float2(0.0, (-3.0) * radius);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.0900000035762786865234375);
    float2 param_2 = uv + float2(0.0, (-2.0) * radius);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.119999997317790985107421875);
    float2 param_3 = uv + float2(0.0, (-1.0) * radius);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.1500000059604644775390625);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.180000007152557373046875);
    float2 param_5 = uv + float2(0.0, 1.0 * radius);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.1500000059604644775390625);
    float2 param_6 = uv + float2(0.0, 2.0 * radius);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.119999997317790985107421875);
    float2 param_7 = uv + float2(0.0, 3.0 * radius);
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.0900000035762786865234375);
    float2 param_8 = uv + float2(0.0, 4.0 * radius);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.0500000007450580596923828125);
    return c;
}

static inline __attribute__((always_inline))
float3 applyContrastBrightness(thread float3& color, thread const float& contrast, thread const float& brightness)
{
    color = ((color - float3(0.5)) * contrast) + float3(0.5);
    color *= brightness;
    return fast::clamp(color, float3(0.0), float3(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, thread float2& vUv, constant float& stripCount, constant float& staggerStep, constant float& sweepWidth, constant float& maxBlurUV, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& startBrightness, constant float& startContrast, constant float& sweepIntensity)
{
    float xScaled = vUv.x * stripCount;
    float idx = floor(xScaled);
    float f = smoothstep(0.0, 1.0, fract(xScaled));
    float d0 = idx * staggerStep;
    float d1 = fast::min(stripCount - 1.0, idx + 1.0) * staggerStep;
    float delay = mix(d0, d1, f);
    float localP = fast::clamp((p - delay) / fast::max(1.0 - delay, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
    float sweepCenter = p;
    float sweep = exp(-pow((vUv.x - sweepCenter) / fast::max(sweepWidth, 9.9999997473787516355514526367188e-05), 2.0));
    sweep *= (1.0 - p);
    localP = fast::clamp(localP + ((sweep * 0.3499999940395355224609375) * (1.0 - localP)), 0.0, 1.0);
    float blurAmt = (1.0 - localP) * maxBlurUV;
    float2 param = vUv;
    float param_1 = blurAmt;
    float4 blurred = verticalBlur(tDiffuse, tDiffuseSmplr, param, param_1);
    float brightness = mix(startBrightness, 1.0, localP);
    float contrast = mix(startContrast, 1.0, localP);
    float3 param_2 = blurred.xyz;
    float param_3 = contrast;
    float param_4 = brightness;
    float3 _299 = applyContrastBrightness(param_2, param_3, param_4);
    float3 color = _299;
    float3 warmLight = float3(1.0, 0.9700000286102294921875, 0.89999997615814208984375);
    color += (warmLight * (sweep * sweepIntensity));
    return float4(fast::clamp(color, float3(0.0), float3(1.0)), texel.w);
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.stripCount, buffer.staggerStep, buffer.sweepWidth, buffer.maxBlurUV, tDiffuse, tDiffuseSmplr, buffer.startBrightness, buffer.startContrast, buffer.sweepIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

