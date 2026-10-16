#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float floatAmount;
    float blurMax;
    float3 crystalColor;
    float glowStrength;
    float sweepStrength;
    float particleDensity;
    float3 goldColor;
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
float4 verticalBlurSample(thread const float2& uv, thread const float& amount, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 stepY = float2(0.0, amount);
    float4 c = float4(0.0);
    float2 param = uv - (stepY * 2.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * 0.119999997317790985107421875);
    float2 param_1 = uv - stepY;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.2199999988079071044921875);
    float2 param_2 = uv;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.319999992847442626953125);
    float2 param_3 = uv + stepY;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.2199999988079071044921875);
    float2 param_4 = uv + (stepY * 2.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.119999997317790985107421875);
    return c;
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 345.45001220703125));
    p += float2(dot(p, p + float2(34.345001220703125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& floatAmount, constant float& blurMax, constant float3& crystalColor, constant float& glowStrength, constant float& sweepStrength, constant float& particleDensity, constant float3& goldColor)
{
    float edgeY = p;
    float revealMask = step(vUv.y, edgeY);
    float wobble = (sin((p * 10.0) * 3.1415927410125732421875) * (1.0 - p)) * floatAmount;
    float scale = 1.0 + (wobble * 0.0599999986588954925537109375);
    float ySkew = (wobble * 0.0500000007450580596923828125) * (1.0 - vUv.y);
    float2 centered = vUv - float2(0.5);
    float2 uv = float2(0.5) + float2(centered.x / scale, (centered.y - ySkew) / scale);
    float2 param = uv;
    uv = handleUVBounds(param);
    float edgeBand = smoothstep(0.0350000001490116119384765625, 0.0, abs(vUv.y - edgeY));
    float blurNearEdge = smoothstep(0.2199999988079071044921875, 0.0, edgeY - vUv.y);
    float blurAmount = (blurMax * (1.0 - p)) * (0.3499999940395355224609375 + (0.64999997615814208984375 * blurNearEdge));
    float2 param_1 = uv;
    float param_2 = blurAmount;
    float4 baseColor = verticalBlurSample(param_1, param_2, tDiffuse, tDiffuseSmplr);
    float crystalRim = edgeBand * (1.0 - p);
    float4 _237 = baseColor;
    float4 _239 = baseColor;
    float3 _252 = mix(_237.xyz, (_239.xyz * 0.87999999523162841796875) + (crystalColor * 0.119999997317790985107421875), float3(crystalRim * 0.699999988079071044921875));
    baseColor.x = _252.x;
    baseColor.y = _252.y;
    baseColor.z = _252.z;
    float glow = (edgeBand * (1.0 - p)) * glowStrength;
    float pulse = smoothstep(0.449999988079071044921875, 0.5, p) * (1.0 - smoothstep(0.5, 0.560000002384185791015625, p));
    float sweepFront = fast::clamp((p - 0.449999988079071044921875) / 0.10999999940395355224609375, 0.0, 1.0);
    float sweep = ((pulse * exp(-pow((vUv.x - sweepFront) * 18.0, 2.0))) * smoothstep(0.02999999932944774627685546875, 0.0, abs(vUv.y - edgeY))) * sweepStrength;
    float2 grid = floor(float2(vUv.x * 140.0, vUv.y * 260.0));
    float2 param_3 = grid + floor(float2(p * 80.0, p * 53.0));
    float _329 = hash21(param_3);
    float rnd = _329;
    float emit = particleDensity * (1.0 - p);
    float spark = step(1.0 - emit, rnd) * edgeBand;
    float2 param_4 = grid + float2(7.13000011444091796875);
    float _350 = hash21(param_4);
    float sparkle = spark * (0.5 + (0.5 * _350));
    float3 lightAdd = goldColor * (((glow * 0.550000011920928955078125) + sweep) + (sparkle * 0.89999997615814208984375));
    float3 rgb = (baseColor.xyz * revealMask) + lightAdd;
    float alpha = (baseColor.w * revealMask) + (((glow * 0.180000007152557373046875) + (sweep * 0.25)) + (sparkle * 0.20000000298023223876953125));
    rgb = fast::clamp(rgb, float3(0.0), float3(1.0));
    alpha = fast::clamp(alpha, 0.0, 1.0);
    return float4(rgb, alpha);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, in.vUv, buffer.floatAmount, buffer.blurMax, buffer.crystalColor, buffer.glowStrength, buffer.sweepStrength, buffer.particleDensity, buffer.goldColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

