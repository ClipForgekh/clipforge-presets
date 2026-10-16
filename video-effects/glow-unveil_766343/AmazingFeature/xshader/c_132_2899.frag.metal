#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float trailWidth;
    float sparkDensity;
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
    return 1.0 - pow(1.0 - p, 2.0);
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
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 345.45001220703125));
    p += float2(dot(p, p + float2(34.345001220703125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, thread float2& vUv, constant float& trailWidth, constant float& sparkDensity, constant float3& glowColor, constant float& glowStrength)
{
    if (p >= 0.99989998340606689453125)
    {
        return texel;
    }
    float strength = 1.0 - p;
    float2 uv = vUv;
    float2 param = uv;
    float2 param_1 = float2(0.5);
    float2 ap = getSDFCoordinate(param, param_1, ratio) + float2(0.5);
    float x = ap.x;
    float curve1 = (0.1599999964237213134765625 + (0.62000000476837158203125 * x)) + (0.100000001490116119384765625 * sin((8.0 * x) - 1.10000002384185791015625));
    float curve2 = (0.0599999986588954925537109375 + (0.699999988079071044921875 * x)) + (0.070000000298023223876953125 * sin((11.0 * x) + 0.60000002384185791015625));
    float front = (-0.2800000011920928955078125) + (p * 1.7799999713897705078125);
    float widthFactor = 220.0 / (trailWidth * trailWidth);
    float d1 = abs(ap.y - curve1);
    float d2 = abs(ap.y - curve2);
    float trail1 = exp(((-d1) * d1) * widthFactor);
    float trail2 = exp(((-d2) * d2) * (widthFactor * 1.10000002384185791015625));
    float head = exp(-pow((ap.x - front) * 10.0, 2.0));
    float tail = fast::clamp(((front - ap.x) + 0.02999999932944774627685546875) / 0.550000011920928955078125, 0.0, 1.0);
    float trailMask = (head * 0.89999997615814208984375) + (tail * 0.699999988079071044921875);
    float2 sparkCell = floor((ap * float2(260.0, 160.0)) + float2(p * 140.0));
    float2 param_2 = sparkCell;
    float _229 = hash21(param_2);
    float sparkRnd = _229;
    float sparkCut = 1.0 - (0.07999999821186065673828125 * sparkDensity);
    float spark = ((step(sparkCut, sparkRnd) * (trail1 + trail2)) * head) * 2.5;
    float reveal1 = smoothstep(front - 0.2199999988079071044921875, front + 0.100000001490116119384765625, ap.x + ((ap.y - curve1) * 0.3499999940395355224609375));
    float reveal2 = smoothstep(front - 0.1599999964237213134765625, front + 0.14000000059604644775390625, ap.x + ((ap.y - curve2) * 0.25));
    float reveal = fast::clamp(fast::max(reveal1, reveal2), 0.0, 1.0);
    float3 baseImage = texel.xyz * reveal;
    float glowShape = ((trail1 * 0.89999997615814208984375) + (trail2 * 0.75)) * trailMask;
    float3 glow = ((glowColor * glowShape) * glowStrength) * strength;
    float3 sparkGlow = ((glowColor * spark) * glowStrength) * strength;
    float3 color = (baseImage + glow) + sparkGlow;
    float alphaImage = texel.w * reveal;
    float alphaGlow = fast::clamp(((glowShape + spark) * 0.5) * strength, 0.0, 1.0);
    float outAlpha = fast::max(alphaImage, alphaGlow);
    return float4(fast::clamp(color, float3(0.0), float3(1.0)), outAlpha);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.trailWidth, buffer.sparkDensity, buffer.glowColor, buffer.glowStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

