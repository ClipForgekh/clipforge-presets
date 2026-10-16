#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_screen_size;
    float2 u_center;
    float u_radian;
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
    float2 _50 = float2(1.0) / buffer.u_screen_size;
    float2 _63 = fma(in.v_uv, buffer.u_screen_size, -buffer.u_center);
    float _66 = length(_63);
    float _72 = precise::atan2(_63.y, _63.x);
    float _78 = buffer.u_radian * 0.5;
    float4 _216;
    _216 = u_src.sample(u_srcSmplr, in.v_uv) * 0.1335709989070892333984375;
    for (int _215 = 0; _215 < 4; )
    {
        float _108 = float4(1.40733301639556884765625, 3.2942149639129638671875, 5.351806163787841796875, 7.302939891815185546875)[_215];
        float _110 = fma(_78, _108, _72);
        float _117 = fma(buffer.u_radian * (-0.5), _108, _72);
        float2 _139 = (buffer.u_center + (float2(cos(_110), sin(_110)) * _66)) * _50;
        float2 _145 = (buffer.u_center + (float2(cos(_117), sin(_117)) * _66)) * _50;
        float2 _183 = step(float2(0.0), _139) * step(_139, float2(1.0));
        float _155 = float4(0.23330800235271453857421875, 0.1359280049800872802734375, 0.0513829998672008514404296875, 0.01259499974548816680908203125)[_215];
        float2 _201 = step(float2(0.0), _145) * step(_145, float2(1.0));
        _216 = (_216 + (((u_src.sample(u_srcSmplr, _139) * _183.x) * _183.y) * _155)) + (((u_src.sample(u_srcSmplr, _145) * _201.x) * _201.y) * _155);
        _215++;
        continue;
    }
    out.gl_FragColor = _216;
    return out;
}

