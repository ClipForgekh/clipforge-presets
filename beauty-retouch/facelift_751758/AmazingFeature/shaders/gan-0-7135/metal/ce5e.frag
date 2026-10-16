#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_intensity;
    float4x4 mvpMat;
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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_blurmask [[texture(0)]], texture2d<float> flowTexture [[texture(1)]], texture2d<float> ganTexture [[texture(2)]], texture2d<float> inputTexture [[texture(3)]], sampler u_blurmaskSmplr [[sampler(0)]], sampler flowTextureSmplr [[sampler(1)]], sampler ganTextureSmplr [[sampler(2)]], sampler inputTextureSmplr [[sampler(3)]])
{
    main0_out out = {};
    float mask = u_blurmask.sample(u_blurmaskSmplr, in.uv).x;
    float4 flow = flowTexture.sample(flowTextureSmplr, in.uv);
    flow = (((flow - float4(0.5)) * 0.25) * mask) * buffer.u_intensity;
    float2 uv_f = in.uv + flow.xy;
    float2 uv_sf = in.uv_screen + (buffer.mvpMat * float4(flow.x, -flow.y, 0.0, 0.0)).xy;
    float4 gan_color = ganTexture.sample(ganTextureSmplr, uv_f);
    float4 input_color = inputTexture.sample(inputTextureSmplr, uv_sf);
    float _77 = input_color.w;
    float4 _79 = input_color;
    float3 _82 = _79.xyz / float3(_77);
    input_color.x = _82.x;
    input_color.y = _82.y;
    input_color.z = _82.z;
    out.gl_FragColor = float4(mix(input_color.xyz, gan_color.xyz, float3(gan_color.w * buffer.u_intensity)), input_color.w * mask);
    return out;
}

