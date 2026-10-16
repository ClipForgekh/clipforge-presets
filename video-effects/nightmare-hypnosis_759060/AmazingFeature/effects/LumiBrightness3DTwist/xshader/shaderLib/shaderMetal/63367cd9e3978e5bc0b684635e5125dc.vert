#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float u_instanceNumber;
    int u_twistAxis;
    float u_twistAngle;
    float4x4 u_MVP;
};

struct main0_out
{
    float2 v_uv [[user(locn0)]];
    float4 screenPos [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float2 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

static inline __attribute__((always_inline))
float _f0(thread const float3& _p0)
{
    return ((_p0.x * 0.2989999949932098388671875) + (_p0.y * 0.58700001239776611328125)) + (_p0.z * 0.114000000059604644775390625);
}

static inline __attribute__((always_inline))
float2 _f1(thread const float& _p0, thread const float2& _p1)
{
    float _46 = (_p0 * 3.141592502593994140625) / 180.0;
    float _51 = cos(_46);
    float _53 = sin(_46);
    return _p1 * float2x2(float2(_51, -_53), float2(_53, _51));
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]], uint gl_InstanceID [[instance_id]])
{
    main0_out out = {};
    float _86 = 1.0 / buffer.u_instanceNumber;
    float2 _98 = in.a_texcoord0 * float2(_86, 1.0);
    float _114 = (float(gl_InstanceID) - (buffer.u_instanceNumber / 2.0)) + 0.5;
    out.v_uv = ((_98 + float2(1.0)) / float2(2.0)) + float2(_86 * _114, 0.0);
    float3 param = u_inputTexture.sample(u_inputTextureSmplr, out.v_uv, level(0.0)).xyz;
    float2 _t9 = in.a_position;
    _t9.x = (_114 * _86) * 2.0;
    float3 _t12 = float3(_t9 + _98, 0.0);
    float _163 = buffer.u_ScreenParams.y / buffer.u_ScreenParams.x;
    bool _166 = _163 > 1.0;
    if (_166)
    {
        _t12.x /= _163;
    }
    else
    {
        _t12.y /= _163;
    }
    bool _184 = buffer.u_twistAxis == 0;
    if (_184)
    {
        float param_1 = 0.0;
        float2 param_2 = _t12.xy;
        float2 _191 = _f1(param_1, param_2);
        _t12.x = _191.x;
        _t12.y = _191.y;
    }
    else
    {
        if (buffer.u_twistAxis == 1)
        {
            float param_3 = 90.0;
            float2 param_4 = _t12.xy;
            float2 _207 = _f1(param_3, param_4);
            _t12.x = _207.x;
            _t12.y = _207.y;
        }
        else
        {
            if (buffer.u_twistAxis == 2)
            {
                float param_5 = 90.0;
                float2 param_6 = _t12.yz;
                float2 _222 = _f1(param_5, param_6);
                _t12.y = _222.x;
                _t12.z = _222.y;
                float param_7 = -90.0;
                float2 param_8 = _t12.xy;
                float2 _232 = _f1(param_7, param_8);
                _t12.x = _232.x;
                _t12.y = _232.y;
            }
            else
            {
                if (buffer.u_twistAxis == 3)
                {
                    float param_9 = 45.0;
                    float2 param_10 = _t12.xy;
                    float2 _248 = _f1(param_9, param_10);
                    _t12.x = _248.x;
                    _t12.y = _248.y;
                }
                else
                {
                    if (buffer.u_twistAxis == 4)
                    {
                        float param_11 = 45.0;
                        float2 param_12 = _t12.xz;
                        float2 _263 = _f1(param_11, param_12);
                        _t12.x = _263.x;
                        _t12.z = _263.y;
                    }
                    else
                    {
                        if (buffer.u_twistAxis == 5)
                        {
                            float param_13 = 90.0;
                            float2 param_14 = _t12.xy;
                            float2 _278 = _f1(param_13, param_14);
                            _t12.x = _278.x;
                            _t12.y = _278.y;
                            float param_15 = 45.0;
                            float2 param_16 = _t12.xz;
                            float2 _287 = _f1(param_15, param_16);
                            _t12.x = _287.x;
                            _t12.z = _287.y;
                        }
                        else
                        {
                            if (buffer.u_twistAxis == 6)
                            {
                                float param_17 = 45.0;
                                float2 param_18 = _t12.xy;
                                float2 _302 = _f1(param_17, param_18);
                                _t12.x = _302.x;
                                _t12.y = _302.y;
                                float param_19 = 45.0;
                                float2 param_20 = _t12.xz;
                                float2 _311 = _f1(param_19, param_20);
                                _t12.x = _311.x;
                                _t12.z = _311.y;
                            }
                        }
                    }
                }
            }
        }
    }
    float2 _321 = float2(_t12.yz);
    float2 _t14 = _321;
    float param_21 = buffer.u_twistAngle * (1.0 - _f0(param));
    float2 param_22 = _321;
    _t14 = _f1(param_21, param_22);
    _t12 = float3(_t12.x, _t14.x, _t14.y);
    if (_184)
    {
        float param_23 = -0.0;
        float2 param_24 = _t12.xy;
        float2 _347 = _f1(param_23, param_24);
        _t12.x = _347.x;
        _t12.y = _347.y;
    }
    else
    {
        if (buffer.u_twistAxis == 1)
        {
            float param_25 = -90.0;
            float2 param_26 = _t12.xy;
            float2 _361 = _f1(param_25, param_26);
            _t12.x = _361.x;
            _t12.y = _361.y;
        }
        else
        {
            if (buffer.u_twistAxis == 2)
            {
                float param_27 = 90.0;
                float2 param_28 = _t12.xy;
                float2 _375 = _f1(param_27, param_28);
                _t12.x = _375.x;
                _t12.y = _375.y;
                float param_29 = -90.0;
                float2 param_30 = _t12.yz;
                float2 _384 = _f1(param_29, param_30);
                _t12.y = _384.x;
                _t12.z = _384.y;
            }
            else
            {
                if (buffer.u_twistAxis == 3)
                {
                    float param_31 = -45.0;
                    float2 param_32 = _t12.xy;
                    float2 _399 = _f1(param_31, param_32);
                    _t12.x = _399.x;
                    _t12.y = _399.y;
                }
                else
                {
                    if (buffer.u_twistAxis == 4)
                    {
                        float param_33 = -45.0;
                        float2 param_34 = _t12.xz;
                        float2 _413 = _f1(param_33, param_34);
                        _t12.x = _413.x;
                        _t12.z = _413.y;
                    }
                    else
                    {
                        if (buffer.u_twistAxis == 5)
                        {
                            float param_35 = -45.0;
                            float2 param_36 = _t12.xz;
                            float2 _427 = _f1(param_35, param_36);
                            _t12.x = _427.x;
                            _t12.z = _427.y;
                            float param_37 = -90.0;
                            float2 param_38 = _t12.xy;
                            float2 _436 = _f1(param_37, param_38);
                            _t12.x = _436.x;
                            _t12.y = _436.y;
                        }
                        else
                        {
                            if (buffer.u_twistAxis == 6)
                            {
                                float param_39 = -45.0;
                                float2 param_40 = _t12.xz;
                                float2 _450 = _f1(param_39, param_40);
                                _t12.x = _450.x;
                                _t12.z = _450.y;
                                float param_41 = -45.0;
                                float2 param_42 = _t12.xy;
                                float2 _459 = _f1(param_41, param_42);
                                _t12.x = _459.x;
                                _t12.y = _459.y;
                            }
                        }
                    }
                }
            }
        }
    }
    if (_166)
    {
        _t12.x *= _163;
    }
    else
    {
        _t12.y *= _163;
    }
    float4 _493 = buffer.u_MVP * float4(_t12.xy, _t12.z * 6.0, 1.0);
    float4 _t15 = _493;
    out.gl_Position = _493;
    out.screenPos = float4(in.a_position, _t15.z, 1.0);
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

