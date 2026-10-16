#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int u_blendType;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

static inline __attribute__((always_inline))
float4 _f2(thread const float4& _p0, thread const float4& _p1)
{
    float4 _t0 = float4(0.0);
    float3 _76 = _p0.xyz + _p1.xyz;
    _t0.x = _76.x;
    _t0.y = _76.y;
    _t0.z = _76.z;
    _t0.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t0;
}

static inline __attribute__((always_inline))
float4 _f3(thread const float4& _p0, thread const float4& _p1)
{
    return float4(1.0) - ((float4(1.0) - _p0) * (float4(1.0) - _p1));
}

static inline __attribute__((always_inline))
float4 _f0(thread float4& _p0)
{
    float _42 = _p0.w;
    float4 _46 = _p0;
    float3 _49 = _46.xyz / float3(fast::max(_42, 9.9999997473787516355514526367188e-06));
    _p0.x = _49.x;
    _p0.y = _49.y;
    _p0.z = _49.z;
    return _p0;
}

static inline __attribute__((always_inline))
float4 _f4(thread float4& _p0, thread float4& _p1)
{
    float4 _t1 = float4(0.0);
    float4 param = _p0;
    float4 _111 = _f0(param);
    _p0 = _111;
    float4 param_1 = _p1;
    float4 _114 = _f0(param_1);
    _p1 = _114;
    float3 _119 = _p0.xyz * _p1.xyz;
    _t1.x = _119.x;
    _t1.y = _119.y;
    _t1.z = _119.z;
    _t1.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t1;
}

static inline __attribute__((always_inline))
float4 _f5(thread const float4& _p0, thread const float4& _p1)
{
    float4 _t2 = float4(0.0);
    float3 _144 = fast::max(_p0.xyz, _p1.xyz);
    _t2.x = _144.x;
    _t2.y = _144.y;
    _t2.z = _144.z;
    _t2.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t2;
}

static inline __attribute__((always_inline))
float4 _f6(thread const float4& _p0, thread const float4& _p1)
{
    float4 _t3 = float4(0.0);
    float3 _169 = fast::min(_p0.xyz, _p1.xyz);
    _t3.x = _169.x;
    _t3.y = _169.y;
    _t3.z = _169.z;
    _t3.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    return _t3;
}

static inline __attribute__((always_inline))
float4 _f1(thread const float4& _p0, thread const float4& _p1)
{
    return (_p0 + _p1) * 0.5;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_gaussianBlurXTexture [[texture(0)]], texture2d<float> u_gaussianBlurYTexture [[texture(1)]], sampler u_gaussianBlurXTextureSmplr [[sampler(0)]], sampler u_gaussianBlurYTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _199 = u_gaussianBlurXTexture.sample(u_gaussianBlurXTextureSmplr, in.uv0);
    float4 _204 = u_gaussianBlurYTexture.sample(u_gaussianBlurYTextureSmplr, in.uv0);
    if (buffer.u_blendType == 1)
    {
        float4 param = _199;
        float4 param_1 = _204;
        out.o_fragColor = _f2(param, param_1);
    }
    else
    {
        if (buffer.u_blendType == 2)
        {
            float4 param_2 = _199;
            float4 param_3 = _204;
            out.o_fragColor = _f3(param_2, param_3);
        }
        else
        {
            if (buffer.u_blendType == 3)
            {
                float4 param_4 = _199;
                float4 param_5 = _204;
                float4 _242 = _f4(param_4, param_5);
                out.o_fragColor = _242;
            }
            else
            {
                if (buffer.u_blendType == 4)
                {
                    float4 param_6 = _199;
                    float4 param_7 = _204;
                    out.o_fragColor = _f5(param_6, param_7);
                }
                else
                {
                    if (buffer.u_blendType == 5)
                    {
                        float4 param_8 = _199;
                        float4 param_9 = _204;
                        out.o_fragColor = _f6(param_8, param_9);
                    }
                    else
                    {
                        float4 param_10 = _199;
                        float4 param_11 = _204;
                        out.o_fragColor = _f1(param_10, param_11);
                    }
                }
            }
        }
    }
    return out;
}

