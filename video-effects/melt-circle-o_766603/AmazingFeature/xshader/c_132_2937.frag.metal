#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float fragmentCount;
    float flySpeed;
    float blurStrength;
    float overExposureStrength;
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
    return pow(progress, 5.0);
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, thread float2& vUv, constant float& ratio, constant float& fragmentCount, constant float& flySpeed, constant float& blurStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& overExposureStrength)
{
    float t = progress;
    if (t <= 0.001000000047497451305389404296875)
    {
        return texel;
    }
    float2 centeredUv = vUv - float2(0.5);
    if (ratio > 1.0)
    {
        centeredUv.y /= ratio;
    }
    else
    {
        centeredUv.x *= ratio;
    }
    float angle = precise::atan2(centeredUv.y, centeredUv.x);
    float dist = length(centeredUv);
    float2 radialDir = float2(cos(angle), sin(angle));
    float2 gridUV = centeredUv * fragmentCount;
    float2 cellId = floor(gridUV);
    float2 param = cellId;
    float cellRand = random(param);
    float2 param_1 = cellId + float2(123.4499969482421875);
    float cellRand2 = random(param_1);
    float flyDist = ((t * t) * flySpeed) * (0.60000002384185791015625 + (cellRand * 0.800000011920928955078125));
    float2 flyOffset = (radialDir * flyDist) + ((float2(cellRand - 0.5, cellRand2 - 0.5) * t) * 0.100000001490116119384765625);
    float2 fragmentUV = centeredUv + flyOffset;
    if (ratio > 1.0)
    {
        fragmentUV.y *= ratio;
    }
    else
    {
        fragmentUV.x /= ratio;
    }
    fragmentUV += float2(0.5);
    float2 param_2 = fragmentUV;
    fragmentUV = handleUVBounds(param_2);
    float blurSize = t * blurStrength;
    float2 blurStep = (radialDir * blurSize) * (0.800000011920928955078125 + (cellRand * 0.4000000059604644775390625));
    float4 blurColor = float4(0.0);
    float totalWeight = 0.0;
    for (int i = 0; i < 4; i++)
    {
        float weight = 1.0 - (float(i) / 4.0);
        float2 param_3 = fragmentUV + (blurStep * float(i));
        float2 sampleUV = handleUVBounds(param_3);
        blurColor += (tDiffuse.sample(tDiffuseSmplr, sampleUV) * weight);
        totalWeight += weight;
    }
    blurColor /= float4(totalWeight);
    float3 goldTint = float3(1.0, 0.75, 0.3499999940395355224609375);
    float3 overExposed = mix(blurColor.xyz, goldTint, float3(t * 0.60000002384185791015625));
    overExposed *= (1.0 + ((t * overExposureStrength) * (1.0 + (cellRand * 0.5))));
    float alpha = 1.0 - (t * 1.2000000476837158203125);
    alpha *= smoothstep(1.0, 0.60000002384185791015625, dist + (t * 1.7999999523162841796875));
    alpha *= smoothstep(0.0, 0.100000001490116119384765625, alpha);
    alpha = fast::clamp(alpha, 0.0, 1.0);
    return float4(overExposed * alpha, alpha);
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.ratio, buffer.fragmentCount, buffer.flySpeed, buffer.blurStrength, tDiffuse, tDiffuseSmplr, buffer.overExposureStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

