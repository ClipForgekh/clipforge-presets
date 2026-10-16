#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maxScale;
    float maxBlurUV;
    float maxBrightness;
    float maxSaturation;
    float glowPeak;
    float3 glowColor;
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
    float _45;
    if (p < 0.5)
    {
        _45 = ((4.0 * p) * p) * p;
    }
    else
    {
        _45 = 1.0 - (pow(((-2.0) * p) + 2.0, 3.0) * 0.5);
    }
    return _45;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur9Tap(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusUV)
{
    float2 stepV = float2(0.0, radiusUV / 4.0);
    float4 c = float4(0.0);
    float2 param = uv - (stepV * 4.0);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.0500000007450580596923828125);
    float2 param_1 = uv - (stepV * 3.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.0900000035762786865234375);
    float2 param_2 = uv - (stepV * 2.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.119999997317790985107421875);
    float2 param_3 = uv - (stepV * 1.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.1500000059604644775390625);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.180000007152557373046875);
    float2 param_5 = uv + (stepV * 1.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.1500000059604644775390625);
    float2 param_6 = uv + (stepV * 2.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.119999997317790985107421875);
    float2 param_7 = uv + (stepV * 3.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.0900000035762786865234375);
    float2 param_8 = uv + (stepV * 4.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.0500000007450580596923828125);
    return c;
}

static inline __attribute__((always_inline))
float3 applySaturation(thread const float3& color, thread const float& sat)
{
    float luma = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(luma), color, float3(sat));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& maxScale, thread float2& vUv, constant float& maxBlurUV, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& maxBrightness, constant float& maxSaturation, constant float& glowPeak, constant float3& glowColor)
{
    float strength = 1.0 - p;
    float zoom = mix(1.0, maxScale, strength);
    float2 uv = float2(0.5) + ((vUv - float2(0.5)) / float2(zoom));
    float2 param = uv;
    uv = handleUVBounds(param);
    float blurR = maxBlurUV * strength;
    float2 param_1 = uv;
    float param_2 = blurR;
    float4 col = verticalBlur9Tap(tDiffuse, tDiffuseSmplr, param_1, param_2);
    float bright = mix(1.0, maxBrightness, strength);
    float sat = mix(1.0, maxSaturation, strength);
    float4 _247 = col;
    float3 _249 = _247.xyz * bright;
    col.x = _249.x;
    col.y = _249.y;
    col.z = _249.z;
    float3 param_3 = col.xyz;
    float param_4 = sat;
    float3 _265 = applySaturation(param_3, param_4);
    col.x = _265.x;
    col.y = _265.y;
    col.z = _265.z;
    float glowAmt = (glowPeak - 1.0) * strength;
    float xBand = exp(-pow((vUv.x - 0.5) / 0.2199999988079071044921875, 2.0));
    float yBand = exp(-pow((vUv.y - 0.5) / 0.64999997615814208984375, 2.0));
    float glowMask = xBand * (0.60000002384185791015625 + (0.4000000059604644775390625 * yBand));
    float4 _314 = col;
    float3 _316 = _314.xyz + (((glowColor * glowMask) * glowAmt) * 0.3499999940395355224609375);
    col.x = _316.x;
    col.y = _316.y;
    col.z = _316.z;
    float4 _323 = col;
    float3 _327 = fast::clamp(_323.xyz, float3(0.0), float3(1.0));
    col.x = _327.x;
    col.y = _327.y;
    col.z = _327.z;
    return float4(col.xyz, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.maxScale, in.vUv, buffer.maxBlurUV, tDiffuse, tDiffuseSmplr, buffer.maxBrightness, buffer.maxSaturation, buffer.glowPeak, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

