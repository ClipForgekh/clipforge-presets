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
    float2 a_uv0 [[attribute(4)]];
    float2 a_uv1 [[attribute(5)]];
};

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0, thread const float& _p1, constant float& u_frameCount, thread float2& a_uv1)
{
    return float2(a_uv1.x * _p0.x, ((1.0 - a_uv1.y) * _p0.y) + ((mod(floor(_p1) - 1.0, u_frameCount) / u_frameCount) * _p0.y));
}

static inline __attribute__((always_inline))
float4 _f3(thread const float2& _p0, texture2d<float> u_colTex, sampler u_colTexSmplr)
{
    return u_colTex.sample(u_colTexSmplr, _p0, level(0.0));
}

static inline __attribute__((always_inline))
float3 _f1(thread const float4& _p0, thread const float3& _p1)
{
    return fast::normalize((cross(_p0.xyz, cross(_p0.xyz, _p1) + (_p1 * _p0.w)) * 2.0) + _p1);
}

static inline __attribute__((always_inline))
float3 _f2(thread const float4& _p0, thread const float3& _p1)
{
    float3 _95 = fast::normalize(cross(_p1, float3(0.0, 1.0, 0.0)));
    return fast::normalize((cross(_p0.xyz, cross(_p0.xyz, _95) + (_95 * _p0.w)) * 2.0) + _95);
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_colTex [[texture(0)]], texture2d<float> u_posTex [[texture(1)]], texture2d<float> u_rotTex [[texture(2)]], sampler u_colTexSmplr [[sampler(0)]], sampler u_posTexSmplr [[sampler(1)]], sampler u_rotTexSmplr [[sampler(2)]])
{
    main0_out out = {};
    float _136 = buffer.u_boundMin.z * 10.0;
    float _147 = buffer.u_boundMax.x * (-10.0);
    float2 param = float2(1.0 - (ceil(_136) - _136), 1.0 - (_147 - floor(_147)));
    float param_1 = buffer.u_displayFrame;
    float2 _161 = _f0(param, param_1, buffer.u_frameCount, in.a_uv1);
    float4 _171 = u_rotTex.sample(u_rotTexSmplr, _161, level(0.0));
    float4 _t9 = float4(1.0);
    if (buffer.u_useVertexColor > 0)
    {
        float2 param_2 = _161;
        _t9 = _f3(param_2, u_colTex, u_colTexSmplr);
    }
    float3 _190 = u_colTex.sample(u_colTexSmplr, _161, level(0.0)).xyz;
    float4 param_3 = _171;
    float3 param_4 = _190;
    float3 _196 = _f1(param_3, param_4);
    float4 param_5 = _171;
    float3 param_6 = _196;
    float3 _202 = _f2(param_5, param_6);
    float3 _223 = (u_posTex.sample(u_posTexSmplr, _161, level(0.0)).xyz * float3(-1.0, 1.0, 1.0)) + in.a_position;
    out.gl_Position = buffer.u_MVP * float4(_223, 1.0);
    out.v_uv0 = float2(in.a_uv0.x, in.a_uv0.y);
    out.v_posWS = _223;
    out.v_nDirWS = _190;
    out.v_tDirWS = _202;
    out.v_bDirWS = fast::normalize(cross(_196, _202));
    out.v_vertexColor = _t9;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

