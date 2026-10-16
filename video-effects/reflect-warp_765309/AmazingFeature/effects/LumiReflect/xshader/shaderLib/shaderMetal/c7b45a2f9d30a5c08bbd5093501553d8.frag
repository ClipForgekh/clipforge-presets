#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_gamma;
    float u_blurAmount;
    float u_sigmaY;
    float u_sampleY;
    float u_stepY;
    float4 u_ScreenParams;
    float u_lineOffsetX;
    float u_lineOffsetY;
    float u_reflectionAngle;
    float u_maskFalloff;
    int u_blendStyle;
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
float2 _f4(thread const float2& _p0, thread const float2& _p1, thread const float& _p2, constant float4& u_ScreenParams)
{
    float2 _t19 = _p0 - _p1;
    float _306 = u_ScreenParams.x / u_ScreenParams.y;
    bool _308 = _306 < 1.0;
    float2 _309;
    if (_308)
    {
        _309 = float2(_306, 1.0);
    }
    else
    {
        _309 = float2(1.0, 1.0 / _306);
    }
    _t19 = float2x2(float2(cos(_p2), sin(_p2)), float2(-sin(_p2), cos(_p2))) * (_t19 * _309);
    float2 _341;
    if (_308)
    {
        _341 = float2(_306, 1.0);
    }
    else
    {
        _341 = float2(1.0, 1.0 / _306);
    }
    float2 _351 = _t19;
    float2 _352 = _351 / _341;
    _t19 = _352;
    return _352 + _p1;
}

static inline __attribute__((always_inline))
float4 _f2(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, constant float& u_gamma)
{
    float4 _123 = _p0.sample(_p0Smplr, _p1);
    float4 _t5 = _123;
    return float4(pow(_123.xyz, float3(u_gamma)), _t5.w);
}

static inline __attribute__((always_inline))
float _f1(thread const float& _p0, thread const float& _p1)
{
    float _111 = _p0 / _p1;
    return exp(((-0.5) * _111) * _111);
}

static inline __attribute__((always_inline))
float4 _f3(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float& _p2, constant float& u_gamma, constant float& u_blurAmount, constant float& u_sigmaY, constant float& u_sampleY, constant float& u_stepY, texture2d<float> u_inputTexture, sampler u_inputTextureSmplr)
{
    if (u_blurAmount < 0.001000000047497451305389404296875)
    {
        return _p0.sample(_p0Smplr, _p1);
    }
    float2 param = _p1;
    float4 _t6 = _f2(_p0, _p0Smplr, param, u_gamma);
    float param_1 = 0.0;
    float param_2 = u_sigmaY * _p2;
    float _t7 = _f1(param_1, param_2);
    float _170 = fast::min(u_sampleY * _p2, 72.0);
    float _175 = u_stepY * _p2;
    float _179 = u_sigmaY * _p2;
    float _203;
    float4 _223;
    float4 _247;
    for (float _t11 = 1.0; _t11 <= _170; _t11 += 1.0)
    {
        if (_t11 >= _170)
        {
            break;
        }
        float _198 = _t11 * _175;
        if (_t11 < 7.19999980926513671875)
        {
            _203 = 1.0;
        }
        else
        {
            float param_3 = _198;
            float param_4 = _179;
            _203 = _f1(param_3, param_4);
        }
        float2 _216 = float2(0.0, _198);
        float2 _217 = _p1 - _216;
        float2 _t14 = _217;
        if (_t14.y < 0.0)
        {
            float2 param_5 = float2(_t14.x, 0.0);
            _223 = _f2(u_inputTexture, u_inputTextureSmplr, param_5, u_gamma);
        }
        else
        {
            float2 param_6 = _217;
            _223 = _f2(_p0, _p0Smplr, param_6, u_gamma);
        }
        float2 _242 = _p1 + _216;
        float2 _t16 = _242;
        if (_t16.y > 1.0)
        {
            float2 param_7 = float2(_t16.x, 1.0);
            _247 = _f2(u_inputTexture, u_inputTextureSmplr, param_7, u_gamma);
        }
        else
        {
            float2 param_8 = _242;
            _247 = _f2(_p0, _p0Smplr, param_8, u_gamma);
        }
        _t6 += ((_223 + _247) * _203);
        _t7 += (2.0 * _203);
    }
    float4 _278 = _t6 / float4(_t7);
    float4 _t18 = _278;
    float3 _284 = pow(_278.xyz, float3(1.0 / u_gamma));
    _t18.x = _284.x;
    _t18.y = _284.y;
    _t18.z = _284.z;
    return _t18;
}

static inline __attribute__((always_inline))
float4 _f0(thread const float4& _p0, thread const float4& _p1)
{
    float3 _54 = _p0.xyz / float3(fast::max(_p0.w, 0.001000000047497451305389404296875));
    return float4(((((_p1.xyz / float3(fast::max(_p1.w, 0.001000000047497451305389404296875))) * _p1.w) * (1.0 - _p0.w)) + ((_54 * _p0.w) * (1.0 - _p1.w))) + ((_54 * _p0.w) * _p1.w), _p0.w + (_p1.w * (1.0 - _p0.w)));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], texture2d<float> u_inputTexture2 [[texture(1)]], sampler u_inputTextureSmplr [[sampler(0)]], sampler u_inputTexture2Smplr [[sampler(1)]])
{
    main0_out out = {};
    float _375 = 1.0 / fast::max(fast::max(buffer.u_ScreenParams.x / buffer.u_ScreenParams.y, buffer.u_ScreenParams.y / buffer.u_ScreenParams.x) * 2.2000000476837158203125, 0.001000000047497451305389404296875);
    float2 _401 = (((float2(in.v_uv.x, 1.0 - in.v_uv.y) - float2(0.5)) * _375) + float2(0.5)) - (float2(buffer.u_lineOffsetX, buffer.u_lineOffsetY) * _375);
    float2 _t24 = _401;
    float2 param = _401;
    float2 param_1 = float2(0.5);
    float param_2 = buffer.u_reflectionAngle;
    _t24 = _f4(param, param_1, param_2, buffer.u_ScreenParams);
    float _414 = 1.0 - step(0.5, _t24.y);
    float2 param_3 = in.v_uv;
    float param_4 = 1.0 - smoothstep(0.00999999977648258209228515625, buffer.u_maskFalloff + 0.100000001490116119384765625, in.v_uv.y);
    float4 _433 = fast::clamp(_f3(u_inputTexture, u_inputTextureSmplr, param_3, param_4, buffer.u_gamma, buffer.u_blurAmount, buffer.u_sigmaY, buffer.u_sampleY, buffer.u_stepY, u_inputTexture, u_inputTextureSmplr), float4(0.0), float4(1.0));
    float4 _438 = u_inputTexture2.sample(u_inputTexture2Smplr, in.v_uv);
    float4 _t29;
    if (buffer.u_blendStyle == 0)
    {
        _t29 = mix(_433, _438, float4(_414));
    }
    else
    {
        if (buffer.u_blendStyle == 1)
        {
            float4 param_5 = _438;
            float4 param_6 = _433 * (1.0 - _414);
            _t29 = _f0(param_5, param_6);
        }
        else
        {
            _t29 = _433 * fast::clamp(1.0 - _414, 0.0, 1.0);
        }
    }
    out.o_fragColor = _t29;
    return out;
}

