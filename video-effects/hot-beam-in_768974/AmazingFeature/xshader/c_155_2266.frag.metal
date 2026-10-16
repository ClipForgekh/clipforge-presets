#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uProgress;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUv [[user(vUv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> uTexture [[texture(0)]], sampler uTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float t = fast::clamp(buffer.uProgress, 0.0, 1.0);
    float _19;
    if (t >= 1.0)
    {
        _19 = 1.0;
    }
    else
    {
        _19 = 1.0 - pow(1.0 - t, 3.7999999523162841796875);
    }
    float easeSnap = _19;
    float flashExposure = exp((-t) * 7.5) * 2.400000095367431640625;
    float leakIntensity = sin(smoothstep(0.0, 0.85000002384185791015625, t) * 3.1415927410125732421875) * pow(1.0 - t, 0.3499999940395355224609375);
    float chromaticShift = pow(1.0 - easeSnap, 2.2000000476837158203125) * 0.04500000178813934326171875;
    float zoomScale = 1.0 + ((1.0 - easeSnap) * 0.07999999821186065673828125);
    float2 uv = in.vUv;
    float2 centeredUV = uv - float2(0.5);
    float2 zoomedUV = (centeredUV / float2(fast::max(zoomScale, 9.9999997473787516355514526367188e-05))) + float2(0.5);
    float2 splitDir = float2(chromaticShift, (-chromaticShift) * 0.4000000059604644775390625);
    float2 rUV = fast::clamp(zoomedUV + splitDir, float2(0.0), float2(1.0));
    float2 gUV = fast::clamp(zoomedUV, float2(0.0), float2(1.0));
    float2 bUV = fast::clamp(zoomedUV - splitDir, float2(0.0), float2(1.0));
    float r = uTexture.sample(uTextureSmplr, rUV).x;
    float g = uTexture.sample(uTextureSmplr, gUV).y;
    float b = uTexture.sample(uTextureSmplr, bUV).z;
    float3 sampledContent = float3(r, g, b);
    float streak1Axis = ((uv.x * 0.800000011920928955078125) + (uv.y * 1.2000000476837158203125)) - ((t * 2.2000000476837158203125) - 0.20000000298023223876953125);
    float streak1 = exp((-abs(streak1Axis)) * 8.0) * leakIntensity;
    float3 amberLeak = (float3(1.0, 0.64999997615814208984375, 0.25) * streak1) * 2.2000000476837158203125;
    float streak2Dist = length(uv - float2(0.85000002384185791015625 - (t * 0.300000011920928955078125), 0.89999997615814208984375));
    float streak2 = exp((-streak2Dist) * 4.5) * leakIntensity;
    float3 roseLeak = (float3(1.0, 0.20000000298023223876953125, 0.64999997615814208984375) * streak2) * 1.7999999523162841796875;
    float streak3 = (exp((-abs(uv.y - 0.449999988079071044921875)) * 65.0) * exp((-abs(uv.x - 0.5)) * 1.5)) * leakIntensity;
    float3 cyanLeak = (float3(0.25, 0.75, 1.0) * streak3) * 1.5;
    float3 totalLightLeak = (amberLeak + roseLeak) + cyanLeak;
    float3 exposedContent = (sampledContent * (1.0 + flashExposure)) + float3(flashExposure * 0.85000002384185791015625);
    float3 compositeRgb = exposedContent + totalLightLeak;
    float alphaReveal = smoothstep(0.0, 0.07999999821186065673828125, t);
    float3 finalRgb = mix(float3(0.0), compositeRgb, float3(alphaReveal));
    float finalAlpha = alphaReveal;
    if (t <= 0.0)
    {
        finalRgb = float3(0.0);
        finalAlpha = 0.0;
    }
    if (t >= 1.0)
    {
        finalRgb = uTexture.sample(uTextureSmplr, uv).xyz;
        finalAlpha = 1.0;
    }
    out.gl_FragColor = float4(finalRgb, finalAlpha);
    return out;
}

