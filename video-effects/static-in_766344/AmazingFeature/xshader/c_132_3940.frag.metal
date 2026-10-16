#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float particleDensity;
    float turbulenceStrength;
    float blurStrength;
    float4 inkColor;
    float glowStrength;
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
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float2 hash22(thread const float2& p)
{
    float2 param = p;
    float n = hash12(param);
    float2 param_1 = (p + float2(n)) + float2(7.13000011444091796875);
    return float2(n, hash12(param_1));
}

static inline __attribute__((always_inline))
float _noise(thread const float2& p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    float2 u = (f * f) * (float2(3.0) - (f * 2.0));
    float2 param = i;
    float a = hash12(param);
    float2 param_1 = i + float2(1.0, 0.0);
    float b = hash12(param_1);
    float2 param_2 = i + float2(0.0, 1.0);
    float c = hash12(param_2);
    float2 param_3 = i + float2(1.0);
    float d = hash12(param_3);
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

static inline __attribute__((always_inline))
float2 flowField(thread const float2& p, thread const float& t, constant float& ratio)
{
    float2 param = (p * 3.0) + float2(0.0, t * 0.699999988079071044921875);
    float n1 = _noise(param);
    float2 param_1 = (p * 3.0) + float2(9.69999980926513671875, (-t) * 0.60000002384185791015625);
    float n2 = _noise(param_1);
    float2 v = float2(n1 - 0.5, n2 - 0.5);
    if (ratio > 1.0)
    {
        v.y /= ratio;
    }
    else
    {
        v.x *= ratio;
    }
    return v;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 motionBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float2& vel, thread const float& radius)
{
    float2 dir = fast::normalize(vel + float2(9.9999997473787516355514526367188e-06));
    float2 stepv = dir * radius;
    float4 c = float4(0.0);
    float2 param = uv - (stepv * 2.0);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.119999997317790985107421875);
    float2 param_1 = uv - (stepv * 1.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.23000000417232513427734375);
    float2 param_2 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.300000011920928955078125);
    float2 param_3 = uv + (stepv * 1.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.23000000417232513427734375);
    float2 param_4 = uv + (stepv * 2.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.119999997317790985107421875);
    return c;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& particleDensity, thread float2& vUv, constant float& turbulenceStrength, constant float& blurStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float4& inkColor, constant float& glowStrength)
{
    if (p >= 1.0)
    {
        return texel;
    }
    float strength = 1.0 - p;
    float grid = fast::max(8.0, particleDensity);
    float2 cell = floor(vUv * grid);
    float2 cellUV = (cell + float2(0.5)) / float2(grid);
    float2 param = cell;
    float2 rnd = hash22(param);
    float2 randDir = fast::normalize((rnd - float2(0.5)) + float2(9.9999997473787516355514526367188e-05));
    float spread = (0.519999980926513671875 + (0.449999988079071044921875 * (1.0 - rnd.x))) * strength;
    float2 param_1 = (cellUV * 2.7000000476837158203125) + (rnd * 5.30000019073486328125);
    float param_2 = p;
    float2 turb = ((flowField(param_1, param_2, ratio) * turbulenceStrength) * strength) * 2.400000095367431640625;
    float2 swirl = float2(-(vUv.y - 0.5), vUv.x - 0.5) * ((0.2199999988079071044921875 * strength) * (0.5 + rnd.y));
    float2 offset = ((randDir * spread) + turb) + swirl;
    float2 param_3 = cellUV + offset;
    float2 srcUV = handleUVBounds(param_3);
    float2 vel = srcUV - cellUV;
    float blurR = (blurStrength * strength) * 2.0;
    float2 param_4 = srcUV;
    float2 param_5 = vel;
    float param_6 = blurR;
    float4 movingTexel = motionBlur(tDiffuse, tDiffuseSmplr, param_4, param_5, param_6);
    float luma = dot(movingTexel.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float2 param_7 = ((cellUV * 18.0) + (rnd * 13.0)) + float2(p * 2.0);
    float inkNoise = _noise(param_7);
    float3 inkBase = mix(float3(luma * 0.550000011920928955078125), inkColor.xyz, float3(0.75));
    float glow = (glowStrength * strength) * (0.5 + (0.5 * inkNoise));
    float3 particleRgb = fast::clamp(inkBase + ((inkColor.xyz * glow) * 0.60000002384185791015625), float3(0.0), float3(1.0));
    float2 gv = fract(vUv * grid) - float2(0.5);
    float r = mix(0.800000011920928955078125, 0.519999980926513671875, p);
    float particleMask = smoothstep(r, r - 0.2199999988079071044921875, length(gv));
    particleMask = mix(1.0, particleMask, smoothstep(0.3499999940395355224609375, 0.949999988079071044921875, p));
    float3 inkLayer = mix(particleRgb, (movingTexel.xyz * 0.64999997615814208984375) + (inkColor.xyz * 0.20000000298023223876953125), float3(0.3499999940395355224609375));
    inkLayer = mix(inkLayer, texel.xyz, float3(p * p));
    float reveal = smoothstep(0.2199999988079071044921875, 1.0, p);
    float3 finalRgb = mix(inkLayer * particleMask, texel.xyz, float3(reveal));
    return float4(fast::clamp(finalRgb, float3(0.0), float3(1.0)), texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.particleDensity, in.vUv, buffer.turbulenceStrength, buffer.blurStrength, tDiffuse, tDiffuseSmplr, buffer.inkColor, buffer.glowStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

