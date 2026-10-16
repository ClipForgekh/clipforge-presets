#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float zoomStrength;
    float heartSize;
    float pixelStep;
    float heartGlow;
    float3 heartColor;
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
float2 hash21(thread const float& n)
{
    return fract(sin(float2(n * 91.6999969482421875, n * 173.3000030517578125)) * 43758.546875);
}

static inline __attribute__((always_inline))
float hash11(thread const float& n)
{
    return fract(sin(n * 127.09999847412109375) * 43758.546875);
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
float sdHeart(thread float2& p)
{
    p.x = abs(p.x);
    if ((p.y + p.x) > 1.0)
    {
        float2 q = p - float2(0.25, 0.75);
        return length(q) - 0.3535533845424652099609375;
    }
    float d1 = dot(p - float2(0.0, 1.0), p - float2(0.0, 1.0));
    float d2 = dot(p - float2(0.5), p - float2(0.5));
    return sqrt(fast::min(d1, d2)) * sign(p.x - p.y);
}

static inline __attribute__((always_inline))
float pixelHeartMask(thread const float2& uv, thread const float2& center, thread const float& size, thread const float& px, constant float& ratio)
{
    float2 param = uv;
    float2 param_1 = center;
    float2 p = getSDFCoordinate(param, param_1, ratio) / float2(fast::max(size, 9.9999997473787516355514526367188e-05));
    p = floor((p / float2(fast::max(px, 9.9999997473787516355514526367188e-05))) + float2(0.5)) * fast::max(px, 9.9999997473787516355514526367188e-05);
    p.y += 0.449999988079071044921875;
    float2 param_2 = p;
    float _213 = sdHeart(param_2);
    float d = _213;
    return step(d, 0.0);
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& zoomStrength, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& heartSize, constant float& pixelStep, constant float& heartGlow, constant float3& heartColor)
{
    float effectStrength = 1.0 - p;
    float zoom = 1.0 + (effectStrength * zoomStrength);
    float2 zoomUV = float2(0.5) + ((vUv - float2(0.5)) / float2(zoom));
    float2 param = zoomUV;
    zoomUV = handleUVBounds(param);
    float4 sceneTex = tDiffuse.sample(tDiffuseSmplr, zoomUV);
    float baseReveal = smoothstep(0.02999999932944774627685546875, 0.7200000286102294921875, p);
    float heartEnvelope = sin(fast::clamp(p / 0.769999980926513671875, 0.0, 1.0) * 3.1415927410125732421875);
    float heartField = 0.0;
    for (int i = 0; i < 36; i++)
    {
        float fi = float(i) + 1.0;
        float param_1 = fi * 3.1700000762939453125;
        float2 rnd = hash21(param_1);
        float2 pos = rnd;
        float param_2 = fi * 5.730000019073486328125;
        float start = hash11(param_2) * 0.550000011920928955078125;
        float param_3 = fi * 9.31000041961669921875;
        float life = mix(0.180000007152557373046875, 0.319999992847442626953125, hash11(param_3));
        float lt = (p - start) / life;
        float aliveMask = step(0.0, lt) * step(lt, 1.0);
        float inScale = fast::clamp(lt / 0.4000000059604644775390625, 0.0, 1.0);
        float outScale = fast::clamp((1.0 - lt) / 0.60000002384185791015625, 0.0, 1.0);
        float lifeScale = fast::min(inScale, outScale);
        float param_4 = fi * 13.69999980926513671875;
        float yFloat = ((hash11(param_4) - 0.5) * 0.0199999995529651641845703125) * sin(lt * 3.1415927410125732421875);
        pos.y += yFloat;
        float param_5 = fi * 17.8999996185302734375;
        float size = (heartSize * mix(0.85000002384185791015625, 1.14999997615814208984375, hash11(param_5))) * fast::max(lifeScale, 9.9999997473787516355514526367188e-05);
        float2 param_6 = vUv;
        float2 param_7 = pos;
        float param_8 = size;
        float param_9 = pixelStep;
        float m = pixelHeartMask(param_6, param_7, param_8, param_9, ratio);
        heartField = fast::max(heartField, m * aliveMask);
    }
    float revealMask = fast::clamp(fast::max(baseReveal, heartField * (0.449999988079071044921875 + (0.550000011920928955078125 * heartEnvelope))), 0.0, 1.0);
    float3 revealed = sceneTex.xyz * revealMask;
    float tintAlpha = ((heartField * heartEnvelope) * effectStrength) * heartGlow;
    float3 tinted = revealed + (heartColor * tintAlpha);
    float2 param_10 = vUv;
    float borderMask = getHardBoundaryMask(param_10);
    return float4(fast::clamp(tinted, float3(0.0), float3(1.0)), sceneTex.w * borderMask);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.zoomStrength, in.vUv, tDiffuse, tDiffuseSmplr, buffer.heartSize, buffer.pixelStep, buffer.heartGlow, buffer.heartColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

