#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_spaceFalloff;
    float u_radialBlurCenter;
    float u_radialBlurEdge;
    float u_verticalBlurCenter;
    float u_verticalBlurEdge;
    float u_exposureCenter;
    float u_exposureEdge;
    float u_progress;
    float u_bokehGlow;
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
float2 getAspectCorrectUV(thread const float2& uv, constant float& ratio)
{
    float2 aspectUV = uv;
    if (ratio > 1.0)
    {
        aspectUV.y /= ratio;
        aspectUV.y += ((1.0 - (1.0 / ratio)) * 0.5);
    }
    else
    {
        aspectUV.x *= ratio;
        aspectUV.x += ((1.0 - ratio) * 0.5);
    }
    return aspectUV;
}

static inline __attribute__((always_inline))
float getCenterDistance(thread const float2& uv, constant float& ratio)
{
    float2 param = uv;
    float2 corrected = getAspectCorrectUV(param, ratio);
    return fast::clamp(length(corrected - float2(0.5)), 0.0, 0.707106769084930419921875);
}

static inline __attribute__((always_inline))
float getSpatialFactor(thread const float2& uv, constant float& ratio, constant float& u_spaceFalloff)
{
    float2 param = uv;
    float d = getCenterDistance(param, ratio) / 0.707106769084930419921875;
    return fast::clamp(pow(d, u_spaceFalloff), 0.0, 1.0);
}

static inline __attribute__((always_inline))
float4 sampleRadialBlur(thread const float2& uv, thread const float& blurPx, constant float& ratio, texture2d<float> texture1, sampler texture1Smplr)
{
    if (blurPx <= 0.001000000047497451305389404296875)
    {
        return texture1.sample(texture1Smplr, uv);
    }
    float2 param = uv;
    float2 corrected = getAspectCorrectUV(param, ratio);
    float2 correctedCenter = float2(0.5);
    float2 dir = corrected - correctedCenter;
    float dist = length(dir);
    float2 _135;
    if (dist > 9.9999997473787516355514526367188e-05)
    {
        _135 = fast::normalize(uv - float2(0.5));
    }
    else
    {
        _135 = float2(0.0);
    }
    float2 uvDir = _135;
    float radius = blurPx / 600.0;
    float4 color = float4(0.0);
    float total = 0.0;
    for (int i = 0; i < 7; i++)
    {
        float fi = float(i);
        float t = fi / 6.0;
        float offset = (t - 0.5) * 2.0;
        float w = 1.0 - (abs(offset) * 0.699999988079071044921875);
        float2 sampleUv = fast::clamp(uv + ((uvDir * radius) * offset), float2(0.0), float2(1.0));
        color += (texture1.sample(texture1Smplr, sampleUv) * w);
        total += w;
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float4 sampleVerticalBlur(thread const float2& uv, thread const float& blurPx, constant float& ratio, texture2d<float> texture1, sampler texture1Smplr)
{
    if (blurPx <= 0.001000000047497451305389404296875)
    {
        return texture1.sample(texture1Smplr, uv);
    }
    float radius = blurPx / 600.0;
    float2 stepUv = float2(0.0, radius / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 color = float4(0.0);
    float total = 0.0;
    for (int i = 0; i < 7; i++)
    {
        float fi = float(i);
        float offset = fi - 3.0;
        float w = 1.0 - (abs(offset) / 4.0);
        float2 sampleUv = fast::clamp(uv + (stepUv * offset), float2(0.0), float2(1.0));
        color += (texture1.sample(texture1Smplr, sampleUv) * w);
        total += w;
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float circleGlow(thread const float2& uv, thread const float2& center, thread const float& radiusGlow, thread const float& softness, constant float& ratio)
{
    float2 param = uv;
    float2 param_1 = center;
    float d = length(getAspectCorrectUV(param, ratio) - getAspectCorrectUV(param_1, ratio));
    return 1.0 - smoothstep(radiusGlow, radiusGlow + softness, d);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float spaceT = getSpatialFactor(param, buffer.ratio, buffer.u_spaceFalloff);
    float radialBlur = mix(buffer.u_radialBlurCenter, buffer.u_radialBlurEdge, spaceT);
    float verticalBlur = mix(buffer.u_verticalBlurCenter, buffer.u_verticalBlurEdge, spaceT);
    float exposure = mix(buffer.u_exposureCenter, buffer.u_exposureEdge, spaceT);
    float2 param_1 = in.vUv;
    float param_2 = radialBlur;
    float4 radialColor = sampleRadialBlur(param_1, param_2, buffer.ratio, texture1, texture1Smplr);
    float2 param_3 = in.vUv;
    float param_4 = verticalBlur;
    float4 verticalColor = sampleVerticalBlur(param_3, param_4, buffer.ratio, texture1, texture1Smplr);
    float4 baseColor = mix(radialColor, verticalColor, float4(0.5));
    float2 param_5 = in.vUv;
    float2 correctedUv = getAspectCorrectUV(param_5, buffer.ratio);
    float2 correctedCenter = float2(0.5);
    float2 dir = correctedUv - correctedCenter;
    float dist = length(dir);
    float2 _358;
    if (dist > 9.9999997473787516355514526367188e-05)
    {
        _358 = dir / float2(dist);
    }
    else
    {
        _358 = float2(0.0);
    }
    float2 normalizedDir = _358;
    float outwardWave = smoothstep(0.1500000059604644775390625, 0.85000002384185791015625, buffer.u_progress);
    float2 glowCenter = float2(0.5) + ((normalizedDir * outwardWave) * 0.0599999986588954925537109375);
    float2 param_6 = in.vUv;
    float2 param_7 = glowCenter;
    float param_8 = 0.07999999821186065673828125 + (0.100000001490116119384765625 * outwardWave);
    float param_9 = 0.180000007152557373046875;
    float glowMask = circleGlow(param_6, param_7, param_8, param_9, buffer.ratio) * (1.0 - smoothstep(0.1500000059604644775390625, 0.89999997615814208984375, dist));
    float3 glowColor = (float3(1.0, 0.9700000286102294921875, 0.89999997615814208984375) * glowMask) * buffer.u_bokehGlow;
    float4 _410 = baseColor;
    float3 _412 = _410.xyz * exposure;
    baseColor.x = _412.x;
    baseColor.y = _412.y;
    baseColor.z = _412.z;
    float4 _421 = baseColor;
    float3 _423 = _421.xyz + glowColor;
    baseColor.x = _423.x;
    baseColor.y = _423.y;
    baseColor.z = _423.z;
    out.gl_FragColor = float4(baseColor.xyz, 1.0);
    return out;
}

