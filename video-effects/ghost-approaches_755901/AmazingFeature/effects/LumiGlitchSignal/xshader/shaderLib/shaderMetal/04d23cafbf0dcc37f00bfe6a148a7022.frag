#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float blurSize;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t1 = float2(1.0) / ((buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y))) * 720.0);
    float4 _t2 = inputImageTexture.sample(inputImageTextureSmplr, in.v_uv);
    for (float _t3 = 1.0; _t3 <= 128.0; _t3 += 1.0)
    {
        if (_t3 > buffer.blurSize)
        {
            break;
        }
        _t2 = (_t2 + inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(0.0, _t3 * _t1.y)))) + inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv - float2(0.0, _t3 * _t1.y)));
    }
    float4 _91 = _t2;
    float4 _93 = _91 / float4(1.0 + (buffer.blurSize * 2.0));
    _t2 = _93;
    out.o_fragColor = _93;
    return out;
}

