#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_step_x;
    float u_step_y;
    float u_intensity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(v_uv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_src [[texture(0)]], sampler u_srcSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _18 = float2(buffer.u_step_x, buffer.u_step_y) * buffer.u_intensity;
    float2 _37 = _18 * 1.40733301639556884765625;
    float2 _57 = _18 * 3.2942149639129638671875;
    float2 _77 = _18 * 5.351806163787841796875;
    float2 _97 = _18 * 7.302939891815185546875;
    out.gl_FragColor = ((((((((u_src.sample(u_srcSmplr, in.v_uv) * 0.1335709989070892333984375) + (u_src.sample(u_srcSmplr, (in.v_uv - _37)) * 0.23330800235271453857421875)) + (u_src.sample(u_srcSmplr, (in.v_uv + _37)) * 0.23330800235271453857421875)) + (u_src.sample(u_srcSmplr, (in.v_uv - _57)) * 0.1359280049800872802734375)) + (u_src.sample(u_srcSmplr, (in.v_uv + _57)) * 0.1359280049800872802734375)) + (u_src.sample(u_srcSmplr, (in.v_uv - _77)) * 0.0513829998672008514404296875)) + (u_src.sample(u_srcSmplr, (in.v_uv + _77)) * 0.0513829998672008514404296875)) + (u_src.sample(u_srcSmplr, (in.v_uv - _97)) * 0.01259499974548816680908203125)) + (u_src.sample(u_srcSmplr, (in.v_uv + _97)) * 0.01259499974548816680908203125);
    return out;
}

