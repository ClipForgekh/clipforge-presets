#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float eyeDetailIntensity;
    float removePouchIntensity;
    float removeNasolabialFoldsIntensity;
    float2 inputSize;
    float intensity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 texCoord [[user(texCoord)]];
    float2 sucaiTexCoord [[user(sucaiTexCoord)]];
    float2 textureShift_1 [[user(textureShift_1)]];
    float2 textureShift_2 [[user(textureShift_2)]];
    float2 textureShift_3 [[user(textureShift_3)]];
    float2 textureShift_4 [[user(textureShift_4)]];
    float2 segCoord [[user(segCoord)]];
};

static inline __attribute__((always_inline))
float4 LUT8x8(thread const float4& inColor, texture2d<float> lutImageTexture, sampler lutImageTextureSmplr)
{
    float blueColor = inColor.z * 63.0;
    float2 quad1;
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);
    float2 quad2;
    quad2.y = floor(ceil(blueColor) / 8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);
    float2 texPos1 = ((quad1 * 0.125) + float2(0.0009765625)) + (inColor.xy * 0.123046875);
    float2 texPos2 = ((quad2 * 0.125) + float2(0.0009765625)) + (inColor.xy * 0.123046875);
    float4 newColor2_1 = lutImageTexture.sample(lutImageTextureSmplr, texPos1);
    float4 newColor2_2 = lutImageTexture.sample(lutImageTextureSmplr, texPos2);
    float4 newColor22 = mix(newColor2_1, newColor2_2, float4(fract(blueColor)));
    float4 _93 = newColor22;
    return _93;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> inputImageMaskTexture [[texture(1)]], texture2d<float> inputScaledTexture [[texture(2)]], texture2d<float> inputScaledBlurTexture [[texture(3)]], texture2d<float> lutImageTexture [[texture(4)]], texture2d<float> segMaskTexture [[texture(5)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler inputImageMaskTextureSmplr [[sampler(1)]], sampler inputScaledTextureSmplr [[sampler(2)]], sampler inputScaledBlurTextureSmplr [[sampler(3)]], sampler lutImageTextureSmplr [[sampler(4)]], sampler segMaskTextureSmplr [[sampler(5)]])
{
    main0_out out = {};
    float4 color = inputImageTexture.sample(inputImageTextureSmplr, in.texCoord);
    float4 maskColor = inputImageMaskTexture.sample(inputImageMaskTextureSmplr, in.sucaiTexCoord);
    float3 resultColor = color.xyz;
    float border = 0.100000001490116119384765625;
    bool _121 = maskColor.y > border;
    bool _128;
    if (_121)
    {
        _128 = maskColor.x > border;
    }
    else
    {
        _128 = _121;
    }
    if (_128 && (buffer.eyeDetailIntensity >= 0.00999999977648258209228515625))
    {
        float2 step1 = float2(0.002080000005662441253662109375, 0.0);
        float2 step2 = float2(0.0, 0.00133999995887279510498046875);
        float3 sumColor = float3(0.0);
        for (float t = -2.0; t < 2.5; t += 1.0)
        {
            for (float p = -2.0; p < 2.5; p += 1.0)
            {
                sumColor += inputImageTexture.sample(inputImageTextureSmplr, ((in.texCoord + (step1 * t)) + (step2 * p))).xyz;
            }
        }
        sumColor *= 0.039999999105930328369140625;
        sumColor = fast::clamp(sumColor + ((color.xyz - sumColor) * 3.0), float3(0.0), float3(1.0));
        sumColor = fast::max(color.xyz, sumColor);
        resultColor = mix(color.xyz, sumColor, float3((buffer.eyeDetailIntensity * maskColor.y) * 0.5));
    }
    bool _215 = maskColor.x > border;
    bool _222;
    if (_215)
    {
        _222 = maskColor.y < border;
    }
    else
    {
        _222 = _215;
    }
    if (_222 && (buffer.removePouchIntensity >= 0.00999999977648258209228515625))
    {
        float3 scaledColor = inputScaledTexture.sample(inputScaledTextureSmplr, in.texCoord).xyz;
        float3 scaledBlurColor = inputScaledBlurTexture.sample(inputScaledBlurTextureSmplr, in.texCoord).xyz;
        float3 highColor = color.xyz - scaledColor;
        float3 newColor = scaledBlurColor + highColor;
        float diff = fast::clamp((15.0 * (newColor.x - color.x)) + 1.0, 0.0, 1.0);
        float4 originColor = float4(newColor, 1.0);
        float4 param = originColor;
        float4 brightColor = LUT8x8(param, lutImageTexture, lutImageTextureSmplr);
        newColor = mix(newColor, brightColor.xyz, float3(maskColor.x * 0.4000000059604644775390625));
        float3 sum = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_1).xyz;
        sum += inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_2).xyz;
        sum += inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_3).xyz;
        sum += inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_4).xyz;
        sum *= 0.25;
        float3 hColor = fast::clamp(((color.xyz - sum) / float3(2.0)) + float3(0.5), float3(0.0), float3(1.0));
        float3 evenColor = fast::clamp((newColor + (hColor * 2.0)) - float3(1.0), float3(0.0), float3(1.0));
        float removePouchIntensityValue = buffer.removePouchIntensity * 1.25;
        resultColor = mix(resultColor, evenColor, float3((removePouchIntensityValue * maskColor.x) * diff));
    }
    bool _349 = maskColor.y > border;
    bool _356;
    if (_349)
    {
        _356 = maskColor.x < border;
    }
    else
    {
        _356 = _349;
    }
    if (_356 && (buffer.removeNasolabialFoldsIntensity >= 0.00999999977648258209228515625))
    {
        float3 scaledColor_1 = inputScaledTexture.sample(inputScaledTextureSmplr, in.texCoord).xyz;
        float3 scaledBlurColor_1 = inputScaledBlurTexture.sample(inputScaledBlurTextureSmplr, in.texCoord).xyz;
        float3 highColor_1 = color.xyz - scaledColor_1;
        float3 newColor_1 = scaledBlurColor_1 + highColor_1;
        float ratio = 1080.0 / buffer.inputSize.x;
        if (ratio < 1.0)
        {
            ratio = 1.0;
        }
        float diff_1 = fast::clamp(((ratio * 5.0) * (newColor_1.x - color.x)) + 1.0, 0.0, 1.0);
        float4 originColor_1 = float4(newColor_1, 1.0);
        float4 param_1 = originColor_1;
        float4 brightColor_1 = LUT8x8(param_1, lutImageTexture, lutImageTextureSmplr);
        newColor_1 = mix(newColor_1, brightColor_1.xyz, float3(maskColor.y * 0.4000000059604644775390625));
        float3 sum_1 = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_1).xyz;
        sum_1 += inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_2).xyz;
        sum_1 += inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_3).xyz;
        sum_1 += inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_4).xyz;
        sum_1 *= 0.25;
        float3 hColor_1 = fast::clamp(((color.xyz - sum_1) / float3(2.0)) + float3(0.5), float3(0.0), float3(1.0));
        float3 evenColor_1 = fast::clamp((newColor_1 + (hColor_1 * 2.0)) - float3(1.0), float3(0.0), float3(1.0));
        float removeNasolabialFoldsIntensityValue = buffer.removeNasolabialFoldsIntensity * 1.25;
        resultColor = mix(resultColor, evenColor_1, float3((removeNasolabialFoldsIntensityValue * maskColor.y) * diff_1));
    }
    float seg_opacity = segMaskTexture.sample(segMaskTextureSmplr, in.segCoord).x;
    if (any(fast::clamp(in.segCoord, float2(0.0), float2(1.0)) != in.segCoord))
    {
        seg_opacity = 1.0;
    }
    resultColor = mix(color.xyz, resultColor, float3(seg_opacity));
    out.gl_FragColor = float4(mix(color.xyz, resultColor, float3(buffer.intensity)), color.w);
    return out;
}

