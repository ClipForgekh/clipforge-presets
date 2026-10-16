#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float spiralDensity;
    float blurStrength;
    float particleAmount;
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
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float3 adjustSaturation(thread const float3& color, thread const float& sat)
{
    float l = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(l), color, float3(sat));
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
float4 fastBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius, constant float& ratio)
{
    float2 stepSize = float2(0.00179999996908009052276611328125 * radius, (0.00179999996908009052276611328125 * radius) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param = uv + (stepSize * float2(-1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 1.0);
    float2 param_1 = uv + (stepSize * float2(0.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 2.0);
    float2 param_2 = uv + (stepSize * float2(1.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 1.0);
    float2 param_3 = uv + (stepSize * float2(-1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 2.0);
    float2 param_4 = uv + (stepSize * float2(0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 4.0);
    float2 param_5 = uv + (stepSize * float2(1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 2.0);
    float2 param_6 = uv + (stepSize * float2(-1.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 1.0);
    float2 param_7 = uv + (stepSize * float2(0.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 2.0);
    float2 param_8 = uv + (stepSize * float2(1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 1.0);
    return c / float4(16.0);
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float2 hash22(thread const float2& p)
{
    float2 param = p;
    float n = hash12(param);
    float2 param_1 = (p + float2(n)) + float2(7.13000011444091796875);
    return float2(n, hash12(param_1));
}

static inline __attribute__((always_inline))
float particleLayer(thread const float2& uv, thread const float& grid, thread const float& minR, thread const float& maxR, thread const float& seed, thread const float& gate)
{
    float2 guv = uv * grid;
    float2 id = floor(guv);
    float2 fv = fract(guv) - float2(0.5);
    float2 param = id + float2(seed);
    float2 rnd = hash22(param);
    float2 pos = (rnd - float2(0.5)) * 0.75;
    float rr = mix(minR, maxR, rnd.x);
    float d = length(fv - pos);
    float p = 1.0 - smoothstep(rr, rr * 1.89999997615814208984375, d);
    float exist = step(1.0 - gate, rnd.y);
    return p * exist;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& spiralDensity, constant float& blurStrength, constant float& particleAmount)
{
    float strength = 1.0 - p;
    float baseScale = mix(0.9700000286102294921875, 1.0, p);
    float2 uvRaw = float2(0.5) + ((vUv - float2(0.5)) / float2(baseScale));
    float2 param = uvRaw;
    float2 uv = handleUVBounds(param);
    float2 param_1 = uvRaw;
    float borderMask = getHardBoundaryMask(param_1);
    float4 src = tDiffuse.sample(tDiffuseSmplr, uv);
    float brightness = mix(0.1500000059604644775390625, 1.0, p);
    float saturation = mix(0.449999988079071044921875, 1.0, p);
    float3 param_2 = src.xyz * brightness;
    float param_3 = saturation;
    float3 baseColor = adjustSaturation(param_2, param_3);
    float2 start = float2(0.819999992847442626953125);
    float2 center = float2(0.5);
    float2 head = mix(start, center, float2(p));
    float2 param_4 = vUv;
    float2 param_5 = head;
    float2 sp = getSDFCoordinate(param_4, param_5, ratio);
    float r = length(sp);
    float a = precise::atan2(sp.y, sp.x);
    float spin = (p * (8.0 + (6.0 * spiralDensity))) * 6.283185482025146484375;
    float arm = 0.5 + (0.5 * cos(((a * (5.0 + (2.0 * spiralDensity))) + (r * (38.0 + (10.0 * spiralDensity)))) - spin));
    float coverRadius = mix(0.0599999986588954925537109375, 1.35000002384185791015625, p);
    float cover = 1.0 - smoothstep(coverRadius - 0.2199999988079071044921875, coverRadius + 0.0199999995529651641845703125, r);
    float sweep = smoothstep(0.62000000476837158203125, 0.980000019073486328125, arm) * cover;
    float2 param_6 = uv;
    float param_7 = 5.0 * blurStrength;
    float4 blurC = fastBlur9(tDiffuse, tDiffuseSmplr, param_6, param_7, ratio);
    float blurMask = sweep * strength;
    float3 layeredBase = mix(baseColor, blurC.xyz, float3(fast::clamp(blurMask, 0.0, 1.0)));
    float layerGate1 = 0.2199999988079071044921875 * particleAmount;
    float layerGate2 = 0.300000011920928955078125 * particleAmount;
    float layerGate3 = 0.4199999868869781494140625 * particleAmount;
    float2 param_8 = vUv + (float2(0.10999999940395355224609375, -0.02999999932944774627685546875) * p);
    float param_9 = 48.0;
    float param_10 = 0.100000001490116119384765625;
    float param_11 = 0.180000007152557373046875;
    float param_12 = 11.69999980926513671875;
    float param_13 = layerGate1;
    float l1 = particleLayer(param_8, param_9, param_10, param_11, param_12, param_13);
    float2 param_14 = vUv + (float2(0.070000000298023223876953125, 0.0199999995529651641845703125) * p);
    float param_15 = 86.0;
    float param_16 = 0.07999999821186065673828125;
    float param_17 = 0.14000000059604644775390625;
    float param_18 = 27.299999237060546875;
    float param_19 = layerGate2;
    float l2 = particleLayer(param_14, param_15, param_16, param_17, param_18, param_19);
    float2 param_20 = vUv + (float2(-0.039999999105930328369140625, 0.0500000007450580596923828125) * p);
    float param_21 = 150.0;
    float param_22 = 0.0500000007450580596923828125;
    float param_23 = 0.0900000035762786865234375;
    float param_24 = 49.90000152587890625;
    float param_25 = layerGate3;
    float l3 = particleLayer(param_20, param_21, param_22, param_23, param_24, param_25);
    float particleFade = strength;
    float particleMask = sweep * particleFade;
    float3 c1 = float3(1.0, 0.800000011920928955078125, 0.4199999868869781494140625);
    float3 c2 = float3(1.0, 0.86000001430511474609375, 0.550000011920928955078125);
    float3 c3 = float3(1.0, 0.920000016689300537109375, 0.699999988079071044921875);
    float glow = (3.5 * (1.0 - p)) * (1.0 - (0.3499999940395355224609375 * p));
    float3 particles = ((((c1 * l1) + (c2 * l2)) + (c3 * l3)) * glow) * particleMask;
    float3 finalRgb = fast::clamp(layeredBase + particles, float3(0.0), float3(1.0));
    return float4(finalRgb, src.w * borderMask);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, tDiffuse, tDiffuseSmplr, buffer.spiralDensity, buffer.blurStrength, buffer.particleAmount);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

