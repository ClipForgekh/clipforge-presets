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

// Implementation of the GLSL radians() function
template<typename T>
inline T radians(T d)
{
    return d * T(0.01745329251);
}

struct buffer_t
{
    float ratio;
    float rotationAngle;
    float2 dotsShift;
    float dotsRelativeWidth;
    float dotFreq;
    float2 alternateShift;
    float blackDots;
    float useRings;
    float colorMode;
    float dotsSharpen;
    float dotsLighten;
    float ringThickness;
    float ringCount;
    float ringPhase;
    float redOffsetX;
    float redOffsetY;
    float greenOffsetX;
    float greenOffsetY;
    float blueOffsetX;
    float blueOffsetY;
    float3 color2;
    float3 color1;
    float intensity;
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
float2 transformCoords(thread float2& uv, thread const float& angle, thread const float2& shift, thread const float2& scale, constant float& ratio)
{
    uv -= shift;
    uv -= float2(0.5);
    uv.x *= ratio;
    float s = sin(angle);
    float c = cos(angle);
    uv = float2x2(float2(c, -s), float2(s, c)) * uv;
    uv *= scale;
    uv += float2(0.5);
    return uv;
}

static inline __attribute__((always_inline))
float halftoneRings(thread const float2& cellUV, thread const float& intensity, thread const bool& isBlackDots, thread const float& sharpen, thread const float& lighten, thread const float& thickness, thread const float& count, thread const float& phase)
{
    float dist = length(cellUV - float2(0.5));
    if (isBlackDots)
    {
        dist = 1.0 - dist;
    }
    float rings = fract(((dist * count) + phase) * 0.5);
    float ringMask = smoothstep(0.5 - thickness, 0.5, rings) - smoothstep(0.5, 0.5 + thickness, rings);
    return smoothstep(-sharpen, sharpen, (intensity - ringMask) + lighten);
}

static inline __attribute__((always_inline))
float halftoneDots(thread const float2& cellUV, thread const float& intensity, thread const bool& isBlackDots, thread const float& sharpen, thread const float& lighten)
{
    float dist = length(cellUV - float2(0.5));
    if (isBlackDots)
    {
        dist = 1.0 - dist;
    }
    return smoothstep(-sharpen, sharpen, (intensity - dist) + lighten);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 inputColor = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float3 color = inputColor.xyz / float3(fast::max(inputColor.w, 0.001000000047497451305389404296875));
    float luminance = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float2 param = in.vUv;
    float param_1 = radians(buffer.rotationAngle);
    float2 param_2 = buffer.dotsShift;
    float2 param_3 = float2(buffer.dotsRelativeWidth, 1.0);
    float2 _188 = transformCoords(param, param_1, param_2, param_3, buffer.ratio);
    float2 transformedUV = _188;
    float2 cellSize = float2(1.0 / buffer.dotFreq);
    float2 cellIndex = floor(transformedUV / cellSize);
    float2 cellUV = fract((transformedUV + float2(mod(cellIndex.y, 2.0) * buffer.alternateShift.x, mod(cellIndex.x, 2.0) * buffer.alternateShift.y)) / cellSize);
    bool isBlackDots = buffer.blackDots > 0.5;
    bool isRings = buffer.useRings > 0.5;
    float3 result;
    if (buffer.colorMode < 0.5)
    {
        if (isRings)
        {
            float2 param_4 = cellUV;
            float param_5 = luminance;
            bool param_6 = isBlackDots;
            float param_7 = buffer.dotsSharpen;
            float param_8 = buffer.dotsLighten;
            float param_9 = buffer.ringThickness;
            float param_10 = buffer.ringCount;
            float param_11 = buffer.ringPhase;
            result = float3(halftoneRings(param_4, param_5, param_6, param_7, param_8, param_9, param_10, param_11));
        }
        else
        {
            float2 param_12 = cellUV;
            float param_13 = luminance;
            bool param_14 = isBlackDots;
            float param_15 = buffer.dotsSharpen;
            float param_16 = buffer.dotsLighten;
            result = float3(halftoneDots(param_12, param_13, param_14, param_15, param_16));
        }
    }
    else
    {
        spvUnsafeArray<float2, 3> colorOffsets;
        colorOffsets[0] = float2(buffer.redOffsetX, buffer.redOffsetY) * 0.5;
        colorOffsets[1] = float2(buffer.greenOffsetX, buffer.greenOffsetY) * 0.5;
        colorOffsets[2] = float2(buffer.blueOffsetX, buffer.blueOffsetY) * 0.5;
        bool invertDots = (buffer.colorMode > 1.5) ? false : true;
        for (int i = 0; i < 3; i++)
        {
            float2 offsetCellUV = cellUV + colorOffsets[i];
            if (isRings)
            {
                float2 param_17 = offsetCellUV;
                float param_18 = color[i];
                bool param_19 = invertDots;
                float param_20 = buffer.dotsSharpen;
                float param_21 = buffer.dotsLighten;
                float param_22 = buffer.ringThickness;
                float param_23 = buffer.ringCount;
                float param_24 = buffer.ringPhase;
                result[i] = halftoneRings(param_17, param_18, param_19, param_20, param_21, param_22, param_23, param_24);
            }
            else
            {
                float2 param_25 = offsetCellUV;
                float param_26 = color[i];
                bool param_27 = invertDots;
                float param_28 = buffer.dotsSharpen;
                float param_29 = buffer.dotsLighten;
                result[i] = halftoneDots(param_25, param_26, param_27, param_28, param_29);
            }
        }
    }
    float3 finalColor = mix(buffer.color2, buffer.color1, result);
    float3 originalColor = inputColor.xyz;
    float3 halftoneColor = finalColor * inputColor.w;
    out.gl_FragColor = float4(mix(originalColor, halftoneColor, float3(buffer.intensity)), inputColor.w);
    return out;
}

