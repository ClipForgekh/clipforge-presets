#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int u_ca;
    float u_redOffset;
    float u_greenOffset;
    float u_blueOffset;
    float u_threshold;
    float u_thresholdSmooth;
    int u_view;
    int u_gamma;
    float u_gammaValue;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _t0 = u_inputTex.sample(u_inputTexSmplr, in.v_uv);
    if (buffer.u_ca == 1)
    {
        float4 _t1 = u_inputTex.sample(u_inputTexSmplr, (in.v_uv + float2(-buffer.u_redOffset, buffer.u_redOffset))).yzwx;
        float _46 = _t1.w;
        float _49 = _t1.x;
        float _50 = _49 * _46;
        _t1.x = _50;
        _t1 = u_inputTex.sample(u_inputTexSmplr, (in.v_uv + float2(-buffer.u_greenOffset, buffer.u_greenOffset))).yzwx;
        float _64 = _t1.w;
        float _67 = _t1.y;
        float _68 = _67 * _64;
        _t1.y = _68;
        _t1 = u_inputTex.sample(u_inputTexSmplr, (in.v_uv + float2(-buffer.u_blueOffset, buffer.u_blueOffset))).yzwx;
        float _82 = _t1.w;
        float _85 = _t1.z;
        float _86 = _85 * _82;
        _t1.z = _86;
        _t0 = float4(_50, _68, _86, 1.0);
    }
    if (_t0.x < buffer.u_threshold)
    {
        _t0.x = ((_t0.x / buffer.u_threshold) * _t0.x) * buffer.u_thresholdSmooth;
    }
    if (_t0.y < buffer.u_threshold)
    {
        _t0.y = ((_t0.y / buffer.u_threshold) * _t0.y) * buffer.u_thresholdSmooth;
    }
    if (_t0.z < buffer.u_threshold)
    {
        _t0.z = ((_t0.z / buffer.u_threshold) * _t0.z) * buffer.u_thresholdSmooth;
    }
    if (buffer.u_view == 1)
    {
        if (buffer.u_gamma == 1)
        {
            _t0 = pow(_t0, float4(buffer.u_gammaValue));
        }
    }
    out.o_fragColor = _t0;
    return out;
}

