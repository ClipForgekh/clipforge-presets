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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], texture2d<float> u_smoothTexture [[texture(1)]], sampler u_inputTextureSmplr [[sampler(0)]], sampler u_smoothTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _19 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t0 = _19;
    float _24 = _t0.w;
    float3 _28 = _19.xyz * _24;
    _t0.x = _28.x;
    _t0.y = _28.y;
    _t0.z = _28.z;
    float4 _t1 = u_smoothTexture.sample(u_smoothTextureSmplr, in.v_uv);
    float _t2 = _t1.x;
    if (buffer.u_smoothness > 0.001000000047497451305389404296875)
    {
        float _t6 = 0.0;
        int _79 = int(buffer.u_smoothness * (fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y) * 0.01400000043213367462158203125));
        int _85 = (_79 * 2) + 1;
        float _t10 = 0.0;
        float _t11 = _t1.z;
        float _t12 = _t1.z;
        int _95 = _85 - 1;
        for (int _t13 = _95; _t13 >= 0; _t13--)
        {
            float4 _127 = u_smoothTexture.sample(u_smoothTextureSmplr, fast::clamp(in.v_uv + float2(0.0, (1.0 / buffer.u_ScreenParams.y) * float(_t13 - (_85 / 2))), float2(0.0), float2(1.0)));
            float _128 = _127.x;
            _t6 += _128;
            _t10 += 1.0;
            _t11 = fast::max(_t11, _128);
            _t12 = fast::min(_t12, _128);
        }
        float _142 = _t6;
        float _152 = 0.5 + (buffer.u_smoothness / 3.0);
        float _166 = fast::clamp(((fast::clamp(_142 / fast::max(0.001000000047497451305389404296875, _t10), 0.0, 1.0) - _152) * ((float(_79) / 5.0) + 1.0)) + _152, _t12, _t11);
        _t6 = _166;
        _t2 = mix(fast::min(_t2, _166), _166, fast::clamp(7.0 * buffer.u_smoothness, 0.0, 1.0));
    }
    out.o_fragColor = _t0 * _t2;
    out.o_fragColor.w *= _t0.w;
    return out;
}

