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
    float u_segmentCount;
    float u_scanProgress;
    float u_verticalBlurRadius;
    float u_uvYOffset;
    float u_glitchNoiseIntensity;
    float u_exposureGain;
    float u_glowIntensity;
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
float saturate0(thread const float& v)
{
    return fast::clamp(v, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float2 clampUv(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.001000000047497451305389404296875), float2(0.999000012874603271484375));
}

static inline __attribute__((always_inline))
float4 sampleVerticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusUv)
{
    float4 color = float4(0.0);
    float total = 0.0;
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        float weight = 1.0 - (abs(fi) / 4.5);
        float2 param = uv + float2(0.0, radiusUv * fi);
        float2 sampleUv = clampUv(param);
        color += (tex.sample(texSmplr, sampleUv) * weight);
        total += weight;
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& base, thread const float3& blend)
{
    return float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - blend));
}

static inline __attribute__((always_inline))
float3 overlayBlend(thread const float3& base, thread const float3& blend)
{
    float3 lowPart = (base * 2.0) * blend;
    float3 highPart = float3(1.0) - (((float3(1.0) - base) * 2.0) * (float3(1.0) - blend));
    return mix(lowPart, highPart, step(float3(0.5), base));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float segH = 1.0 / buffer.u_segmentCount;
    float topIndex = floor((1.0 - uv.y) * buffer.u_segmentCount);
    topIndex = fast::clamp(topIndex, 0.0, buffer.u_segmentCount - 1.0);
    float segTop = 1.0 - (topIndex * segH);
    float segBottom = segTop - segH;
    float param = (uv.y - segBottom) / segH;
    float localY = saturate0(param);
    float isOdd = 1.0 - mod(topIndex, 2.0);
    float directionDown = isOdd;
    float sweepPos = mix(buffer.u_scanProgress, 1.0 - buffer.u_scanProgress, directionDown);
    float restoredMask = 0.0;
    if (directionDown > 0.5)
    {
        restoredMask = step(sweepPos, localY);
    }
    else
    {
        restoredMask = step(localY, sweepPos);
    }
    float unresolvedMask = 1.0 - restoredMask;
    float blurPx = mix(buffer.u_verticalBlurRadius, 0.0, restoredMask);
    float offsetAmount = mix(buffer.u_uvYOffset, 0.0, restoredMask);
    float noiseAmount = mix(buffer.u_glitchNoiseIntensity, 0.0, restoredMask);
    float offsetSign = (mod(topIndex, 2.0) < 0.5) ? 1.0 : (-1.0);
    float2 shiftedUv = uv;
    shiftedUv.y += ((offsetSign * offsetAmount) * unresolvedMask);
    float2 param_1 = shiftedUv;
    shiftedUv = clampUv(param_1);
    float blurUv = blurPx / 600.0;
    float2 param_2 = shiftedUv;
    float param_3 = blurUv;
    float4 blurredBase = sampleVerticalBlur(texture1, texture1Smplr, param_2, param_3);
    float2 param_4 = float2(floor(uv.y * 220.0) + (topIndex * 3.099999904632568359375), floor(uv.x * 180.0) + (buffer.u_scanProgress * 97.0));
    float noiseSeed = random(param_4);
    float2 param_5 = float2(topIndex * 17.0, floor(uv.y * 96.0));
    float noiseBand = random(param_5);
    float glitchShift = ((((noiseSeed - 0.5) * 0.02999999932944774627685546875) * noiseAmount) * unresolvedMask) + (((offsetSign * offsetAmount) * 0.3499999940395355224609375) * unresolvedMask);
    float2 dir = float2(1.0, 0.1500000059604644775390625);
    float2 param_6 = shiftedUv + (dir * glitchShift);
    float2 rUv = clampUv(param_6);
    float2 param_7 = shiftedUv;
    float2 gUv = clampUv(param_7);
    float2 param_8 = shiftedUv - (dir * glitchShift);
    float2 bUv = clampUv(param_8);
    float2 param_9 = rUv;
    float param_10 = blurUv;
    float2 param_11 = gUv;
    float param_12 = blurUv;
    float2 param_13 = bUv;
    float param_14 = blurUv;
    float3 glitchColor = float3(sampleVerticalBlur(texture1, texture1Smplr, param_9, param_10).x, sampleVerticalBlur(texture1, texture1Smplr, param_11, param_12).y, sampleVerticalBlur(texture1, texture1Smplr, param_13, param_14).z);
    float gray = dot(glitchColor, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float3 saturatedBlocks = mix(float3(gray), glitchColor, float3(1.75 + (0.300000011920928955078125 * unresolvedMask)));
    float poster = 5.0 + (6.0 * unresolvedMask);
    saturatedBlocks = floor(saturatedBlocks * poster) / float3(poster);
    saturatedBlocks *= (1.0 + (buffer.u_exposureGain * (0.550000011920928955078125 + (0.449999988079071044921875 * unresolvedMask))));
    float lineWidth = 0.07500000298023223876953125;
    float glowDist = abs(localY - sweepPos);
    float glowCore = 1.0 - smoothstep(0.0, lineWidth, glowDist);
    float glowSoft = 1.0 - smoothstep(lineWidth, lineWidth * 3.5, glowDist);
    float glowMask = (fast::max(glowCore, glowSoft * 0.5) * unresolvedMask) * buffer.u_glowIntensity;
    float3 glowColorA = float3(0.2156859934329986572265625, 0.901961028575897216796875, 0.8156859874725341796875);
    float3 glowColorB = float3(0.60392200946807861328125, 0.301961004734039306640625, 1.0);
    float glowMix = 0.5 + (0.5 * sin((uv.x * 22.0) + (topIndex * 1.7000000476837158203125)));
    float3 glowColor = mix(glowColorA, glowColorB, float3(glowMix));
    float3 color = saturatedBlocks;
    float3 param_15 = color;
    float3 param_16 = glowColor * glowMask;
    color = screenBlend(param_15, param_16);
    color += ((glowColor * glowMask) * 0.37999999523162841796875);
    float2 param_17 = float2(noiseSeed * 11.0, noiseBand * 7.0);
    float3 overlayNoise = float3(0.5 + ((noiseSeed - 0.5) * noiseAmount), 0.5 + (((noiseBand - 0.5) * noiseAmount) * 0.75), 0.5 + ((random(param_17) - 0.5) * noiseAmount));
    float3 param_18 = color;
    float3 param_19 = overlayNoise;
    float param_20 = (noiseAmount * 0.60000002384185791015625) * unresolvedMask;
    color = mix(color, overlayBlend(param_18, param_19), float3(saturate0(param_20)));
    float2 param_21 = uv;
    float3 original = texture1.sample(texture1Smplr, clampUv(param_21)).xyz;
    color = mix(color, original, float3(restoredMask));
    color = mix(color, blurredBase.xyz, float3(0.0500000007450580596923828125 * unresolvedMask));
    color = fast::clamp(color, float3(0.0), float3(1.0));
    out.gl_FragColor = float4(color, 1.0);
    return out;
}

