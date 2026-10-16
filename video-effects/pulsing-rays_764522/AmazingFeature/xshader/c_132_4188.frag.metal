#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float blurStrength;
    float splitStrength;
    float neonIntensity;
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
float tween(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 2.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float bandMask(thread const float& d, thread const float& front, thread const float& offset, thread const float& width)
{
    float center = front + offset;
    return smoothstep(width, 0.0, abs(d - center));
}

static inline __attribute__((always_inline))
float4 sampleDirectionalBlur(thread const float2& uv, thread const float2& dir, thread const float& strength, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 o1 = (dir * strength) * 0.60000002384185791015625;
    float2 o2 = (dir * strength) * 1.2000000476837158203125;
    float2 param = uv;
    float4 c0 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param));
    float2 param_1 = uv + o1;
    float4 c1 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1));
    float2 param_2 = uv - o1;
    float4 c2 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2));
    float2 param_3 = uv + o2;
    float4 c3 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3));
    float2 param_4 = uv - o2;
    float4 c4 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4));
    return ((c0 * 0.3400000035762786865234375) + ((c1 + c2) * 0.23999999463558197021484375)) + ((c3 + c4) * 0.0900000035762786865234375);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& ratio, constant float& blurStrength, constant float& splitStrength, constant float& neonIntensity)
{
    float e = 1.0 - p;
    float zoom = 1.0 - (0.0599999986588954925537109375 * e);
    float2 uvZoom = float2(0.5) + ((vUv - float2(0.5)) * zoom);
    float2 param = uvZoom;
    uvZoom = handleUVBounds(param);
    float2 dir = fast::normalize(float2(1.0, 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05)));
    float d = dot(vUv - float2(0.5), dir);
    float dMin = -0.7200000286102294921875;
    float dMax = 0.7200000286102294921875;
    float sweep = fast::clamp(p / 0.800000011920928955078125, 0.0, 1.0);
    float frontA = mix(dMin - 0.25, dMax + 0.25, sweep);
    float frontB = mix(dMax + 0.25, dMin - 0.25, sweep);
    float param_1 = d;
    float param_2 = frontA;
    float param_3 = -0.23999999463558197021484375;
    float param_4 = 0.0500000007450580596923828125;
    float param_5 = d;
    float param_6 = frontA;
    float param_7 = -0.10999999940395355224609375;
    float param_8 = 0.08200000226497650146484375;
    float param_9 = d;
    float param_10 = frontA;
    float param_11 = 0.00999999977648258209228515625;
    float param_12 = 0.0579999983310699462890625;
    float param_13 = d;
    float param_14 = frontA;
    float param_15 = 0.12999999523162841796875;
    float param_16 = 0.09600000083446502685546875;
    float param_17 = d;
    float param_18 = frontA;
    float param_19 = 0.2599999904632568359375;
    float param_20 = 0.06599999964237213134765625;
    float bA = (((bandMask(param_1, param_2, param_3, param_4) + bandMask(param_5, param_6, param_7, param_8)) + bandMask(param_9, param_10, param_11, param_12)) + bandMask(param_13, param_14, param_15, param_16)) + bandMask(param_17, param_18, param_19, param_20);
    float param_21 = d;
    float param_22 = frontB;
    float param_23 = -0.20999999344348907470703125;
    float param_24 = 0.0540000014007091522216796875;
    float param_25 = d;
    float param_26 = frontB;
    float param_27 = -0.07999999821186065673828125;
    float param_28 = 0.0900000035762786865234375;
    float param_29 = d;
    float param_30 = frontB;
    float param_31 = 0.039999999105930328369140625;
    float param_32 = 0.056000001728534698486328125;
    float param_33 = d;
    float param_34 = frontB;
    float param_35 = 0.1599999964237213134765625;
    float param_36 = 0.1019999980926513671875;
    float param_37 = d;
    float param_38 = frontB;
    float param_39 = 0.2800000011920928955078125;
    float param_40 = 0.070000000298023223876953125;
    float bB = (((bandMask(param_21, param_22, param_23, param_24) + bandMask(param_25, param_26, param_27, param_28)) + bandMask(param_29, param_30, param_31, param_32)) + bandMask(param_33, param_34, param_35, param_36)) + bandMask(param_37, param_38, param_39, param_40);
    float activeBand = fast::clamp(fast::max(bA, bB), 0.0, 1.0);
    float sweptA = smoothstep(-0.0199999995529651641845703125, 0.07999999821186065673828125, frontA - d);
    float sweptB = smoothstep(-0.0199999995529651641845703125, 0.07999999821186065673828125, d - frontB);
    float reveal = fast::clamp(fast::max(sweptA, sweptB), 0.0, 1.0);
    float ageA = fast::clamp((frontA - d) / ((dMax - dMin) + 0.5), 0.0, 1.0);
    float ageB = fast::clamp((d - frontB) / ((dMax - dMin) + 0.5), 0.0, 1.0);
    float frontInfluence = fast::max(exp((-ageA) * 7.0), exp((-ageB) * 7.0));
    float distort = (e * (0.25 + (0.75 * frontInfluence))) * activeBand;
    float2 stretchUV = uvZoom - (dir * ((0.02999999932944774627685546875 * blurStrength) * distort));
    float2 param_41 = stretchUV;
    stretchUV = handleUVBounds(param_41);
    float4 stretched = tDiffuse.sample(tDiffuseSmplr, stretchUV);
    float2 param_42 = stretchUV;
    float2 param_43 = dir;
    float param_44 = (0.00999999977648258209228515625 * blurStrength) * distort;
    float4 blurred = sampleDirectionalBlur(param_42, param_43, param_44, tDiffuse, tDiffuseSmplr);
    float split = splitStrength * distort;
    float2 param_45 = stretchUV + (dir * split);
    float3 rgbSplit;
    rgbSplit.x = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_45)).x;
    float2 param_46 = stretchUV;
    rgbSplit.y = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_46)).y;
    float2 param_47 = stretchUV - (dir * split);
    rgbSplit.z = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_47)).z;
    float3 baseFx = mix(stretched.xyz, blurred.xyz, float3(fast::clamp(0.550000011920928955078125 * distort, 0.0, 1.0)));
    baseFx = mix(baseFx, rgbSplit, float3(fast::clamp(0.449999988079071044921875 * distort, 0.0, 1.0)));
    float3 neonA = float3(1.0, 0.25, 0.85000002384185791015625);
    float3 neonB = float3(0.64999997615814208984375, 0.3499999940395355224609375, 1.0);
    float g = fast::clamp((vUv.x * 0.64999997615814208984375) + (vUv.y * 0.3499999940395355224609375), 0.0, 1.0);
    float3 neonColor = mix(neonA, neonB, float3(g));
    float travelFade = 1.0 - (0.550000011920928955078125 * sweep);
    float3 neonAdd = ((((neonColor * activeBand) * neonIntensity) * travelFade) * e) * 0.89999997615814208984375;
    float3 revealedColor = baseFx + neonAdd;
    float3 finalRgb = mix(float3(0.0), revealedColor, float3(reveal));
    return float4(finalRgb, texel.w * reveal);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, in.vUv, buffer.ratio, buffer.blurStrength, buffer.splitStrength, buffer.neonIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

