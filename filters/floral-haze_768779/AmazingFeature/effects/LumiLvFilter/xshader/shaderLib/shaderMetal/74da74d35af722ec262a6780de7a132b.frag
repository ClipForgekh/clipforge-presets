#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uniAlpha;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline float hash21(float2 p)
{
    return fract(sin(dot(p, float2(127.1, 311.7))) * 43758.5453123);
}

static inline float valueNoise(float2 p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    return mix(mix(hash21(i), hash21(i + float2(1.0, 0.0)), f.x),
               mix(hash21(i + float2(0.0, 1.0)), hash21(i + float2(1.0, 1.0)), f.x), f.y);
}

static inline float4 applyLut(texture2d<float> lut, sampler lutSampler,
                              thread const float4& source, float amount)
{
    float blue = source.b * 63.0;
    float slice0 = floor(blue);
    float slice1 = ceil(blue);
    float2 tile0 = float2(slice0 - floor(slice0 / 8.0) * 8.0, floor(slice0 / 8.0));
    float2 tile1 = float2(slice1 - floor(slice1 / 8.0) * 8.0, floor(slice1 / 8.0));
    float2 uv0 = tile0 / 8.0 + float2(0.0009765625) + 0.123046875 * source.rg;
    float2 uv1 = tile1 / 8.0 + float2(0.0009765625) + 0.123046875 * source.rg;
    uv0.y = 1.0 - uv0.y;
    uv1.y = 1.0 - uv1.y;
    float3 mapped = mix(lut.sample(lutSampler, uv0).rgb,
                        lut.sample(lutSampler, uv1).rgb, fract(blue));
    return float4(mix(source.rgb, mapped, clamp(amount, 0.0, 1.0)), source.a);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer,
                          texture2d<float> inputImageTexture [[texture(0)]],
                          texture2d<float> inputImageTexture2 [[texture(1)]],
                          sampler inputImageTextureSmplr [[sampler(0)]],
                          sampler inputImageTexture2Smplr [[sampler(1)]])
{
    main0_out out = {};
    float4 original = inputImageTexture.sample(inputImageTextureSmplr, in.v_uv);
    if (buffer.uniAlpha < 0.00001)
    {
        out.o_fragColor = original;
        return out;
    }

    float strength = clamp(buffer.uniAlpha / 0.88, 0.0, 1.0);
    float2 refractedUV = clamp(in.v_uv, float2(0.003), float2(0.997));
    float2 softStep = float2(0.0020);
    float4 sharpSample = inputImageTexture.sample(inputImageTextureSmplr, refractedUV);
    float2 chromaShift = (refractedUV - float2(0.5)) * 0.0060 * strength;
    sharpSample.r = inputImageTexture.sample(inputImageTextureSmplr, clamp(refractedUV + chromaShift, float2(0.003), float2(0.997))).r;
    sharpSample.b = inputImageTexture.sample(inputImageTextureSmplr, clamp(refractedUV - chromaShift, float2(0.003), float2(0.997))).b;
    float4 softSample = sharpSample * 4.0;
    softSample += inputImageTexture.sample(inputImageTextureSmplr, refractedUV + float2(softStep.x, 0.0)) * 2.0;
    softSample += inputImageTexture.sample(inputImageTextureSmplr, refractedUV - float2(softStep.x, 0.0)) * 2.0;
    softSample += inputImageTexture.sample(inputImageTextureSmplr, refractedUV + float2(0.0, softStep.y)) * 2.0;
    softSample += inputImageTexture.sample(inputImageTextureSmplr, refractedUV - float2(0.0, softStep.y)) * 2.0;
    softSample += inputImageTexture.sample(inputImageTextureSmplr, refractedUV + softStep);
    softSample += inputImageTexture.sample(inputImageTextureSmplr, refractedUV - softStep);
    softSample += inputImageTexture.sample(inputImageTextureSmplr, refractedUV + float2(softStep.x, -softStep.y));
    softSample += inputImageTexture.sample(inputImageTextureSmplr, refractedUV + float2(-softStep.x, softStep.y));
    softSample /= 16.0;
    float4 refracted = mix(sharpSample, softSample, 0.22 * strength);
    float4 graded = applyLut(inputImageTexture2, inputImageTexture2Smplr, refracted, buffer.uniAlpha);

    float coarse = valueNoise(in.v_uv * float2(5.3, 7.1) + float2(2.7, 9.4));
    float fineNoise = valueNoise(in.v_uv * float2(31.0, 37.0));
    float2 peachP = (in.v_uv - float2(0.63, 0.58)) / float2(0.55, 0.38);
    float2 goldP = (in.v_uv - float2(0.52, 0.15)) / float2(0.62, 0.34);
    float2 cyanP = (in.v_uv - float2(0.18, 0.24)) / float2(0.42, 0.38);
    float2 greenP = (in.v_uv - float2(0.28, 0.80)) / float2(0.52, 0.32);
    float peachLeak = exp(-dot(peachP, peachP) * 1.45) * 0.250;
    float goldVeil = exp(-dot(goldP, goldP) * 1.20) * 0.135;
    float cyanVeil = exp(-dot(cyanP, cyanP) * 1.35) * 0.090;
    float greenVeil = exp(-dot(greenP, greenP) * 1.40) * 0.075;
    float milk = 0.052 + 0.086 * (0.70 * coarse + 0.30 * fineNoise);

    float3 optical = float3(milk * 1.08, milk, milk * 0.78);
    optical += peachLeak * float3(1.00, 0.47, 0.48);
    optical += goldVeil * float3(1.00, 0.76, 0.33);
    optical += cyanVeil * float3(0.28, 0.76, 1.00);
    optical += greenVeil * float3(0.42, 1.00, 0.60);
    float3 color = 1.0 - (1.0 - graded.rgb) * (1.0 - clamp(optical * strength, 0.0, 0.32));

    float grain = hash21(in.v_uv * float2(1280.0, 960.0) + float2(13.0, 71.0)) - 0.5;
    color += grain * 0.010 * strength;
    out.o_fragColor = float4(clamp(color, 0.0, 1.0), original.a);
    return out;
}
