#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float pixelSize;
    float pixelJumpIntensity;
    float flightSpeed;
    float4 gbColor1;
    float4 gbColor2;
    float4 gbColor3;
    float4 gbColor4;
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
float hash(thread const float2& p)
{
    return fract(sin(dot(p, float2(127.09999847412109375, 311.70001220703125))) * 43758.546875);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
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
    float _164 = sdHeart(param_2);
    return _164 * size;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, thread float2& vUv, constant float& pixelSize, constant float& pixelJumpIntensity, constant float& flightSpeed, constant float4& gbColor1, constant float4& gbColor2, constant float4& gbColor3, constant float4& gbColor4, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float flightT = fast::clamp(progress / 0.800000011920928955078125, 0.0, 1.0);
    float explodeT = fast::clamp((progress - 0.800000011920928955078125) / 0.20000000298023223876953125, 0.0, 1.0);
    float2 pixelUV = (floor(vUv / float2(pixelSize)) * pixelSize) + float2(pixelSize * 0.5);
    float jumpOffset = (flightT * pixelJumpIntensity) * pixelSize;
    float2 param = pixelUV * flightT;
    pixelUV.x += (((hash(param) * 2.0) - 1.0) * jumpOffset);
    float2 param_1 = pixelUV.yx * flightT;
    pixelUV.y += (((hash(param_1) * 2.0) - 1.0) * jumpOffset);
    if (explodeT > 0.0)
    {
        float2 param_2 = float2(progress);
        float2 flyDir = fast::normalize(pixelUV - float2(0.5 + (hash(param_2) * 0.20000000298023223876953125)));
        float flySpeed = (explodeT * 3.0) * flightSpeed;
        float2 param_3 = pixelUV;
        pixelUV += ((flyDir * flySpeed) * hash(param_3));
    }
    float2 param_4 = pixelUV;
    pixelUV = handleUVBounds(param_4);
    float4 heartLayer = float4(0.0);
    float4 pixelCol;
    for (int i = 0; i < 27; i++)
    {
        float2 param_5 = float2(float(i), 12.340000152587890625);
        float rand1 = hash(param_5);
        float2 param_6 = float2(float(i), 56.779998779296875);
        float rand2 = hash(param_6);
        float2 param_7 = float2(float(i), 90.12000274658203125);
        float rand3 = hash(param_7);
        float2 center = float2(rand1, rand2);
        center.y -= ((((0.300000011920928955078125 * flightT) * flightT) * (rand3 - 0.5)) * 2.0);
        float z = 10.0 * (1.0 - ((flightT * flightSpeed) * (0.60000002384185791015625 + (rand3 * 0.4000000059604644775390625))));
        if (z < 0.0)
        {
            continue;
        }
        float heartSize = 0.119999997317790985107421875 / fast::max(z, 0.100000001490116119384765625);
        float2 param_8 = pixelUV;
        float2 param_9 = center;
        float param_10 = heartSize;
        float dist = heartSDF(param_8, param_9, param_10, ratio);
        if (dist < 0.0)
        {
            float2 param_11 = float2(float(i), dist * 100.0);
            float gray = hash(param_11);
            if (gray > 0.75)
            {
                pixelCol = gbColor1;
            }
            else
            {
                if (gray > 0.5)
                {
                    pixelCol = gbColor2;
                }
                else
                {
                    if (gray > 0.25)
                    {
                        pixelCol = gbColor3;
                    }
                    else
                    {
                        pixelCol = gbColor4;
                    }
                }
            }
            float alpha = fast::clamp(1.0 - (z / 10.0), 0.0, 1.0);
            heartLayer = mix(heartLayer, pixelCol, float4(alpha));
        }
    }
    heartLayer.w *= (1.0 - explodeT);
    float4 originalTex = tDiffuse.sample(tDiffuseSmplr, vUv);
    float4 finalColor = mix(heartLayer, originalTex, float4(explodeT));
    if (progress >= 1.0)
    {
        finalColor = originalTex;
    }
    return finalColor;
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.pixelSize, buffer.pixelJumpIntensity, buffer.flightSpeed, buffer.gbColor1, buffer.gbColor2, buffer.gbColor3, buffer.gbColor4, tDiffuse, tDiffuseSmplr);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

