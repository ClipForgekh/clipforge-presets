#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float scanLineWidth;
    float3 blueColor;
    float glowIntensity;
    float3 redColor;
    float flySpeed;
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
    return sqrt(progress);
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
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& t, constant float& ratio, thread float2& vUv, constant float& scanLineWidth, constant float3& blueColor, constant float& glowIntensity, constant float3& redColor, constant float& flySpeed, constant float& glitchStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& progress)
{
    if (t <= 0.0)
    {
        return texel;
    }
    float2 param = vUv;
    float2 uv = getAspectCorrectUV(param, ratio);
    float diag = uv.x + uv.y;
    float scanBlue1 = abs(diag - ((t * 0.89999997615814208984375) + 0.0));
    float scanBlue2 = abs(diag - ((t * 0.89999997615814208984375) + 0.300000011920928955078125));
    float scanBlue3 = abs(diag - ((t * 0.89999997615814208984375) + 0.60000002384185791015625));
    float scanRed1 = abs(diag - ((2.0 - (t * 0.89999997615814208984375)) - 0.0));
    float scanRed2 = abs(diag - ((2.0 - (t * 0.89999997615814208984375)) - 0.300000011920928955078125));
    float scanRed3 = abs(diag - ((2.0 - (t * 0.89999997615814208984375)) - 0.60000002384185791015625));
    float blueGlow = (smoothstep(scanLineWidth, 0.0, scanBlue1) + smoothstep(scanLineWidth, 0.0, scanBlue2)) + smoothstep(scanLineWidth, 0.0, scanBlue3);
    float redGlow = (smoothstep(scanLineWidth, 0.0, scanRed1) + smoothstep(scanLineWidth, 0.0, scanRed2)) + smoothstep(scanLineWidth, 0.0, scanRed3);
    float3 glowColor = ((blueColor * blueGlow) * glowIntensity) + ((redColor * redGlow) * glowIntensity);
    float triggerTime = 0.0;
    int sliceId = 0;
    if (diag < ((t * 0.89999997615814208984375) + 0.0))
    {
        triggerTime = 0.0;
        sliceId = 0;
    }
    else
    {
        if (diag < ((t * 0.89999997615814208984375) + 0.300000011920928955078125))
        {
            triggerTime = 0.0;
            sliceId = 1;
        }
        else
        {
            if (diag < ((t * 0.89999997615814208984375) + 0.60000002384185791015625))
            {
                triggerTime = 0.333000004291534423828125;
                sliceId = 2;
            }
            else
            {
                if (diag < ((2.0 - (t * 0.89999997615814208984375)) - 0.60000002384185791015625))
                {
                    triggerTime = 0.66600000858306884765625;
                    sliceId = 3;
                }
                else
                {
                    if (diag < ((2.0 - (t * 0.89999997615814208984375)) - 0.300000011920928955078125))
                    {
                        triggerTime = 0.66600000858306884765625;
                        sliceId = 4;
                    }
                    else
                    {
                        if (diag < ((2.0 - (t * 0.89999997615814208984375)) - 0.0))
                        {
                            triggerTime = 0.333000004291534423828125;
                            sliceId = 5;
                        }
                        else
                        {
                            triggerTime = 0.0;
                            sliceId = 6;
                        }
                    }
                }
            }
        }
    }
    float triggerDur = fast::max(0.0, t - triggerTime);
    if (triggerDur <= 0.0)
    {
        return float4(texel.xyz + glowColor, texel.w);
    }
    float sliceFloat = float(sliceId);
    float isEven = 1.0 - step(0.001000000047497451305389404296875, fract(sliceFloat / 2.0));
    float2 flyDir = mix(float2(1.0), float2(-1.0), float2(isEven));
    float randomSpeed = 0.5 + (fract(sliceFloat * 17.2390003204345703125) * 0.5);
    float2 offsetUV = vUv + (((flyDir * triggerDur) * flySpeed) * randomSpeed);
    float2 param_1 = offsetUV;
    offsetUV = handleUVBounds(param_1);
    float glitchOffset = (triggerDur * glitchStrength) * randomSpeed;
    float4 rTex = tDiffuse.sample(tDiffuseSmplr, (offsetUV + float2(glitchOffset, glitchOffset * 0.5)));
    float4 gTex = tDiffuse.sample(tDiffuseSmplr, offsetUV);
    float4 bTex = tDiffuse.sample(tDiffuseSmplr, (offsetUV - float2(glitchOffset, glitchOffset * 0.5)));
    float3 glitchColor = float3(rTex.x, gTex.y, bTex.z);
    float alpha = 1.0 - smoothstep(0.0, 1.0, triggerDur * 1.2000000476837158203125);
    float2 param_2 = offsetUV;
    float mask = getHardBoundaryMask(param_2);
    alpha *= mask;
    float3 finalColor = glitchColor + glowColor;
    float fadeOut = smoothstep(0.800000011920928955078125, 1.0, progress);
    finalColor = mix(finalColor, float3(0.0), float3(fadeOut));
    alpha *= (1.0 - fadeOut);
    return float4(finalColor, alpha);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.scanLineWidth, buffer.blueColor, buffer.glowIntensity, buffer.redColor, buffer.flySpeed, buffer.glitchStrength, tDiffuse, tDiffuseSmplr, buffer.progress);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

