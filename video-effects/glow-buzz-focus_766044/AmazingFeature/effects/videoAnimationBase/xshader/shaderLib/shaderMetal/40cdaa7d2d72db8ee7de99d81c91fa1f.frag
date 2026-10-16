#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    float2 FBS;
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
void _f2(thread spvUnsafeArray<float, 10>& QUALITY)
{
    QUALITY[0] = 1.5;
    QUALITY[1] = 2.0;
    QUALITY[2] = 2.0;
    QUALITY[3] = 2.0;
    QUALITY[4] = 2.0;
    QUALITY[5] = 4.0;
    QUALITY[6] = 8.0;
}

static inline __attribute__((always_inline))
float _f0(thread const float3& _p0)
{
    return sqrt(dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
}

static inline __attribute__((always_inline))
float _f1(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1)
{
    float3 param = _p0.sample(_p0Smplr, _p1).xyz;
    return _f0(param);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    spvUnsafeArray<float, 10> QUALITY;
    _f2(QUALITY);
    float2 _78 = float2(float2(1.0) / buffer.FBS);
    float2 _t0 = _78;
    float2 _t1 = in.v_uv;
    float4 _88 = inputImageTexture.sample(inputImageTextureSmplr, in.v_uv);
    float3 param = _88.xyz;
    float _96 = _f0(param);
    float2 param_1 = in.v_uv + (float2(0.0, -1.0) * _78);
    float _106 = _f1(inputImageTexture, inputImageTextureSmplr, param_1);
    float2 param_2 = in.v_uv + (float2(0.0, 1.0) * _78);
    float _114 = _f1(inputImageTexture, inputImageTextureSmplr, param_2);
    float2 param_3 = in.v_uv + (float2(-1.0, 0.0) * _78);
    float _122 = _f1(inputImageTexture, inputImageTextureSmplr, param_3);
    float2 param_4 = in.v_uv + (float2(1.0, 0.0) * _78);
    float _130 = _f1(inputImageTexture, inputImageTextureSmplr, param_4);
    float _150 = fast::max(_96, fast::max(fast::max(_106, _114), fast::max(_122, _130)));
    float _154 = _150 - fast::min(_96, fast::min(fast::min(_106, _114), fast::min(_122, _130)));
    if (_154 < fast::max(0.031199999153614044189453125, _150 * 0.125))
    {
        out.o_fragColor = _88;
        return out;
    }
    float2 param_5 = in.v_uv + (float2(-1.0) * _78);
    float _176 = _f1(inputImageTexture, inputImageTextureSmplr, param_5);
    float2 param_6 = in.v_uv + (float2(1.0) * _78);
    float _184 = _f1(inputImageTexture, inputImageTextureSmplr, param_6);
    float2 param_7 = in.v_uv + (float2(-1.0, 1.0) * _78);
    float _192 = _f1(inputImageTexture, inputImageTextureSmplr, param_7);
    float2 param_8 = in.v_uv + (float2(1.0, -1.0) * _78);
    float _200 = _f1(inputImageTexture, inputImageTextureSmplr, param_8);
    float _204 = _106 + _114;
    float _208 = _122 + _130;
    float _212 = _176 + _192;
    float _220 = _200 + _184;
    float _233 = (-2.0) * _96;
    bool _268 = ((abs(((-2.0) * _122) + _212) + (abs(_233 + _204) * 2.0)) + abs(((-2.0) * _130) + _220)) >= ((abs(((-2.0) * _114) + (_184 + _192)) + (abs(_233 + _208) * 2.0)) + abs(((-2.0) * _106) + (_176 + _200)));
    float _273 = _268 ? _106 : _122;
    float _278 = _268 ? _114 : _130;
    float _289 = abs(_273 - _96);
    float _291 = abs(_278 - _96);
    float _300 = 0.25 * fast::max(_289, _291);
    float _303;
    if (_268)
    {
        _303 = _t0.y;
    }
    else
    {
        _303 = _t0.x;
    }
    float _t31 = _303;
    float _t32 = 0.0;
    if (_289 >= _291)
    {
        _t31 = -_t31;
        _t32 = 0.5 * (_273 + _96);
    }
    else
    {
        _t32 = 0.5 * (_278 + _96);
    }
    float2 _t33 = in.v_uv;
    if (_268)
    {
        _t33.y += (_t31 * 0.5);
    }
    else
    {
        _t33.x += (_t31 * 0.5);
    }
    float2 _350;
    if (_268)
    {
        _350 = float2(_t0.x, 0.0);
    }
    else
    {
        _350 = float2(0.0, _t0.y);
    }
    float2 _364 = _t33 - _350;
    float2 _t35 = _364;
    float2 _t36 = _t33 + _350;
    float3 param_9 = inputImageTexture.sample(inputImageTextureSmplr, _364).xyz;
    float _t37 = _f0(param_9);
    float3 param_10 = inputImageTexture.sample(inputImageTextureSmplr, _t36).xyz;
    float _384 = _t37;
    float _385 = _384 - _t32;
    _t37 = _385;
    float _388 = _f0(param_10) - _t32;
    float _t38 = _388;
    bool _393 = abs(_385) >= _300;
    bool _t39 = _393;
    bool _398 = abs(_388) >= _300;
    bool _t40 = _398;
    bool _t41 = _393 && _398;
    if (!_393)
    {
        _t35 -= _350;
    }
    if (!_t40)
    {
        _t36 += _350;
    }
    if (!_t41)
    {
        for (int _t42 = 2; _t42 < 12; _t42++)
        {
            if (!_t39)
            {
                float3 param_11 = inputImageTexture.sample(inputImageTextureSmplr, _t35).xyz;
                _t37 = _f0(param_11) - _t32;
            }
            if (!_t40)
            {
                float3 param_12 = inputImageTexture.sample(inputImageTextureSmplr, _t36).xyz;
                _t38 = _f0(param_12) - _t32;
            }
            bool _460 = abs(_t37) >= _300;
            _t39 = _460;
            bool _464 = abs(_t38) >= _300;
            _t40 = _464;
            _t41 = _460 && _464;
            if (!_460)
            {
                if (_t42 == 2)
                {
                    _t35 -= (_350 * QUALITY[2]);
                }
                else
                {
                    if (_t42 == 3)
                    {
                        _t35 -= (_350 * QUALITY[3]);
                    }
                    else
                    {
                        if (_t42 == 4)
                        {
                            _t35 -= (_350 * QUALITY[4]);
                        }
                        else
                        {
                            if (_t42 == 5)
                            {
                                _t35 -= (_350 * QUALITY[5]);
                            }
                            else
                            {
                                if (_t42 == 6)
                                {
                                    _t35 -= (_350 * QUALITY[6]);
                                }
                                else
                                {
                                    if (_t42 == 7)
                                    {
                                        _t35 -= (_350 * QUALITY[7]);
                                    }
                                    else
                                    {
                                        if (_t42 == 8)
                                        {
                                            _t35 -= (_350 * QUALITY[8]);
                                        }
                                        else
                                        {
                                            if (_t42 == 9)
                                            {
                                                _t35 -= (_350 * QUALITY[9]);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (!_t40)
            {
                if (_t42 == 2)
                {
                    _t36 += (_350 * QUALITY[2]);
                }
                else
                {
                    if (_t42 == 3)
                    {
                        _t36 += (_350 * QUALITY[3]);
                    }
                    else
                    {
                        if (_t42 == 4)
                        {
                            _t36 += (_350 * QUALITY[4]);
                        }
                        else
                        {
                            if (_t42 == 5)
                            {
                                _t36 += (_350 * QUALITY[5]);
                            }
                            else
                            {
                                if (_t42 == 6)
                                {
                                    _t36 += (_350 * QUALITY[6]);
                                }
                                else
                                {
                                    if (_t42 == 7)
                                    {
                                        _t36 += (_350 * QUALITY[7]);
                                    }
                                    else
                                    {
                                        if (_t42 == 8)
                                        {
                                            _t36 += (_350 * QUALITY[8]);
                                        }
                                        else
                                        {
                                            if (_t42 == 9)
                                            {
                                                _t36 += (_350 * QUALITY[9]);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (_t41)
            {
                break;
            }
        }
    }
    float _661;
    if (_268)
    {
        _661 = _t1.x - _t35.x;
    }
    else
    {
        _661 = _t1.y - _t35.y;
    }
    float _678;
    if (_268)
    {
        _678 = _t36.x - _t1.x;
    }
    else
    {
        _678 = _t36.y - _t1.y;
    }
    float _745 = fast::clamp(abs((0.083333335816860198974609375 * (((2.0 * (_204 + _208)) + _212) + _220)) - _96) / _154, 0.0, 1.0);
    float _754 = ((((-2.0) * _745) + 3.0) * _745) * _745;
    float _763 = fast::max(((((_661 < _678) ? _t37 : _t38) < 0.0) != (_96 < _t32)) ? (((-fast::min(_661, _678)) / (_661 + _678)) + 0.5) : 0.0, (_754 * _754) * 0.75);
    float2 _t56 = in.v_uv;
    if (_268)
    {
        _t56.y += (_763 * _t31);
    }
    else
    {
        _t56.x += (_763 * _t31);
    }
    out.o_fragColor = inputImageTexture.sample(inputImageTextureSmplr, _t56);
    return out;
}

