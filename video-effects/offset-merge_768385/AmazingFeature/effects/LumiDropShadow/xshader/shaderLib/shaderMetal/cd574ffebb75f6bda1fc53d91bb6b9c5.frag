#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_angle;
    float u_distance;
    float2 u_screenSize;
    float u_scale;
    float u_inputOpacity;
    float u_opacity;
    float4 u_color;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, constant float& u_angle, constant float& u_distance, constant float2& u_screenSize)
{
    float _80 = (u_angle * 3.141590118408203125) / 180.0;
    return _p0 + ((float2(cos(_80), sin(_80)) * u_distance) / float2(u_screenSize.x));
}

static inline __attribute__((always_inline))
float _f0(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1)
{
    float2 _30 = _p1;
    _p1 = step(float2(0.0), _p1) * step(_p1, float2(1.0));
    float4 _t0 = _p0.sample(_p0Smplr, _30) * (_p1.x * _p1.y);
    return ((_t0.x + (_t0.y / 255.0)) + (_t0.z / 65025.0)) + (_t0.w / 16581375.0);
}

static inline __attribute__((always_inline))
float4 _f2(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1)
{
    float2 _103 = _p1;
    _p1 = step(float2(0.0), _p1) * step(_p1, float2(1.0));
    return (_p0.sample(_p0Smplr, _103) * _p1.x) * _p1.y;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_shadowTexture [[texture(0)]], texture2d<float> u_shadowMaskTexture [[texture(1)]], texture2d<float> u_inputTexture [[texture(2)]], sampler u_shadowTextureSmplr [[sampler(0)]], sampler u_shadowMaskTextureSmplr [[sampler(1)]], sampler u_inputTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float2 param = in.v_uv;
    float2 _124 = _f1(param, buffer.u_angle, buffer.u_distance, buffer.u_screenSize);
    float2 param_1 = ((_124 - float2(0.5)) * buffer.u_scale) + float2(0.5);
    float _139 = _f0(u_shadowTexture, u_shadowTextureSmplr, param_1);
    float4 _t7 = u_shadowMaskTexture.sample(u_shadowMaskTextureSmplr, _124);
    float2 param_2 = in.v_uv;
    float4 _150 = _f2(u_inputTexture, u_inputTextureSmplr, param_2);
    float4 _t8 = _150;
    float _157 = fast::clamp(_t8.w * buffer.u_inputOpacity, 0.0, 1.0);
    float _178 = fast::clamp(((_139 * buffer.u_opacity) * buffer.u_color.w) * _t7.x, 0.0, 1.0);
    float _188 = 1.0 - _157;
    float _190 = _157 + (_178 * _188);
    float3 _203;
    if (_190 > 9.9999997473787516355514526367188e-06)
    {
        _203 = ((_150.xyz * _157) + ((buffer.u_color.xyz * _178) * _188)) / float3(_190);
    }
    else
    {
        _203 = float3(0.0);
    }
    out.o_fragColor = float4(_203, _190);
    return out;
}

