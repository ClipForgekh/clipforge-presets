#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float ratio;
    float blurStrength;
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
float4 verticalBlur(thread const float2& uv, thread const float& strength, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float4 sum = float4(0.0);
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    float stepY = (0.006000000052154064178466796875 * strength) / fast::max(ratio, 9.9999997473787516355514526367188e-05);
    float2 param = uv;
    sum += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * w0);
    float2 param_1 = uv + float2(0.0, stepY * 1.0);
    sum += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * w1);
    float2 param_2 = uv - float2(0.0, stepY * 1.0);
    sum += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * w1);
    float2 param_3 = uv + float2(0.0, stepY * 2.0);
    sum += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * w2);
    float2 param_4 = uv - float2(0.0, stepY * 2.0);
    sum += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * w2);
    float2 param_5 = uv + float2(0.0, stepY * 3.0);
    sum += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * w3);
    float2 param_6 = uv - float2(0.0, stepY * 3.0);
    sum += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * w3);
    float2 param_7 = uv + float2(0.0, stepY * 4.0);
    sum += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_7)) * w4);
    float2 param_8 = uv - float2(0.0, stepY * 4.0);
    sum += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_8)) * w4);
    return sum;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& blurStrength, constant float& glowStrength)
{
    float t = progress;
    float inv = 1.0 - t;
    float sx = vUv.x * 7.0;
    float stripeId = floor(sx);
    float localX = fract(sx);
    float speed = 0.85000002384185791015625 + (stripeId * 0.07999999821186065673828125);
    float startOffset = stripeId * 0.100000001490116119384765625;
    float scanFront = (-startOffset) + ((t * speed) * 1.35000002384185791015625);
    float scanned = smoothstep(-0.0199999995529651641845703125, 0.0199999995529651641845703125, scanFront - vUv.y);
    float halfWidth = mix(0.2800000011920928955078125, 0.5, t);
    float coreDist = abs(localX - 0.5);
    float stripeCoreMask = 1.0 - smoothstep(halfWidth - 0.0199999995529651641845703125, halfWidth + 0.0199999995529651641845703125, coreDist);
    float revealMask = scanned * stripeCoreMask;
    float blurLevelByStripe = 1.0 - (0.20000000298023223876953125 * mod(stripeId, 3.0));
    float currentBlur = (inv * blurStrength) * blurLevelByStripe;
    float2 param = vUv;
    float param_1 = currentBlur;
    float4 blurred = verticalBlur(param, param_1, ratio, tDiffuse, tDiffuseSmplr);
    float3 holoStripe = float3(0.5) + (cos((float3(0.0, 2.099999904632568359375, 4.19999980926513671875) + float3(vUv.x * 90.0)) + float3(stripeId * 0.699999988079071044921875)) * 0.5);
    float3 stretchedColor = mix(blurred.xyz, (blurred.xyz * holoStripe) * 1.35000002384185791015625, float3(inv * 0.85000002384185791015625));
    float edgeGlowY = exp((-abs(vUv.y - scanFront)) * 75.0);
    float edgeGlowX = 1.0 - smoothstep(halfWidth - 0.02999999932944774627685546875, halfWidth + 0.00999999977648258209228515625, coreDist);
    float3 glowColor = mix(float3(1.0, 0.1500000059604644775390625, 0.75), float3(0.100000001490116119384765625, 1.0, 1.0), float3(localX));
    float3 glow = (((glowColor * edgeGlowY) * edgeGlowX) * inv) * glowStrength;
    float3 baseRGB = stretchedColor * revealMask;
    float baseAlpha = revealMask * mix(0.449999988079071044921875, 1.0, t);
    float3 finalRGB = baseRGB + glow;
    float finalAlpha = fast::clamp(baseAlpha + (fast::max(glow.x, fast::max(glow.y, glow.z)) * 0.3499999940395355224609375), 0.0, 1.0);
    float4 holo = float4(fast::clamp(finalRGB, float3(0.0), float3(1.0)), finalAlpha);
    return mix(holo, texel, float4(smoothstep(0.920000016689300537109375, 1.0, t)));
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, in.vUv, buffer.blurStrength, buffer.glowStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

