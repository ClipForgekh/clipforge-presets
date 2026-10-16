#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 textureCoordinate [[user(textureCoordinate)]];
    float4 textureShift_1 [[user(textureShift_1)]];
    float4 textureShift_2 [[user(textureShift_2)]];
    float4 textureShift_3 [[user(textureShift_3)]];
    float4 textureShift_4 [[user(textureShift_4)]];
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> faceSkinMaskTexture [[texture(1)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler faceSkinMaskTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 curColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureCoordinate);
    float skinArea = faceSkinMaskTexture.sample(faceSkinMaskTextureSmplr, in.textureCoordinate).w;
    float toleranceFactor = 5.248638629913330078125;
    if (skinArea > 0.100000001490116119384765625)
    {
        float sum_weight = 0.180000007152557373046875;
        float3 sum = curColor.xyz * 0.180000007152557373046875;
        float sum_g = curColor.y;
        float4 neighborColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_1.xy);
        float color_dist = fast::min(distance(curColor.xyz, neighborColor.xyz) * toleranceFactor, 1.0);
        float sample_weight = 0.1500000059604644775390625 * (1.0 - color_dist);
        sum_weight += sample_weight;
        sum += (neighborColor.xyz * sample_weight);
        sum_g += neighborColor.y;
        neighborColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_1.zw);
        color_dist = fast::min(distance(curColor.xyz, neighborColor.xyz) * toleranceFactor, 1.0);
        sample_weight = 0.1500000059604644775390625 * (1.0 - color_dist);
        sum_weight += sample_weight;
        sum += (neighborColor.xyz * sample_weight);
        sum_g += neighborColor.y;
        neighborColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_2.xy);
        color_dist = fast::min(distance(curColor.xyz, neighborColor.xyz) * toleranceFactor, 1.0);
        sample_weight = 0.119999997317790985107421875 * (1.0 - color_dist);
        sum_weight += sample_weight;
        sum += (neighborColor.xyz * sample_weight);
        sum_g += neighborColor.y;
        neighborColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_2.zw);
        color_dist = fast::min(distance(curColor.xyz, neighborColor.xyz) * toleranceFactor, 1.0);
        sample_weight = 0.119999997317790985107421875 * (1.0 - color_dist);
        sum_weight += sample_weight;
        sum += (neighborColor.xyz * sample_weight);
        sum_g += neighborColor.y;
        neighborColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_3.xy);
        color_dist = fast::min(distance(curColor.xyz, neighborColor.xyz) * toleranceFactor, 1.0);
        sample_weight = 0.0900000035762786865234375 * (1.0 - color_dist);
        sum_weight += sample_weight;
        sum += (neighborColor.xyz * sample_weight);
        sum_g += neighborColor.y;
        neighborColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_3.zw);
        color_dist = fast::min(distance(curColor.xyz, neighborColor.xyz) * toleranceFactor, 1.0);
        sample_weight = 0.0900000035762786865234375 * (1.0 - color_dist);
        sum_weight += sample_weight;
        sum += (neighborColor.xyz * sample_weight);
        sum_g += neighborColor.y;
        neighborColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_4.xy);
        color_dist = fast::min(distance(curColor.xyz, neighborColor.xyz) * toleranceFactor, 1.0);
        sample_weight = 0.0500000007450580596923828125 * (1.0 - color_dist);
        sum_weight += sample_weight;
        sum += (neighborColor.xyz * sample_weight);
        sum_g += neighborColor.y;
        neighborColor = inputImageTexture.sample(inputImageTextureSmplr, in.textureShift_4.zw);
        color_dist = fast::min(distance(curColor.xyz, neighborColor.xyz) * toleranceFactor, 1.0);
        sample_weight = 0.0500000007450580596923828125 * (1.0 - color_dist);
        sum_weight += sample_weight;
        sum += (neighborColor.xyz * sample_weight);
        sum_g += neighborColor.y;
        if (sum_weight < 0.4000000059604644775390625)
        {
            out.gl_FragColor = float4(curColor.xyz, sum_g * 0.11110000312328338623046875);
        }
        else
        {
            if (sum_weight < 0.5)
            {
                out.gl_FragColor = float4(mix(curColor.xyz, sum / float3(sum_weight), float3((sum_weight - 0.4000000059604644775390625) / 0.100000001490116119384765625)), sum_g * 0.11110000312328338623046875);
            }
            else
            {
                out.gl_FragColor = float4(sum / float3(sum_weight), sum_g * 0.11110000312328338623046875);
            }
        }
    }
    else
    {
        out.gl_FragColor = curColor;
    }
    return out;
}

