#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float4 u_ScreenParams;
    int u_skipSample;
    spvUnsafeArray<float, 6> u_rotationFloatVector;
    spvUnsafeArray<float2, 6> u_positionVec2Vector;
    spvUnsafeArray<float2, 6> u_pivotVec2Vector;
    spvUnsafeArray<float2, 6> u_scaleVec2Vector;
    float u_mirrorEdge;
    float u_intensity;
    float u_minSamples;
    float u_maxSamples;
    float u_dither;
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
float2 _f0(thread float2& _p0, thread const float& _p1, thread const float2& _p2, thread const float2& _p3, thread const float2& _p4, constant float4& u_ScreenParams)
{
    _p0 -= _p2;
    _p0 -= float2(0.5);
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _64 = sin(_p1);
    float _67 = cos(_p1);
    _p0 = float2x2(float2(float2(_67, _64)), float2(float2(-_64, _67))) * _p0;
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    _p0 *= (float2(1.0) / _p4);
    _p0 += float2(0.5);
    _p0 += _p3;
    return _p0;
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f2(thread const float2& _p0)
{
    return ((step(0.0, _p0.x) * step(0.0, _p0.y)) * step(_p0.x, 1.0)) * step(_p0.y, 1.0);
}

static inline __attribute__((always_inline))
float _f4(thread const float& _p0, thread const float& _p1)
{
    float2 _137 = fract(float2(_p0, _p1) * 13.5170001983642578125);
    float2 _t3 = _137 + float2(dot(_137, _137.yx + float2(22.5410003662109375)));
    return fract((_t3.x + _t3.y) * _t3.y);
}

static inline __attribute__((always_inline))
float2 _f3(thread const float& _p0, thread const float2& _p1, thread const float2& _p2, thread const float2& _p3, thread const float2& _p4, thread const float2& _p5, thread const float2& _p6)
{
    return ((((mix(_p1, _p2, float2(_p0 * 5.0)) * step(_p0, 0.20000000298023223876953125)) + ((mix(_p2, _p3, float2((_p0 * 5.0) - 1.0)) * (1.0 - step(_p0, 0.20000000298023223876953125))) * step(_p0, 0.4000000059604644775390625))) + ((mix(_p3, _p4, float2((_p0 * 5.0) - 2.0)) * (1.0 - step(_p0, 0.4000000059604644775390625))) * step(_p0, 0.60000002384185791015625))) + ((mix(_p4, _p5, float2((_p0 * 5.0) - 3.0)) * (1.0 - step(_p0, 0.60000002384185791015625))) * step(_p0, 0.800000011920928955078125))) + (mix(_p5, _p6, float2((_p0 * 5.0) - 4.0)) * (1.0 - step(_p0, 0.800000011920928955078125)));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 originalColor = tDiffuse.sample(tDiffuseSmplr, in.v_uv);
    if (buffer.u_skipSample == 1)
    {
        float2 param = in.v_uv;
        float param_1 = (buffer.u_rotationFloatVector[0] * 3.141592502593994140625) / 180.0;
        float2 param_2 = buffer.u_positionVec2Vector[0];
        float2 param_3 = buffer.u_pivotVec2Vector[0];
        float2 param_4 = buffer.u_scaleVec2Vector[0];
        float2 param_5 = param;
        float param_6 = param_1;
        float2 param_7 = param_2;
        float2 param_8 = param_3;
        float2 param_9 = param_4;
        float2 _301 = _f0(param_5, param_6, param_7, param_8, param_9, buffer.u_ScreenParams);
        param = param_5;
        float2 _290 = _301;
        float _303 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_5_1 = _290;
        float2 param_10 = param_5_1;
        float2 _309 = (_290 * _303) + (_f1(param_10) * (1.0 - _303));
        float2 param_6_1 = _309;
        float2 param_11 = param_6_1;
        float4 processedColor = tDiffuse.sample(tDiffuseSmplr, _309) * _f2(param_11);
        out.gl_FragColor = mix(originalColor, processedColor, float4(buffer.u_intensity));
        return out;
    }
    float2 param_7_1 = in.v_uv;
    float param_8_1 = (buffer.u_rotationFloatVector[0] * 3.141592502593994140625) / 180.0;
    float2 param_9_1 = buffer.u_positionVec2Vector[0];
    float2 param_10_1 = buffer.u_pivotVec2Vector[0];
    float2 param_11_1 = buffer.u_scaleVec2Vector[0];
    float2 param_12 = param_7_1;
    float param_13 = param_8_1;
    float2 param_14 = param_9_1;
    float2 param_15 = param_10_1;
    float2 param_16 = param_11_1;
    float2 _366 = _f0(param_12, param_13, param_14, param_15, param_16, buffer.u_ScreenParams);
    param_7_1 = param_12;
    float2 _355 = _366;
    float2 param_12_1 = in.v_uv;
    float param_13_1 = (buffer.u_rotationFloatVector[1] * 3.141592502593994140625) / 180.0;
    float2 param_14_1 = buffer.u_positionVec2Vector[1];
    float2 param_15_1 = buffer.u_pivotVec2Vector[1];
    float2 param_16_1 = buffer.u_scaleVec2Vector[1];
    float2 param_17 = param_12_1;
    float param_18 = param_13_1;
    float2 param_19 = param_14_1;
    float2 param_20 = param_15_1;
    float2 param_21 = param_16_1;
    float2 _395 = _f0(param_17, param_18, param_19, param_20, param_21, buffer.u_ScreenParams);
    param_12_1 = param_17;
    float2 _384 = _395;
    float2 param_17_1 = in.v_uv;
    float param_18_1 = (buffer.u_rotationFloatVector[2] * 3.141592502593994140625) / 180.0;
    float2 param_19_1 = buffer.u_positionVec2Vector[2];
    float2 param_20_1 = buffer.u_pivotVec2Vector[2];
    float2 param_21_1 = buffer.u_scaleVec2Vector[2];
    float2 param_22 = param_17_1;
    float param_23 = param_18_1;
    float2 param_24 = param_19_1;
    float2 param_25 = param_20_1;
    float2 param_26 = param_21_1;
    float2 _425 = _f0(param_22, param_23, param_24, param_25, param_26, buffer.u_ScreenParams);
    param_17_1 = param_22;
    float2 _414 = _425;
    float2 param_22_1 = in.v_uv;
    float param_23_1 = (buffer.u_rotationFloatVector[3] * 3.141592502593994140625) / 180.0;
    float2 param_24_1 = buffer.u_positionVec2Vector[3];
    float2 param_25_1 = buffer.u_pivotVec2Vector[3];
    float2 param_26_1 = buffer.u_scaleVec2Vector[3];
    float2 param_27 = param_22_1;
    float param_28 = param_23_1;
    float2 param_29 = param_24_1;
    float2 param_30 = param_25_1;
    float2 param_31 = param_26_1;
    float2 _455 = _f0(param_27, param_28, param_29, param_30, param_31, buffer.u_ScreenParams);
    param_22_1 = param_27;
    float2 _444 = _455;
    float2 param_27_1 = in.v_uv;
    float param_28_1 = (buffer.u_rotationFloatVector[4] * 3.141592502593994140625) / 180.0;
    float2 param_29_1 = buffer.u_positionVec2Vector[4];
    float2 param_30_1 = buffer.u_pivotVec2Vector[4];
    float2 param_31_1 = buffer.u_scaleVec2Vector[4];
    float2 param_32 = param_27_1;
    float param_33 = param_28_1;
    float2 param_34 = param_29_1;
    float2 param_35 = param_30_1;
    float2 param_36 = param_31_1;
    float2 _485 = _f0(param_32, param_33, param_34, param_35, param_36, buffer.u_ScreenParams);
    param_27_1 = param_32;
    float2 _474 = _485;
    float2 param_32_1 = in.v_uv;
    float param_33_1 = (buffer.u_rotationFloatVector[5] * 3.141592502593994140625) / 180.0;
    float2 param_34_1 = buffer.u_positionVec2Vector[5];
    float2 param_35_1 = buffer.u_pivotVec2Vector[5];
    float2 param_36_1 = buffer.u_scaleVec2Vector[5];
    float2 param_37 = param_32_1;
    float param_38 = param_33_1;
    float2 param_39 = param_34_1;
    float2 param_40 = param_35_1;
    float2 param_41 = param_36_1;
    float2 _515 = _f0(param_37, param_38, param_39, param_40, param_41, buffer.u_ScreenParams);
    param_32_1 = param_37;
    float2 _504 = _515;
    float _517 = fast::max(buffer.u_minSamples, 2.0);
    float _521 = floor(_517 + ((fast::max(buffer.u_maxSamples, _517) - _517) * smoothstep(0.0, 0.20000000298023223876953125, length(_504 - _355))));
    float4 _t14 = float4(0.0);
    for (float _t15 = 0.0; _t15 <= 256.0; _t15 += 1.0)
    {
        if (_t15 >= _521)
        {
            break;
        }
        float _t16 = _t15 / (_521 - 1.0);
        float param_37_1 = _t15 + in.v_uv.x;
        float param_38_1 = _t15 * in.v_uv.y;
        float _570 = _t16;
        float param_42 = param_37_1;
        float param_43 = param_38_1;
        float _572 = _570 + ((buffer.u_dither * (_f4(param_42, param_43) - 0.5)) / _521);
        _t16 = _572;
        float param_39_1 = _572;
        float2 param_40_1 = _355;
        float2 param_41_1 = _384;
        float2 param_42_1 = _414;
        float2 param_43_1 = _444;
        float2 param_44 = _474;
        float2 param_45 = _504;
        float param_46 = param_39_1;
        float2 param_47 = param_40_1;
        float2 param_48 = param_41_1;
        float2 param_49 = param_42_1;
        float2 param_50 = param_43_1;
        float2 param_51 = param_44;
        float2 param_52 = param_45;
        float2 _601 = _f3(param_46, param_47, param_48, param_49, param_50, param_51, param_52);
        float _617 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_46_1 = _601;
        float2 param_53 = param_46_1;
        float2 _622 = (_601 * _617) + (_f1(param_53) * (1.0 - _617));
        float2 param_47_1 = _622;
        float2 param_54 = param_47_1;
        _t14 += (tDiffuse.sample(tDiffuseSmplr, _622) * _f2(param_54));
    }
    float4 _646 = _t14;
    float4 _648 = _646 / float4(_521);
    _t14 = _648;
    out.gl_FragColor = mix(originalColor, _648, float4(buffer.u_intensity));
    return out;
}

