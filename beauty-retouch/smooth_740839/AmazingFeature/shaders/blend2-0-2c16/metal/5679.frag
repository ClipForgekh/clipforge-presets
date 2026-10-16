#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv [[user(uv)]];
    float2 uv0 [[user(uv0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> blendImageTexture [[texture(1)]], texture2d<float> blur3ImageTexture [[texture(2)]], texture2d<float> blur4ImageTexture [[texture(3)]], texture2d<float> faceSkinMaskTexture [[texture(4)]], texture2d<float> skinsegMaskTexture [[texture(5)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler blendImageTextureSmplr [[sampler(1)]], sampler blur3ImageTextureSmplr [[sampler(2)]], sampler blur4ImageTextureSmplr [[sampler(3)]], sampler faceSkinMaskTextureSmplr [[sampler(4)]], sampler skinsegMaskTextureSmplr [[sampler(5)]])
{
    main0_out out = {};
    float4 oriColor = inputImageTexture.sample(inputImageTextureSmplr, in.uv);
    float4 preColor = blendImageTexture.sample(blendImageTextureSmplr, in.uv);
    float4 blurColor = blur3ImageTexture.sample(blur3ImageTextureSmplr, in.uv);
    float4 twiceBlurColor = blur4ImageTexture.sample(blur4ImageTextureSmplr, in.uv);
    float4 maskColor = faceSkinMaskTexture.sample(faceSkinMaskTextureSmplr, in.uv);
    float4 skinColor = skinsegMaskTexture.sample(skinsegMaskTextureSmplr, in.uv0);
    float kMin = 1.0 - (preColor.w / (preColor.w + 0.5));
    float smoothArea = (mix(skinColor.w, maskColor.z, step(0.004999999888241291046142578125, maskColor.y)) * skinColor.w) * kMin;
    float smoothIntensity = maskColor.w;
    float3 hColor = ((preColor.xyz - blurColor.xyz) / float3(2.0)) + float3(0.5);
    float3 evenColor = fast::clamp((twiceBlurColor.xyz + (hColor * 2.0)) - float3(1.0), float3(0.0), float3(1.0));
    evenColor = mix(preColor.xyz, evenColor, float3(smoothArea));
    float smoothFactor = mix(0.300000011920928955078125, smoothIntensity - 0.300000011920928955078125, step(0.60000002384185791015625, smoothIntensity));
    evenColor = mix(evenColor, twiceBlurColor.xyz, float3(smoothFactor * smoothArea));
    float finalIntensity = mix(smoothIntensity * 1.66999995708465576171875, 1.0, step(0.60000002384185791015625, smoothIntensity));
    float3 smoothColor = mix(oriColor.xyz, evenColor, float3(finalIntensity));
    out.gl_FragColor = float4(smoothColor, oriColor.w);
    return out;
}

