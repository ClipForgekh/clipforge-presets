#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 windowSize;
    float edgeSoftness;
    float grainStrength;
    float4 frameColor;
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
    return p;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float sineOut(thread const float& x)
{
    return sin(x * 1.57079637050628662109375);
}

static inline __attribute__((always_inline))
float rectMask(thread const float2& uv, thread const float2& center, thread const float2& halfSize, thread const float& blurEdge)
{
    float2 d = abs(uv - center) - halfSize;
    float dist = fast::max(d.x, d.y);
    return 1.0 - smoothstep(0.0, fast::max(blurEdge, 9.9999999747524270787835121154785e-07), dist);
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, thread float2& vUv, constant float2& windowSize, constant float& edgeSoftness, constant float& grainStrength, constant float4& frameColor)
{
    float2 param = vUv;
    float2 uv = handleUVBounds(param);
    float2 center = float2(0.5);
    float2 baseHalf = fast::clamp(windowSize * 0.5, float2(0.0500000007450580596923828125), float2(0.5));
    float openT = 0.0;
    if ((p >= 0.5) && (p < 0.813953459262847900390625))
    {
        float local = (p - 0.5) / 0.3139534890651702880859375;
        float param_1 = fast::clamp(local, 0.0, 1.0);
        openT = sineOut(param_1);
    }
    else
    {
        if (p >= 0.813953459262847900390625)
        {
            openT = 1.0;
        }
    }
    float2 currentHalf = mix(baseHalf, float2(0.5), float2(openT));
    float2 param_2 = uv;
    float2 param_3 = center;
    float2 param_4 = currentHalf;
    float param_5 = edgeSoftness;
    float openingMask = rectMask(param_2, param_3, param_4, param_5);
    float frameMask = 1.0 - openingMask;
    float2 shutterCenter = float2(0.5, mix(0.5, 1.5, openT));
    float2 param_6 = uv;
    float2 param_7 = shutterCenter;
    float2 param_8 = currentHalf;
    float param_9 = edgeSoftness;
    float shutterMask = rectMask(param_6, param_7, param_8, param_9);
    float occlusion = 0.0;
    if (p < 0.5)
    {
        occlusion = 1.0;
    }
    else
    {
        if (p < 0.813953459262847900390625)
        {
            occlusion = fast::max(frameMask, shutterMask);
        }
        else
        {
            occlusion = 0.0;
        }
    }
    float grainStart = 0.5;
    float grainEnd = 0.69767439365386962890625;
    float grainOn = smoothstep(grainStart, grainStart + 0.02999999932944774627685546875, p);
    float grainOff = 1.0 - smoothstep(grainEnd - 0.02999999932944774627685546875, grainEnd, p);
    float grainFade = grainOn * grainOff;
    float2 param_10 = (uv * float2(153.6999969482421875, 271.899993896484375)) + float2(p * 47.299999237060546875, p * 91.09999847412109375);
    float n = hash12(param_10) - 0.5;
    float3 grainTex = fast::clamp(texel.xyz + float3((n * grainStrength) * grainFade), float3(0.0), float3(1.0));
    float3 rgb = mix(grainTex, frameColor.xyz, float3(occlusion));
    float a = mix(texel.w, frameColor.w, occlusion);
    if (p <= 0.104651160538196563720703125)
    {
        rgb = frameColor.xyz;
        a = frameColor.w;
    }
    else
    {
        if ((p > 0.104651160538196563720703125) && (p < 0.1860465109348297119140625))
        {
            rgb = frameColor.xyz;
            a = frameColor.w;
        }
        else
        {
            if ((p >= 0.813953459262847900390625) && (p <= 1.0))
            {
                rgb = grainTex;
                a = texel.w;
            }
        }
    }
    return float4(rgb, a);
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.windowSize, buffer.edgeSoftness, buffer.grainStrength, buffer.frameColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

