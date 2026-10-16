#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(uv0)]];
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
    float2 texPos1 = (float2(quad1 * 0.125) + float2(0.0009765625)) + (inColor.xy * 0.123046875);
    float2 texPos2 = (float2(quad2 * 0.125) + float2(0.0009765625)) + (inColor.xy * 0.123046875);
    float4 newColor2_1 = lutImageTexture.sample(lutImageTextureSmplr, texPos1);
    float4 newColor2_2 = lutImageTexture.sample(lutImageTextureSmplr, texPos2);
    float4 newColor22 = mix(newColor2_1, newColor2_2, float4(fract(blueColor)));
    float4 _99 = newColor22;
    return _99;
}

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> blurImageTexture [[texture(1)]], texture2d<float> faceSkinMaskTexture [[texture(2)]], texture2d<float> lutImageTexture [[texture(3)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler blurImageTextureSmplr [[sampler(1)]], sampler faceSkinMaskTextureSmplr [[sampler(2)]], sampler lutImageTextureSmplr [[sampler(3)]])
{
    main0_out out = {};
    float dark_threshold_Factor = 28.8675098419189453125;
    float4 srcColor = inputImageTexture.sample(inputImageTextureSmplr, in.uv0);
    float4 blurColor = blurImageTexture.sample(blurImageTextureSmplr, in.uv0);
    float4 maskColor = faceSkinMaskTexture.sample(faceSkinMaskTextureSmplr, in.uv0);
    float4 dstColor = float4(srcColor.xyz, blurColor.w);
    if (maskColor.z > 0.004999999888241291046142578125)
    {
        float cDistance = distance(float3(0.0), fast::max(blurColor.xyz - srcColor.xyz, float3(0.0))) * dark_threshold_Factor;
        if ((cDistance > 0.5) && (cDistance < 5.0))
        {
            float4 param = srcColor;
            float4 brightColor = LUT8x8(param, lutImageTexture, lutImageTextureSmplr);
            float3 _180 = mix(srcColor.xyz, brightColor.xyz, float3(maskColor.z * ((0.0888999998569488525390625 * cDistance) + 0.3549999892711639404296875)));
            dstColor.x = _180.x;
            dstColor.y = _180.y;
            dstColor.z = _180.z;
        }
    }
    out.gl_FragColor = dstColor;
    return out;
}

