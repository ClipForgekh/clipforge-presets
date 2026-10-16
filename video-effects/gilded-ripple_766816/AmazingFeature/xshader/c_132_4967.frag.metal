#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float ringStartRadius;
    float blurStrength;
    float ringWidth;
    float3 goldColor;
    float ringGlow;
    float rayIntensity;
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
    return 1.0 - pow(1.0 - p, 3.0);
}

static inline __attribute__((always_inline))
float2 getSDFCoordinate(thread const float2& uv, thread const float2& center, constant float& ratio)
{
    float2 p = uv - center;
    if (ratio > 1.0)
    {
        p.y /= ratio;
    }
    else
    {
        p.x *= ratio;
    }
    return p;
}

static inline __attribute__((always_inline))
float getMaxShapeSize(constant float& ratio)
{
    if (ratio > 1.0)
    {
        return sqrt(1.0 + (1.0 / (ratio * ratio))) * 2.0;
    }
    else
    {
        return sqrt((ratio * ratio) + 1.0) * 2.0;
    }
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 fastBlur(thread const float2& uv, thread const float& amount, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    if (amount <= 9.9999997473787516355514526367188e-05)
    {
        float4 _115 = tDiffuse.sample(tDiffuseSmplr, uv);
        return _115;
    }
    float2 stepUV = float2(amount * 0.00120000005699694156646728515625, (amount * 0.00120000005699694156646728515625) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = tDiffuse.sample(tDiffuseSmplr, uv) * 0.23999999463558197021484375;
    float2 param = uv + float2(stepUV.x, 0.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * 0.119999997317790985107421875);
    float2 param_1 = uv - float2(stepUV.x, 0.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.119999997317790985107421875);
    float2 param_2 = uv + float2(0.0, stepUV.y);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.119999997317790985107421875);
    float2 param_3 = uv - float2(0.0, stepUV.y);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.119999997317790985107421875);
    float2 param_4 = uv + stepUV;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.070000000298023223876953125);
    float2 param_5 = uv - stepUV;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * 0.070000000298023223876953125);
    float2 param_6 = uv + float2(stepUV.x, -stepUV.y);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * 0.070000000298023223876953125);
    float2 param_7 = uv + float2(-stepUV.x, stepUV.y);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_7)) * 0.070000000298023223876953125);
    return c;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& ringStartRadius, constant float& blurStrength, constant float& ringWidth, constant float3& goldColor, constant float& ringGlow, constant float& rayIntensity)
{
    float2 center = float2(0.5);
    float2 param = vUv;
    float2 param_1 = center;
    float2 pc = getSDFCoordinate(param, param_1, ratio);
    float d = length(pc);
    float maxR = getMaxShapeSize(ratio) * 0.550000011920928955078125;
    float imageAlpha = 0.0;
    if (p < 0.17647059261798858642578125)
    {
        imageAlpha = 0.0;
    }
    else
    {
        if (p < 0.705882370471954345703125)
        {
            imageAlpha = ((p - 0.17647059261798858642578125) / 0.529411792755126953125) * 0.699999988079071044921875;
        }
        else
        {
            imageAlpha = 0.699999988079071044921875 + (((p - 0.705882370471954345703125) / 0.2941175997257232666015625) * 0.300000011920928955078125);
        }
    }
    float frontRadius = mix(ringStartRadius, maxR, smoothstep(0.17647059261798858642578125, 0.705882370471954345703125, p));
    float blurRegion = 1.0 - smoothstep(frontRadius, frontRadius + 0.100000001490116119384765625, d);
    float blurFade = 1.0 - smoothstep(0.705882370471954345703125, 1.0, p);
    float blurAmount = (blurStrength * blurRegion) * blurFade;
    float2 param_2 = vUv;
    float param_3 = blurAmount;
    float4 blurredTexel = fastBlur(param_2, param_3, ratio, tDiffuse, tDiffuseSmplr);
    float clarity = smoothstep(0.705882370471954345703125, 1.0, p);
    float3 baseRgb = mix(blurredTexel.xyz, texel.xyz, float3(clarity)) * imageAlpha;
    float startupHalo = exp(-pow((d - ringStartRadius) / fast::max(ringWidth * 1.7999999523162841796875, 9.9999997473787516355514526367188e-05), 2.0));
    startupHalo *= (1.0 - smoothstep(0.17647059261798858642578125, 0.23647059500217437744140625, p));
    float rings = 0.0;
    for (int i = 0; i < 5; i++)
    {
        float fi = float(i);
        float startT = 0.17647059261798858642578125 + (fi * 0.11764709651470184326171875);
        float rp = fast::clamp((p - startT) / fast::max(0.705882370471954345703125 - startT, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
        float ringLife = step(startT, p) * (1.0 - smoothstep(0.705882370471954345703125, 1.0, p));
        float radius = mix(ringStartRadius, maxR, rp);
        float edgeFade = smoothstep(maxR * 0.89999997615814208984375, maxR, radius);
        float band = exp(-pow((d - radius) / fast::max(ringWidth, 9.9999997473787516355514526367188e-05), 2.0));
        rings += ((band * ringLife) * (1.0 - edgeFade));
    }
    float angle = precise::atan2(pc.y, pc.x);
    float rayPattern = pow(fast::max(0.0, cos(((angle * 12.0) + (d * 20.0)) - (p * 12.0))), 6.0);
    float rayPulse = 0.75 + (0.25 * sin((d * 36.0) - (p * 20.0)));
    float rayMask = smoothstep(ringStartRadius * 0.800000011920928955078125, frontRadius + 0.039999999105930328369140625, d) * (1.0 - smoothstep(frontRadius + 0.3499999940395355224609375, maxR, d));
    float rays = (rayPattern * rayPulse) * rayMask;
    float fxFade = 1.0 - smoothstep(0.705882370471954345703125, 1.0, p);
    float3 glow = (goldColor * (((rings + startupHalo) * ringGlow) + (rays * rayIntensity))) * fxFade;
    float3 finalRgb = fast::clamp(baseRgb + glow, float3(0.0), float3(1.0));
    float fxAlpha = fast::clamp((((rings + startupHalo) * 0.550000011920928955078125) + (rays * 0.25)) * fxFade, 0.0, 1.0);
    float finalAlpha = fast::clamp(fast::max(texel.w * imageAlpha, fxAlpha), 0.0, 1.0);
    float4 outCol = float4(finalRgb, finalAlpha);
    outCol = mix(outCol, texel, float4(smoothstep(0.999000012874603271484375, 1.0, p)));
    return outCol;
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, in.vUv, buffer.ringStartRadius, buffer.blurStrength, buffer.ringWidth, buffer.goldColor, buffer.ringGlow, buffer.rayIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

