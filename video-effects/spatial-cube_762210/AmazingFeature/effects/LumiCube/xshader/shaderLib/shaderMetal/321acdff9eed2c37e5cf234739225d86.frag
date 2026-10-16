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

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    spvUnsafeArray<float, 12> u_wrapMode;
    int u_maskChannel;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
    float2 v_id [[user(locn1)]];
};

static inline __attribute__((always_inline))
float4 _f0(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1, thread const int& _p2)
{
    if (_p2 == 0)
    {
        float2 _t0 = step(float2(0.0), _p1) * step(_p1, float2(1.0));
        return _p0.sample(_p0Smplr, _p1) * (_t0.x * _t0.y);
    }
    else
    {
        if (_p2 == 1)
        {
            _p1 = fract(_p1);
            return _p0.sample(_p0Smplr, _p1);
        }
        else
        {
            if (_p2 == 2)
            {
                _p1 = abs(mod(_p1 + float2(1.0), float2(2.0)) - float2(1.0));
                return _p0.sample(_p0Smplr, _p1);
            }
            else
            {
                if (_p2 == 3)
                {
                    float2 _t1 = step(float2(0.0), _p1) * step(_p1, float2(1.0));
                    return mix(float4(0.0, 0.0, 0.0, 1.0), _p0.sample(_p0Smplr, _p1), float4(_t1.x * _t1.y));
                }
                else
                {
                    if (_p2 == 4)
                    {
                        float2 _t3 = step(float2(0.0), _p1) * step(_p1, float2(1.0));
                        return mix(float4(1.0), _p0.sample(_p0Smplr, _p1), float4(_t3.x * _t3.y));
                    }
                }
            }
        }
    }
    return float4(0.0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_imageFFront [[texture(0)]], texture2d<float> u_imageBFront [[texture(1)]], texture2d<float> u_imageFBack [[texture(2)]], texture2d<float> u_imageBBack [[texture(3)]], texture2d<float> u_imageFTop [[texture(4)]], texture2d<float> u_imageBTop [[texture(5)]], texture2d<float> u_imageFBottom [[texture(6)]], texture2d<float> u_imageBBottom [[texture(7)]], texture2d<float> u_imageFLeft [[texture(8)]], texture2d<float> u_imageBLeft [[texture(9)]], texture2d<float> u_imageFRight [[texture(10)]], texture2d<float> u_imageBRight [[texture(11)]], texture2d<float> u_mask [[texture(12)]], sampler u_imageFFrontSmplr [[sampler(0)]], sampler u_imageBFrontSmplr [[sampler(1)]], sampler u_imageFBackSmplr [[sampler(2)]], sampler u_imageBBackSmplr [[sampler(3)]], sampler u_imageFTopSmplr [[sampler(4)]], sampler u_imageBTopSmplr [[sampler(5)]], sampler u_imageFBottomSmplr [[sampler(6)]], sampler u_imageBBottomSmplr [[sampler(7)]], sampler u_imageFLeftSmplr [[sampler(8)]], sampler u_imageBLeftSmplr [[sampler(9)]], sampler u_imageFRightSmplr [[sampler(10)]], sampler u_imageBRightSmplr [[sampler(11)]], sampler u_maskSmplr [[sampler(12)]])
{
    main0_out out = {};
    int _144 = int(in.v_id.x);
    int _148 = int(in.v_id.y);
    int _154 = (_144 + _144) + _148;
    float4 _t8;
    if (_144 == 0)
    {
        if (_148 == 0)
        {
            float2 param = in.v_uv;
            int param_1 = int(buffer.u_wrapMode[_154]);
            float4 _178 = _f0(u_imageFFront, u_imageFFrontSmplr, param, param_1);
            _t8 = _178;
        }
        else
        {
            float2 param_2 = in.v_uv;
            int param_3 = int(buffer.u_wrapMode[_154]);
            float4 _188 = _f0(u_imageBFront, u_imageBFrontSmplr, param_2, param_3);
            _t8 = _188;
        }
    }
    else
    {
        if (_144 == 1)
        {
            if (_148 == 0)
            {
                float2 param_4 = in.v_uv;
                int param_5 = int(buffer.u_wrapMode[_154]);
                float4 _206 = _f0(u_imageFBack, u_imageFBackSmplr, param_4, param_5);
                _t8 = _206;
            }
            else
            {
                float2 param_6 = in.v_uv;
                int param_7 = int(buffer.u_wrapMode[_154]);
                float4 _216 = _f0(u_imageBBack, u_imageBBackSmplr, param_6, param_7);
                _t8 = _216;
            }
        }
        else
        {
            if (_144 == 2)
            {
                if (_148 == 0)
                {
                    float2 param_8 = in.v_uv;
                    int param_9 = int(buffer.u_wrapMode[_154]);
                    float4 _234 = _f0(u_imageFTop, u_imageFTopSmplr, param_8, param_9);
                    _t8 = _234;
                }
                else
                {
                    float2 param_10 = in.v_uv;
                    int param_11 = int(buffer.u_wrapMode[_154]);
                    float4 _244 = _f0(u_imageBTop, u_imageBTopSmplr, param_10, param_11);
                    _t8 = _244;
                }
            }
            else
            {
                if (_144 == 3)
                {
                    if (_148 == 0)
                    {
                        float2 param_12 = in.v_uv;
                        int param_13 = int(buffer.u_wrapMode[_154]);
                        float4 _262 = _f0(u_imageFBottom, u_imageFBottomSmplr, param_12, param_13);
                        _t8 = _262;
                    }
                    else
                    {
                        float2 param_14 = in.v_uv;
                        int param_15 = int(buffer.u_wrapMode[_154]);
                        float4 _272 = _f0(u_imageBBottom, u_imageBBottomSmplr, param_14, param_15);
                        _t8 = _272;
                    }
                }
                else
                {
                    if (_144 == 4)
                    {
                        if (_148 == 0)
                        {
                            float2 param_16 = in.v_uv;
                            int param_17 = int(buffer.u_wrapMode[_154]);
                            float4 _290 = _f0(u_imageFLeft, u_imageFLeftSmplr, param_16, param_17);
                            _t8 = _290;
                        }
                        else
                        {
                            float2 param_18 = in.v_uv;
                            int param_19 = int(buffer.u_wrapMode[_154]);
                            float4 _300 = _f0(u_imageBLeft, u_imageBLeftSmplr, param_18, param_19);
                            _t8 = _300;
                        }
                    }
                    else
                    {
                        if (_148 == 0)
                        {
                            float2 param_20 = in.v_uv;
                            int param_21 = int(buffer.u_wrapMode[_154]);
                            float4 _314 = _f0(u_imageFRight, u_imageFRightSmplr, param_20, param_21);
                            _t8 = _314;
                        }
                        else
                        {
                            float2 param_22 = in.v_uv;
                            int param_23 = int(buffer.u_wrapMode[_154]);
                            float4 _324 = _f0(u_imageBRight, u_imageBRightSmplr, param_22, param_23);
                            _t8 = _324;
                        }
                    }
                }
            }
        }
    }
    float _t9 = 1.0;
    if (buffer.u_maskChannel < 4)
    {
        _t9 = u_mask.sample(u_maskSmplr, in.v_uv)[buffer.u_maskChannel];
    }
    out.o_fragColor = _t8 * _t9;
    return out;
}

