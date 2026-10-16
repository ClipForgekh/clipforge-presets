#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float helixStrength;
    float spinTurns;
    float shuttleAmount;
    float tunnelFocus;
    float brightnessBoost;
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
    return 0.5 * (1.0 - cos((p * 2.0) * 3.1415927410125732421875));
}

static inline __attribute__((always_inline))
float2 rotate2D(thread const float2& p, thread const float& a)
{
    float s = sin(a);
    float c = cos(a);
    return float2((c * p.x) - (s * p.y), (s * p.x) + (c * p.y));
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, thread float2& vUv, constant float& ratio, constant float& helixStrength, constant float& spinTurns, constant float& shuttleAmount, constant float& tunnelFocus, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& brightnessBoost)
{
    float amp = fast::clamp(p, 0.0, 1.0);
    float2 c = float2(0.5);
    float2 q = vUv - c;
    if (ratio > 1.0)
    {
        q.y /= ratio;
    }
    else
    {
        q.x *= ratio;
    }
    float r = length(q) + 9.9999999747524270787835121154785e-07;
    float a = precise::atan2(q.y, q.x);
    float cone = 1.0 - smoothstep(0.0, 0.949999988079071044921875, r);
    float swirl = (amp * helixStrength) * (0.3499999940395355224609375 + (0.64999997615814208984375 * cone));
    float ang = swirl * (((spinTurns * 2.0) * 3.1415927410125732421875) + ((1.0 - r) * 8.0));
    float2 param = q;
    float param_1 = ang;
    float2 qr = rotate2D(param, param_1);
    float forward = (amp * shuttleAmount) * (0.25 + (0.75 * cone));
    float squeeze = 1.0 + ((amp * tunnelFocus) * (1.0 - r));
    qr /= float2(squeeze);
    qr += (((float2(cos(a * 3.0), sin(a * 3.0)) * forward) * 0.0599999986588954925537109375) * cone);
    float2 uv = qr;
    if (ratio > 1.0)
    {
        uv.y *= ratio;
    }
    else
    {
        uv.x /= ratio;
    }
    uv += c;
    float2 param_2 = uv;
    uv = handleUVBounds(param_2);
    float4 warped = tDiffuse.sample(tDiffuseSmplr, uv);
    float radialFade = smoothstep(1.2000000476837158203125, 0.100000001490116119384765625, r);
    float glow = (amp * brightnessBoost) * radialFade;
    float3 color = mix(texel.xyz, warped.xyz, float3(amp));
    color *= (1.0 + glow);
    color = fast::clamp(color, float3(0.0), float3(1.0));
    return float4(color, texel.w);
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.ratio, buffer.helixStrength, buffer.spinTurns, buffer.shuttleAmount, buffer.tunnelFocus, tDiffuse, tDiffuseSmplr, buffer.brightnessBoost);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

