#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float rollRadius;
    float shadowStrength;
    float ambientLight;
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
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.1415927410125732421875));
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& rollRadius, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& shadowStrength, constant float& ambientLight)
{
    float currentY = 1.0 - progress;
    float r = rollRadius;
    float PI = 3.1415927410125732421875;
    float dist = currentY - vUv.y;
    if (vUv.y >= currentY)
    {
        return texel;
    }
    bool _71 = dist > 0.0;
    bool _79;
    if (_71)
    {
        _79 = dist < (PI * r);
    }
    else
    {
        _79 = _71;
    }
    if (_79)
    {
        float angle = dist / r;
        float2 uv = float2(vUv.x, currentY);
        float3 normal = float3(0.0, sin(angle), cos(angle));
        float3 lightDir = float3(0.0, 0.707106769084930419921875, 0.707106769084930419921875);
        float3 viewDir = float3(0.0, 0.0, 1.0);
        float diff = fast::max(dot(normal, lightDir), 0.0);
        float3 halfDir = fast::normalize(lightDir + viewDir);
        float spec = pow(fast::max(dot(normal, halfDir), 0.0), 16.0);
        float edgeShadow = smoothstep(0.0, 0.300000011920928955078125, angle);
        float2 param = float2(vUv.x, currentY + (dist * 0.100000001490116119384765625));
        float4 rollTexel = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param));
        float3 finalRGB = (rollTexel.xyz * ((diff * shadowStrength) + ambientLight)) + float3(spec * 0.300000011920928955078125);
        finalRGB *= edgeShadow;
        return float4(finalRGB, texel.w);
    }
    return float4(0.0);
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
    float4 effectColor = effect(param_1, param_2, buffer.rollRadius, in.vUv, tDiffuse, tDiffuseSmplr, buffer.shadowStrength, buffer.ambientLight);
    out.gl_FragColor = effectColor;
    return out;
}

