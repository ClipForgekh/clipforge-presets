#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int u_frag_num;
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
float4 _f0(thread const float4& _p0, thread const float4& _p1)
{
    return _p1 + (_p0 * (1.0 - _p1.w));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_fragmentTexture_1 [[texture(0)]], texture2d<float> u_fragmentTexture_2 [[texture(1)]], texture2d<float> u_fragmentTexture_3 [[texture(2)]], texture2d<float> u_fragmentTexture_4 [[texture(3)]], texture2d<float> u_fragmentTexture_5 [[texture(4)]], texture2d<float> u_fragmentTexture_6 [[texture(5)]], texture2d<float> u_fragmentTexture_7 [[texture(6)]], texture2d<float> u_fragmentTexture_8 [[texture(7)]], texture2d<float> u_fragmentTexture_9 [[texture(8)]], texture2d<float> u_fragmentTexture_10 [[texture(9)]], texture2d<float> u_fragmentTexture_11 [[texture(10)]], texture2d<float> u_fragmentTexture_12 [[texture(11)]], texture2d<float> u_fragmentTexture_13 [[texture(12)]], texture2d<float> u_fragmentTexture_14 [[texture(13)]], texture2d<float> u_fragmentTexture_15 [[texture(14)]], sampler u_fragmentTexture_1Smplr [[sampler(0)]], sampler u_fragmentTexture_2Smplr [[sampler(1)]], sampler u_fragmentTexture_3Smplr [[sampler(2)]], sampler u_fragmentTexture_4Smplr [[sampler(3)]], sampler u_fragmentTexture_5Smplr [[sampler(4)]], sampler u_fragmentTexture_6Smplr [[sampler(5)]], sampler u_fragmentTexture_7Smplr [[sampler(6)]], sampler u_fragmentTexture_8Smplr [[sampler(7)]], sampler u_fragmentTexture_9Smplr [[sampler(8)]], sampler u_fragmentTexture_10Smplr [[sampler(9)]], sampler u_fragmentTexture_11Smplr [[sampler(10)]], sampler u_fragmentTexture_12Smplr [[sampler(11)]], sampler u_fragmentTexture_13Smplr [[sampler(12)]], sampler u_fragmentTexture_14Smplr [[sampler(13)]], sampler u_fragmentTexture_15Smplr [[sampler(14)]])
{
    main0_out out = {};
    float4 _t0 = float4(0.0);
    if (buffer.u_frag_num >= 1)
    {
        float4 _49 = u_fragmentTexture_1.sample(u_fragmentTexture_1Smplr, in.v_uv);
        float4 _t1 = _49;
        float4 param = _t0;
        float4 param_1 = float4(_49.xyz * _t1.w, _t1.w);
        _t0 = _f0(param, param_1);
    }
    if (buffer.u_frag_num >= 2)
    {
        float4 _75 = u_fragmentTexture_2.sample(u_fragmentTexture_2Smplr, in.v_uv);
        float4 _t2 = _75;
        float4 param_2 = _t0;
        float4 param_3 = float4(_75.xyz * _t2.w, _t2.w);
        _t0 = _f0(param_2, param_3);
    }
    if (buffer.u_frag_num >= 3)
    {
        float4 _100 = u_fragmentTexture_3.sample(u_fragmentTexture_3Smplr, in.v_uv);
        float4 _t3 = _100;
        float4 param_4 = _t0;
        float4 param_5 = float4(_100.xyz * _t3.w, _t3.w);
        _t0 = _f0(param_4, param_5);
    }
    if (buffer.u_frag_num >= 4)
    {
        float4 _125 = u_fragmentTexture_4.sample(u_fragmentTexture_4Smplr, in.v_uv);
        float4 _t4 = _125;
        float4 param_6 = _t0;
        float4 param_7 = float4(_125.xyz * _t4.w, _t4.w);
        _t0 = _f0(param_6, param_7);
    }
    if (buffer.u_frag_num >= 5)
    {
        float4 _150 = u_fragmentTexture_5.sample(u_fragmentTexture_5Smplr, in.v_uv);
        float4 _t5 = _150;
        float4 param_8 = _t0;
        float4 param_9 = float4(_150.xyz * _t5.w, _t5.w);
        _t0 = _f0(param_8, param_9);
    }
    if (buffer.u_frag_num >= 6)
    {
        float4 _175 = u_fragmentTexture_6.sample(u_fragmentTexture_6Smplr, in.v_uv);
        float4 _t6 = _175;
        float4 param_10 = _t0;
        float4 param_11 = float4(_175.xyz * _t6.w, _t6.w);
        _t0 = _f0(param_10, param_11);
    }
    if (buffer.u_frag_num >= 7)
    {
        float4 _200 = u_fragmentTexture_7.sample(u_fragmentTexture_7Smplr, in.v_uv);
        float4 _t7 = _200;
        float4 param_12 = _t0;
        float4 param_13 = float4(_200.xyz * _t7.w, _t7.w);
        _t0 = _f0(param_12, param_13);
    }
    if (buffer.u_frag_num >= 8)
    {
        float4 _225 = u_fragmentTexture_8.sample(u_fragmentTexture_8Smplr, in.v_uv);
        float4 _t8 = _225;
        float4 param_14 = _t0;
        float4 param_15 = float4(_225.xyz * _t8.w, _t8.w);
        _t0 = _f0(param_14, param_15);
    }
    if (buffer.u_frag_num >= 9)
    {
        float4 _250 = u_fragmentTexture_9.sample(u_fragmentTexture_9Smplr, in.v_uv);
        float4 _t9 = _250;
        float4 param_16 = _t0;
        float4 param_17 = float4(_250.xyz * _t9.w, _t9.w);
        _t0 = _f0(param_16, param_17);
    }
    if (buffer.u_frag_num >= 10)
    {
        float4 _275 = u_fragmentTexture_10.sample(u_fragmentTexture_10Smplr, in.v_uv);
        float4 _t10 = _275;
        float4 param_18 = _t0;
        float4 param_19 = float4(_275.xyz * _t10.w, _t10.w);
        _t0 = _f0(param_18, param_19);
    }
    if (buffer.u_frag_num >= 11)
    {
        float4 _300 = u_fragmentTexture_11.sample(u_fragmentTexture_11Smplr, in.v_uv);
        float4 _t11 = _300;
        float4 param_20 = _t0;
        float4 param_21 = float4(_300.xyz * _t11.w, _t11.w);
        _t0 = _f0(param_20, param_21);
    }
    if (buffer.u_frag_num >= 12)
    {
        float4 _325 = u_fragmentTexture_12.sample(u_fragmentTexture_12Smplr, in.v_uv);
        float4 _t12 = _325;
        float4 param_22 = _t0;
        float4 param_23 = float4(_325.xyz * _t12.w, _t12.w);
        _t0 = _f0(param_22, param_23);
    }
    if (buffer.u_frag_num >= 13)
    {
        float4 _350 = u_fragmentTexture_13.sample(u_fragmentTexture_13Smplr, in.v_uv);
        float4 _t13 = _350;
        float4 param_24 = _t0;
        float4 param_25 = float4(_350.xyz * _t13.w, _t13.w);
        _t0 = _f0(param_24, param_25);
    }
    if (buffer.u_frag_num >= 14)
    {
        float4 _375 = u_fragmentTexture_14.sample(u_fragmentTexture_14Smplr, in.v_uv);
        float4 _t14 = _375;
        float4 param_26 = _t0;
        float4 param_27 = float4(_375.xyz * _t14.w, _t14.w);
        _t0 = _f0(param_26, param_27);
    }
    if (buffer.u_frag_num >= 15)
    {
        float4 _400 = u_fragmentTexture_15.sample(u_fragmentTexture_15Smplr, in.v_uv);
        float4 _t15 = _400;
        float4 param_28 = _t0;
        float4 param_29 = float4(_400.xyz * _t15.w, _t15.w);
        _t0 = _f0(param_28, param_29);
    }
    out.o_fragColor = _t0;
    return out;
}

