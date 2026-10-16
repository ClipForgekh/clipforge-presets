#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL radians() function
template<typename T>
inline T radians(T d)
{
    return d * T(0.01745329251);
}

struct buffer_t
{
    float u_rotation;
    int u_wipeMode;
    float2 u_wipeCenter;
    float u_progress;
    float u_feather;
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
float2x2 _f0(float _p0)
{
    float _30 = cos(_p0);
    float _32 = sin(_p0);
    return float2x2(float2(_30, -_32), float2(_32, _30));
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float& _p1, thread const float2& _p2)
{
    return (_f0(_p1) * (_p0 - _p2)) + _p2;
}

static inline __attribute__((always_inline))
float _f2(thread const float2& _p0, thread const float2& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4, constant float& u_rotation, constant int& u_wipeMode)
{
    float2 param = _p0;
    float param_1 = radians((-90.0) + u_rotation);
    float2 param_2 = _p1;
    float2 _t2 = _f1(param, param_1, param_2) - _p1;
    float _79 = precise::atan2(-_t2.y, _t2.x);
    float _85 = precise::atan2(_t2.y, _t2.x);
    float _t6 = ((_p3 * 3.1415927410125732421875) * 2.0) - 3.1415927410125732421875;
    float _t7;
    if (u_wipeMode == 0)
    {
        _t7 = _79;
    }
    else
    {
        if (u_wipeMode == 1)
        {
            _t7 = _85;
        }
        else
        {
            if (u_wipeMode == 2)
            {
                _t6 = (_p3 * 3.1415927410125732421875) - 3.1415927410125732421875;
                _t7 = fast::min(_79, _85);
            }
        }
    }
    return mix(0.0, 1.0, step(0.0, _t7 - _t6));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float2 param = in.v_uv;
    float2 param_1 = buffer.u_wipeCenter;
    float param_2 = buffer.u_rotation;
    float param_3 = buffer.u_progress;
    float param_4 = buffer.u_feather;
    out.o_fragColor = float4(_f2(param, param_1, param_2, param_3, param_4, buffer.u_rotation, buffer.u_wipeMode));
    return out;
}

