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
    float u_rotation;
    float u_rotationAxis;
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
float2x2 _f1(thread const float& _p0)
{
    return float2x2(float2(cos(_p0), -sin(_p0)), float2(sin(_p0), cos(_p0)));
}

static inline __attribute__((always_inline))
float2 _f2(thread const float2& _p0, thread const float& _p1, thread const float& _p2)
{
    float2 _58 = _p0 - float2(0.5);
    float2 _t1 = _58;
    float _63 = tan(_p2 + 1.5707962512969970703125);
    float _66 = tan(_p2);
    float2 _t5 = float2(0.0);
    _t5.x = (_t1.y - (_66 * _t1.x)) / (_63 - _66);
    _t5.y = _t5.x * _63;
    float param = -_p1;
    return ((_f1(param) * (_58 - _t5)) + _t5) + float2(0.5);
}

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0)
{
    return abs(mod(_p0 + float2(1.0), float2(2.0)) - float2(1.0));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.v_uv;
    float param_1 = buffer.u_rotation;
    float param_2 = buffer.u_rotationAxis;
    float2 param_3 = _f2(param, param_1, param_2);
    out.o_fragColor = u_inputTex.sample(u_inputTexSmplr, _f0(param_3));
    return out;
}

