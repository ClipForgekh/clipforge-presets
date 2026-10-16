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
    float u_brightness;
    int u_tonemapMode;
    float u_exposure;
    float u_rotation;
    float u_gammaValue;
    float u_shimmerIntensity;
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
float2 _f7(thread const float2& _p0, thread const float& _p1, thread const float& _p2)
{
    return float2x2(float2(_p2, -_p1), float2(_p1, _p2)) * _p0;
}

static inline __attribute__((always_inline))
float2 _f8(thread const float2& _p0, thread const float& _p1, thread const float& _p2)
{
    float2 param = _p0 - float2(0.5);
    float param_1 = _p1;
    float param_2 = _p2;
    return _f7(param, param_1, param_2) + float2(0.5);
}

static inline __attribute__((always_inline))
float4 _f6(thread const float4& _p0, thread const float3& _p1)
{
    return float4(pow(_p0.xyz, _p1), _p0.w);
}

static inline __attribute__((always_inline))
float4 _f3(thread const float4& _p0, thread const float4& _p1)
{
    return float4(_p0.xyz * _p1.xyz, _p0.w * _p1.w);
}

static inline __attribute__((always_inline))
float4 _f2(thread const float4& _p0, thread const float4& _p1)
{
    return float4(float3(1.0) - ((float3(1.0) - _p0.xyz) * (float3(1.0) - _p1.xyz)), (_p0.w + _p1.w) - (_p0.w * _p1.w));
}

static inline __attribute__((always_inline))
float3 _f0(thread float3& _p0, thread const float& _p1)
{
    _p0 *= _p1;
    return fast::clamp((_p0 * ((_p0 * 2.5099999904632568359375) + float3(0.02999999932944774627685546875))) / ((_p0 * ((_p0 * 2.4300000667572021484375) + float3(0.589999973773956298828125))) + float3(0.14000000059604644775390625)), float3(0.0), float3(1.0));
}

static inline __attribute__((always_inline))
float3 _f1(thread const float3& _p0, thread const int& _p1, thread const float& _p2)
{
    if (_p1 == 1)
    {
        float3 param = _p0;
        float param_1 = _p2;
        float3 _107 = _f0(param, param_1);
        return _107;
    }
    return _p0 * _p2;
}

static inline __attribute__((always_inline))
float4 _f4(thread const float4& _p0, thread const float4& _p1, thread const float4& _p2, thread const float4& _p3, thread const float4& _p4, thread const float4& _p5, thread const float4& _p6, thread const float4& _p7, constant float& u_brightness, constant int& u_tonemapMode, constant float& u_exposure)
{
    float4 param = _p0;
    float4 param_1 = _p2;
    float4 param_2 = _p1;
    float4 param_3 = _p3;
    float4 param_4 = _p4;
    float4 param_5 = _p6;
    float4 param_6 = _p5;
    float4 param_7 = _p7;
    float4 param_8 = _f2(param, param_1);
    float4 param_9 = _f2(param_2, param_3);
    float4 _195 = _f2(param_8, param_9);
    float4 _t8 = _195;
    float4 param_10 = _195;
    float4 param_11 = _f2(param_4, param_5);
    float4 _200 = _f2(param_10, param_11);
    _t8 = _200;
    float4 param_12 = _200;
    float4 param_13 = _f2(param_6, param_7);
    _t8 = _f2(param_12, param_13);
    if (u_brightness > 0.0)
    {
        float4 _213 = _t8;
        float3 _234 = _213.xyz * (1.0 + ((u_brightness * smoothstep(0.00999999977648258209228515625, 0.5, dot(_213.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)))) * 0.5));
        _t8.x = _234.x;
        _t8.y = _234.y;
        _t8.z = _234.z;
    }
    float3 param_14 = _t8.xyz;
    int param_15 = u_tonemapMode;
    float param_16 = u_exposure;
    float3 _254 = _f1(param_14, param_15, param_16);
    _t8.x = _254.x;
    _t8.y = _254.y;
    _t8.z = _254.z;
    return _t8;
}

static inline __attribute__((always_inline))
float4 _f5(thread const float4& _p0, thread const float3& _p1)
{
    return float4(pow(_p0.xyz, _p1), _p0.w);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_shimmerTex [[texture(0)]], texture2d<float> u_verticalTex1 [[texture(1)]], texture2d<float> u_verticalTex2 [[texture(2)]], texture2d<float> u_horizontalTex1 [[texture(3)]], texture2d<float> u_horizontalTex2 [[texture(4)]], texture2d<float> u_diagonal_1Tex [[texture(5)]], texture2d<float> u_diagonal_2Tex [[texture(6)]], texture2d<float> u_diagonal_3Tex [[texture(7)]], texture2d<float> u_diagonal_4Tex [[texture(8)]], sampler u_shimmerTexSmplr [[sampler(0)]], sampler u_verticalTex1Smplr [[sampler(1)]], sampler u_verticalTex2Smplr [[sampler(2)]], sampler u_horizontalTex1Smplr [[sampler(3)]], sampler u_horizontalTex2Smplr [[sampler(4)]], sampler u_diagonal_1TexSmplr [[sampler(5)]], sampler u_diagonal_2TexSmplr [[sampler(6)]], sampler u_diagonal_3TexSmplr [[sampler(7)]], sampler u_diagonal_4TexSmplr [[sampler(8)]])
{
    main0_out out = {};
    float _322 = radians(buffer.u_rotation);
    float _325 = sin(_322);
    float _328 = cos(_322);
    float _337 = _325 * 0.707106769084930419921875;
    float _339 = _328 * 0.707106769084930419921875;
    float3 _362 = float3(buffer.u_gammaValue);
    float2 param = in.v_uv;
    float param_1 = _325;
    float param_2 = _328;
    float2 param_3 = in.v_uv;
    float param_4 = _328;
    float param_5 = -_325;
    float2 param_6 = in.v_uv;
    float param_7 = _337 + _339;
    float param_8 = _339 - _337;
    float2 param_9 = in.v_uv;
    float param_10 = _337 - _339;
    float param_11 = _339 + _337;
    float4 param_12 = u_shimmerTex.sample(u_shimmerTexSmplr, _f8(param, param_1, param_2));
    float3 param_13 = _362;
    float4 _414 = _f6(param_12, param_13);
    float4 param_14 = u_shimmerTex.sample(u_shimmerTexSmplr, _f8(param_3, param_4, param_5));
    float3 param_15 = _362;
    float4 _422 = _f6(param_14, param_15);
    float4 param_16 = u_shimmerTex.sample(u_shimmerTexSmplr, _f8(param_6, param_7, param_8));
    float3 param_17 = _362;
    float4 _430 = _f6(param_16, param_17);
    float4 param_18 = u_shimmerTex.sample(u_shimmerTexSmplr, _f8(param_9, param_10, param_11));
    float3 param_19 = _362;
    float4 _438 = _f6(param_18, param_19);
    float4 param_20 = u_verticalTex1.sample(u_verticalTex1Smplr, in.v_uv);
    float3 param_21 = _362;
    float4 _t33 = _f6(param_20, param_21);
    float4 param_22 = u_verticalTex2.sample(u_verticalTex2Smplr, in.v_uv);
    float3 param_23 = _362;
    float4 _t34 = _f6(param_22, param_23);
    float4 param_24 = u_horizontalTex1.sample(u_horizontalTex1Smplr, in.v_uv);
    float3 param_25 = _362;
    float4 _t35 = _f6(param_24, param_25);
    float4 param_26 = u_horizontalTex2.sample(u_horizontalTex2Smplr, in.v_uv);
    float3 param_27 = _362;
    float4 _t36 = _f6(param_26, param_27);
    float4 param_28 = u_diagonal_1Tex.sample(u_diagonal_1TexSmplr, in.v_uv);
    float3 param_29 = _362;
    float4 _t37 = _f6(param_28, param_29);
    float4 param_30 = u_diagonal_2Tex.sample(u_diagonal_2TexSmplr, in.v_uv);
    float3 param_31 = _362;
    float4 _t38 = _f6(param_30, param_31);
    float4 param_32 = u_diagonal_3Tex.sample(u_diagonal_3TexSmplr, in.v_uv);
    float3 param_33 = _362;
    float4 _t39 = _f6(param_32, param_33);
    float4 param_34 = u_diagonal_4Tex.sample(u_diagonal_4TexSmplr, in.v_uv);
    float3 param_35 = _362;
    float4 _t40 = _f6(param_34, param_35);
    float4 param_36 = _t33;
    float4 param_37 = _414;
    float4 param_38 = _t34;
    float4 param_39 = _414;
    float4 param_40 = _t35;
    float4 param_41 = _422;
    float4 param_42 = _t36;
    float4 param_43 = _422;
    float4 param_44 = _t37;
    float4 param_45 = _438;
    float4 param_46 = _t38;
    float4 param_47 = _438;
    float4 param_48 = _t39;
    float4 param_49 = _430;
    float4 param_50 = _t40;
    float4 param_51 = _430;
    float4 _559 = _t33;
    float4 _563 = float4(buffer.u_shimmerIntensity);
    float4 _564 = mix(_559, _f3(param_36, param_37), _563);
    _t33 = _564;
    float4 _565 = _t34;
    float4 _569 = mix(_565, _f3(param_38, param_39), _563);
    _t34 = _569;
    float4 _570 = _t35;
    float4 _574 = mix(_570, _f3(param_40, param_41), _563);
    _t35 = _574;
    float4 _575 = _t36;
    float4 _579 = mix(_575, _f3(param_42, param_43), _563);
    _t36 = _579;
    float4 _580 = _t37;
    float4 _584 = mix(_580, _f3(param_44, param_45), _563);
    _t37 = _584;
    float4 _585 = _t38;
    float4 _589 = mix(_585, _f3(param_46, param_47), _563);
    _t38 = _589;
    float4 _590 = _t39;
    float4 _594 = mix(_590, _f3(param_48, param_49), _563);
    _t39 = _594;
    float4 _595 = _t40;
    float4 _599 = mix(_595, _f3(param_50, param_51), _563);
    _t40 = _599;
    float4 param_52 = _564;
    float4 param_53 = _569;
    float4 param_54 = _574;
    float4 param_55 = _579;
    float4 param_56 = _584;
    float4 param_57 = _589;
    float4 param_58 = _594;
    float4 param_59 = _599;
    float4 _617 = _f4(param_52, param_53, param_54, param_55, param_56, param_57, param_58, param_59, buffer.u_brightness, buffer.u_tonemapMode, buffer.u_exposure);
    float4 _t49 = _617;
    float3 _620 = _617.xyz;
    float3 _633 = _620 * (1.0 + ((fast::max(buffer.u_brightness, 0.0) * smoothstep(0.00999999977648258209228515625, 0.5, dot(_620, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)))) * 0.5));
    _t49.x = _633.x;
    _t49.y = _633.y;
    _t49.z = _633.z;
    float3 param_60 = _t49.xyz;
    int param_61 = buffer.u_tonemapMode;
    float param_62 = buffer.u_exposure;
    float3 _647 = _f1(param_60, param_61, param_62);
    _t49.x = _647.x;
    _t49.y = _647.y;
    _t49.z = _647.z;
    float4 param_63 = _t49;
    float3 param_64 = float3(1.0 / fast::max(buffer.u_gammaValue, 0.001000000047497451305389404296875));
    out.o_fragColor = _f5(param_63, param_64);
    return out;
}

