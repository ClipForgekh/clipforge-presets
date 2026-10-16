#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float u_smoothness;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _32 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t2 = _32;
    if (buffer.u_smoothness < 0.001000000047497451305389404296875)
    {
        out.o_fragColor = _32;
    }
    else
    {
        float _t4 = 0.0;
        int _67 = (int(buffer.u_smoothness * (fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y) * 0.01400000043213367462158203125)) * 2) + 1;
        float _t8 = 0.0;
        float _t9 = _t2.x;
        float _t10 = _t2.x;
        int _75 = _67 - 1;
        for (int _t11 = _75; _t11 >= 0; _t11--)
        {
            float4 _107 = u_inputTexture.sample(u_inputTextureSmplr, fast::clamp(in.v_uv + float2((1.0 / buffer.u_ScreenParams.x) * float(_t11 - (_67 / 2)), 0.0), float2(0.0), float2(1.0)));
            float _108 = _107.x;
            _t4 += _108;
            _t8 += 1.0;
            _t9 = fast::max(_t9, _108);
            _t10 = fast::min(_t10, _108);
        }
        float _122 = _t4;
        float _126 = fast::clamp(_122 / fast::max(0.001000000047497451305389404296875, _t8), 0.0, 1.0);
        _t4 = _126;
        out.o_fragColor = float4(float3(_126, _t9, _t10), 1.0);
    }
    return out;
}

