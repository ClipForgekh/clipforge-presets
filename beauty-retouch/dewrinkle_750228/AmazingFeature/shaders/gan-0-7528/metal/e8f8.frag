#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_intensity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv [[user(uv)]];
    float2 uv_screen [[user(uv_screen)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_blurmask [[texture(0)]], texture2d<float> ganTexture [[texture(1)]], texture2d<float> inputTexture [[texture(2)]], sampler u_blurmaskSmplr [[sampler(0)]], sampler ganTextureSmplr [[sampler(1)]], sampler inputTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float mask = u_blurmask.sample(u_blurmaskSmplr, in.uv).x;
    float4 gan_color = ganTexture.sample(ganTextureSmplr, in.uv);
    float4 input_color = inputTexture.sample(inputTextureSmplr, in.uv_screen);
    out.gl_FragColor = float4(mix(input_color.xyz, gan_color.xyz, float3(gan_color.w * buffer.u_intensity)), input_color.w * mask);
    return out;
}

