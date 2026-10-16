#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float ringWidth;
    float maxBlur;
    float grainIntensity;
    float3 warmGoldColor;
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
    return p * p;
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
float getMaxShapeSize(constant float& ratio)
{
    if (ratio > 1.0)
    {
        return sqrt(1.0 + (1.0 / (ratio * ratio))) * 1.2000000476837158203125;
    }
    else
    {
        return sqrt((ratio * ratio) + 1.0) * 1.2000000476837158203125;
    }
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 radialBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float2& center, thread const float& blurAmt)
{
    float2 dir = uv - center;
    float lenDir = length(dir);
    if ((lenDir < 9.9999997473787516355514526367188e-06) || (blurAmt <= 9.9999997473787516355514526367188e-06))
    {
        float4 _151 = tex.sample(texSmplr, uv);
        return _151;
    }
    dir /= float2(lenDir);
    float4 col = float4(0.0);
    float w = 0.0;
    for (int i = -3; i <= 3; i++)
    {
        float fi = float(i);
        float wt = 1.0 - (abs(fi) / 4.0);
        float2 param = uv + ((dir * blurAmt) * fi);
        float2 suv = handleUVBounds(param);
        col += (tex.sample(texSmplr, suv) * wt);
        w += wt;
    }
    return col / float4(w);
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 345.45001220703125));
    p += float2(dot(p, p + float2(34.345001220703125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, thread float2& vUv, constant float& ringWidth, constant float& maxBlur, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& grainIntensity, constant float3& warmGoldColor)
{
    float2 center = float2(0.5);
    float2 param = vUv;
    float2 param_1 = center;
    float2 sp = getSDFCoordinate(param, param_1, ratio);
    float dist = length(sp);
    float maxR = getMaxShapeSize(ratio) * 0.5;
    float scanR = p * maxR;
    float revealFeather = ringWidth * 2.0;
    float reveal = smoothstep(0.0, revealFeather, scanR - dist);
    float bandDist = abs(dist - scanR);
    float ring = exp((-bandDist) / fast::max(ringWidth, 9.9999997473787516355514526367188e-05));
    ring *= (1.0 - p);
    float localBlur = (maxBlur * (1.0 - reveal)) * (1.0 - p);
    float2 param_2 = vUv;
    float2 param_3 = center;
    float param_4 = localBlur;
    float4 blurredTexel = radialBlur(tDiffuse, tDiffuseSmplr, param_2, param_3, param_4);
    float3 sceneRgb = mix(blurredTexel.xyz, texel.xyz, float3(reveal));
    float2 param_5 = vUv * float2(1280.0, 720.0);
    float _295 = hash21(param_5);
    float _noise = _295;
    float grain = (_noise - 0.5) * 2.0;
    float grainAmt = (grainIntensity * reveal) * (1.0 - p);
    sceneRgb += float3(grain * grainAmt);
    float highlight = pow(ring, 1.5) * 0.3499999940395355224609375;
    float3 ringColor = warmGoldColor * ((ring * 1.10000002384185791015625) + highlight);
    float visibility = fast::clamp(reveal + (ring * 0.85000002384185791015625), 0.0, 1.0);
    float3 finalRgb = (sceneRgb * visibility) + ringColor;
    finalRgb = fast::clamp(finalRgb, float3(0.0), float3(1.0));
    float alpha = fast::clamp(reveal + (ring * 0.60000002384185791015625), 0.0, 1.0);
    return float4(finalRgb, alpha);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.ringWidth, buffer.maxBlur, tDiffuse, tDiffuseSmplr, buffer.grainIntensity, buffer.warmGoldColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

