#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maskTexFlag;
    float frameNums;
    float softEdge;
    float u_fadeout;
    float u_isStart;
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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> maskTexture [[texture(0)]], texture2d<float> mergedTexture [[texture(1)]], texture2d<float> inputImageTexture1 [[texture(2)]], texture2d<float> inputImageTexture2 [[texture(3)]], texture2d<float> inputImageTexture3 [[texture(4)]], texture2d<float> inputImageTexture4 [[texture(5)]], texture2d<float> inputImageTexture5 [[texture(6)]], texture2d<float> inputImageTexture6 [[texture(7)]], texture2d<float> inputImageTexture7 [[texture(8)]], texture2d<float> inputImageTexture8 [[texture(9)]], texture2d<float> inputImageTexture9 [[texture(10)]], texture2d<float> inputImageTexture10 [[texture(11)]], texture2d<float> inputImageTexture11 [[texture(12)]], texture2d<float> inputImageTexture12 [[texture(13)]], texture2d<float> inputImageTexture13 [[texture(14)]], texture2d<float> u_inputTex [[texture(15)]], sampler maskTextureSmplr [[sampler(0)]], sampler mergedTextureSmplr [[sampler(1)]], sampler inputImageTexture1Smplr [[sampler(2)]], sampler inputImageTexture2Smplr [[sampler(3)]], sampler inputImageTexture3Smplr [[sampler(4)]], sampler inputImageTexture4Smplr [[sampler(5)]], sampler inputImageTexture5Smplr [[sampler(6)]], sampler inputImageTexture6Smplr [[sampler(7)]], sampler inputImageTexture7Smplr [[sampler(8)]], sampler inputImageTexture8Smplr [[sampler(9)]], sampler inputImageTexture9Smplr [[sampler(10)]], sampler inputImageTexture10Smplr [[sampler(11)]], sampler inputImageTexture11Smplr [[sampler(12)]], sampler inputImageTexture12Smplr [[sampler(13)]], sampler inputImageTexture13Smplr [[sampler(14)]], sampler u_inputTexSmplr [[sampler(15)]])
{
    main0_out out = {};
    float4 _35 = maskTexture.sample(maskTextureSmplr, in.v_uv);
    float _58 = 1.0 - fma(dot(_35.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)), step(0.5, buffer.maskTexFlag), step(buffer.maskTexFlag, 0.5));
    float4 _63 = mergedTexture.sample(mergedTextureSmplr, in.v_uv);
    float4 _68 = inputImageTexture1.sample(inputImageTexture1Smplr, in.v_uv);
    float4 _73 = inputImageTexture2.sample(inputImageTexture2Smplr, in.v_uv);
    float4 _78 = inputImageTexture3.sample(inputImageTexture3Smplr, in.v_uv);
    float4 _83 = inputImageTexture4.sample(inputImageTexture4Smplr, in.v_uv);
    float4 _88 = inputImageTexture5.sample(inputImageTexture5Smplr, in.v_uv);
    float4 _93 = inputImageTexture6.sample(inputImageTexture6Smplr, in.v_uv);
    float4 _98 = inputImageTexture7.sample(inputImageTexture7Smplr, in.v_uv);
    float4 _103 = inputImageTexture8.sample(inputImageTexture8Smplr, in.v_uv);
    float4 _108 = inputImageTexture9.sample(inputImageTexture9Smplr, in.v_uv);
    float4 _113 = inputImageTexture10.sample(inputImageTexture10Smplr, in.v_uv);
    float4 _118 = inputImageTexture11.sample(inputImageTexture11Smplr, in.v_uv);
    float4 _123 = inputImageTexture12.sample(inputImageTexture12Smplr, in.v_uv);
    float4 _128 = inputImageTexture13.sample(inputImageTexture13Smplr, in.v_uv);
    float _133 = _58 * buffer.frameNums;
    float _137 = step(_133, 15.0);
    float _t17 = _137;
    float _141 = step(_133, 16.0);
    float _t18 = _141 * (1.0 - _137);
    float _149 = step(_133, 17.0);
    float _t19 = _149 * (1.0 - _141);
    float _157 = step(_133, 18.0);
    float _t20 = _157 * (1.0 - _149);
    float _165 = step(_133, 19.0);
    float _t21 = _165 * (1.0 - _157);
    float _173 = step(_133, 20.0);
    float _t22 = _173 * (1.0 - _165);
    float _181 = step(_133, 21.0);
    float _t23 = _181 * (1.0 - _173);
    float _189 = step(_133, 22.0);
    float _t24 = _189 * (1.0 - _181);
    float _197 = step(_133, 23.0);
    float _t25 = _197 * (1.0 - _189);
    float _205 = step(_133, 24.0);
    float _t26 = _205 * (1.0 - _197);
    float _213 = step(_133, 25.0);
    float _t27 = _213 * (1.0 - _205);
    float _221 = step(_133, 26.0);
    float _t28 = _221 * (1.0 - _213);
    float _229 = step(_133, 27.0);
    float _t29 = _229 * (1.0 - _221);
    float _t30 = step(_133, 28.0) * (1.0 - _229);
    if (buffer.softEdge > 0.5)
    {
        float param = _133;
        float param_1 = 15.0;
        float param_2 = 16.0;
        _t17 = fma(_f0(param, param_1, param_2), 1.0 - abs(fma(_58, buffer.frameNums, -15.0)), 1.0 - step(15.0, _133));
        float param_3 = _133;
        float param_4 = 15.0;
        float param_5 = 17.0;
        _t18 = _f0(param_3, param_4, param_5) * (1.0 - abs(fma(_58, buffer.frameNums, -16.0)));
        float param_6 = _133;
        float param_7 = 16.0;
        float param_8 = 18.0;
        _t19 = _f0(param_6, param_7, param_8) * (1.0 - abs(fma(_58, buffer.frameNums, -17.0)));
        float param_9 = _133;
        float param_10 = 17.0;
        float param_11 = 19.0;
        _t20 = _f0(param_9, param_10, param_11) * (1.0 - abs(fma(_58, buffer.frameNums, -18.0)));
        float param_12 = _133;
        float param_13 = 18.0;
        float param_14 = 20.0;
        _t21 = _f0(param_12, param_13, param_14) * (1.0 - abs(fma(_58, buffer.frameNums, -19.0)));
        float param_15 = _133;
        float param_16 = 19.0;
        float param_17 = 21.0;
        _t22 = _f0(param_15, param_16, param_17) * (1.0 - abs(fma(_58, buffer.frameNums, -20.0)));
        float param_18 = _133;
        float param_19 = 20.0;
        float param_20 = 22.0;
        _t23 = _f0(param_18, param_19, param_20) * (1.0 - abs(fma(_58, buffer.frameNums, -21.0)));
        float param_21 = _133;
        float param_22 = 21.0;
        float param_23 = 23.0;
        _t24 = _f0(param_21, param_22, param_23) * (1.0 - abs(fma(_58, buffer.frameNums, -22.0)));
        float param_24 = _133;
        float param_25 = 22.0;
        float param_26 = 24.0;
        _t25 = _f0(param_24, param_25, param_26) * (1.0 - abs(fma(_58, buffer.frameNums, -23.0)));
        float param_27 = _133;
        float param_28 = 23.0;
        float param_29 = 25.0;
        _t26 = _f0(param_27, param_28, param_29) * (1.0 - abs(fma(_58, buffer.frameNums, -24.0)));
        float param_30 = _133;
        float param_31 = 24.0;
        float param_32 = 26.0;
        _t27 = _f0(param_30, param_31, param_32) * (1.0 - abs(fma(_58, buffer.frameNums, -25.0)));
        float param_33 = _133;
        float param_34 = 25.0;
        float param_35 = 27.0;
        _t28 = _f0(param_33, param_34, param_35) * (1.0 - abs(fma(_58, buffer.frameNums, -26.0)));
        float param_36 = _133;
        float param_37 = 26.0;
        float param_38 = 28.0;
        _t29 = _f0(param_36, param_37, param_38) * (1.0 - abs(fma(_58, buffer.frameNums, -27.0)));
        float param_39 = _133;
        float param_40 = 27.0;
        float param_41 = 29.0;
        _t30 = _f0(param_39, param_40, param_41) * (1.0 - abs(fma(_58, buffer.frameNums, -28.0)));
        float param_42 = _133;
        float param_43 = 28.0;
        float param_44 = 30.0;
    }
    out.o_fragColor = mix(mix(u_inputTex.sample(u_inputTexSmplr, in.v_uv), (((((((((((((_63 * _t17) + (_68 * _t18)) + (_73 * _t19)) + (_78 * _t20)) + (_83 * _t21)) + (_88 * _t22)) + (_93 * _t23)) + (_98 * _t24)) + (_103 * _t25)) + (_108 * _t26)) + (_113 * _t27)) + (_118 * _t28)) + (_123 * _t29)) + (_128 * _t30), float4(buffer.u_fadeout)), float4(0.0), float4(buffer.u_isStart));
    return out;
}

