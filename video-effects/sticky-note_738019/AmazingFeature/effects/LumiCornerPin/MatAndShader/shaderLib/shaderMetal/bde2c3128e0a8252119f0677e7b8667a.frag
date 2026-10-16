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
    float2 u_downLeftVertex;
    float2 u_downRightVertex;
    float2 u_upRightVertex;
    float2 u_upLeftVertex;
    int u_motionTileType;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_InputTex [[texture(0)]], sampler u_InputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float3 _454 = float3x3(float3(buffer.u_downRightVertex.y - buffer.u_upRightVertex.y, buffer.u_upRightVertex.y - buffer.u_downLeftVertex.y, buffer.u_downLeftVertex.y - buffer.u_downRightVertex.y), float3(buffer.u_upRightVertex.x - buffer.u_downRightVertex.x, buffer.u_downLeftVertex.x - buffer.u_upRightVertex.x, buffer.u_downRightVertex.x - buffer.u_downLeftVertex.x), float3(fma(buffer.u_downRightVertex.x, buffer.u_upRightVertex.y, -(buffer.u_upRightVertex.x * buffer.u_downRightVertex.y)), fma(buffer.u_upRightVertex.x, buffer.u_downLeftVertex.y, -(buffer.u_downLeftVertex.x * buffer.u_upRightVertex.y)), fma(buffer.u_downLeftVertex.x, buffer.u_downRightVertex.y, -(buffer.u_downRightVertex.x * buffer.u_downLeftVertex.y)))) * float3(buffer.u_upLeftVertex, 1.0);
    float3x3 _479 = float3x3(float3(buffer.u_downLeftVertex, 1.0), float3(buffer.u_downRightVertex, 1.0), float3(buffer.u_upRightVertex, 1.0)) * float3x3(float3(_454.x, 0.0, 0.0), float3(0.0, _454.y, 0.0), float3(0.0, 0.0, _454.z));
    float _782 = _479[1].y;
    float _784 = _479[2].z;
    float _787 = _479[2].y;
    float _789 = _479[1].z;
    float _795 = _479[0].z;
    float _798 = _479[0].y;
    float _816 = _479[2].x;
    float _821 = _479[1].x;
    float _827 = _479[0].x;
    float3 _903 = ((float3x3(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 1.0), float3(1.0)) * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, -1.0, 0.0), float3(0.0, 0.0, 1.0))) * float3x3(float3(fma(_782, _784, -(_787 * _789)), fma(_787, _795, -(_798 * _784)), fma(_798, _789, -(_782 * _795))), float3(fma(_816, _789, -(_821 * _784)), fma(_827, _784, -(_816 * _795)), fma(_821, _795, -(_827 * _789))), float3(fma(_821, _787, -(_816 * _782)), fma(_816, _798, -(_827 * _787)), fma(_827, _782, -(_821 * _798))))) * float3(in.v_uv, 1.0);
    float2 _909 = _903.xy / float2(_903.z);
    float2 _1056;
    float _1059;
    if (buffer.u_motionTileType == 0)
    {
        float _913 = _909.x;
        float _920 = _909.y;
        _1059 = ((step(0.0, _913) * step(_913, 1.0)) * step(0.0, _920)) * step(_920, 1.0);
        _1056 = _909;
    }
    else
    {
        float2 _1057;
        if (buffer.u_motionTileType == 1)
        {
            _1057 = abs(mod(_909 - float2(1.0), float2(2.0)) - float2(1.0));
        }
        else
        {
            float2 _1058;
            if (buffer.u_motionTileType == 2)
            {
                _1058 = fract(_909);
            }
            else
            {
                _1058 = _909;
            }
            _1057 = _1058;
        }
        _1059 = 1.0;
        _1056 = _1057;
    }
    out.o_fragColor = u_InputTex.sample(u_InputTexSmplr, _1056) * _1059;
    return out;
}

