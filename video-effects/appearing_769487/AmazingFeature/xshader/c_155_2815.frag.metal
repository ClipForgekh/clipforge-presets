#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float2 uvScale;
    float2 uvOffset;
    float4 u_panelProgress;
    float u_openWidth;
    float u_feather;
    float u_seamGap;
    float u_merge;
    float u_chromatic;
    float u_grayscale;
    float u_brightness;
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
float panelMask(thread const float2& p, thread const float2& dir, thread const float& prog, thread const float& width, thread const float& feather, thread const float& seamGap)
{
    float2 q = float2(p.x * dir.x, p.y * dir.y);
    bool _81 = q.x <= 0.0;
    bool _88;
    if (!_81)
    {
        _88 = q.y <= 0.0;
    }
    else
    {
        _88 = _81;
    }
    if (_88)
    {
        return 0.0;
    }
    float extent = mix(0.014999999664723873138427734375, 0.5, fast::clamp(prog, 0.0, 1.0));
    float radiusVal = fast::max(q.x, q.y);
    float radialMask = 1.0 - smoothstep(extent - feather, extent + feather, radiusVal);
    float diagDist = abs(q.x - q.y);
    float maxWidth = width + (prog * 0.2800000011920928955078125);
    float wedgeMask = 1.0 - smoothstep(maxWidth - feather, maxWidth + feather, diagDist);
    float axisDist = fast::min(q.x, q.y);
    float seamMask = smoothstep(seamGap, seamGap + feather, axisDist);
    return (radialMask * wedgeMask) * seamMask;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.uvScale) + buffer.uvOffset;
    float2 param = mappedUv;
    float2 correctedUv = getAspectCorrectUV(param, buffer.ratio);
    float2 p = correctedUv - float2(0.5);
    float2 param_1 = p;
    float2 param_2 = float2(-1.0, 1.0);
    float param_3 = buffer.u_panelProgress.x;
    float param_4 = buffer.u_openWidth;
    float param_5 = buffer.u_feather;
    float param_6 = buffer.u_seamGap;
    float mLU = panelMask(param_1, param_2, param_3, param_4, param_5, param_6);
    float2 param_7 = p;
    float2 param_8 = float2(1.0);
    float param_9 = buffer.u_panelProgress.y;
    float param_10 = buffer.u_openWidth;
    float param_11 = buffer.u_feather;
    float param_12 = buffer.u_seamGap;
    float mRU = panelMask(param_7, param_8, param_9, param_10, param_11, param_12);
    float2 param_13 = p;
    float2 param_14 = float2(-1.0);
    float param_15 = buffer.u_panelProgress.z;
    float param_16 = buffer.u_openWidth;
    float param_17 = buffer.u_feather;
    float param_18 = buffer.u_seamGap;
    float mLD = panelMask(param_13, param_14, param_15, param_16, param_17, param_18);
    float2 param_19 = p;
    float2 param_20 = float2(1.0, -1.0);
    float param_21 = buffer.u_panelProgress.w;
    float param_22 = buffer.u_openWidth;
    float param_23 = buffer.u_feather;
    float param_24 = buffer.u_seamGap;
    float mRD = panelMask(param_19, param_20, param_21, param_22, param_23, param_24);
    float revealMask = fast::max(fast::max(mLU, mRU), fast::max(mLD, mRD));
    revealMask = mix(revealMask, 1.0, fast::clamp(buffer.u_merge, 0.0, 1.0));
    float4 texColor = texture1.sample(texture1Smplr, mappedUv);
    float2 dir = mappedUv - float2(0.5);
    float offset = buffer.u_chromatic * 0.0199999995529651641845703125;
    float r = texture1.sample(texture1Smplr, (mappedUv + (dir * offset))).x;
    float g = texture1.sample(texture1Smplr, mappedUv).y;
    float b = texture1.sample(texture1Smplr, (mappedUv - (dir * offset))).z;
    float3 _301 = float3(r, g, b);
    texColor.x = _301.x;
    texColor.y = _301.y;
    texColor.z = _301.z;
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _316 = texColor;
    float3 _323 = mix(_316.xyz, float3(gray), float3(buffer.u_grayscale));
    texColor.x = _323.x;
    texColor.y = _323.y;
    texColor.z = _323.z;
    float4 _332 = texColor;
    float3 _334 = _332.xyz * buffer.u_brightness;
    texColor.x = _334.x;
    texColor.y = _334.y;
    texColor.z = _334.z;
    out.gl_FragColor = float4(texColor.xyz, texColor.w * revealMask);
    return out;
}

