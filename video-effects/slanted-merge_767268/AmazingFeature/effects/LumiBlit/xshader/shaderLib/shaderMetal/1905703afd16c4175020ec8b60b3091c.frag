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
    int u_frag_num;
    spvUnsafeArray<float, 12> u_fragDepth;
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
float4 _f0(thread const float4& _p0, thread const float4& _p1)
{
    return _p1 + (_p0 * (1.0 - _p1.w));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_fragmentTexture_1 [[texture(0)]], texture2d<float> u_fragmentTexture_2 [[texture(1)]], texture2d<float> u_fragmentTexture_3 [[texture(2)]], texture2d<float> u_fragmentTexture_4 [[texture(3)]], texture2d<float> u_fragmentTexture_5 [[texture(4)]], texture2d<float> u_fragmentTexture_6 [[texture(5)]], texture2d<float> u_fragmentTexture_7 [[texture(6)]], texture2d<float> u_fragmentTexture_8 [[texture(7)]], texture2d<float> u_fragmentTexture_9 [[texture(8)]], texture2d<float> u_fragmentTexture_10 [[texture(9)]], texture2d<float> u_fragmentTexture_11 [[texture(10)]], texture2d<float> u_fragmentTexture_12 [[texture(11)]], sampler u_fragmentTexture_1Smplr [[sampler(0)]], sampler u_fragmentTexture_2Smplr [[sampler(1)]], sampler u_fragmentTexture_3Smplr [[sampler(2)]], sampler u_fragmentTexture_4Smplr [[sampler(3)]], sampler u_fragmentTexture_5Smplr [[sampler(4)]], sampler u_fragmentTexture_6Smplr [[sampler(5)]], sampler u_fragmentTexture_7Smplr [[sampler(6)]], sampler u_fragmentTexture_8Smplr [[sampler(7)]], sampler u_fragmentTexture_9Smplr [[sampler(8)]], sampler u_fragmentTexture_10Smplr [[sampler(9)]], sampler u_fragmentTexture_11Smplr [[sampler(10)]], sampler u_fragmentTexture_12Smplr [[sampler(11)]])
{
    main0_out out = {};
    int _t0 = 0;
    spvUnsafeArray<float4, 12> _t2;
    spvUnsafeArray<float, 12> _t3;
    if (buffer.u_frag_num >= 1)
    {
        float4 _49 = u_fragmentTexture_1.sample(u_fragmentTexture_1Smplr, in.v_uv);
        float4 _t1 = _49;
        if (_t1.w > 0.001000000047497451305389404296875)
        {
            _t2[0] = float4(_49.xyz * _t1.w, _t1.w);
            _t3[0] = buffer.u_fragDepth[0];
            _t0 = 1;
        }
    }
    if (buffer.u_frag_num >= 2)
    {
        float4 _91 = u_fragmentTexture_2.sample(u_fragmentTexture_2Smplr, in.v_uv);
        float4 _t4 = _91;
        if (_t4.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_91.xyz * _t4.w, _t4.w);
            _t3[_t0] = buffer.u_fragDepth[1];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 3)
    {
        float4 _125 = u_fragmentTexture_3.sample(u_fragmentTexture_3Smplr, in.v_uv);
        float4 _t5 = _125;
        if (_t5.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_125.xyz * _t5.w, _t5.w);
            _t3[_t0] = buffer.u_fragDepth[2];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 4)
    {
        float4 _159 = u_fragmentTexture_4.sample(u_fragmentTexture_4Smplr, in.v_uv);
        float4 _t6 = _159;
        if (_t6.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_159.xyz * _t6.w, _t6.w);
            _t3[_t0] = buffer.u_fragDepth[3];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 5)
    {
        float4 _193 = u_fragmentTexture_5.sample(u_fragmentTexture_5Smplr, in.v_uv);
        float4 _t7 = _193;
        if (_t7.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_193.xyz * _t7.w, _t7.w);
            _t3[_t0] = buffer.u_fragDepth[4];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 6)
    {
        float4 _227 = u_fragmentTexture_6.sample(u_fragmentTexture_6Smplr, in.v_uv);
        float4 _t8 = _227;
        if (_t8.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_227.xyz * _t8.w, _t8.w);
            _t3[_t0] = buffer.u_fragDepth[5];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 7)
    {
        float4 _261 = u_fragmentTexture_7.sample(u_fragmentTexture_7Smplr, in.v_uv);
        float4 _t9 = _261;
        if (_t9.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_261.xyz * _t9.w, _t9.w);
            _t3[_t0] = buffer.u_fragDepth[6];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 8)
    {
        float4 _295 = u_fragmentTexture_8.sample(u_fragmentTexture_8Smplr, in.v_uv);
        float4 _t10 = _295;
        if (_t10.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_295.xyz * _t10.w, _t10.w);
            _t3[_t0] = buffer.u_fragDepth[7];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 9)
    {
        float4 _329 = u_fragmentTexture_9.sample(u_fragmentTexture_9Smplr, in.v_uv);
        float4 _t11 = _329;
        if (_t11.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_329.xyz * _t11.w, _t11.w);
            _t3[_t0] = buffer.u_fragDepth[8];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 10)
    {
        float4 _363 = u_fragmentTexture_10.sample(u_fragmentTexture_10Smplr, in.v_uv);
        float4 _t12 = _363;
        if (_t12.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_363.xyz * _t12.w, _t12.w);
            _t3[_t0] = buffer.u_fragDepth[9];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 11)
    {
        float4 _397 = u_fragmentTexture_11.sample(u_fragmentTexture_11Smplr, in.v_uv);
        float4 _t13 = _397;
        if (_t13.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_397.xyz * _t13.w, _t13.w);
            _t3[_t0] = buffer.u_fragDepth[10];
            _t0++;
        }
    }
    if (buffer.u_frag_num >= 12)
    {
        float4 _431 = u_fragmentTexture_12.sample(u_fragmentTexture_12Smplr, in.v_uv);
        float4 _t14 = _431;
        if (_t14.w > 0.001000000047497451305389404296875)
        {
            _t2[_t0] = float4(_431.xyz * _t14.w, _t14.w);
            _t3[_t0] = buffer.u_fragDepth[11];
            _t0++;
        }
    }
    for (int _t15 = 0; _t15 < 11; _t15++)
    {
        int _466 = _t15 + 1;
        for (int _t16 = _466; _t16 < 12; _t16++)
        {
            bool _476 = _t16 < _t0;
            bool _486;
            if (_476)
            {
                _486 = _t3[_t15] > _t3[_t16];
            }
            else
            {
                _486 = _476;
            }
            if (_486)
            {
                float _492 = _t3[_t15];
                _t3[_t15] = _t3[_t16];
                _t3[_t16] = _492;
                float4 _504 = _t2[_t15];
                _t2[_t15] = _t2[_t16];
                _t2[_t16] = _504;
            }
        }
    }
    float4 _t19 = float4(0.0);
    for (int _t20 = 0; _t20 < 12; _t20++)
    {
        if (_t20 < _t0)
        {
            float4 param = _t19;
            float4 param_1 = _t2[_t20];
            _t19 = _f0(param, param_1);
        }
    }
    out.o_fragColor = _t19;
    return out;
}

