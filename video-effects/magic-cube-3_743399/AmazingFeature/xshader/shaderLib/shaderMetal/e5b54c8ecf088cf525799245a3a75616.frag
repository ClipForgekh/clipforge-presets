#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int u_cubeMidBool;
    float u_timeType;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], texture2d<float> u_inputTexture2 [[texture(1)]], texture2d<float> u_inputTexture3 [[texture(2)]], texture2d<float> u_inputTexture4 [[texture(3)]], sampler u_inputTextureSmplr [[sampler(0)]], sampler u_inputTexture2Smplr [[sampler(1)]], sampler u_inputTexture3Smplr [[sampler(2)]], sampler u_inputTexture4Smplr [[sampler(3)]])
{
    main0_out out = {};
    float4 _23 = u_inputTexture.sample(u_inputTextureSmplr, in.uv0);
    float4 _28 = u_inputTexture2.sample(u_inputTexture2Smplr, in.uv0);
    float4 _t3 = _28;
    float4 _33 = u_inputTexture3.sample(u_inputTexture3Smplr, in.uv0);
    float4 _t4 = _33;
    float4 _38 = u_inputTexture4.sample(u_inputTexture4Smplr, in.uv0);
    float4 _t5 = _38;
    float3 _45 = _28.xyz - float3(0.00999999977648258209228515625);
    _t3.x = _45.x;
    _t3.y = _45.y;
    _t3.z = _45.z;
    float4 _57 = _t3;
    float3 _65 = float3(1.0) - pow(float3(1.0) - _57.xyz, float3(0.2857142984867095947265625));
    _t3.x = _65.x;
    _t3.y = _65.y;
    _t3.z = _65.z;
    float4 _72 = _t3;
    float4 _75 = fast::clamp(_72, float4(0.0), float4(1.0));
    _t3 = _75;
    float4 _t6 = mix(_23, _75, float4(_t3.w));
    float3 _93 = float3(1.0) - pow(float3(1.0) - _33.xyz, float3(2.650000095367431640625));
    _t4.x = _93.x;
    _t4.y = _93.y;
    _t4.z = _93.z;
    _t4 = fast::clamp(_t4, float4(0.0), float4(1.0));
    float3 _112 = float3(1.0) - pow(float3(1.0) - _38.xyz, float3(2.650000095367431640625));
    _t5.x = _112.x;
    _t5.y = _112.y;
    _t5.z = _112.z;
    _t5 = fast::clamp(_t5, float4(0.0), float4(1.0));
    if (buffer.u_cubeMidBool == 1)
    {
        _t6 = _23;
    }
    if ((buffer.u_timeType >= 1.0) && (buffer.u_timeType < 2.0))
    {
        _t6 = mix(mix(_t6, _t4, float4(_t4.w)), _t5, float4(_t5.w));
    }
    else
    {
        if ((buffer.u_timeType >= 2.0) && (buffer.u_timeType < 3.0))
        {
            _t6 = mix(mix(_t5, _t6, float4(_t6.w)), _t4, float4(_t4.w));
        }
        else
        {
            if ((buffer.u_timeType >= 3.0) && (buffer.u_timeType < 4.0))
            {
                _t6 = mix(mix(_t4, _t6, float4(_t6.w)), _t5, float4(_t5.w));
            }
            else
            {
                if ((buffer.u_timeType >= 4.0) && (buffer.u_timeType < 5.0))
                {
                    float4 _207 = _t6;
                    float _209 = _t6.w;
                    float4 _211 = mix(_t5, _207, float4(_209));
                    _t6 = _211;
                    _t6 = mix(_t4, _211, float4(_t6.w));
                }
                else
                {
                    if ((buffer.u_timeType >= 5.0) && (buffer.u_timeType < 6.0))
                    {
                        float4 _228 = _t6;
                        float _230 = _t6.w;
                        float4 _232 = mix(_t4, _228, float4(_230));
                        _t6 = _232;
                        _t6 = mix(_t5, _232, float4(_t6.w));
                    }
                    else
                    {
                        if (buffer.u_timeType < 1.0)
                        {
                            float4 _245 = _t6;
                            float _247 = _t6.w;
                            float4 _249 = mix(_t4, _245, float4(_247));
                            _t6 = _249;
                            _t6 = mix(_t5, _249, float4(_t6.w));
                        }
                        else
                        {
                            _t6 = _23;
                        }
                    }
                }
            }
        }
    }
    out.o_fragColor = _t6;
    return out;
}

