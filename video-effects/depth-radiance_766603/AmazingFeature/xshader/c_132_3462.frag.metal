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
    float progress;
    float layerCount;
    float maxBlur;
    float3 glowColor;
    float grainIntensity;
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
    float _119;
    if (p < 0.5)
    {
        _119 = ((4.0 * p) * p) * p;
    }
    else
    {
        _119 = 1.0 - (pow(((-2.0) * p) + 2.0, 3.0) * 0.5);
    }
    return _119;
}

static inline __attribute__((always_inline))
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurAmount)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    spvUnsafeArray<float, 5> weights;
    weights[0] = 0.05449999868869781494140625;
    weights[1] = 0.24420000612735748291015625;
    weights[2] = 0.402599990367889404296875;
    weights[3] = 0.24420000612735748291015625;
    weights[4] = 0.05449999868869781494140625;
    float stepSize = blurAmount * 0.0199999995529651641845703125;
    for (int i = -2; i <= 2; i++)
    {
        float2 offset = float2(0.0, float(i) * stepSize);
        float2 sampleUV = fast::clamp(uv + offset, float2(0.0), float2(1.0));
        color += (tex.sample(texSmplr, sampleUV) * weights[i + 2]);
        totalWeight += weights[i + 2];
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], texture2d<float> tDiffuse1 [[texture(1)]], sampler tDiffuseSmplr [[sampler(0)]], sampler tDiffuse1Smplr [[sampler(1)]])
{
    main0_out out = {};
    float param = buffer.progress;
    float t = tween(param);
    float phase = step(0.5, t);
    float _154;
    if (phase == 0.0)
    {
        _154 = t * 2.0;
    }
    else
    {
        _154 = (t - 0.5) * 2.0;
    }
    float phaseProgress = _154;
    float4 finalColor = float4(0.0);
    float layerStep = 1.0 / buffer.layerCount;
    float _187;
    for (float i = 0.0; i < 10.0; i += 1.0)
    {
        if (i >= buffer.layerCount)
        {
            break;
        }
        if (phase == 0.0)
        {
            _187 = phaseProgress * (1.0 + (i * layerStep));
        }
        else
        {
            _187 = (1.0 - phaseProgress) * (1.0 + (i * layerStep));
        }
        float zOffset = _187;
        float scale = 1.0 + (zOffset * 0.5);
        if (phase == 1.0)
        {
            scale += ((sin(phaseProgress * 12.5659999847412109375) * 0.02999999932944774627685546875) * (1.0 - phaseProgress));
        }
        float2 layerUV = ((in.vUv - float2(0.5)) / float2(scale)) + float2(0.5);
        layerUV = fast::clamp(layerUV, float2(0.0), float2(1.0));
        float blurAmount = buffer.maxBlur * zOffset;
        float2 param_1 = layerUV;
        float param_2 = blurAmount;
        float4 layerColorA = verticalBlur(tDiffuse, tDiffuseSmplr, param_1, param_2);
        float2 param_3 = layerUV;
        float param_4 = blurAmount;
        float4 layerColorB = verticalBlur(tDiffuse1, tDiffuse1Smplr, param_3, param_4);
        float4 layerColor = mix(layerColorA, layerColorB, float4(phase));
        float layerWeight = (((i + 1.0) / buffer.layerCount) * layerStep) * 2.0;
        float luminance = dot(layerColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
        float3 glow = ((buffer.glowColor * pow(luminance, 3.0)) * blurAmount) * 2.0;
        float4 _293 = layerColor;
        float3 _295 = _293.xyz + glow;
        layerColor.x = _295.x;
        layerColor.y = _295.y;
        layerColor.z = _295.z;
        finalColor += (layerColor * layerWeight);
    }
    float centerGlow = pow(sin(t * 3.1415927410125732421875), 8.0) * 1.5;
    float4 _324 = finalColor;
    float3 _326 = _324.xyz + (buffer.glowColor * centerGlow);
    finalColor.x = _326.x;
    finalColor.y = _326.y;
    finalColor.z = _326.z;
    float2 param_5 = in.vUv + float2(t * 10.0);
    float grain = random(param_5);
    float _344;
    if (phase == 0.0)
    {
        _344 = buffer.grainIntensity;
    }
    else
    {
        _344 = mix(buffer.grainIntensity, 0.100000001490116119384765625 * buffer.grainIntensity, phaseProgress);
    }
    float grainAmount = _344;
    float4 _360 = finalColor;
    float3 _363 = _360.xyz + float3(grain * grainAmount);
    finalColor.x = _363.x;
    finalColor.y = _363.y;
    finalColor.z = _363.z;
    if (buffer.progress <= 0.00999999977648258209228515625)
    {
        finalColor = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    }
    if (buffer.progress >= 0.9900000095367431640625)
    {
        finalColor = tDiffuse1.sample(tDiffuse1Smplr, in.vUv);
    }
    out.gl_FragColor = fast::clamp(finalColor, float4(0.0), float4(1.0));
    return out;
}

