#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uOffsetY;
    float uCardScale;
    float uProgress;
    float uParallax;
    float uFrost;
    float uSheen;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUv [[user(vUv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> uTexture [[texture(0)]], sampler uTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float2 centeredUV = uv - float2(0.5);
    float2 cardPos = centeredUV - float2(0.0, buffer.uOffsetY);
    float2 cardSize = mix(float2(0.37999999523162841796875) * buffer.uCardScale, float2(0.5), float2(smoothstep(0.550000011920928955078125, 0.949999988079071044921875, buffer.uProgress)));
    float cardRadius = mix(0.0500000007450580596923828125 * fast::min(buffer.uCardScale, 1.0), 0.0, smoothstep(0.680000007152557373046875, 0.980000019073486328125, buffer.uProgress));
    float2 q = (abs(cardPos) - cardSize) + float2(cardRadius);
    float distSDF = (fast::min(fast::max(q.x, q.y), 0.0) + length(fast::max(q, float2(0.0)))) - cardRadius;
    float2 localCardUV = (cardPos / (cardSize * 2.0)) + float2(0.5);
    float2 parallaxShift = float2(0.0, buffer.uOffsetY * buffer.uParallax);
    float2 targetUV = mix(localCardUV + parallaxShift, uv, float2(smoothstep(0.699999988079071044921875, 1.0, buffer.uProgress)));
    float2 clampedUV = fast::clamp(targetUV, float2(0.0), float2(1.0));
    float blurRadius = buffer.uFrost * 0.01600000075995922088623046875;
    float4 blurredColor = float4(0.0);
    blurredColor += (uTexture.sample(uTextureSmplr, fast::clamp(clampedUV + float2(-blurRadius, -blurRadius), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    blurredColor += (uTexture.sample(uTextureSmplr, fast::clamp(clampedUV + float2(blurRadius, -blurRadius), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    blurredColor += (uTexture.sample(uTextureSmplr, fast::clamp(clampedUV + float2(-blurRadius, blurRadius), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    blurredColor += (uTexture.sample(uTextureSmplr, fast::clamp(clampedUV + float2(blurRadius, blurRadius), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    blurredColor += (uTexture.sample(uTextureSmplr, fast::clamp(clampedUV + float2(0.0, (-blurRadius) * 1.39999997615814208984375), float2(0.0), float2(1.0))) * 0.12999999523162841796875);
    blurredColor += (uTexture.sample(uTextureSmplr, fast::clamp(clampedUV + float2(0.0, blurRadius * 1.39999997615814208984375), float2(0.0), float2(1.0))) * 0.12999999523162841796875);
    blurredColor += (uTexture.sample(uTextureSmplr, fast::clamp(clampedUV + float2((-blurRadius) * 1.39999997615814208984375, 0.0), float2(0.0), float2(1.0))) * 0.12999999523162841796875);
    blurredColor += (uTexture.sample(uTextureSmplr, fast::clamp(clampedUV + float2(blurRadius * 1.39999997615814208984375, 0.0), float2(0.0), float2(1.0))) * 0.12999999523162841796875);
    float3 baseContent = mix(uTexture.sample(uTextureSmplr, clampedUV).xyz, blurredColor.xyz, float3(buffer.uFrost));
    float borderEdge = smoothstep(0.00999999977648258209228515625, 0.0, abs(distSDF)) * (0.449999988079071044921875 + (buffer.uFrost * 0.550000011920928955078125));
    float3 rimColor = float3(1.0) * borderEdge;
    float sheenPos = (buffer.uProgress * 2.2999999523162841796875) - 0.3499999940395355224609375;
    float sheenAxis = (localCardUV.x + localCardUV.y) * 0.707099974155426025390625;
    float sheenGlint = (smoothstep(0.070000000298023223876953125, 0.0, abs(sheenAxis - sheenPos)) * buffer.uSheen) * 0.64999997615814208984375;
    float3 sheenColor = float3(0.949999988079071044921875, 0.980000019073486328125, 1.0) * sheenGlint;
    float3 glassAmbient = float3(0.02999999932944774627685546875, 0.0500000007450580596923828125, 0.07999999821186065673828125) * buffer.uFrost;
    float3 finalCardRgb = ((baseContent + glassAmbient) + sheenColor) + rimColor;
    float cardMask = smoothstep(0.0030000000260770320892333984375, -0.0030000000260770320892333984375, distSDF);
    float2 shadowOffset = float2(0.0, ((-0.0500000007450580596923828125) * (1.0 - buffer.uProgress)) - 0.0199999995529651641845703125);
    float2 shadowQ = (abs(cardPos + shadowOffset) - cardSize) + float2(cardRadius);
    float shadowDist = (fast::min(fast::max(shadowQ.x, shadowQ.y), 0.0) + length(fast::max(shadowQ, float2(0.0)))) - cardRadius;
    float dropShadow = ((smoothstep(0.07999999821186065673828125, 0.0, shadowDist) * (1.0 - cardMask)) * buffer.uFrost) * 0.449999988079071044921875;
    float3 compositeRgb = mix(float3(0.0), finalCardRgb, float3(cardMask));
    float finalAlpha = fast::max(cardMask, dropShadow);
    if (buffer.uProgress <= 0.0)
    {
        compositeRgb = float3(0.0);
        finalAlpha = 0.0;
    }
    if (buffer.uProgress >= 1.0)
    {
        compositeRgb = uTexture.sample(uTextureSmplr, uv).xyz;
        finalAlpha = 1.0;
    }
    out.gl_FragColor = float4(compositeRgb, finalAlpha);
    return out;
}

