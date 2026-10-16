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
    float spiralTightness;
    float outlineThickness;
    float pixelSize;
    float3 outlineColor;
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
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.1415927410125732421875));
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
    float _177 = sdHeart(param_2);
    return _177 * size;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, thread float2& vUv, constant float& spiralTightness, constant float& outlineThickness, constant float& pixelSize, constant float3& outlineColor, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float maxHeartSize = getMaxShapeSize(ratio);
    float2 param = vUv;
    float2 param_1 = float2(0.5);
    float param_2 = maxHeartSize;
    float heartDist = heartSDF(param, param_1, param_2, ratio);
    if (progress <= 0.300000011920928955078125)
    {
        float spiralProgress = progress / 0.300000011920928955078125;
        float2 param_3 = vUv;
        float2 param_4 = float2(0.5);
        float2 p = getSDFCoordinate(param_3, param_4, ratio);
        float r = length(p);
        float a = precise::atan2(p.y, p.x) + 3.1415927410125732421875;
        float spiralValue = mod(a + (r * spiralTightness), 6.283185482025146484375);
        float spiralThreshold = spiralProgress * 6.283185482025146484375;
        bool _235 = abs(spiralValue - spiralThreshold) < 0.20000000298023223876953125;
        bool _243;
        if (_235)
        {
            _243 = r < (spiralProgress * 1.5);
        }
        else
        {
            _243 = _235;
        }
        bool onSpiral = _243;
        bool onHeartOutline = abs(heartDist) < (outlineThickness * (1.0 + (spiralProgress * 2.0)));
        if (onSpiral && onHeartOutline)
        {
            float2 pixelUV = (floor(vUv / float2(pixelSize)) * pixelSize) + float2(pixelSize * 0.5);
            float pixelMask = step(0.0, pixelSize - length(vUv - pixelUV));
            return float4(outlineColor * pixelMask, 1.0);
        }
        return float4(0.0, 0.0, 0.0, 1.0);
    }
    else
    {
        if (progress <= 0.89999997615814208984375)
        {
            float fillProgress = (progress - 0.300000011920928955078125) / 0.60000002384185791015625;
            float fillThreshold = maxHeartSize * (1.0 - fillProgress);
            if (heartDist > fillThreshold)
            {
                return float4(0.0, 0.0, 0.0, 1.0);
            }
            float currentPixelSize = pixelSize * (1.0 - (fillProgress * 0.949999988079071044921875));
            float2 pixelUV_1 = (floor(vUv / float2(currentPixelSize)) * currentPixelSize) + float2(currentPixelSize * 0.5);
            float2 param_5 = pixelUV_1;
            pixelUV_1 = handleUVBounds(param_5);
            float4 pixelatedTexel = tDiffuse.sample(tDiffuseSmplr, pixelUV_1);
            bool isOutline = abs(heartDist - fillThreshold) < outlineThickness;
            if (isOutline)
            {
                return float4(mix(pixelatedTexel.xyz, outlineColor, float3(0.800000011920928955078125)), 1.0);
            }
            return pixelatedTexel;
        }
        else
        {
            float finalProgress = (progress - 0.89999997615814208984375) / 0.100000001490116119384765625;
            float outlineAlpha = 1.0 - finalProgress;
            float currentPixelSize_1 = (pixelSize * 0.0500000007450580596923828125) * (1.0 - finalProgress);
            if (currentPixelSize_1 > 0.001000000047497451305389404296875)
            {
                float2 pixelUV_2 = (floor(vUv / float2(currentPixelSize_1)) * currentPixelSize_1) + float2(currentPixelSize_1 * 0.5);
                float2 param_6 = pixelUV_2;
                pixelUV_2 = handleUVBounds(param_6);
                float4 pixelatedTexel_1 = tDiffuse.sample(tDiffuseSmplr, pixelUV_2);
                bool isOutline_1 = abs(heartDist) < (outlineThickness * outlineAlpha);
                return float4(mix(pixelatedTexel_1.xyz, outlineColor, float3((outlineAlpha * 0.300000011920928955078125) * float(isOutline_1))), 1.0);
            }
            return texel;
        }
    }
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.spiralTightness, buffer.outlineThickness, buffer.pixelSize, buffer.outlineColor, tDiffuse, tDiffuseSmplr);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

