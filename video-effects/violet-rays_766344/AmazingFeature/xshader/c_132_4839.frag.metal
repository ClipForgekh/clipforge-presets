#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float ratio;
    float particleGroups;
    float spiralRotation;
    float3 neonColor1;
    float3 neonColor2;
    float glowIntensity;
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
float rand(thread const float2& co)
{
    return fract(sin(dot(co, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, thread float2& vUv, constant float& particleGroups, constant float& spiralRotation, constant float3& neonColor1, constant float3& neonColor2, constant float& glowIntensity, constant float& glitchStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float brightness = progress;
    float contrast = mix(0.5, 1.0, progress);
    float3 baseColor = (texel.xyz * contrast) - float3((contrast - 1.0) * 0.5);
    baseColor *= brightness;
    if (progress >= 1.0)
    {
        return float4(baseColor, texel.w);
    }
    float2 param = vUv;
    float2 uv = getAspectCorrectUV(param, ratio);
    float2 p = uv - float2(0.5);
    float len = length(p);
    float angle = precise::atan2(p.y, p.x);
    float decay = 1.0 - progress;
    float3 neonGlow = float3(0.0);
    float edgeFlash = 0.0;
    for (float i = 0.0; i < 16.0; i += 1.0)
    {
        if (i >= particleGroups)
        {
            break;
        }
        float groupId = i / particleGroups;
        float baseAngle = (groupId * 6.28318023681640625) + (progress * spiralRotation);
        float2 param_1 = float2(groupId, 0.123000003397464752197265625);
        float speedOffset = (rand(param_1) * 0.5) + 0.75;
        float flyDistance = (progress * speedOffset) * 1.2000000476837158203125;
        float angleDiff = mod((angle - baseAngle) + 3.141590118408203125, 6.28318023681640625) - 3.141590118408203125;
        float2 param_2 = float2(groupId, 0.4560000002384185791015625);
        float particleRadius = (0.0199999995529651641845703125 * (1.0 + (rand(param_2) * 0.5))) * decay;
        float mainParticle = smoothstep(particleRadius, 0.0, abs(angleDiff)) * smoothstep(flyDistance + 0.0199999995529651641845703125, flyDistance, len);
        float2 param_3 = float2(groupId, 0.788999974727630615234375);
        float subAngle1 = baseAngle + ((rand(param_3) - 0.5) * 0.800000011920928955078125);
        float2 param_4 = float2(groupId, 0.111000001430511474609375);
        float subSpeed1 = speedOffset * ((rand(param_4) * 0.300000011920928955078125) + 0.60000002384185791015625);
        float subFly1 = (progress * subSpeed1) * 1.2000000476837158203125;
        float subParticle1 = smoothstep(particleRadius * 0.60000002384185791015625, 0.0, abs(mod((angle - subAngle1) + 3.141590118408203125, 6.28318023681640625) - 3.141590118408203125)) * smoothstep(subFly1 + 0.0199999995529651641845703125, subFly1, len);
        float2 param_5 = float2(groupId, 0.22200000286102294921875);
        float subAngle2 = baseAngle + ((rand(param_5) - 0.5) * 0.800000011920928955078125);
        float2 param_6 = float2(groupId, 0.333000004291534423828125);
        float subSpeed2 = speedOffset * ((rand(param_6) * 0.300000011920928955078125) + 0.60000002384185791015625);
        float subFly2 = (progress * subSpeed2) * 1.2000000476837158203125;
        float subParticle2 = smoothstep(particleRadius * 0.60000002384185791015625, 0.0, abs(mod((angle - subAngle2) + 3.141590118408203125, 6.28318023681640625) - 3.141590118408203125)) * smoothstep(subFly2 + 0.0199999995529651641845703125, subFly2, len);
        float trail = ((smoothstep(flyDistance - (0.100000001490116119384765625 * decay), flyDistance, len) * smoothstep(particleRadius * 3.0, 0.0, abs(angleDiff))) * decay) * 0.5;
        if ((flyDistance > 0.89999997615814208984375) && (len > 0.89999997615814208984375))
        {
            edgeFlash += ((smoothstep(0.89999997615814208984375, 1.0, flyDistance) * 0.300000011920928955078125) * decay);
        }
        float2 param_7 = float2(groupId, progress);
        float3 particleColor = mix(neonColor1, neonColor2, float3(rand(param_7)));
        neonGlow += (((particleColor * (((mainParticle + subParticle1) + subParticle2) + trail)) * glowIntensity) * decay);
    }
    float glitchOffset = glitchStrength * decay;
    float2 param_8 = vUv + float2(glitchOffset * sin(progress * 10.0), 0.0);
    float2 glitchUVR = handleUVBounds(param_8);
    float2 param_9 = vUv + float2((-glitchOffset) * cos(progress * 10.0), 0.0);
    float2 glitchUVB = handleUVBounds(param_9);
    float r = tDiffuse.sample(tDiffuseSmplr, glitchUVR).x;
    float b = tDiffuse.sample(tDiffuseSmplr, glitchUVB).z;
    baseColor = mix(baseColor, float3(r, baseColor.y, b), float3(decay * 0.300000011920928955078125));
    neonGlow += (float3(0.800000011920928955078125, 0.89999997615814208984375, 1.0) * edgeFlash);
    float3 finalColor = baseColor + neonGlow;
    if (progress < 0.00999999977648258209228515625)
    {
        finalColor = float3(0.0);
    }
    return float4(finalColor, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.particleGroups, buffer.spiralRotation, buffer.neonColor1, buffer.neonColor2, buffer.glowIntensity, buffer.glitchStrength, tDiffuse, tDiffuseSmplr);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

