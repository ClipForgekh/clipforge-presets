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
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> _MainTex [[texture(0)]], texture2d<float> segMaskTexture [[texture(1)]], sampler _MainTexSmplr [[sampler(0)]], sampler segMaskTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 src = _MainTex.sample(_MainTexSmplr, in.textureCoordinate);
    float3 sum = src.xyz;
    float seg_offset = segMaskTexture.sample(segMaskTextureSmplr, in.textureShift_3.xy).x;
    float seg_offset2 = segMaskTexture.sample(segMaskTextureSmplr, in.textureShift_3.zw).x;
    if ((seg_offset < 0.89999997615814208984375) || (seg_offset2 < 0.89999997615814208984375))
    {
        sum *= 5.0;
    }
    else
    {
        sum += _MainTex.sample(_MainTexSmplr, in.textureShift_1.xy).xyz;
        sum += _MainTex.sample(_MainTexSmplr, in.textureShift_1.zw).xyz;
        sum += _MainTex.sample(_MainTexSmplr, in.textureShift_2.xy).xyz;
        sum += _MainTex.sample(_MainTexSmplr, in.textureShift_2.zw).xyz;
    }
    out.gl_FragColor = float4(sum * 0.20000000298023223876953125, src.w);
    return out;
}

