#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float maxPixelSize;
    float heartCount;
    float heartEdgeBlur;
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
    return 1.0 - pow(1.0 - progress, 2.0);
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
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
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
        return sqrt(dot(p - float2(0.25, 0.75), p - float2(0.25, 0.75))) - 0.3535533845424652099609375;
    }
    return sqrt(fast::min(dot(p - float2(0.0, 1.0), p - float2(0.0, 1.0)), dot(p - float2(0.5), p - float2(0.5)))) * sign(p.x - p.y);
}

static inline __attribute__((always_inline))
float heartSDF(thread const float2& uv, thread const float2& center, thread const float& size, constant float& ratio)
{
    float2 param = uv;
    float2 param_1 = center;
    float2 p = getSDFCoordinate(param, param_1, ratio);
    p /= float2(fast::max(size, 9.9999997473787516355514526367188e-05));
    p.y += 0.449999988079071044921875;
    float2 param_2 = p;
    float _215 = sdHeart(param_2);
    return _215 * size;
}

static inline __attribute__((always_inline))
float generateHeartMask(thread const float2& uv, thread const float2& center, thread const float& size, thread const float& blurEdge, constant float& ratio)
{
    float2 param = uv;
    float2 param_1 = center;
    float param_2 = size;
    float dist = heartSDF(param, param_1, param_2, ratio);
    return 1.0 - smoothstep(-blurEdge, blurEdge, dist);
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, constant float& maxPixelSize, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& heartCount, constant float& heartEdgeBlur)
{
    float param = progress;
    float t = tween(param);
    float maxSize = getMaxShapeSize(ratio);
    float pixelSize = (1.0 - t) * maxPixelSize;
    float2 pixelUV = vUv;
    if (pixelSize > 9.9999997473787516355514526367188e-05)
    {
        pixelUV = (floor(vUv / float2(pixelSize)) * pixelSize) + float2(pixelSize * 0.5);
    }
    float2 param_1 = pixelUV;
    pixelUV = handleUVBounds(param_1);
    float4 pixelColor = tDiffuse.sample(tDiffuseSmplr, pixelUV);
    float totalMask = 0.0;
    int count = int(floor(heartCount));
    for (int i = 0; i < 30; i++)
    {
        if (i >= count)
        {
            break;
        }
        float2 randSeed = float2(float(i) * 0.123000003397464752197265625, float(i) * 0.4560000002384185791015625);
        float2 param_2 = randSeed;
        float2 param_3 = randSeed + float2(0.100000001490116119384765625);
        float2 heartCenter = float2(random(param_2), random(param_3));
        float2 param_4 = randSeed + float2(0.20000000298023223876953125);
        float delay = random(param_4) * 0.60000002384185791015625;
        float heartProgress = fast::clamp(t - delay, 0.0, 1.0) / (1.0 - delay);
        float currentSize = heartProgress * maxSize;
        float2 param_5 = vUv;
        float2 param_6 = heartCenter;
        float param_7 = currentSize;
        float param_8 = heartEdgeBlur;
        float heartMask = generateHeartMask(param_5, param_6, param_7, param_8, ratio);
        totalMask += heartMask;
    }
    totalMask = fast::clamp(totalMask, 0.0, 1.0);
    float2 param_9 = vUv;
    float borderMask = getHardBoundaryMask(param_9);
    return float4(pixelColor.xyz, (pixelColor.w * totalMask) * borderMask);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.maxPixelSize, in.vUv, tDiffuse, tDiffuseSmplr, buffer.heartCount, buffer.heartEdgeBlur);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

