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
    float u_frameCount;
    float3 u_boundMin;
    float3 u_boundMax;
    float u_displayFrame;
    int u_useVertexColor;
    float4x4 u_MVP;
};

struct main0_out
{
    float3 v_posWS [[user(locn0)]];
    float3 v_nDirWS [[user(locn1)]];
    float3 v_tDirWS [[user(locn2)]];
    float3 v_bDirWS [[user(locn3)]];
    float2 v_uv0 [[user(locn4)]];
    float2 v_uv1 [[user(locn5)]];
    float4 v_vertexColor [[user(locn6)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 a_position [[attribute(0)]];
    float3 a_normal [[attribute(2)]];
    float2 a_uv0 [[attribute(4)]];
    float2 a_uv1 [[attribute(5)]];
    float2 a_uv2 [[attribute(6)]];
    float2 a_uv3 [[attribute(7)]];
};

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0, thread const float& _p1, constant float& u_frameCount, thread float2& a_uv1)
{
    return float2(a_uv1.x * _p0.x, ((1.0 - a_uv1.y) * _p0.y) + ((mod(floor(_p1) - 1.0, u_frameCount) / u_frameCount) * _p0.y));
}

static inline __attribute__((always_inline))
float3 _f1(thread float3& a_position, thread float2& a_uv2, thread float2& a_uv3)
{
    return a_position - float3(a_uv2.x * 1.0, a_uv3.x, 1.0 - a_uv3.y);
}

static inline __attribute__((always_inline))
void _f2(thread const float3& _p0, thread const float& _p1, thread float4& _p2)
{
    float _121 = sqrt(((1.0 - pow(_p0.x, 2.0)) - pow(_p0.y, 2.0)) - pow(_p0.z, 2.0));
    float4 _t3 = float4(0.0, 0.0, 0.0, 1.0);
    if (_p1 < 0.5)
    {
        _t3 = float4(_p0, _121);
    }
    else
    {
        if (_p1 < 1.5)
        {
            _t3 = float4(_121, _p0.yzx);
        }
        else
        {
            if (_p1 < 2.5)
            {
                _t3 = float4(_p0.x, -_121, _p0.z, -_p0.y);
            }
            else
            {
                if (_p1 < 3.5)
                {
                    _t3 = float4(_p0.xy, -_121, -_p0.z);
                }
                else
                {
                    _t3 = float4(_p0, _121);
                }
            }
        }
    }
    _p2 = _t3;
}

static inline __attribute__((always_inline))
float4 _f3(thread const float4& _p0, thread const float4& _p1)
{
    return float4((((_p0.w * _p1.x) + (_p0.x * _p1.w)) + (_p0.z * _p1.y)) - (_p0.y * _p1.z), (((_p0.w * _p1.y) + (_p0.y * _p1.w)) + (_p0.x * _p1.z)) - (_p0.z * _p1.x), (((_p0.w * _p1.z) + (_p0.z * _p1.w)) + (_p0.y * _p1.x)) - (_p0.x * _p1.y), (((_p0.w * _p1.w) - (_p0.x * _p1.x)) - (_p0.y * _p1.y)) - (_p0.z * _p1.z));
}

static inline __attribute__((always_inline))
float3 _f4(thread const float3& _p0, thread const float4& _p1)
{
    float4 param = _p1;
    float4 param_1 = float4(_p0, 0.0);
    float4 param_2 = _f3(param, param_1);
    float4 param_3 = float4(-_p1.x, -_p1.y, -_p1.z, _p1.w);
    return _f3(param_2, param_3).xyz;
}

static inline __attribute__((always_inline))
float4 _f7(thread const float2& _p0, texture2d<float> u_colTex, sampler u_colTexSmplr)
{
    return u_colTex.sample(u_colTexSmplr, _p0, level(0.0));
}

static inline __attribute__((always_inline))
float3 _f5(thread const float4& _p0, thread const float3& _p1)
{
    return fast::normalize((cross(_p0.xyz, cross(_p0.xyz, _p1) + (_p1 * _p0.w)) * 2.0) + _p1);
}

static inline __attribute__((always_inline))
float3 _f6(thread const float4& _p0, thread const float3& _p1)
{
    float3 _337 = fast::normalize(cross(_p1, float3(0.0, 1.0, 0.0)));
    return fast::normalize((cross(_p0.xyz, cross(_p0.xyz, _337) + (_337 * _p0.w)) * 2.0) + _337);
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_colTex [[texture(0)]], texture2d<float> u_posTex [[texture(1)]], texture2d<float> u_rotTex [[texture(2)]], sampler u_colTexSmplr [[sampler(0)]], sampler u_posTexSmplr [[sampler(1)]], sampler u_rotTexSmplr [[sampler(2)]])
{
    main0_out out = {};
    float _375 = buffer.u_boundMin.z * 10.0;
    float _386 = buffer.u_boundMax.x * (-10.0);
    float2 param = float2(1.0 - (ceil(_375) - _375), 1.0 - (_386 - floor(_386)));
    float param_1 = buffer.u_displayFrame;
    float2 _400 = _f0(param, param_1, buffer.u_frameCount, in.a_uv1);
    float4 _405 = u_posTex.sample(u_posTexSmplr, _400, level(0.0));
    float4 _t10 = _405;
    float4 _410 = u_rotTex.sample(u_rotTexSmplr, _400, level(0.0));
    float3 param_2 = _410.xyz;
    float param_3 = floor(_t10.w * 4.0);
    float4 param_4;
    _f2(param_2, param_3, param_4);
    float3 param_5 = _f1(in.a_position, in.a_uv2, in.a_uv3);
    float4 param_6 = param_4;
    if (buffer.u_useVertexColor > 0)
    {
        float2 param_7 = _400;
    }
    float4 param_8 = _410;
    float3 param_9 = in.a_normal;
    float3 _453 = _f5(param_8, param_9);
    float4 param_10 = _410;
    float3 param_11 = _453;
    float3 _459 = _f6(param_10, param_11);
    float3 _480 = (_405.xyz * float3(-1.0, 1.0, 1.0)) + _f4(param_5, param_6);
    out.gl_Position = buffer.u_MVP * float4(_480, 1.0);
    out.v_uv0 = float2(in.a_uv0.x, in.a_uv0.y);
    out.v_posWS = _480;
    out.v_nDirWS = _453;
    out.v_tDirWS = _459;
    out.v_bDirWS = fast::normalize(cross(_453, _459));
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

