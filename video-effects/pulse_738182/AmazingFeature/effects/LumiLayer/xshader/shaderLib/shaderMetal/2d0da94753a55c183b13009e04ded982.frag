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
    float u_mirrorEdge;
    float u_alpha;
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
float2 _f1(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f0(thread const float2& _p0)
{
    float2 _t0 = step(float2(0.0), _p0) * step(_p0, float2(1.2000000476837158203125));
    return _t0.x * _t0.y;
}

static inline __attribute__((always_inline))
float4 _f2(thread const float2& _p0, thread const float4& _p1)
{
    bool _61 = _p0.x > 1.230000019073486328125;
    bool _69;
    if (!_61)
    {
        _69 = _p0.x < (-0.23000000417232513427734375);
    }
    else
    {
        _69 = _61;
    }
    bool _76;
    if (!_69)
    {
        _76 = _p0.y > 1.230000019073486328125;
    }
    else
    {
        _76 = _69;
    }
    bool _83;
    if (!_76)
    {
        _83 = _p0.y < (-0.23000000417232513427734375);
    }
    else
    {
        _83 = _76;
    }
    if (_83)
    {
        return float4(0.0);
    }
    else
    {
        return _p1;
    }
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputTex [[texture(0)]], sampler inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _97 = step(buffer.u_mirrorEdge, 0.5);
    float2 param = in.v_uv;
    float2 _109 = (in.v_uv * _97) + (_f1(param) * (1.0 - _97));
    float4 _117 = inputTex.sample(inputTexSmplr, _109);
    float2 param_1 = _109;
    float4 _t3 = float4(1.0);
    if (buffer.u_mirrorEdge > 0.5)
    {
        float2 param_2 = in.v_uv;
        float4 param_3 = _t3;
        float2 param_4 = _109;
        _t3 = _f2(param_2, param_3) * _f0(param_4);
    }
    out.o_fragColor = ((_117 * buffer.u_alpha) * _f0(param_1)) * _t3;
    return out;
}

