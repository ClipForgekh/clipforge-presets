#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maskTexFlag;
    float frameNums;
    float softEdge;
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
float _f0(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    return step(_p0, _p2) * step(_p1, _p0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> maskTexture [[texture(0)]], texture2d<float> inputImageTexture1 [[texture(1)]], texture2d<float> inputImageTexture2 [[texture(2)]], texture2d<float> inputImageTexture3 [[texture(3)]], texture2d<float> inputImageTexture4 [[texture(4)]], texture2d<float> inputImageTexture5 [[texture(5)]], texture2d<float> inputImageTexture6 [[texture(6)]], texture2d<float> inputImageTexture7 [[texture(7)]], texture2d<float> inputImageTexture8 [[texture(8)]], texture2d<float> inputImageTexture9 [[texture(9)]], texture2d<float> inputImageTexture10 [[texture(10)]], texture2d<float> inputImageTexture11 [[texture(11)]], texture2d<float> inputImageTexture12 [[texture(12)]], texture2d<float> inputImageTexture13 [[texture(13)]], texture2d<float> inputImageTexture14 [[texture(14)]], texture2d<float> inputImageTexture15 [[texture(15)]], sampler maskTextureSmplr [[sampler(0)]], sampler inputImageTexture1Smplr [[sampler(1)]], sampler inputImageTexture2Smplr [[sampler(2)]], sampler inputImageTexture3Smplr [[sampler(3)]], sampler inputImageTexture4Smplr [[sampler(4)]], sampler inputImageTexture5Smplr [[sampler(5)]], sampler inputImageTexture6Smplr [[sampler(6)]], sampler inputImageTexture7Smplr [[sampler(7)]], sampler inputImageTexture8Smplr [[sampler(8)]], sampler inputImageTexture9Smplr [[sampler(9)]], sampler inputImageTexture10Smplr [[sampler(10)]], sampler inputImageTexture11Smplr [[sampler(11)]], sampler inputImageTexture12Smplr [[sampler(12)]], sampler inputImageTexture13Smplr [[sampler(13)]], sampler inputImageTexture14Smplr [[sampler(14)]], sampler inputImageTexture15Smplr [[sampler(15)]])
{
    main0_out out = {};
    float4 _35 = maskTexture.sample(maskTextureSmplr, in.v_uv);
    float4 _63 = inputImageTexture1.sample(inputImageTexture1Smplr, in.v_uv);
    float4 _68 = inputImageTexture2.sample(inputImageTexture2Smplr, in.v_uv);
    float4 _73 = inputImageTexture3.sample(inputImageTexture3Smplr, in.v_uv);
    float4 _78 = inputImageTexture4.sample(inputImageTexture4Smplr, in.v_uv);
    float4 _83 = inputImageTexture5.sample(inputImageTexture5Smplr, in.v_uv);
    float4 _88 = inputImageTexture6.sample(inputImageTexture6Smplr, in.v_uv);
    float4 _93 = inputImageTexture7.sample(inputImageTexture7Smplr, in.v_uv);
    float4 _98 = inputImageTexture8.sample(inputImageTexture8Smplr, in.v_uv);
    float4 _103 = inputImageTexture9.sample(inputImageTexture9Smplr, in.v_uv);
    float4 _108 = inputImageTexture10.sample(inputImageTexture10Smplr, in.v_uv);
    float4 _113 = inputImageTexture11.sample(inputImageTexture11Smplr, in.v_uv);
    float4 _118 = inputImageTexture12.sample(inputImageTexture12Smplr, in.v_uv);
    float4 _123 = inputImageTexture13.sample(inputImageTexture13Smplr, in.v_uv);
    float4 _128 = inputImageTexture14.sample(inputImageTexture14Smplr, in.v_uv);
    float4 _133 = inputImageTexture15.sample(inputImageTexture15Smplr, in.v_uv);
    float _138 = (1.0 - ((dot(_35.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)) * step(0.5, buffer.maskTexFlag)) + (step(buffer.maskTexFlag, 0.5) * 1.0))) * buffer.frameNums;
    float _141 = step(_138, 1.0);
    float _t18 = _141;
    float _145 = step(_138, 2.0);
    float _t19 = _145 * (1.0 - _141);
    float _153 = step(_138, 3.0);
    float _t20 = _153 * (1.0 - _145);
    float _161 = step(_138, 4.0);
    float _t21 = _161 * (1.0 - _153);
    float _169 = step(_138, 5.0);
    float _t22 = _169 * (1.0 - _161);
    float _177 = step(_138, 6.0);
    float _t23 = _177 * (1.0 - _169);
    float _185 = step(_138, 7.0);
    float _t24 = _185 * (1.0 - _177);
    float _193 = step(_138, 8.0);
    float _t25 = _193 * (1.0 - _185);
    float _201 = step(_138, 9.0);
    float _t26 = _201 * (1.0 - _193);
    float _209 = step(_138, 10.0);
    float _t27 = _209 * (1.0 - _201);
    float _217 = step(_138, 11.0);
    float _t28 = _217 * (1.0 - _209);
    float _225 = step(_138, 12.0);
    float _t29 = _225 * (1.0 - _217);
    float _233 = step(_138, 13.0);
    float _t30 = _233 * (1.0 - _225);
    float _241 = step(_138, 14.0);
    float _t31 = _241 * (1.0 - _233);
    float _t32 = 1.0 - _241;
    if (buffer.softEdge > 0.5)
    {
        float param = _138;
        float param_1 = 0.0;
        float param_2 = 1.0;
        float _264 = abs(_138 - 1.0);
        float param_3 = _138;
        float param_4 = 0.0;
        float param_5 = 2.0;
        _t18 = (_f0(param, param_1, param_2) * _264) + (_f0(param_3, param_4, param_5) * (1.0 - _264));
        float param_6 = _138;
        float param_7 = 1.0;
        float param_8 = 3.0;
        _t19 = _f0(param_6, param_7, param_8) * (1.0 - abs(_138 - 2.0));
        float param_9 = _138;
        float param_10 = 2.0;
        float param_11 = 4.0;
        _t20 = _f0(param_9, param_10, param_11) * (1.0 - abs(_138 - 3.0));
        float param_12 = _138;
        float param_13 = 3.0;
        float param_14 = 5.0;
        _t21 = _f0(param_12, param_13, param_14) * (1.0 - abs(_138 - 4.0));
        float param_15 = _138;
        float param_16 = 4.0;
        float param_17 = 6.0;
        _t22 = _f0(param_15, param_16, param_17) * (1.0 - abs(_138 - 5.0));
        float param_18 = _138;
        float param_19 = 5.0;
        float param_20 = 7.0;
        _t23 = _f0(param_18, param_19, param_20) * (1.0 - abs(_138 - 6.0));
        float param_21 = _138;
        float param_22 = 6.0;
        float param_23 = 8.0;
        _t24 = _f0(param_21, param_22, param_23) * (1.0 - abs(_138 - 7.0));
        float param_24 = _138;
        float param_25 = 7.0;
        float param_26 = 9.0;
        _t25 = _f0(param_24, param_25, param_26) * (1.0 - abs(_138 - 8.0));
        float param_27 = _138;
        float param_28 = 8.0;
        float param_29 = 10.0;
        _t26 = _f0(param_27, param_28, param_29) * (1.0 - abs(_138 - 9.0));
        float param_30 = _138;
        float param_31 = 9.0;
        float param_32 = 11.0;
        _t27 = _f0(param_30, param_31, param_32) * (1.0 - abs(_138 - 10.0));
        float param_33 = _138;
        float param_34 = 10.0;
        float param_35 = 12.0;
        _t28 = _f0(param_33, param_34, param_35) * (1.0 - abs(_138 - 11.0));
        float param_36 = _138;
        float param_37 = 11.0;
        float param_38 = 13.0;
        _t29 = _f0(param_36, param_37, param_38) * (1.0 - abs(_138 - 12.0));
        float param_39 = _138;
        float param_40 = 12.0;
        float param_41 = 14.0;
        _t30 = _f0(param_39, param_40, param_41) * (1.0 - abs(_138 - 13.0));
        float param_42 = _138;
        float param_43 = 13.0;
        float param_44 = 15.0;
        _t31 = _f0(param_42, param_43, param_44) * (1.0 - abs(_138 - 14.0));
        float param_45 = _138;
        float param_46 = 14.0;
        float param_47 = 15.0;
        _t32 = (_f0(param_45, param_46, param_47) * (1.0 - abs(_138 - 15.0))) + ((1.0 - step(_138, 15.0)) * 1.0);
    }
    out.o_fragColor = ((((((((((((((_63 * _t18) + (_68 * _t19)) + (_73 * _t20)) + (_78 * _t21)) + (_83 * _t22)) + (_88 * _t23)) + (_93 * _t24)) + (_98 * _t25)) + (_103 * _t26)) + (_108 * _t27)) + (_113 * _t28)) + (_118 * _t29)) + (_123 * _t30)) + (_128 * _t31)) + (_133 * _t32);
    return out;
}

