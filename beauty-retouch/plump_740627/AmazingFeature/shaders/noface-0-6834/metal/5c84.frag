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
    float2 uv_screen [[user(uv_screen)]];
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_blurmask [[texture(0)]], texture2d<float> u_gan [[texture(1)]], texture2d<float> u_input [[texture(2)]], sampler u_blurmaskSmplr [[sampler(0)]], sampler u_ganSmplr [[sampler(1)]], sampler u_inputSmplr [[sampler(2)]])
{
    main0_out out = {};
    float mask = u_blurmask.sample(u_blurmaskSmplr, in.uv).x;
    float4 gan = u_gan.sample(u_ganSmplr, in.uv);
    float4 src = u_input.sample(u_inputSmplr, in.uv_screen);
    gan.w *= mask;
    out.gl_FragColor = float4(mix(src.xyz, gan.xyz, float3(gan.w)), src.w * mask);
    return out;
}

