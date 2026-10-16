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
    float2 uvScale;
    float2 uvOffset;
    float3 glowColorFar;
    float3 glowColorNear;
    float glowIntensity;
    float u_brightness;
    float progress;
    float layerCount;
    spvUnsafeArray<float, 12> depthOffsetsStart;
    spvUnsafeArray<float, 12> depthOffsetsEnd;
    float u_grayscale;
    float u_chromatic;
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
float4 sampleBlurredLayer(thread const float2& uv, thread const float& blurStrength, thread const float& stretchAmount, thread const float& chroma, thread const float& layerT, constant float& ratio, constant float2& uvScale, constant float2& uvOffset, texture2d<float> texture1, sampler texture1Smplr, thread float2& vUv, constant float3& glowColorFar, constant float3& glowColorNear, constant float& glowIntensity, constant float& u_brightness)
{
    float2 mappedUv = (uv * uvScale) + uvOffset;
    float2 center = float2(0.5);
    float2 dir = mappedUv - center;
    float2 stretchUv = mappedUv;
    stretchUv.y = center.y + ((stretchUv.y - center.y) * (1.0 + stretchAmount));
    float blurX = blurStrength * 0.00150000001303851604461669921875;
    float blurY = (blurStrength * 0.00150000001303851604461669921875) / fast::max(ratio, 9.9999997473787516355514526367188e-05);
    float2 chromaDir = (fast::normalize(dir + float2(9.9999997473787516355514526367188e-05)) * chroma) * 0.0199999995529651641845703125;
    float2 uv0 = fast::clamp(stretchUv, float2(0.0), float2(1.0));
    float2 uv1 = fast::clamp(stretchUv + float2(-blurX, -blurY), float2(0.0), float2(1.0));
    float2 uv2 = fast::clamp(stretchUv + float2(blurX, -blurY), float2(0.0), float2(1.0));
    float2 uv3 = fast::clamp(stretchUv + float2(-blurX, blurY), float2(0.0), float2(1.0));
    float2 uv4 = fast::clamp(stretchUv + float2(blurX, blurY), float2(0.0), float2(1.0));
    float2 uv5 = fast::clamp(stretchUv + float2(0.0, (-blurY) * 1.5), float2(0.0), float2(1.0));
    float2 uv6 = fast::clamp(stretchUv + float2(0.0, blurY * 1.5), float2(0.0), float2(1.0));
    float4 base0 = texture1.sample(texture1Smplr, uv0);
    float4 base1 = texture1.sample(texture1Smplr, uv1);
    float4 base2 = texture1.sample(texture1Smplr, uv2);
    float4 base3 = texture1.sample(texture1Smplr, uv3);
    float4 base4 = texture1.sample(texture1Smplr, uv4);
    float4 base5 = texture1.sample(texture1Smplr, uv5);
    float4 base6 = texture1.sample(texture1Smplr, uv6);
    float4 blurred = ((((((base0 * 0.2199999988079071044921875) + (base1 * 0.12999999523162841796875)) + (base2 * 0.12999999523162841796875)) + (base3 * 0.12999999523162841796875)) + (base4 * 0.12999999523162841796875)) + (base5 * 0.12999999523162841796875)) + (base6 * 0.12999999523162841796875);
    float r = texture1.sample(texture1Smplr, fast::clamp(stretchUv + chromaDir, float2(0.0), float2(1.0))).x;
    float g = texture1.sample(texture1Smplr, fast::clamp(stretchUv, float2(0.0), float2(1.0))).y;
    float b = texture1.sample(texture1Smplr, fast::clamp(stretchUv - chromaDir, float2(0.0), float2(1.0))).z;
    float3 chromaColor = float3(r, g, b);
    float4 texColor = mix(blurred, float4(chromaColor, blurred.w), float4(fast::clamp(chroma * 4.0, 0.0, 1.0)));
    float2 param = vUv;
    float edgeMask = smoothstep(0.20000000298023223876953125, 0.949999988079071044921875, length(getAspectCorrectUV(param, ratio) - center));
    edgeMask += smoothstep(0.0500000007450580596923828125, 0.300000011920928955078125, abs(vUv.y - 0.5) * (1.0 + stretchAmount));
    edgeMask = fast::clamp(edgeMask, 0.0, 1.0);
    float3 glowColor = mix(glowColorFar, glowColorNear, float3(layerT));
    float _332 = texColor.w;
    float4 _336 = texColor;
    float3 _338 = _336.xyz + ((((glowColor * edgeMask) * glowIntensity) * _332) * 0.800000011920928955078125);
    texColor.x = _338.x;
    texColor.y = _338.y;
    texColor.z = _338.z;
    float4 _347 = texColor;
    float3 _349 = _347.xyz * u_brightness;
    texColor.x = _349.x;
    texColor.y = _349.y;
    texColor.z = _349.z;
    return texColor;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float4 accum = float4(0.0);
    float p = fast::clamp(buffer.progress, 0.0, 1.0);
    for (int i = 0; i < 12; i++)
    {
        if (float(i) >= buffer.layerCount)
        {
            break;
        }
        float layerT = float(i) / fast::max(buffer.layerCount - 1.0, 1.0);
        float depthOffset = mix(buffer.depthOffsetsStart[i], buffer.depthOffsetsEnd[i], p);
        float depthNorm = fast::clamp((-depthOffset) / 6.599999904632568359375, 0.0, 1.0);
        float startBlur = mix(40.0, 20.0, layerT);
        float startStretch = mix(0.699999988079071044921875, 0.300000011920928955078125, layerT);
        float currentBlur = mix(startBlur, 0.0, p);
        float currentStretch = mix(startStretch, 0.0, p);
        float currentGlow = mix(1.0, 0.0, p) * depthNorm;
        float currentChromatic = mix(0.119999997317790985107421875, 0.0, p) * depthNorm;
        float2 param = in.vUv;
        float param_1 = currentBlur;
        float param_2 = currentStretch;
        float param_3 = currentChromatic;
        float param_4 = layerT;
        float4 layerColor = sampleBlurredLayer(param, param_1, param_2, param_3, param_4, buffer.ratio, buffer.uvScale, buffer.uvOffset, texture1, texture1Smplr, in.vUv, buffer.glowColorFar, buffer.glowColorNear, buffer.glowIntensity, buffer.u_brightness);
        float alphaWeight = (1.0 / buffer.layerCount) * mix(1.25, 0.85000002384185791015625, layerT);
        layerColor.w *= alphaWeight;
        float4 _465 = accum;
        float _473 = accum.w;
        float3 _476 = _465.xyz + ((layerColor.xyz * layerColor.w) * (1.0 - _473));
        accum.x = _476.x;
        accum.y = _476.y;
        accum.z = _476.z;
        accum.w += (layerColor.w * (1.0 - accum.w));
        float _503 = accum.w;
        float4 _506 = accum;
        float3 _508 = _506.xyz + (((mix(buffer.glowColorFar, buffer.glowColorNear, float3(layerT)) * currentGlow) * 0.02999999932944774627685546875) * (1.0 - _503));
        accum.x = _508.x;
        accum.y = _508.y;
        accum.z = _508.z;
    }
    float2 mappedUv = (in.vUv * buffer.uvScale) + buffer.uvOffset;
    float4 clearTex = texture1.sample(texture1Smplr, fast::clamp(mappedUv, float2(0.0), float2(1.0)));
    float4 finalColor = mix(accum, clearTex, float4(p));
    float gray = dot(finalColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _545 = finalColor;
    float3 _552 = mix(_545.xyz, float3(gray), float3(buffer.u_grayscale));
    finalColor.x = _552.x;
    finalColor.y = _552.y;
    finalColor.z = _552.z;
    if (buffer.u_chromatic > 0.0)
    {
        float2 dir = mappedUv - float2(0.5);
        float offset = buffer.u_chromatic * 0.0199999995529651641845703125;
        float rr = texture1.sample(texture1Smplr, fast::clamp(mappedUv + (dir * offset), float2(0.0), float2(1.0))).x;
        float gg = texture1.sample(texture1Smplr, fast::clamp(mappedUv, float2(0.0), float2(1.0))).y;
        float bb = texture1.sample(texture1Smplr, fast::clamp(mappedUv - (dir * offset), float2(0.0), float2(1.0))).z;
        float3 _605 = float3(rr, gg, bb);
        finalColor.x = _605.x;
        finalColor.y = _605.y;
        finalColor.z = _605.z;
    }
    out.gl_FragColor = float4(finalColor.xyz, fast::clamp(finalColor.w, 0.0, 1.0));
    return out;
}

