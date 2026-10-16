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
    int u_property;
    int u_edgeMode;
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
float4 _f2(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1)
{
    return _p0.sample(_p0Smplr, fast::clamp(_p1, float2(0.0), float2(1.0)));
}

static inline __attribute__((always_inline))
float4 _f3(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1)
{
    return _p0.sample(_p0Smplr, fract(_p1));
}

static inline __attribute__((always_inline))
float4 _f4(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1)
{
    _p1 = abs(mod(_p1 + float2(1.0), float2(2.0)) - float2(1.0));
    return _p0.sample(_p0Smplr, _p1);
}

static inline __attribute__((always_inline))
float4 _f1(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1)
{
    float2 _88 = _p1;
    _p1 = step(float2(0.0), _p1) * step(_p1, float2(1.0));
    return (_p0.sample(_p0Smplr, _88) * _p1.x) * _p1.y;
}

static inline __attribute__((always_inline))
float4 _f5(thread const int& _p0, texture2d<float> _p1, sampler _p1Smplr, thread const float2& _p2)
{
    if (_p0 == 0)
    {
        float2 param = _p2;
        return _f2(_p1, _p1Smplr, param);
    }
    else
    {
        if (_p0 == 1)
        {
            float2 param_1 = _p2;
            return _f3(_p1, _p1Smplr, param_1);
        }
        else
        {
            if (_p0 == 2)
            {
                float2 param_2 = _p2;
                float4 _169 = _f4(_p1, _p1Smplr, param_2);
                return _169;
            }
            else
            {
                float2 param_3 = _p2;
                float4 _174 = _f1(_p1, _p1Smplr, param_3);
                return _174;
            }
        }
    }
}

static inline __attribute__((always_inline))
float _f6(thread const float4& _p0, constant int& u_property)
{
    if (u_property == 0)
    {
        return _p0.x;
    }
    else
    {
        if (u_property == 1)
        {
            return _p0.y;
        }
        else
        {
            if (u_property == 2)
            {
                return _p0.z;
            }
            else
            {
                if (u_property == 3)
                {
                    return _p0.w;
                }
                else
                {
                    if (u_property == 4)
                    {
                        return dot(_p0.xyz, float3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875));
                    }
                    else
                    {
                        if (u_property == 5)
                        {
                            return (fast::max(fast::max(_p0.x, _p0.y), _p0.z) + fast::min(fast::min(_p0.x, _p0.y), _p0.z)) * 0.5;
                        }
                    }
                }
            }
        }
    }
    return dot(_p0.xyz, float3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875));
}

static inline __attribute__((always_inline))
float4 _f0(thread float& _p0)
{
    float4 _t0 = float4(0.0);
    _p0 *= 255.0;
    _t0.x = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.y = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.z = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _t0.w = _p0;
    return _t0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    int param = buffer.u_edgeMode;
    float2 param_1 = in.v_uv;
    float4 param_2 = _f5(param, u_inputTexture, u_inputTextureSmplr, param_1);
    float param_3 = _f6(param_2, buffer.u_property);
    float4 _276 = _f0(param_3);
    out.o_fragColor = _276;
    return out;
}

