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
    float2 u_center;
    float2 u_wh;
    float2 u_wipeCenter;
    int u_maskType;
    float u_time;
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
    float _56 = cos(_p0);
    float _58 = sin(_p0);
    return float2x2(float2(_56, -_58), float2(_58, _56));
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float& _p1)
{
    return ((_p0 - float2(0.5)) * _f0(_p1)) + float2(0.5);
}

static inline __attribute__((always_inline))
float4 _f4(thread const float2& _p0, thread float& _p1, thread const float& _p2, thread const float& _p3)
{
    _p1 *= (1.0 + _p3);
    float2 param = _p0;
    float param_1 = radians(_p2);
    float2 _t10 = _f1(param, param_1);
    return float4(0.0, 0.0, 0.0, mix(0.0, 1.0, smoothstep(_p1 - _p3, _p1 + _p3, _t10.y)));
}

static inline __attribute__((always_inline))
float4 _f5(thread const float2& _p0, thread const float2& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4)
{
    float _205 = distance(_p0, _p1);
    float _209 = fast::min(_205, _p3);
    float _218 = smoothstep(_p2 + _209, _p2 - _209, _205);
    return float4(0.0, 0.0, 0.0, 1.0 - mix(_218, 1.0 - _218, _p4));
}

static inline __attribute__((always_inline))
float4 _f6(thread const float2& _p0, thread float& _p1, thread const float& _p2, thread const float& _p3)
{
    _p1 = (-_p1) / 2.0;
    float2 param = _p0;
    float param_1 = _p3;
    float2 _240 = _f1(param, param_1);
    float2 _t17 = _240 + float2(0.0, _p1);
    float2 _t18 = _240 - float2(0.0, _p1);
    return fast::clamp(float4(0.0, 0.0, 0.0, 1.0) * (smoothstep(0.5 - _p2, 0.5 + _p2, _t17.y) + (1.0 - smoothstep(0.5 - _p2, 0.5 + _p2, _t18.y))), float4(0.0), float4(1.0));
}

static inline __attribute__((always_inline))
float2 _f2(thread const float2& _p0, thread const float& _p1, thread const float2& _p2)
{
    return (_f0(_p1) * (_p0 - _p2)) + _p2;
}

static inline __attribute__((always_inline))
float4 _f3(thread const float2& _p0, thread const float2& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4, constant float& u_rotation, constant int& u_wipeMode)
{
    float2 param = _p0;
    float param_1 = radians((-90.0) + u_rotation);
    float2 param_2 = _p1;
    float2 _t3 = _f2(param, param_1, param_2) - _p1;
    float _119 = precise::atan2(-_t3.y, _t3.x);
    float _125 = precise::atan2(_t3.y, _t3.x);
    float _t7 = ((_p3 * 3.1415927410125732421875) * 2.0) - 3.1415927410125732421875;
    float _t8;
    if (u_wipeMode == 0)
    {
        _t8 = _119;
    }
    else
    {
        if (u_wipeMode == 1)
        {
            _t8 = _125;
        }
        else
        {
            if (u_wipeMode == 2)
            {
                _t7 = (_p3 * 3.1415927410125732421875) - 3.1415927410125732421875;
                _t8 = fast::min(_119, _125);
            }
        }
    }
    return float4(0.0, 0.0, 0.0, smoothstep(_t7 - _p4, _t7, _t8));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture2 [[texture(0)]], sampler u_inputTexture2Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t24 = buffer.u_center;
    _t24.y = 1.0 - _t24.y;
    _t24 -= float2(0.5);
    float _309 = buffer.u_wh.x / buffer.u_wh.y;
    _t24.y /= _309;
    _t24 += float2(0.5);
    float2 _t25 = buffer.u_wipeCenter - float2(0.5);
    _t25.y /= _309;
    _t25 += float2(0.5);
    float2 _t22 = float2(in.v_uv.x, 1.0 - in.v_uv.y) - float2(0.5);
    _t22.y /= _309;
    _t22 += float2(0.5);
    float4 _t26 = float4(0.0);
    if (buffer.u_maskType == 0)
    {
        float2 param = in.v_uv;
        float param_1 = (buffer.u_time * 2.0) - 0.5;
        float param_2 = buffer.u_rotation * 360.0;
        float param_3 = buffer.u_feather;
        float4 _370 = _f4(param, param_1, param_2, param_3);
        _t26 = _370;
    }
    else
    {
        if (buffer.u_maskType == 1)
        {
            float2 param_4 = _t22;
            float2 param_5 = _t24;
            float param_6 = buffer.u_time * 1.0499999523162841796875;
            float param_7 = (buffer.u_feather * fast::max(buffer.u_wh.x, buffer.u_wh.y)) / 720.0;
            float param_8 = 0.0;
            _t26 = _f5(param_4, param_5, param_6, param_7, param_8);
        }
        else
        {
            if (buffer.u_maskType == 2)
            {
                float2 param_9 = in.v_uv;
                float param_10 = (buffer.u_time * 2.0) - 0.5;
                float param_11 = buffer.u_feather;
                float param_12 = buffer.u_rotation * 3.141592502593994140625;
                float4 _413 = _f6(param_9, param_10, param_11, param_12);
                _t26 = _413;
            }
            else
            {
                if (buffer.u_maskType == 3)
                {
                    float2 param_13 = _t22;
                    float2 param_14 = _t25;
                    float param_15 = buffer.u_rotation * 360.0;
                    float param_16 = (buffer.u_time * 2.0) - 0.5;
                    float param_17 = buffer.u_feather;
                    _t26 = _f3(param_13, param_14, param_15, param_16, param_17, buffer.u_rotation, buffer.u_wipeMode);
                }
                else
                {
                    _t26 = float4(0.0);
                }
            }
        }
    }
    float4 _t27 = u_inputTexture2.sample(u_inputTexture2Smplr, _t22);
    out.o_fragColor = _t26 * (1.0 - smoothstep(0.5, 0.89999997615814208984375, _t27.x));
    return out;
}

