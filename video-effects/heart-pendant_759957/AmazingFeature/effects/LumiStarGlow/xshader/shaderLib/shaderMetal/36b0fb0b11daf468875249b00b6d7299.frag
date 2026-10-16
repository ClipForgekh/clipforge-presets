#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_srcOpacity;
    float u_glowOpacity;
    int u_view;
    int u_blendMode;
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
float4 _f0(thread const float4& _p0)
{
    return float4(_p0.xyz, fast::max(fast::max(_p0.x, _p0.y), _p0.z));
}

static inline __attribute__((always_inline))
float4 _f1(thread const float4& _p0, thread const float4& _p1)
{
    return float4(fast::min(_p0.xyz + _p1.xyz, float3(1.0)), fast::min(_p0.w + _p1.w, 1.0));
}

static inline __attribute__((always_inline))
float4 _f2(thread const float4& _p0, thread const float4& _p1)
{
    return float4(float3(1.0) - ((float3(1.0) - _p0.xyz) * (float3(1.0) - _p1.xyz)), (_p0.w + _p1.w) - (_p0.w * _p1.w));
}

static inline __attribute__((always_inline))
float4 _f3(thread const float4& _p0, thread const float4& _p1, thread const int& _p2)
{
    if (_p2 == 1)
    {
        float4 param = _p0;
        float4 param_1 = _p1;
        return _f1(param, param_1);
    }
    else
    {
        if (_p2 == 2)
        {
            float4 param_2 = _p0;
            float4 param_3 = _p1;
            return _f2(param_2, param_3);
        }
    }
    return _p0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], texture2d<float> u_postTex [[texture(1)]], texture2d<float> u_thresholdTex [[texture(2)]], texture2d<float> u_shimmerTex [[texture(3)]], sampler u_inputTexSmplr [[sampler(0)]], sampler u_postTexSmplr [[sampler(1)]], sampler u_thresholdTexSmplr [[sampler(2)]], sampler u_shimmerTexSmplr [[sampler(3)]])
{
    main0_out out = {};
    float4 _146 = u_inputTex.sample(u_inputTexSmplr, in.v_uv);
    float4 _160 = u_postTex.sample(u_postTexSmplr, in.v_uv) * float4(buffer.u_glowOpacity);
    float4 _t6 = _160;
    float4 param = _160;
    _t6 = _f0(param);
    float4 _t7;
    if (buffer.u_view == 0)
    {
        _t7 = u_thresholdTex.sample(u_thresholdTexSmplr, in.v_uv);
    }
    else
    {
        if (buffer.u_view == 1)
        {
            _t7 = u_shimmerTex.sample(u_shimmerTexSmplr, in.v_uv);
        }
        else
        {
            if (buffer.u_view == 2)
            {
                _t7 = _t6;
            }
            else
            {
                if (buffer.u_view == 3)
                {
                    float4 param_1 = _t6;
                    float4 param_2 = _146 * float4(buffer.u_srcOpacity);
                    int param_3 = buffer.u_blendMode;
                    _t7 = _f3(param_1, param_2, param_3);
                }
            }
        }
    }
    out.o_fragColor = _t7;
    return out;
}

