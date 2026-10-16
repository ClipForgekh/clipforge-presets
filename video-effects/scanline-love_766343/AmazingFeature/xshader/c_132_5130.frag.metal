#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    float ratio;
    float pixelSize;
    float scanLineIntensity;
    float3 lightPink;
    float3 offWhite;
    float3 darkGray;
    float bounceIntensity;
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
float random(thread const float2& p)
{
    return fract(sin(dot(p, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
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
    float _161 = sdHeart(param_2);
    return _161 * size;
}

static inline __attribute__((always_inline))
float generatePixelHeartMask(thread const float2& uv, thread const float2& center, thread const float& size, constant float& ratio)
{
    float2 param = uv;
    float2 param_1 = center;
    float param_2 = size;
    float dist = heartSDF(param, param_1, param_2, ratio);
    return step(dist, 0.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, constant float& pixelSize, thread float2& vUv, constant float& scanLineIntensity, constant float3& lightPink, constant float3& offWhite, constant float3& darkGray, constant float& bounceIntensity)
{
    float pixelUV = pixelSize / 1080.0;
    float2 pixelatedUV = (floor(vUv / float2(pixelUV)) * pixelUV) + float2(pixelUV * 0.5);
    float _200;
    if (progress < 0.5)
    {
        _200 = progress * 2.0;
    }
    else
    {
        _200 = (1.0 - progress) * 2.0;
    }
    float phase = _200;
    bool isGatherPhase = progress < 0.5;
    float gray = dot(texel.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float saturation = smoothstep(0.5, 1.0, progress);
    float brightness = 0.25 + (progress * 0.75);
    float3 baseColor = mix(float3(gray) * brightness, texel.xyz, float3(saturation));
    float scanLine = (step(0.5, fract((pixelatedUV.y * 1080.0) / 2.0)) * scanLineIntensity) * (1.0 - progress);
    baseColor -= float3(scanLine);
    spvUnsafeArray<float2, 8> heartStartPositions;
    heartStartPositions[0] = float2(-0.20000000298023223876953125);
    heartStartPositions[1] = float2(-0.20000000298023223876953125, 1.2000000476837158203125);
    heartStartPositions[2] = float2(1.2000000476837158203125, -0.20000000298023223876953125);
    heartStartPositions[3] = float2(1.2000000476837158203125);
    heartStartPositions[4] = float2(-0.5, 0.5);
    heartStartPositions[5] = float2(1.5, 0.5);
    heartStartPositions[6] = float2(0.5, -0.300000011920928955078125);
    heartStartPositions[7] = float2(0.5, 1.2999999523162841796875);
    spvUnsafeArray<float3, 3> heartColors;
    heartColors[0] = lightPink;
    heartColors[1] = offWhite;
    heartColors[2] = darkGray;
    float3 heartLayer = float3(0.0);
    float heartAlpha = 0.0;
    float _360;
    for (int i = 0; i < 8; i++)
    {
        float2 param = float2(float(i), 0.0);
        float rnd = random(param);
        float2 dir = float2(0.5) - heartStartPositions[i];
        float bounceY = (sin((phase * 3.141590118408203125) * (1.0 + (rnd * 0.5))) * bounceIntensity) * (1.0 - phase);
        float2 currentPos = (heartStartPositions[i] + (dir * phase)) + float2(0.0, bounceY);
        if (isGatherPhase)
        {
            _360 = 0.4000000059604644775390625 + (phase * 0.699999988079071044921875);
        }
        else
        {
            _360 = 1.10000002384185791015625 - ((1.0 - phase) * 1.10000002384185791015625);
        }
        float scale = _360;
        scale *= (0.89999997615814208984375 + (rnd * 0.20000000298023223876953125));
        float deform = sin(phase * 3.141590118408203125) * 0.100000001490116119384765625;
        float2 deformUV = pixelatedUV;
        deformUV.y += (deform * abs(deformUV.x - 0.5));
        float heartSize = (scale * 0.1500000059604644775390625) * (1.0 + (rnd * 0.300000011920928955078125));
        float2 param_1 = deformUV;
        float2 param_2 = currentPos;
        float param_3 = heartSize;
        float mask = generatePixelHeartMask(param_1, param_2, param_3, ratio);
        int colorIdx = int(floor(rnd * 3.0));
        heartLayer += (heartColors[colorIdx] * mask);
        heartAlpha += mask;
    }
    float _437;
    if (isGatherPhase)
    {
        _437 = phase;
    }
    else
    {
        _437 = (1.0 - phase) * 1.5;
    }
    float heartOpacity = _437;
    float3 finalColor = mix(baseColor, heartLayer, float3(fast::clamp(heartAlpha * heartOpacity, 0.0, 1.0)));
    return float4(finalColor, 1.0);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.pixelSize, in.vUv, buffer.scanLineIntensity, buffer.lightPink, buffer.offWhite, buffer.darkGray, buffer.bounceIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

