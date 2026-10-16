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
    float u_interpolate;
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
};

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0, thread const float& _p1, constant float& u_frameCount, thread float2& a_uv1)
{
    return float2(a_uv1.x * _p0.x, ((1.0 - a_uv1.y) * _p0.y) + ((mod(floor(_p1) - 1.0, u_frameCount) / u_frameCount) * _p0.y));
}

static inline __attribute__((always_inline))
float4 _f2(thread const float2& _p0, texture2d<float> u_colTex, sampler u_colTexSmplr)
{
    return u_colTex.sample(u_colTexSmplr, _p0, level(0.0));
}

static inline __attribute__((always_inline))
void _f1(thread const float4& _p0, thread float3& _p1, thread float3& _p2)
{
    _p1 = fast::normalize((cross(_p0.xyz, cross(_p0.xyz, float3(0.0, 1.0, 0.0)) + (float3(0.0, 1.0, 0.0) * _p0.w)) * 2.0) + float3(0.0, 1.0, 0.0));
    _p2 = fast::normalize((cross(_p0.xyz, cross(_p0.xyz, float3(-1.0, 0.0, 0.0)) + (float3(-1.0, 0.0, 0.0) * _p0.w)) * 2.0) + float3(-1.0, 0.0, 0.0));
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_colTex [[texture(0)]], texture2d<float> u_posTex [[texture(1)]], texture2d<float> u_rotTex [[texture(2)]], sampler u_colTexSmplr [[sampler(0)]], sampler u_posTexSmplr [[sampler(1)]], sampler u_rotTexSmplr [[sampler(2)]])
{
    main0_out out = {};
    float _129 = buffer.u_boundMin.z * 10.0;
    float _140 = buffer.u_boundMax.x * (-10.0);
    float2 _147 = float2(1.0 - (ceil(_129) - _129), 1.0 - (_140 - floor(_140)));
    float2 param = _147;
    float param_1 = buffer.u_displayFrame;
    float2 _154 = _f0(param, param_1, buffer.u_frameCount, in.a_uv1);
    float2 param_2 = _154;
    float4 _168 = _f2(param_2, u_colTex, u_colTexSmplr);
    float3 _t11 = in.a_normal;
    float4 param_3 = u_rotTex.sample(u_rotTexSmplr, _154, level(0.0));
    float3 param_4;
    float3 param_5;
    _f1(param_3, param_4, param_5);
    _t11 = param_4;
    float3 _182 = u_posTex.sample(u_posTexSmplr, _154, level(0.0)).xyz;
    float3 _t13 = _182;
    float3 _t14 = param_4;
    float3 _t15 = param_5;
    float4 _t16 = _168;
    if (buffer.u_interpolate > 0.5)
    {
        float2 param_6 = _147;
        float param_7 = buffer.u_displayFrame + 1.0;
        float2 _202 = _f0(param_6, param_7, buffer.u_frameCount, in.a_uv1);
        float2 param_8 = _202;
        float4 param_9 = u_rotTex.sample(u_rotTexSmplr, _202, level(0.0));
        float3 param_10;
        float3 param_11;
        _f1(param_9, param_10, param_11);
        float _226 = fract(buffer.u_displayFrame);
        float3 _232 = float3(_226);
        _t13 = mix(_182, u_posTex.sample(u_posTexSmplr, _202, level(0.0)).xyz, _232);
        _t14 = mix(_t11, param_10, _232);
        _t15 = mix(param_5, param_11, _232);
        _t16 = mix(_168, _f2(param_8, u_colTex, u_colTexSmplr), float4(_226));
    }
    float3 _263 = select((_t13 * float3(-1.0, 1.0, 1.0)) + in.a_position, float3(0.0), bool3(in.a_uv1.y <= 0.100000001490116119384765625));
    out.gl_Position = buffer.u_MVP * float4(_263, 1.0);
    out.v_uv0 = float2(in.a_uv0.x, in.a_uv0.y);
    out.v_nDirWS = fast::normalize(_t14);
    out.v_tDirWS = fast::normalize(_t15);
    out.v_bDirWS = fast::normalize(cross(out.v_nDirWS, out.v_tDirWS));
    out.v_posWS = _263;
    out.v_vertexColor = _t16;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

