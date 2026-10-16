#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float u_progress;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputImageTexture [[texture(0)]], sampler u_inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _35 = float2(buffer.u_progress * 2.0) / ((buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y))) * 720.0);
    float4 _t2 = float4(0.0);
    float _t3 = 0.0;
    for (int _t4 = -1; _t4 <= 1; _t4++)
    {
        for (int _t5 = -1; _t5 <= 1; _t5++)
        {
            _t2 += u_inputImageTexture.sample(u_inputImageTextureSmplr, (in.v_uv + (_35 * float2(float(_t4), float(_t5)))));
            _t3 += 1.0;
        }
    }
    out.o_fragColor = _t2 / float4(_t3);
    return out;
}

