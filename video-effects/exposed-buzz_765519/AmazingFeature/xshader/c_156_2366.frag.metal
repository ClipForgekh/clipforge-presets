#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 uvScale;
    float2 uvOffset;
    float ratio;
    float blurRadiusPx;
    float exposureGain;
    float warmTintStrength;
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
float2 getMappedUv(thread const float2& uv, constant float2& uvScale, constant float2& uvOffset)
{
    return (uv * uvScale) + uvOffset;
}

static inline __attribute__((always_inline))
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float2& texelStep)
{
    float4 color = float4(0.0);
    color += (tex.sample(texSmplr, fast::clamp(uv + (texelStep * (-4.0)), float2(0.0), float2(1.0))) * 0.05099999904632568359375);
    color += (tex.sample(texSmplr, fast::clamp(uv + (texelStep * (-3.0)), float2(0.0), float2(1.0))) * 0.091799996793270111083984375);
    color += (tex.sample(texSmplr, fast::clamp(uv + (texelStep * (-2.0)), float2(0.0), float2(1.0))) * 0.122450001537799835205078125);
    color += (tex.sample(texSmplr, fast::clamp(uv + (texelStep * (-1.0)), float2(0.0), float2(1.0))) * 0.15309999883174896240234375);
    color += (tex.sample(texSmplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.16329999268054962158203125);
    color += (tex.sample(texSmplr, fast::clamp(uv + (texelStep * 1.0), float2(0.0), float2(1.0))) * 0.15309999883174896240234375);
    color += (tex.sample(texSmplr, fast::clamp(uv + (texelStep * 2.0), float2(0.0), float2(1.0))) * 0.122450001537799835205078125);
    color += (tex.sample(texSmplr, fast::clamp(uv + (texelStep * 3.0), float2(0.0), float2(1.0))) * 0.091799996793270111083984375);
    color += (tex.sample(texSmplr, fast::clamp(uv + (texelStep * 4.0), float2(0.0), float2(1.0))) * 0.05099999904632568359375);
    return color;
}

static inline __attribute__((always_inline))
float4 gaussianBlurApprox(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusPx, constant float& ratio)
{
    if (radiusPx <= 0.001000000047497451305389404296875)
    {
        return tex.sample(texSmplr, fast::clamp(uv, float2(0.0), float2(1.0)));
    }
    float normalizedRadius = radiusPx / 600.0;
    float2 stepX = float2(normalizedRadius, 0.0);
    float2 stepY = float2(0.0, normalizedRadius);
    float2 param = uv;
    float2 param_1 = stepX;
    float4 horizontal = gaussianBlur9(tex, texSmplr, param, param_1);
    float2 param_2 = uv;
    float2 param_3 = stepY;
    float4 vertical = gaussianBlur9(tex, texSmplr, param_2, param_3);
    float2 param_4 = uv;
    float2 param_5 = float2(normalizedRadius * 0.707099974155426025390625, (normalizedRadius * 0.707099974155426025390625) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 diagonalA = gaussianBlur9(tex, texSmplr, param_4, param_5);
    float2 param_6 = uv;
    float2 param_7 = float2(normalizedRadius * 0.707099974155426025390625, ((-normalizedRadius) * 0.707099974155426025390625) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 diagonalB = gaussianBlur9(tex, texSmplr, param_6, param_7);
    return (((horizontal + vertical) + diagonalA) + diagonalB) * 0.25;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 mappedUv = getMappedUv(param, buffer.uvScale, buffer.uvOffset);
    float2 param_1 = mappedUv;
    float param_2 = buffer.blurRadiusPx;
    float4 texColor = gaussianBlurApprox(texture1, texture1Smplr, param_1, param_2, buffer.ratio);
    float3 warmTint = float3(1.0, 0.939999997615814208984375, 0.86000001430511474609375);
    float4 _264 = texColor;
    float3 _266 = _264.xyz * buffer.exposureGain;
    texColor.x = _266.x;
    texColor.y = _266.y;
    texColor.z = _266.z;
    float4 _277 = texColor;
    float4 _279 = texColor;
    float3 _286 = mix(_277.xyz, _279.xyz * warmTint, float3(buffer.warmTintStrength));
    texColor.x = _286.x;
    texColor.y = _286.y;
    texColor.z = _286.z;
    out.gl_FragColor = float4(texColor.xyz, texColor.w);
    return out;
}

