#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uniAlpha;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 textureCoordinate [[user(textureCoordinate)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> inputImageTexture2 [[texture(1)]], texture2d<float> maskTexture [[texture(2)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler inputImageTexture2Smplr [[sampler(1)]], sampler maskTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 textureColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureCoordinate);
    float blueColor = textureColor.z * 63.0;
    float2 quad1;
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);
    float2 quad2;
    quad2.y = floor(ceil(blueColor) / 8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);
    float2 texPos1;
    texPos1.x = (((quad1.x * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * textureColor.x);
    texPos1.y = (((quad1.y * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * textureColor.y);
    float2 texPos2;
    texPos2.x = (((quad2.x * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * textureColor.x);
    texPos2.y = (((quad2.y * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * textureColor.y);
    float4 newColor1 = inputImageTexture2.sample(inputImageTexture2Smplr, texPos1);
    float4 newColor2 = inputImageTexture2.sample(inputImageTexture2Smplr, texPos2);
    float4 newColor = mix(newColor1, newColor2, float4(fract(blueColor)));
    float4 filterCol = mix(textureColor, float4(newColor.xyz, textureColor.w), float4(buffer.uniAlpha));
    float2 maskCoord = float2(in.textureCoordinate.x, 1.0 - in.textureCoordinate.y);
    float mask = maskTexture.sample(maskTextureSmplr, maskCoord).w;
    out.gl_FragColor = mix(textureColor, filterCol, float4(mask));
    return out;
}

