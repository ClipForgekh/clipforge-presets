#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float layerCount;
    float pulseSoftness;
    float bounceStrength;
    float blurStrength;
    float3 neonColorA;
    float3 neonColorB;
    float glowStrength;
    float glitchStrength;
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
float tween(thread const float& progress)
{
    return 1.0 - pow(1.0 - progress, 3.0);
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
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 radialBlur9(thread const float2& uv, thread const float& amount, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    if (amount <= 9.9999997473787516355514526367188e-05)
    {
        float2 param = uv;
        float4 _113 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param));
        return _113;
    }
    float4 col = float4(0.0);
    float w = 0.0;
    float2 stepBase = float2(0.00120000005699694156646728515625 * amount, 0.00120000005699694156646728515625 * amount);
    if (ratio > 1.0)
    {
        stepBase.y /= ratio;
    }
    else
    {
        stepBase.x *= ratio;
    }
    float2 o0 = float2(0.0);
    float2 o1 = stepBase;
    float2 o2 = -stepBase;
    float2 o3 = float2(stepBase.x, -stepBase.y);
    float2 o4 = float2(-stepBase.x, stepBase.y);
    float2 o5 = stepBase * 2.0;
    float2 o6 = (-stepBase) * 2.0;
    float2 o7 = float2(stepBase.x * 2.0, (-stepBase.y) * 2.0);
    float2 o8 = float2((-stepBase.x) * 2.0, stepBase.y * 2.0);
    float k0 = 0.20000000298023223876953125;
    float k1 = 0.14000000059604644775390625;
    float k2 = 0.14000000059604644775390625;
    float k3 = 0.119999997317790985107421875;
    float k4 = 0.119999997317790985107421875;
    float k5 = 0.0900000035762786865234375;
    float k6 = 0.0900000035762786865234375;
    float k7 = 0.0500000007450580596923828125;
    float k8 = 0.0500000007450580596923828125;
    float2 param_1 = uv + o0;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * k0);
    w += k0;
    float2 param_2 = uv + o1;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * k1);
    w += k1;
    float2 param_3 = uv + o2;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * k2);
    w += k2;
    float2 param_4 = uv + o3;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * k3);
    w += k3;
    float2 param_5 = uv + o4;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * k4);
    w += k4;
    float2 param_6 = uv + o5;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * k5);
    w += k5;
    float2 param_7 = uv + o6;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_7)) * k6);
    w += k6;
    float2 param_8 = uv + o7;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_8)) * k7);
    w += k7;
    float2 param_9 = uv + o8;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_9)) * k8);
    w += k8;
    return col / float4(fast::max(w, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& layerCount, constant float& pulseSoftness, constant float& bounceStrength, constant float& blurStrength, constant float3& neonColorA, constant float3& neonColorB, constant float& glowStrength, constant float& glitchStrength)
{
    float2 center = float2(0.5);
    float2 param = vUv;
    float2 param_1 = center;
    float2 p = getSDFCoordinate(param, param_1, ratio);
    float dist = length(p);
    float maxDist = 0.707106769084930419921875;
    float nDist = fast::clamp(dist / maxDist, 0.0, 1.0);
    float layers = fast::max(layerCount, 1.0);
    float ringPos = nDist * layers;
    float ringId = floor(fast::min(ringPos, layers - 9.9999997473787516355514526367188e-05));
    float ringFrac = fract(ringPos);
    float scanHead = progress * layers;
    float layerReveal = smoothstep(0.0, fast::max(pulseSoftness, 9.9999997473787516355514526367188e-05), scanHead - ringId);
    layerReveal = fast::clamp(layerReveal, 0.0, 1.0);
    float fx = 1.0 - layerReveal;
    float2 _393;
    if (dist > 9.9999997473787516355514526367188e-05)
    {
        _393 = p / float2(dist);
    }
    else
    {
        _393 = float2(0.0);
    }
    float2 dir = _393;
    if (ratio > 1.0)
    {
        dir.y *= ratio;
    }
    else
    {
        dir.x /= fast::max(ratio, 9.9999997473787516355514526367188e-05);
    }
    dir = fast::normalize(dir + float2(9.9999999747524270787835121154785e-07));
    float bounceWindow = (1.0 - layerReveal) * smoothstep(0.0, 0.1500000059604644775390625, layerReveal);
    float2 animatedUV = vUv + ((dir * bounceStrength) * bounceWindow);
    float2 param_2 = animatedUV;
    animatedUV = handleUVBounds(param_2);
    float2 param_3 = animatedUV;
    float param_4 = blurStrength * fx;
    float4 blurred = radialBlur9(param_3, param_4, ratio, tDiffuse, tDiffuseSmplr);
    float4 sharp = tDiffuse.sample(tDiffuseSmplr, animatedUV);
    float4 baseMix = mix(sharp, blurred, float4(fx));
    float angle = precise::atan2(p.y, p.x);
    float a01 = (angle / 6.283185482025146484375) + 0.5;
    float3 neonGrad = mix(neonColorA, neonColorB, float3(smoothstep(0.0, 1.0, a01 + (nDist * 0.25))));
    float overExpo = fx * fx;
    float3 neonOverlay = (neonGrad * (0.800000011920928955078125 + (glowStrength * 1.60000002384185791015625))) * overExpo;
    float edgeMask = 1.0 - smoothstep(0.4000000059604644775390625, 0.5, abs(ringFrac - 0.5) * 2.0);
    float flicker = step(0.64999997615814208984375, (sin(((nDist * 170.0) + (progress * 220.0)) * 6.283185482025146484375) * 0.5) + 0.5);
    float glitchPulse = smoothstep(0.0, 0.119999997317790985107421875, layerReveal) * (1.0 - smoothstep(0.119999997317790985107421875, 0.449999988079071044921875, layerReveal));
    float glitch = ((edgeMask * flicker) * glitchPulse) * glitchStrength;
    float3 glitchColor = (mix(neonColorB, neonColorA, float3(ringFrac)) * glitch) * 1.7999999523162841796875;
    float3 color = (baseMix.xyz + neonOverlay) + glitchColor;
    color = mix(color, sharp.xyz, float3(layerReveal * layerReveal));
    color = fast::clamp(color, float3(0.0), float3(1.0));
    float2 param_5 = vUv;
    float borderMask = getHardBoundaryMask(param_5);
    return float4(color, sharp.w * borderMask);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, in.vUv, buffer.layerCount, buffer.pulseSoftness, buffer.bounceStrength, buffer.blurStrength, buffer.neonColorA, buffer.neonColorB, buffer.glowStrength, buffer.glitchStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

