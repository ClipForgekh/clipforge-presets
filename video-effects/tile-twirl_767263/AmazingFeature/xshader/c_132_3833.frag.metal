#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float gateRadius;
    float uBrightness;
    float3 glowColor;
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
float2 aspectVec(thread float2& p, constant float& ratio)
{
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
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 456.209991455078125));
    p += float2(dot(p, p + float2(34.450000762939453125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float gateLine(thread const float2& p, thread const float2& dir, thread const float& width)
{
    float d = abs(dot(p, dir));
    return 1.0 - smoothstep(width, width + 0.00999999977648258209228515625, d);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, thread float2& vUv, constant float& gateRadius, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& uBrightness, constant float3& glowColor)
{
    float holdA = 1.0 - smoothstep(0.105555556714534759521484375, 0.15555556118488311767578125, p);
    float openRise = smoothstep(0.15555556118488311767578125, 0.405555546283721923828125, p);
    float swapBlend = smoothstep(0.405555546283721923828125, 0.64444446563720703125, p);
    float closeFall = 1.0 - smoothstep(0.64444446563720703125, 0.88333332538604736328125, p);
    float vortexAmp = openRise * closeFall;
    float dirSign = mix(1.0, -1.0, swapBlend);
    float2 grid = floor(vUv * 3.0);
    float2 center = (grid + float2(0.5)) / float2(3.0);
    float2 local = vUv - center;
    float2 param = local;
    float2 _158 = aspectVec(param, ratio);
    float2 localA = _158;
    float r = length(localA);
    float a = precise::atan2(localA.y, localA.x);
    float2 param_1 = grid + float2(0.17000000178813934326171875);
    float _174 = hash21(param_1);
    float jitter = (_174 * 0.25) + 0.875;
    float theta = ((dirSign * vortexAmp) * 3.1415927410125732421875) * jitter;
    float2 param_2 = grid + float2(1.730000019073486328125);
    float _198 = hash21(param_2);
    float rAdd = (gateRadius * vortexAmp) * (0.75 + (0.25 * _198));
    float c = cos(a + theta);
    float s = sin(a + theta);
    float flipOpen = openRise * (1.0 - swapBlend);
    float flipScaleX = mix(1.0, 0.3089999854564666748046875, flipOpen);
    float2 warpedA = float2(c, s) * (r + rAdd);
    warpedA.x *= flipScaleX;
    if (ratio > 1.0)
    {
        warpedA.y *= ratio;
    }
    else
    {
        warpedA.x /= ratio;
    }
    float2 uvWarp = center + warpedA;
    float2 param_3 = uvWarp;
    uvWarp = handleUVBounds(param_3);
    float2 vel = uvWarp - vUv;
    float mbEnvA = smoothstep(0.15555556118488311767578125, 0.300000011920928955078125, p);
    float mbEnvB = 1.0 - smoothstep(0.655555546283721923828125, 0.72222220897674560546875, p);
    float motionBlur = (0.36000001430511474609375 * mbEnvA) * mbEnvB;
    float2 param_4 = uvWarp - (vel * (0.5 + motionBlur));
    float2 uvTrail = handleUVBounds(param_4);
    float4 c0 = tDiffuse.sample(tDiffuseSmplr, uvWarp);
    float4 c1 = tDiffuse.sample(tDiffuseSmplr, uvTrail);
    float4 warped = mix(c0, c1, float4(motionBlur));
    float2 param_5 = vUv - float2(0.5);
    float2 _308 = aspectVec(param_5, ratio);
    float2 cp = _308;
    float gateOn = smoothstep(0.20000000298023223876953125, 0.2611111104488372802734375, p) * (1.0 - smoothstep(0.64444446563720703125, 0.88333332538604736328125, p));
    float2 param_6 = cp;
    float2 param_7 = float2(0.707106769084930419921875);
    float param_8 = 0.014999999664723873138427734375;
    float g0 = gateLine(param_6, param_7, param_8);
    float2 param_9 = cp;
    float2 param_10 = float2(0.707106769084930419921875, -0.707106769084930419921875);
    float param_11 = 0.014999999664723873138427734375;
    float g1 = gateLine(param_9, param_10, param_11);
    float2 param_12 = cp;
    float2 param_13 = float2(0.92426145076751708984375, 0.3817601501941680908203125);
    float param_14 = 0.01200000010430812835693359375;
    float g2 = gateLine(param_12, param_13, param_14);
    float2 param_15 = cp;
    float2 param_16 = float2(0.3817601501941680908203125, 0.92426145076751708984375);
    float param_17 = 0.01200000010430812835693359375;
    float g3 = gateLine(param_15, param_16, param_17);
    float gateMask = fast::clamp((((g0 + g1) + g2) + g3) * 0.3499999940395355224609375, 0.0, 1.0) * gateOn;
    float glowEnv = smoothstep(0.20000000298023223876953125, 0.4222222268581390380859375, p) * (1.0 - smoothstep(0.64444446563720703125, 0.8055555820465087890625, p));
    float glow = (pow(fast::max(gateMask, 0.0), 1.39999997615814208984375) * 0.180000007152557373046875) * glowEnv;
    float3 col = mix(texel.xyz, warped.xyz, float3(1.0 - holdA));
    col *= mix(1.0, 0.930000007152557373046875, smoothstep(0.88333332538604736328125, 1.0, p));
    col = (col * uBrightness) + (glowColor * glow);
    col = fast::clamp(col, float3(0.0), float3(1.0));
    return float4(col, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.gateRadius, tDiffuse, tDiffuseSmplr, buffer.uBrightness, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

