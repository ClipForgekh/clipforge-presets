#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float blurMax;
    float spiralTightness;
    float explosionStrength;
    float particleDensity;
    float3 goldColor;
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
    return (p * p) * p;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 blur9(thread const float2& uv, thread const float& r, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& ratio)
{
    if (r <= 9.9999997473787516355514526367188e-06)
    {
        float4 _126 = tDiffuse.sample(tDiffuseSmplr, uv);
        return _126;
    }
    float2 stepv = float2(r, r / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param = uv + (stepv * float2(-1.0));
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * 0.07500000298023223876953125);
    float2 param_1 = uv + (stepv * float2(0.0, -1.0));
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.100000001490116119384765625);
    float2 param_2 = uv + (stepv * float2(1.0, -1.0));
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.07500000298023223876953125);
    float2 param_3 = uv + (stepv * float2(-1.0, 0.0));
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.100000001490116119384765625);
    float2 param_4 = uv;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.300000011920928955078125);
    float2 param_5 = uv + (stepv * float2(1.0, 0.0));
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * 0.100000001490116119384765625);
    float2 param_6 = uv + (stepv * float2(-1.0, 1.0));
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * 0.07500000298023223876953125);
    float2 param_7 = uv + (stepv * float2(0.0, 1.0));
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_7)) * 0.100000001490116119384765625);
    float2 param_8 = uv + (stepv * float2(1.0));
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_8)) * 0.07500000298023223876953125);
    return c;
}

static inline __attribute__((always_inline))
float2x2 rot(thread const float& a)
{
    float s = sin(a);
    float c = cos(a);
    return float2x2(float2(c, -s), float2(s, c));
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 456.209991455078125));
    p += float2(dot(p, p + float2(45.31999969482421875)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float2 hash22(thread const float2& p)
{
    float2 param = p;
    float _86 = hash21(param);
    float n = _86;
    float2 param_1 = p + float2(n);
    float _93 = hash21(param_1);
    return float2(n, _93);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& ratio, thread float2& vUv, constant float& blurMax, constant float& spiralTightness, constant float& explosionStrength, constant float& particleDensity, constant float3& goldColor)
{
    float2 uv = vUv;
    float2 center = float2(0.5);
    float2 q = uv - center;
    float2 qa = q;
    if (ratio > 1.0)
    {
        qa.y /= ratio;
    }
    else
    {
        qa.x *= ratio;
    }
    float r = length(qa);
    float a = precise::atan2(qa.y, qa.x);
    float converge = smoothstep(0.0, 0.550000011920928955078125, p);
    float explode = smoothstep(0.5, 0.819999992847442626953125, p);
    float vanish = smoothstep(0.7799999713897705078125, 1.0, p);
    float2 c0 = uv;
    float d0 = length(c0 - float2(0.0));
    float d1 = length(c0 - float2(1.0, 0.0));
    float d2 = length(c0 - float2(0.0, 1.0));
    float d3 = length(c0 - float2(1.0));
    float corner = exp((-10.0) * fast::min(fast::min(d0, d1), fast::min(d2, d3)));
    float cornerBlur = ((blurMax * (0.25 + (0.75 * p))) * (1.0 - explode)) * corner;
    float radialBlur = ((blurMax * 1.7999999523162841796875) * smoothstep(0.550000011920928955078125, 1.0, p)) * (1.0 - (vanish * 0.4000000059604644775390625));
    float2 param = uv;
    float param_1 = cornerBlur;
    float4 bgA = blur9(param, param_1, tDiffuse, tDiffuseSmplr, ratio);
    float2 param_2 = uv;
    float param_3 = radialBlur;
    float4 bgB = blur9(param_2, param_3, tDiffuse, tDiffuseSmplr, ratio);
    float4 bg = mix(bgA, bgB, float4(smoothstep(0.5, 0.89999997615814208984375, p)));
    float darken = 0.85000002384185791015625 * smoothstep(0.0, 1.0, p);
    float4 _385 = bg;
    float3 _387 = _385.xyz * (1.0 - darken);
    bg.x = _387.x;
    bg.y = _387.y;
    bg.z = _387.z;
    float spin = (p * 9.0) * spiralTightness;
    float param_4 = spin + ((r * 18.0) * (1.0 - explode));
    float2 flowUv = center + (rot(param_4) * q);
    flowUv = center + ((flowUv - center) * mix(1.7999999523162841796875, 0.699999988079071044921875 + explosionStrength, converge));
    float2 param_5 = floor(uv * 64.0);
    float _441 = hash21(param_5);
    flowUv += ((fast::normalize(q + float2(9.9999997473787516355514526367188e-05)) * explode) * (0.3499999940395355224609375 + (0.3499999940395355224609375 * _441)));
    float2 g1 = flowUv * particleDensity;
    float2 id1 = floor(g1);
    float2 f1 = fract(g1) - float2(0.5);
    float2 param_6 = id1;
    float2 p1 = hash22(param_6) - float2(0.5);
    float dLarge = length(f1 - (p1 * 0.699999988079071044921875));
    float2 param_7 = id1 + float2(11.30000019073486328125);
    float _481 = hash21(param_7);
    float largeMask = smoothstep(0.23000000417232513427734375, 0.0, dLarge) * step(0.3499999940395355224609375, _481);
    float2 g2 = flowUv * ((particleDensity * 2.400000095367431640625) + 37.0);
    float2 id2 = floor(g2);
    float2 f2 = fract(g2) - float2(0.5);
    float2 param_8 = id2 + float2(13.69999980926513671875);
    float2 p2 = hash22(param_8) - float2(0.5);
    float2 param_9 = id2;
    float _518 = hash21(param_9);
    float jitter = sin((((a * 9.0) + (r * 80.0)) + (_518 * 6.283100128173828125)) + (p * 40.0)) * 0.119999997317790985107421875;
    float dSmall = length((f2 - (p2 * 0.89999997615814208984375)) + float2(jitter, -jitter));
    float2 param_10 = id2 + float2(7.099999904632568359375);
    float _550 = hash21(param_10);
    float smallMask = smoothstep(0.0900000035762786865234375, 0.0, dSmall) * step(0.449999988079071044921875, _550);
    float spiralBand = 0.5 + (0.5 * cos(((a * 2.0) + (r * 32.0)) - ((p * 24.0) * spiralTightness)));
    float cornerToCenter = mix(corner, exp((-8.0) * r), converge);
    float coverage = mix(0.300000011920928955078125, 1.0, explode);
    float particleField = (((largeMask * 1.2000000476837158203125) + (smallMask * 0.800000011920928955078125)) * spiralBand) * cornerToCenter;
    particleField *= smoothstep(0.0199999995529651641845703125, coverage, particleField + (r * 0.20000000298023223876953125));
    float glow = mix(0.5, 4.0, converge) * (1.0 - vanish);
    float2 param_11 = id1;
    float _620 = hash21(param_11);
    float spark = (pow(fast::max(0.0, sin(((r * 260.0) - (p * 60.0)) + (_620 * 6.283100128173828125))), 28.0) * largeMask) * explode;
    float3 particleRgb = goldColor * ((particleField * glow) + (spark * 0.800000011920928955078125));
    float3 outRgb = bg.xyz + particleRgb;
    outRgb = fast::clamp(outRgb, float3(0.0), float3(1.0));
    float alphaFade = (1.0 - p) * (1.0 - p);
    float particleFade = (1.0 - vanish) * (1.0 - smoothstep(0.87999999523162841796875, 1.0, p));
    float outA = fast::clamp((bg.w * alphaFade) + ((particleField * 0.3499999940395355224609375) * particleFade), 0.0, 1.0);
    if (p <= 9.9999997473787516355514526367188e-06)
    {
        return texel;
    }
    return float4(outRgb * (1.0 - vanish), outA * (1.0 - vanish));
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, buffer.ratio, in.vUv, buffer.blurMax, buffer.spiralTightness, buffer.explosionStrength, buffer.particleDensity, buffer.goldColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

