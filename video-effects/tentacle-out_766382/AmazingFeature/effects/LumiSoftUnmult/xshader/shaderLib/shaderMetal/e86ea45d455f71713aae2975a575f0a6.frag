#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float lowerLimit;
    float upperLimit;
    float brightness;
    float u_edgeBrightness;
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
    float2 _t1 = float2(1.0) / ((buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y))) * 720.0);
    float4 _43 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t2 = _43;
    float _154 = (-1.0) * u_inputTexture.sample(u_inputTextureSmplr, (in.v_uv + float2((-1.0) * _t1.x, (-1.0) * _t1.y))).w;
    float _160 = 1.0 * u_inputTexture.sample(u_inputTextureSmplr, (in.v_uv + float2((-1.0) * _t1.x, 1.0 * _t1.y))).w;
    float _163 = 1.0 * u_inputTexture.sample(u_inputTextureSmplr, (in.v_uv + float2(1.0 * _t1.x, (-1.0) * _t1.y))).w;
    float _169 = 1.0 * u_inputTexture.sample(u_inputTextureSmplr, (in.v_uv + float2(1.0 * _t1.x, 1.0 * _t1.y))).w;
    float _170 = ((((_154 - (2.0 * u_inputTexture.sample(u_inputTextureSmplr, (in.v_uv + float2((-1.0) * _t1.x, 0.0 * _t1.y))).w)) - _160) + _163) + (2.0 * u_inputTexture.sample(u_inputTextureSmplr, (in.v_uv + float2(1.0 * _t1.x, 0.0 * _t1.y))).w)) + _169;
    float _188 = ((((_154 - (2.0 * u_inputTexture.sample(u_inputTextureSmplr, (in.v_uv + float2(0.0 * _t1.x, (-1.0) * _t1.y))).w)) - _163) + _160) + (2.0 * u_inputTexture.sample(u_inputTextureSmplr, (in.v_uv + float2(0.0 * _t1.x, 1.0 * _t1.y))).w)) + _169;
    float _t14 = ((_t2.x + _t2.y) + _t2.z) / 3.0;
    if (smoothstep(buffer.lowerLimit, buffer.upperLimit, ((_170 * _170) + (_188 * _188)) * buffer.brightness) > 0.5)
    {
        _t14 = fast::min(smoothstep(0.0, buffer.u_edgeBrightness, _t14), _t2.w);
    }
    else
    {
        _t14 = _t2.w;
    }
    out.o_fragColor = float4(_43.xyz, _t14);
    return out;
}

