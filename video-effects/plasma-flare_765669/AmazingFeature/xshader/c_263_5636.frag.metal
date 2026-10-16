#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float pulseRadiusBase;
    float pulseRadiusMax;
    float u_chromatic;
    float3 gridPoint0;
    float nodeProgress0;
    float3 gridPoint1;
    float nodeProgress1;
    float3 gridPoint2;
    float nodeProgress2;
    float3 gridPoint3;
    float nodeProgress3;
    float3 gridPoint4;
    float nodeProgress4;
    float3 gridPoint5;
    float nodeProgress5;
    float3 gridPoint6;
    float nodeProgress6;
    float3 gridPoint7;
    float nodeProgress7;
    float3 gridPoint8;
    float nodeProgress8;
    float glitchIntensity;
    float arcIntensity;
    float haloStrength;
    float whiteoutIntensity;
    float3 haloTint;
    float u_brightness;
    float fadeToBlack;
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
float getNodeMask(thread const float3& point, thread const float& progress, thread const float2& uvWorld, thread float& edgeBand, constant float& pulseRadiusBase, constant float& pulseRadiusMax)
{
    float radius = mix(pulseRadiusBase, pulseRadiusMax, fast::clamp(progress, 0.0, 1.0));
    float distToPoint = distance(uvWorld, point.xy);
    float core = 1.0 - smoothstep(radius * 0.64999997615814208984375, radius, distToPoint);
    float edge = 1.0 - smoothstep(radius - 0.2199999988079071044921875, radius + 0.2199999988079071044921875, distToPoint);
    float inner = 1.0 - smoothstep(fast::max(radius - 0.550000011920928955078125, 0.0), fast::max(radius - 0.0599999986588954925537109375, 0.0), distToPoint);
    edgeBand = fast::max(edge - inner, 0.0);
    return core;
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float steppedNoise(thread const float2& uv, thread const float& steps)
{
    float2 g = floor(uv * steps);
    float2 param = g;
    return hash12(param);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = in.vUv;
    float2 param = mappedUv;
    float2 aspectUv = getAspectCorrectUV(param, buffer.ratio);
    float2 dir = aspectUv - float2(0.5);
    float chromaOffset = buffer.u_chromatic * 0.0199999995529651641845703125;
    float r = texture1.sample(texture1Smplr, fast::clamp(mappedUv + (dir * chromaOffset), float2(0.0), float2(1.0))).x;
    float g = texture1.sample(texture1Smplr, fast::clamp(mappedUv, float2(0.0), float2(1.0))).y;
    float b = texture1.sample(texture1Smplr, fast::clamp(mappedUv - (dir * chromaOffset), float2(0.0), float2(1.0))).z;
    float4 texColor = float4(r, g, b, 1.0);
    float2 uvWorld = (mappedUv * 10.0) - float2(5.0);
    float3 param_1 = buffer.gridPoint0;
    float param_2 = buffer.nodeProgress0;
    float2 param_3 = uvWorld;
    float param_4;
    float _246 = getNodeMask(param_1, param_2, param_3, param_4, buffer.pulseRadiusBase, buffer.pulseRadiusMax);
    float edge0 = param_4;
    float mask0 = _246;
    float3 param_5 = buffer.gridPoint1;
    float param_6 = buffer.nodeProgress1;
    float2 param_7 = uvWorld;
    float param_8;
    float _259 = getNodeMask(param_5, param_6, param_7, param_8, buffer.pulseRadiusBase, buffer.pulseRadiusMax);
    float edge1 = param_8;
    float mask1 = _259;
    float3 param_9 = buffer.gridPoint2;
    float param_10 = buffer.nodeProgress2;
    float2 param_11 = uvWorld;
    float param_12;
    float _272 = getNodeMask(param_9, param_10, param_11, param_12, buffer.pulseRadiusBase, buffer.pulseRadiusMax);
    float edge2 = param_12;
    float mask2 = _272;
    float3 param_13 = buffer.gridPoint3;
    float param_14 = buffer.nodeProgress3;
    float2 param_15 = uvWorld;
    float param_16;
    float _285 = getNodeMask(param_13, param_14, param_15, param_16, buffer.pulseRadiusBase, buffer.pulseRadiusMax);
    float edge3 = param_16;
    float mask3 = _285;
    float3 param_17 = buffer.gridPoint4;
    float param_18 = buffer.nodeProgress4;
    float2 param_19 = uvWorld;
    float param_20;
    float _298 = getNodeMask(param_17, param_18, param_19, param_20, buffer.pulseRadiusBase, buffer.pulseRadiusMax);
    float edge4 = param_20;
    float mask4 = _298;
    float3 param_21 = buffer.gridPoint5;
    float param_22 = buffer.nodeProgress5;
    float2 param_23 = uvWorld;
    float param_24;
    float _311 = getNodeMask(param_21, param_22, param_23, param_24, buffer.pulseRadiusBase, buffer.pulseRadiusMax);
    float edge5 = param_24;
    float mask5 = _311;
    float3 param_25 = buffer.gridPoint6;
    float param_26 = buffer.nodeProgress6;
    float2 param_27 = uvWorld;
    float param_28;
    float _324 = getNodeMask(param_25, param_26, param_27, param_28, buffer.pulseRadiusBase, buffer.pulseRadiusMax);
    float edge6 = param_28;
    float mask6 = _324;
    float3 param_29 = buffer.gridPoint7;
    float param_30 = buffer.nodeProgress7;
    float2 param_31 = uvWorld;
    float param_32;
    float _337 = getNodeMask(param_29, param_30, param_31, param_32, buffer.pulseRadiusBase, buffer.pulseRadiusMax);
    float edge7 = param_32;
    float mask7 = _337;
    float3 param_33 = buffer.gridPoint8;
    float param_34 = buffer.nodeProgress8;
    float2 param_35 = uvWorld;
    float param_36;
    float _350 = getNodeMask(param_33, param_34, param_35, param_36, buffer.pulseRadiusBase, buffer.pulseRadiusMax);
    float edge8 = param_36;
    float mask8 = _350;
    float totalMask = (((((((mask0 + mask1) + mask2) + mask3) + mask4) + mask5) + mask6) + mask7) + mask8;
    float summedMask = fast::clamp(totalMask, 0.0, 1.0);
    float overlapMask = fast::clamp(totalMask - 1.0, 0.0, 1.0);
    float totalEdge = (((((((edge0 + edge1) + edge2) + edge3) + edge4) + edge5) + edge6) + edge7) + edge8;
    float edgeMask = fast::clamp(totalEdge, 0.0, 1.0);
    float2 param_37 = float2((mappedUv.x * 3.0) + (mappedUv.y * 35.0), mappedUv.y * 40.0);
    float param_38 = 180.0;
    float glitchLines = steppedNoise(param_37, param_38);
    float2 param_39 = mappedUv * float2(90.0, 60.0);
    float param_40 = 60.0;
    float glitchBlocks = steppedNoise(param_39, param_40);
    float glitch = (step(0.7200000286102294921875, mix(glitchLines, glitchBlocks, 0.5)) * buffer.glitchIntensity) * edgeMask;
    float2 param_41 = (mappedUv * float2(40.0, 18.0)) + float2(totalMask * 1.7000000476837158203125, totalEdge * 1.2999999523162841796875);
    float param_42 = 45.0;
    float arcNoise = steppedNoise(param_41, param_42);
    float arc = ((overlapMask * buffer.arcIntensity) * smoothstep(0.449999988079071044921875, 1.0, arcNoise)) * 1.25;
    float nodeGlow = smoothstep(0.0, 1.0, summedMask) * (0.64999997615814208984375 + (buffer.haloStrength * 0.699999988079071044921875));
    float edgeFlash = edgeMask * ((0.3499999940395355224609375 + (buffer.glitchIntensity * 0.75)) + (buffer.u_chromatic * 0.800000011920928955078125));
    float detailLoss = fast::clamp((summedMask * 0.75) + (buffer.whiteoutIntensity * 0.699999988079071044921875), 0.0, 1.0);
    float3 baseColor = texColor.xyz;
    baseColor = mix(baseColor, baseColor * float3(1.7999999523162841796875, 1.7000000476837158203125, 1.9500000476837158203125), float3(detailLoss * 0.449999988079071044921875));
    float3 glowColor = buffer.haloTint * nodeGlow;
    float3 arcColor = mix(buffer.haloTint, float3(1.0), float3(0.550000011920928955078125)) * arc;
    float3 glitchColor = float3(1.0, 0.920000016689300537109375, 1.0) * glitch;
    float3 warmWhite = float3(0.95599997043609619140625, 0.9409999847412109375, 1.0);
    float3 composed = baseColor * buffer.u_brightness;
    composed += (glowColor * buffer.haloStrength);
    composed += arcColor;
    composed += glitchColor;
    composed = mix(composed, warmWhite + (buffer.haloTint * 0.07999999821186065673828125), float3(buffer.whiteoutIntensity));
    float whiteBoost = ((buffer.whiteoutIntensity * (0.449999988079071044921875 + (0.550000011920928955078125 * summedMask))) + (arc * 0.20000000298023223876953125)) + (glitch * 0.180000007152557373046875);
    composed = mix(composed, warmWhite, float3(fast::clamp(whiteBoost, 0.0, 1.0)));
    composed = mix(composed, float3(0.0), float3(buffer.fadeToBlack));
    out.gl_FragColor = float4(composed, 1.0);
    return out;
}

