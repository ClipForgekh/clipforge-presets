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
    float randomSeed;
    float sortType;
    float triggerType;
    float blockSize;
    float4 u_ScreenParams;
    float affectType;
    float threshold;
    float randomly;
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
float _f0(thread const float2& _p0)
{
    float2 _65 = fract(_p0 * 1324.5179443359375);
    float2 _t0 = _65 + float2(dot(_65, _65.yx + float2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

static inline __attribute__((always_inline))
float _f7(thread const float4& _p0)
{
    return ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
}

static inline __attribute__((always_inline))
float _f1(thread const float4& _p0)
{
    return ((_p0.x + _p0.y) + _p0.z) / 3.0;
}

static inline __attribute__((always_inline))
float _f6(thread const float4& _p0)
{
    return fast::min(fast::min(_p0.x, _p0.y), _p0.z);
}

static inline __attribute__((always_inline))
float _f5(thread const float4& _p0)
{
    return fast::max(fast::max(_p0.x, _p0.y), _p0.z);
}

static inline __attribute__((always_inline))
float _f2(thread const float4& _p0)
{
    return _p0.x;
}

static inline __attribute__((always_inline))
float _f3(thread const float4& _p0)
{
    return _p0.y;
}

static inline __attribute__((always_inline))
float _f4(thread const float4& _p0)
{
    return _p0.z;
}

static inline __attribute__((always_inline))
float3 _f8(thread const float3& _p0)
{
    float _168 = fast::max(fast::max(_p0.x, _p0.y), _p0.z);
    float _172 = _168 - fast::min(fast::min(_p0.x, _p0.y), _p0.z);
    float _t4 = 0.0;
    float _t5 = 0.0;
    if (_172 != 0.0)
    {
        _t5 = _172 / _168;
        float _195 = _172 / 2.0;
        float _198 = (((_168 - _p0.x) / 6.0) + _195) / _172;
        float _209 = (((_168 - _p0.y) / 6.0) + _195) / _172;
        float _220 = (((_168 - _p0.z) / 6.0) + _195) / _172;
        if (_p0.x == _168)
        {
            _t4 = _220 - _209;
        }
        else
        {
            if (_p0.y == _168)
            {
                _t4 = (0.3333333432674407958984375 + _198) - _220;
            }
            else
            {
                if (_p0.z == _168)
                {
                    _t4 = (0.666666686534881591796875 + _209) - _198;
                }
            }
        }
        if (_t4 < 0.0)
        {
            _t4 += 1.0;
        }
        else
        {
            if (_t4 > 1.0)
            {
                _t4 -= 1.0;
            }
        }
    }
    return float3(_t4, _t5, _168);
}

static inline __attribute__((always_inline))
float _f9(thread const float4& _p0)
{
    float3 param = _p0.xyz;
    return _f8(param).x;
}

static inline __attribute__((always_inline))
float _f10(thread const float4& _p0)
{
    float3 param = _p0.xyz;
    return _f8(param).y;
}

static inline __attribute__((always_inline))
float _f11(thread float2& _p0)
{
    float _t10 = 0.0;
    for (float _t11 = 0.0; _t11 < 8.0; _t11 += 1.0)
    {
        float2 _t12 = floor(_p0);
        _p0 /= float2(2.0);
        _t10 = (_t10 + mod(_t12.x + _t12.y, 2.0)) / 2.0;
    }
    return _t10 * 2.0;
}

static inline __attribute__((always_inline))
float _f12(thread const float4& _p0)
{
    float2 param = _p0.xy * 255.0;
    float _325 = _f11(param);
    float2 param_1 = float2(_325, _p0.z) * 255.0;
    float _331 = _f11(param_1);
    return _331;
}

static inline __attribute__((always_inline))
float _f13(thread const float4& _p0, thread const float& _p1)
{
    if (_p1 < 0.5)
    {
        float4 param = _p0;
        return _f7(param);
    }
    else
    {
        if (_p1 < 1.5)
        {
            float4 param_1 = _p0;
            return _f1(param_1);
        }
        else
        {
            if (_p1 < 2.5)
            {
                float4 param_2 = _p0;
                return _f6(param_2);
            }
            else
            {
                if (_p1 < 3.5)
                {
                    float4 param_3 = _p0;
                    return _f5(param_3);
                }
                else
                {
                    if (_p1 < 4.5)
                    {
                        float4 param_4 = _p0;
                        return _f2(param_4);
                    }
                    else
                    {
                        if (_p1 < 5.5)
                        {
                            float4 param_5 = _p0;
                            return _f3(param_5);
                        }
                        else
                        {
                            if (_p1 < 6.5)
                            {
                                float4 param_6 = _p0;
                                return _f4(param_6);
                            }
                            else
                            {
                                if (_p1 < 7.5)
                                {
                                    float4 param_7 = _p0;
                                    return _f9(param_7);
                                }
                                else
                                {
                                    if (_p1 < 8.5)
                                    {
                                        float4 param_8 = _p0;
                                        return _f10(param_8);
                                    }
                                    else
                                    {
                                        if (_p1 < 9.5)
                                        {
                                            float4 param_9 = _p0;
                                            return _f12(param_9);
                                        }
                                        else
                                        {
                                            float4 param_10 = _p0;
                                            return _f7(param_10);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t13 = in.v_uv;
    float2 param = float2(_t13.x + (buffer.randomSeed * 10.0), _t13.y);
    float4 _466 = inputImageTexture.sample(inputImageTextureSmplr, _t13);
    float4 _t15 = _466;
    if (_t15.w < 0.00999999977648258209228515625)
    {
        out.o_fragColor = float4(0.0, 0.0, 0.0, 1.0);
        return out;
    }
    float4 param_1 = _466;
    float param_2 = buffer.sortType;
    float _484 = _f13(param_1, param_2);
    float4 param_3 = _466;
    float param_4 = buffer.triggerType;
    float _t17 = _f13(param_3, param_4);
    if (buffer.blockSize >= 2.0)
    {
        float2 _497 = _t13;
        float _504 = floor(buffer.blockSize);
        float2 _513 = (floor((_497 * buffer.u_ScreenParams.xy) / float2(_504)) * _504) / buffer.u_ScreenParams.xy;
        _t13 = _513;
        float4 param_5 = inputImageTexture.sample(inputImageTextureSmplr, _513);
        float param_6 = buffer.sortType;
        _t17 = _f13(param_5, param_6);
    }
    bool _528 = (buffer.affectType <= 0.5) && (_t17 >= buffer.threshold);
    bool _538;
    if (!_528)
    {
        _538 = (buffer.affectType > 0.5) && (_t17 <= buffer.threshold);
    }
    else
    {
        _538 = _528;
    }
    bool _547;
    if (_538)
    {
        _547 = (_f0(param) + 0.001000000047497451305389404296875) >= (buffer.randomly / 16.0);
    }
    else
    {
        _547 = _538;
    }
    if (_547)
    {
        out.o_fragColor = float4(1.0, _484, _484, 1.0);
    }
    else
    {
        out.o_fragColor = float4(0.0, _484, _484, 1.0);
    }
    return out;
}

