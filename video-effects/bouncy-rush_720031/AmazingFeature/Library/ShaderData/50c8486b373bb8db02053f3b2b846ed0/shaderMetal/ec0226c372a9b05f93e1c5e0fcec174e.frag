#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float inputWidth;
    float inputHeight;
    float4x4 u_InvModel;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 TexCoords [[user(TexCoords)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _45 = buffer.inputWidth / buffer.inputHeight;
    float2 _99 = in.TexCoords * float2(_45, 1.0);
    float4 _116 = buffer.u_InvModel * float4(fma(_99.x, 2.0, -_45), fma(_99.y, 2.0, -1.0), 0.0, 1.0);
    out.gl_FragColor = u_inputTexture.sample(u_inputTextureSmplr, float2(1.0 - abs(abs(((_116.x / _45) + 1.0) * 0.5) - 1.0), 1.0 - abs(abs((_116.y + 1.0) * 0.5) - 1.0))) * (((step(0.0, in.TexCoords.x) * step(in.TexCoords.x, 1.0)) * step(0.0, in.TexCoords.y)) * step(in.TexCoords.y, 1.0));
    return out;
}

