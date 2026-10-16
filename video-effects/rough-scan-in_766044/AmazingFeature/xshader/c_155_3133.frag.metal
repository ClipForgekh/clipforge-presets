#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_progress;
    float u_bandCount;
    float u_glowIntensity;
    float u_diagBlur;
    float u_exposure;
    float u_rgbShift;
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
float4 sampleDiagBlur(thread const float2& uv, thread const float& blurAmt, constant float& ratio, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 dir = fast::normalize(float2(1.0, 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05)));
    float r = blurAmt * 0.0199999995529651641845703125;
    float4 c = float4(0.0);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv - ((dir * r) * 2.0), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv - (dir * r), float2(0.0), float2(1.0))) * 0.2199999988079071044921875);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.319999992847442626953125);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + (dir * r), float2(0.0), float2(1.0))) * 0.2199999988079071044921875);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + ((dir * r) * 2.0), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    return c;
}

static inline __attribute__((always_inline))
float3 blendDifference(thread const float3& base, thread const float3& blend)
{
    return abs(base - blend);
}

static inline __attribute__((always_inline))
float3 blendScreen(thread const float3& base, thread const float3& blend)
{
    return float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - blend));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float p = fast::clamp(buffer.u_progress, 0.0, 1.0);
    float bandH = 1.0 / buffer.u_bandCount;
    float bandIndex = floor((1.0 - uv.y) / bandH);
    bandIndex = fast::clamp(bandIndex, 0.0, buffer.u_bandCount - 1.0);
    float seqStart = 0.20000000298023223876953125 + (bandIndex * (0.5 / buffer.u_bandCount));
    float local = fast::clamp((p - seqStart) / (0.5 / buffer.u_bandCount), 0.0, 1.0);
    float2 scanDir = float2(0.707106769084930419921875);
    float coord = dot(uv, scanDir);
    float sweepPos = mix(-0.3499999940395355224609375, 1.64999997615814208984375, local);
    float revealInBand = smoothstep(-0.0199999995529651641845703125, 0.0199999995529651641845703125, sweepPos - coord);
    float reveal = revealInBand;
    if (p >= 0.699999988079071044921875)
    {
        reveal = 1.0;
    }
    if (p < 0.20000000298023223876953125)
    {
        reveal = 0.0;
    }
    float localDecay = 1.0 - revealInBand;
    float fxGlow = buffer.u_glowIntensity * localDecay;
    float fxBlur = buffer.u_diagBlur * localDecay;
    float fxExposure = buffer.u_exposure * localDecay;
    float fxRgb = buffer.u_rgbShift * localDecay;
    float2 param = uv;
    float param_1 = fxBlur;
    float4 blurTex = sampleDiagBlur(param, param_1, buffer.ratio, texture1, texture1Smplr);
    float3 color = blurTex.xyz * (1.0 + (fxExposure * 1.60000002384185791015625));
    float px = fxRgb * 0.001599999959580600261688232421875;
    float2 jitterDir = fast::normalize(float2(sin((p * 97.30999755859375) + (uv.y * 30.0)), cos((p * 83.1699981689453125) + (uv.x * 30.0))));
    float2 jitter = jitterDir * px;
    float r = texture1.sample(texture1Smplr, fast::clamp(uv + jitter, float2(0.0), float2(1.0))).x;
    float g = texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))).y;
    float b = texture1.sample(texture1Smplr, fast::clamp(uv - jitter, float2(0.0), float2(1.0))).z;
    float3 glitch = float3(r, g, b);
    float3 param_2 = color;
    float3 param_3 = glitch;
    color = mix(color, blendDifference(param_2, param_3), float3(fast::clamp(fxRgb, 0.0, 1.0)));
    float leftGlowMask = smoothstep(0.36000001430511474609375, 0.0, uv.x) * (1.0 - (reveal * 0.89999997615814208984375));
    float3 neonA = float3(1.0, 0.310000002384185791015625, 0.85000002384185791015625);
    float3 neonB = float3(0.62999999523162841796875, 0.2899999916553497314453125, 1.0);
    float3 neon = mix(neonA, neonB, float3(uv.y));
    float3 glow = ((neon * leftGlowMask) * fxGlow) * 1.7999999523162841796875;
    float3 param_4 = color;
    float3 param_5 = glow;
    float3 composed = blendScreen(param_4, param_5);
    float3 outColor = mix(float3(0.0), composed, float3(reveal));
    out.gl_FragColor = float4(outColor, 1.0);
    return out;
}

