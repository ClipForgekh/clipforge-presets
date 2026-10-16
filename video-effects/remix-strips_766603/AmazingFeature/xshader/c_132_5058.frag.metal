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

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float ratio;
    float glitchIntensity;
    int bandCount;
    float delayStep;
    float bandThickness;
    float3 neonColor1;
    float3 neonColor2;
    float blurMax;
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
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurPixels, constant float& ratio)
{
    float4 color = float4(0.0);
    float _step = 1.0 / (1080.0 * ratio);
    float blurStrength = blurPixels * _step;
    float totalWeight = 0.0;
    spvUnsafeArray<float, 9> kernel0;
    kernel0[0] = 0.02850000001490116119384765625;
    kernel0[1] = 0.067199997603893280029296875;
    kernel0[2] = 0.123800002038478851318359375;
    kernel0[3] = 0.1789000034332275390625;
    kernel0[4] = 0.2030999958515167236328125;
    kernel0[5] = 0.1789000034332275390625;
    kernel0[6] = 0.123800002038478851318359375;
    kernel0[7] = 0.067199997603893280029296875;
    kernel0[8] = 0.02850000001490116119384765625;
    for (int i = -4; i <= 4; i++)
    {
        float weight = kernel0[i + 4];
        float2 offset = float2(0.0, float(i) * blurStrength);
        float2 param = uv + offset;
        float2 sampleUV = handleUVBounds(param);
        color += (tex.sample(texSmplr, sampleUV) * weight);
        totalWeight += weight;
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, constant float& glitchIntensity, thread float2& vUv, constant int& bandCount, constant float& delayStep, constant float& bandThickness, constant float3& neonColor1, constant float3& neonColor2, constant float& blurMax, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float t = progress;
    if (t >= 1.0)
    {
        return texel;
    }
    float glitchFactor = step(t, 0.800000011920928955078125) * glitchIntensity;
    float2 glitchUV = vUv;
    float2 param = glitchUV + float2(t);
    glitchUV.x += (((random(param) * glitchFactor) * 2.0) - glitchFactor);
    float2 param_1 = (glitchUV * 2.0) + float2(t);
    glitchUV.y += (((random(param_1) * glitchFactor) * 0.5) - (glitchFactor * 0.25));
    float bands = float(bandCount);
    float bandWidth = 1.0 / bands;
    float bandIndex = floor(glitchUV.x / bandWidth);
    float uvInBand = mod(glitchUV.x, bandWidth) / bandWidth;
    float bandDelay = (float(int(mod(bandIndex, 2.0))) * delayStep) + ((float(int(bandIndex)) * delayStep) * 0.5);
    float bandT = fast::clamp((t * 1.39999997615814208984375) - bandDelay, 0.0, 1.0);
    bool isOdd = mod(bandIndex, 2.0) == 1.0;
    float _261;
    if (isOdd)
    {
        _261 = bandT;
    }
    else
    {
        _261 = 1.0 - bandT;
    }
    float bandPos = _261;
    float _271;
    if (isOdd)
    {
        _271 = step(glitchUV.y, bandT);
    }
    else
    {
        _271 = step(1.0 - bandT, glitchUV.y);
    }
    float scanMask = _271;
    float _287;
    if (isOdd)
    {
        _287 = fast::clamp(glitchUV.y / fast::max(bandT, 0.001000000047497451305389404296875), 0.0, 1.0);
    }
    else
    {
        _287 = fast::clamp((1.0 - glitchUV.y) / fast::max(bandT, 0.001000000047497451305389404296875), 0.0, 1.0);
    }
    float scanProgress = _287;
    float bandDist = abs(glitchUV.y - bandPos);
    float bandMask = smoothstep(bandThickness, 0.0, bandDist);
    float3 neonColor = mix(neonColor1, neonColor2, float3(uvInBand + (bandIndex * 0.100000001490116119384765625)));
    float neonGlow = (bandMask * (1.0 - t)) * 2.0;
    float nextBandIndex = bandIndex + 1.0;
    float nextBandDelay = (float(int(mod(nextBandIndex, 2.0))) * delayStep) + ((float(int(nextBandIndex)) * delayStep) * 0.5);
    float nextBandT = fast::clamp((t * 1.39999997615814208984375) - nextBandDelay, 0.0, 1.0);
    float _365;
    if (mod(nextBandIndex, 2.0) == 1.0)
    {
        _365 = nextBandT;
    }
    else
    {
        _365 = 1.0 - nextBandT;
    }
    float nextBandPos = _365;
    float nextBandDist = abs(glitchUV.y - nextBandPos);
    float overlapMask = bandMask * smoothstep(bandThickness * 1.5, 0.0, nextBandDist);
    float3 overlapGlow = (float3(1.0) * overlapMask) * 3.0;
    float blurStrength = blurMax * (1.0 - (scanMask * scanProgress));
    float2 param_2 = glitchUV;
    float param_3 = blurStrength;
    float4 blurredTex = verticalBlur(tDiffuse, tDiffuseSmplr, param_2, param_3, ratio);
    float brightness = mix(0.20000000298023223876953125, 1.0, scanMask * scanProgress);
    float saturation = mix(0.100000001490116119384765625, 1.0, scanMask * scanProgress);
    float gray = dot(blurredTex.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float3 baseColor = mix(float3(gray), blurredTex.xyz, float3(saturation)) * brightness;
    float3 finalColor = (baseColor + (neonColor * neonGlow)) + overlapGlow;
    float2 param_4 = (glitchUV * 100.0) + float2(t);
    float2 param_5 = float2(t * 10.0);
    float glitchFlash = ((random(param_4) * step(0.800000011920928955078125, random(param_5))) * glitchFactor) * 2.0;
    finalColor += float3(glitchFlash);
    finalColor = mix(finalColor, texel.xyz, float3(smoothstep(0.699999988079071044921875, 1.0, t)));
    return float4(finalColor, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.glitchIntensity, in.vUv, buffer.bandCount, buffer.delayStep, buffer.bandThickness, buffer.neonColor1, buffer.neonColor2, buffer.blurMax, tDiffuse, tDiffuseSmplr);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

