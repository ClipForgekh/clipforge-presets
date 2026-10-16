#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float feather;
    float bandHeight;
    float stretchStrength;
    float blurMax;
    float3 glowColor;
    float glowStrength;
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
    float _38;
    if (p < 0.5)
    {
        _38 = ((4.0 * p) * p) * p;
    }
    else
    {
        _38 = 1.0 - (pow(((-2.0) * p) + 2.0, 3.0) * 0.5);
    }
    return _38;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius)
{
    float2 stepV = float2(0.0, radius / 6.0);
    float4 c = float4(0.0);
    float2 param = uv - (stepV * 3.0);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.07999999821186065673828125);
    float2 param_1 = uv - (stepV * 2.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.119999997317790985107421875);
    float2 param_2 = uv - (stepV * 1.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.17000000178813934326171875);
    float2 param_3 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.2599999904632568359375);
    float2 param_4 = uv + (stepV * 1.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.17000000178813934326171875);
    float2 param_5 = uv + (stepV * 2.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.119999997317790985107421875);
    float2 param_6 = uv + (stepV * 3.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.07999999821186065673828125);
    return c;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& feather, thread float2& vUv, constant float& bandHeight, constant float& stretchStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& blurMax, constant float3& glowColor, constant float& glowStrength)
{
    float strength = 1.0 - p;
    float scanY = 1.0 - p;
    float wipeMask = 1.0 - smoothstep(scanY - feather, scanY + feather, vUv.y);
    float d = abs(vUv.y - scanY);
    float band = exp(((-d) * d) / fast::max(9.9999997473787516355514526367188e-05, bandHeight * bandHeight));
    float stretchAmt = ((stretchStrength * strength) * band) * 0.180000007152557373046875;
    float2 uv = vUv;
    uv.y += ((vUv.y - scanY) * stretchAmt);
    float2 param = uv;
    uv = handleUVBounds(param);
    float4 stretched = tDiffuse.sample(tDiffuseSmplr, uv);
    float blurRadius = (blurMax * strength) * (0.3499999940395355224609375 + (0.64999997615814208984375 * wipeMask));
    float2 param_1 = uv;
    float param_2 = blurRadius;
    float4 blurred = verticalBlur(tDiffuse, tDiffuseSmplr, param_1, param_2);
    float blurMix = fast::clamp(strength * wipeMask, 0.0, 1.0);
    float3 color = mix(stretched.xyz, blurred.xyz, float3(blurMix));
    float brightness = mix(2.0, 1.0, p);
    float contrast = mix(0.60000002384185791015625, 1.0, p);
    color = (((color - float3(0.5)) * contrast) + float3(0.5)) * brightness;
    float glowAlpha = (strength * band) * (0.4000000059604644775390625 + (0.60000002384185791015625 * wipeMask));
    color += ((glowColor * glowStrength) * glowAlpha);
    color = fast::clamp(color, float3(0.0), float3(1.0));
    return float4(color, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.feather, in.vUv, buffer.bandHeight, buffer.stretchStrength, tDiffuse, tDiffuseSmplr, buffer.blurMax, buffer.glowColor, buffer.glowStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

