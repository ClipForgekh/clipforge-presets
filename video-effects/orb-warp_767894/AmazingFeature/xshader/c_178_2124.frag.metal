#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_Center;
    float4 u_ScreenParams;
    float u_Intensity;
    float u_Radius;
    float u_Convergence;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(v_uv)]];
};

static inline __attribute__((always_inline))
float3 _f1(thread const float2& _p0, thread const float& _p1, thread const float& _p2, constant float2& u_Center, constant float4& u_ScreenParams)
{
    float2 _t1 = _p0 - u_Center;
    _t1.x *= (u_ScreenParams.x / u_ScreenParams.y);
    float _43 = length(_t1);
    float _46 = _43 * _43;
    float _50 = _43 * ((1.0 + ((((-_p2) * 203.087493896484375) / pow(_p1, 2.0)) * _46)) + (0.0 * (_46 * _43)));
    float _71 = precise::atan2(_t1.x, _t1.y);
    float2 _t9 = float2((sin(_71) * _50) * 1.0, (cos(_71) * _50) * 1.0);
    _t9.x *= (u_ScreenParams.y / u_ScreenParams.x);
    float2 _98 = _t9;
    float2 _100 = _98 + u_Center;
    _t9 = _100;
    return float3(_100, _43);
}

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0)
{
    return step(float2(0.0), _p0) * step(_p0, float2(1.0));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    if (buffer.u_Intensity <= 0.0)
    {
        out.gl_FragColor = tDiffuse.sample(tDiffuseSmplr, in.v_uv);
        return out;
    }
    float2 _t10 = in.v_uv;
    float _141 = buffer.u_Radius * pow(1.60000002384185791015625, (buffer.u_ScreenParams.x / buffer.u_ScreenParams.y) - 1.0);
    float2 param = in.v_uv;
    float param_1 = _141 * buffer.u_Intensity;
    float param_2 = buffer.u_Convergence * buffer.u_Intensity;
    float2 param_3 = param;
    float param_4 = param_1;
    float param_5 = param_2;
    float3 _165 = _f1(param_3, param_4, param_5, buffer.u_Center, buffer.u_ScreenParams);
    float3 _t12 = _165;
    float2 _175 = _165.xy;
    _t10 = _175;
    float2 param_3_1 = _175;
    float2 param_6 = param_3_1;
    float2 _t13 = _f0(param_6);
    float _185 = _141 * 0.007000000216066837310791015625;
    float4 originalColor = tDiffuse.sample(tDiffuseSmplr, in.v_uv);
    float4 processedColor = ((tDiffuse.sample(tDiffuseSmplr, _t10) * _t13.x) * _t13.y) * smoothstep(_185 + 0.001000000047497451305389404296875, _185 - 0.001000000047497451305389404296875, _t12.z);
    out.gl_FragColor = mix(originalColor, processedColor, float4(buffer.u_Intensity));
    return out;
}

