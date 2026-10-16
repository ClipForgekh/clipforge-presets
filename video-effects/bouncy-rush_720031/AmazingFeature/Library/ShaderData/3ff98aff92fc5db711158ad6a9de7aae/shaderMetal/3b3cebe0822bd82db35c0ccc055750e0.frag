#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float2 u_screen_size;
    float2 u_center;
    float u_fade0;
    float u_fade1;
    float u_step;
    float u_sneg;
    float u_spos;
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
    float2 _58 = fma(in.v_uv, buffer.u_screen_size, -buffer.u_center);
    float _62 = length(_58);
    float _76 = fast::min(buffer.u_screen_size.x, buffer.u_screen_size.y);
    float2 _96 = (((_58 / float2(_62)) * (float2(1.0) / buffer.u_screen_size)) * buffer.u_step) * smoothstep(_76 * buffer.u_fade0, _76 * buffer.u_fade1, _62);
    float4 _202;
    _202 = u_src.sample(u_srcSmplr, in.v_uv) * 0.1335709989070892333984375;
    for (int _201 = 0; _201 < 4; )
    {
        float2 _126 = _96 * float4(1.40733301639556884765625, 3.2942149639129638671875, 5.351806163787841796875, 7.302939891815185546875)[_201];
        float2 _170 = mod(in.v_uv + _126, float2(2.0));
        float _136 = float4(0.23330800235271453857421875, 0.1359280049800872802734375, 0.0513829998672008514404296875, 0.01259499974548816680908203125)[_201];
        float2 _188 = mod(in.v_uv - _126, float2(2.0));
        _202 = (_202 + ((u_src.sample(u_srcSmplr, fract(mix(_170, float2(2.0) - _170, step(float2(1.0), _170)))) * _136) * buffer.u_sneg)) + ((u_src.sample(u_srcSmplr, fract(mix(_188, float2(2.0) - _188, step(float2(1.0), _188)))) * _136) * buffer.u_spos);
        _201++;
        continue;
    }
    out.gl_FragColor = _202;
    return out;
}

