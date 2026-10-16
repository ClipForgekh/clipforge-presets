#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_verticalBlurStep;
    float u_gaussianRadius;
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
float4 sampleVerticalBlur(thread const float2& uv, thread const float& stepSize, texture2d<float> texture1, sampler texture1Smplr)
{
    float4 col = float4(0.0);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-4.0) * stepSize), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-3.0) * stepSize), float2(0.0), float2(1.0))) * 0.100000001490116119384765625);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-2.0) * stepSize), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-1.0) * stepSize), float2(0.0), float2(1.0))) * 0.14000000059604644775390625);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 1.0 * stepSize), float2(0.0), float2(1.0))) * 0.14000000059604644775390625);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 2.0 * stepSize), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 3.0 * stepSize), float2(0.0), float2(1.0))) * 0.100000001490116119384765625);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 4.0 * stepSize), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    return col;
}

static inline __attribute__((always_inline))
float4 sampleGaussianBlur(thread const float2& uv, thread const float& radiusPx, texture2d<float> texture1, sampler texture1Smplr, constant float& ratio)
{
    float baseStep = radiusPx / 1200.0;
    float2 stepSize = float2(baseStep, baseStep / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 col = float4(0.0);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(-2.0) * stepSize), float2(0.0), float2(1.0))) * 0.0500000007450580596923828125);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(0.0, -2.0) * stepSize), float2(0.0), float2(1.0))) * 0.0900000035762786865234375);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(2.0, -2.0) * stepSize), float2(0.0), float2(1.0))) * 0.0500000007450580596923828125);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(-2.0, 0.0) * stepSize), float2(0.0), float2(1.0))) * 0.0900000035762786865234375);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(0.0) * stepSize), float2(0.0), float2(1.0))) * 0.23999999463558197021484375);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(2.0, 0.0) * stepSize), float2(0.0), float2(1.0))) * 0.0900000035762786865234375);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(-2.0, 2.0) * stepSize), float2(0.0), float2(1.0))) * 0.0500000007450580596923828125);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(0.0, 2.0) * stepSize), float2(0.0), float2(1.0))) * 0.0900000035762786865234375);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(2.0) * stepSize), float2(0.0), float2(1.0))) * 0.0500000007450580596923828125);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(-1.0) * stepSize), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(1.0, -1.0) * stepSize), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(-1.0, 1.0) * stepSize), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    col += (texture1.sample(texture1Smplr, fast::clamp(uv + (float2(1.0) * stepSize), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    return col;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float4 originalColor = texture1.sample(texture1Smplr, in.vUv);
    float vStrength = fast::clamp(buffer.u_verticalBlurStep / 0.02999999932944774627685546875, 0.0, 1.0);
    float gStrength = fast::clamp(buffer.u_gaussianRadius / 12.0, 0.0, 1.0);
    float blurMix = fast::max(vStrength, gStrength);
    float2 param = in.vUv;
    float param_1 = buffer.u_verticalBlurStep;
    float4 verticalColor = sampleVerticalBlur(param, param_1, texture1, texture1Smplr);
    float2 param_2 = in.vUv;
    float param_3 = buffer.u_gaussianRadius;
    float4 gaussianColor = sampleGaussianBlur(param_2, param_3, texture1, texture1Smplr, buffer.ratio);
    float4 combinedBlur = mix(verticalColor, gaussianColor, float4(0.5));
    out.gl_FragColor = mix(originalColor, combinedBlur, float4(blurMix));
    return out;
}

