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
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> inputImageMaskTexture [[texture(0)]], sampler inputImageMaskTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float3 faceMask = inputImageMaskTexture.sample(inputImageMaskTextureSmplr, in.textureCoordinate).xyz;
    out.gl_FragColor = float4(faceMask.z, faceMask.y, 0.0, 0.0);
    return out;
}

