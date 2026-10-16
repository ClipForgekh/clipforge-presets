#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maxBlurRadius;
    float rgbShift;
    float glowIntensity;
    float noiseAmount;
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
float lightHeadY(thread const float& t, thread const float& delay, thread const float& speed)
{
    float y0 = 0.039999999105930328369140625;
    float p1 = fast::clamp((t - delay) / 0.300000011920928955078125, 0.0, 1.0);
    float p2 = fast::clamp(((t - delay) - 0.300000011920928955078125) / 0.699999988079071044921875, 0.0, 1.0);
    float yMid = y0 + ((0.7799999713897705078125 * speed) * p1);
    float y = mix(yMid, 1.059999942779541015625, p2);
    return y;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 directionalVerticalBlur(thread const float2& uv, thread const float& radius, thread const float& dirSign, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float4 sum = float4(0.0);
    float wsum = 0.0;
    for (int i = 0; i < 7; i++)
    {
        float t = float(i) / 6.0;
        float w = 1.0 - (abs(t - 0.5) * 1.60000002384185791015625);
        float2 offset = float2(0.0, (t * radius) * dirSign);
        float2 param = uv + offset;
        float2 suv = handleUVBounds(param);
        sum += (tDiffuse.sample(tDiffuseSmplr, suv) * w);
        wsum += w;
    }
    return sum / float4(fast::max(wsum, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float3 adjustSaturation(thread const float3& color, thread const float& sat)
{
    float l = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(l), color, float3(sat));
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 456.209991455078125));
    p += float2(dot(p, p + float2(45.31999969482421875)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& maxBlurRadius, constant float& rgbShift, constant float& glowIntensity, constant float& noiseAmount)
{
    float strength = 1.0 - p;
    float param = p;
    float param_1 = 0.0;
    float param_2 = 1.0;
    float yL = lightHeadY(param, param_1, param_2);
    float param_3 = p;
    float param_4 = 0.0500000007450580596923828125;
    float param_5 = 0.86000001430511474609375;
    float yM = lightHeadY(param_3, param_4, param_5);
    float param_6 = p;
    float param_7 = 0.100000001490116119384765625;
    float param_8 = 0.7200000286102294921875;
    float yR = lightHeadY(param_6, param_7, param_8);
    float fadeL = 1.0 - smoothstep(0.300000011920928955078125, 1.0, fast::max(0.0, p - 0.0));
    float fadeM = 1.0 - smoothstep(0.300000011920928955078125, 1.0, fast::max(0.0, p - 0.0500000007450580596923828125));
    float fadeR = 1.0 - smoothstep(0.300000011920928955078125, 1.0, fast::max(0.0, p - 0.100000001490116119384765625));
    float bandW = 0.3333333432674407958984375;
    float mXL = 1.0 - smoothstep(bandW * 0.449999988079071044921875, bandW * 0.519999980926513671875, abs(vUv.x - 0.16666667163372039794921875));
    float mXM = 1.0 - smoothstep(bandW * 0.449999988079071044921875, bandW * 0.519999980926513671875, abs(vUv.x - 0.5));
    float mXR = 1.0 - smoothstep(bandW * 0.449999988079071044921875, bandW * 0.519999980926513671875, abs(vUv.x - 0.833333313465118408203125));
    float headL = (exp(-pow((vUv.y - yL) / 0.0599999986588954925537109375, 2.0)) * mXL) * fadeL;
    float headM = (exp(-pow((vUv.y - yM) / 0.0599999986588954925537109375, 2.0)) * mXM) * fadeM;
    float headR = (exp(-pow((vUv.y - yR) / 0.0599999986588954925537109375, 2.0)) * mXR) * fadeR;
    float trailL = (smoothstep(-0.2199999988079071044921875, 0.02999999932944774627685546875, yL - vUv.y) * mXL) * fadeL;
    float trailM = (smoothstep(-0.2199999988079071044921875, 0.02999999932944774627685546875, yM - vUv.y) * mXM) * fadeM;
    float trailR = (smoothstep(-0.2199999988079071044921875, 0.02999999932944774627685546875, yR - vUv.y) * mXR) * fadeR;
    float sweepCoverage = fast::clamp(fast::max(fast::max(trailL, trailM), trailR), 0.0, 1.0);
    float residualDecay = 1.0 - pow(p, 1.60000002384185791015625);
    float localBlurFactor = fast::clamp(residualDecay * (1.0 - (0.85000002384185791015625 * sweepCoverage)), 0.0, 1.0);
    float blurRadius = (maxBlurRadius * strength) * localBlurFactor;
    float dirSign = (vUv.y >= 0.5) ? 1.0 : (-1.0);
    float2 param_9 = vUv;
    float param_10 = blurRadius;
    float param_11 = dirSign;
    float4 blurred = directionalVerticalBlur(param_9, param_10, param_11, tDiffuse, tDiffuseSmplr);
    float shift = rgbShift * strength;
    float2 param_12 = vUv + float2(shift, 0.0);
    float r = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_12)).x;
    float2 param_13 = vUv;
    float g = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_13)).y;
    float2 param_14 = vUv - float2(shift, 0.0);
    float b = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_14)).z;
    float3 shifted = float3(r, g, b);
    float3 base = mix(blurred.xyz, shifted, float3(0.3499999940395355224609375 * strength));
    float brightness = 1.0 + (2.2000000476837158203125 * strength);
    float saturation = 1.0 - (0.25 * strength);
    float3 param_15 = base * brightness;
    float param_16 = saturation;
    base = adjustSaturation(param_15, param_16);
    float3 neonL = float3(1.0, 0.1500000059604644775390625, 0.20000000298023223876953125) * (headL + (trailL * 0.3499999940395355224609375));
    float3 neonM = float3(0.1500000059604644775390625, 0.3499999940395355224609375, 1.0) * (headM + (trailM * 0.3499999940395355224609375));
    float3 neonR = float3(0.64999997615814208984375, 0.20000000298023223876953125, 1.0) * (headR + (trailR * 0.3499999940395355224609375));
    float3 neonGlow = (((neonL + neonM) + neonR) * glowIntensity) * strength;
    float2 param_17 = (vUv * float2(360.0, 640.0)) + float2(p * 37.0, p * 19.0);
    float _517 = hash21(param_17);
    float n = _517;
    float2 param_18 = (vUv * float2(640.0, 280.0)) + float2(p * 13.0, p * 51.0);
    float _532 = hash21(param_18);
    float n2 = _532;
    float3 neonNoise = float3(n, n2, 1.0 - n) - float3(0.5);
    float noiseMask = (((headL + headM) + headR) * 0.60000002384185791015625) + 0.4000000059604644775390625;
    neonNoise *= ((noiseAmount * strength) * noiseMask);
    float3 finalRgb = (base + neonGlow) + neonNoise;
    finalRgb = mix(finalRgb, texel.xyz, float3(p));
    finalRgb = fast::clamp(finalRgb, float3(0.0), float3(1.0));
    return float4(finalRgb, texel.w);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, in.vUv, buffer.maxBlurRadius, buffer.rgbShift, buffer.glowIntensity, buffer.noiseAmount);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

