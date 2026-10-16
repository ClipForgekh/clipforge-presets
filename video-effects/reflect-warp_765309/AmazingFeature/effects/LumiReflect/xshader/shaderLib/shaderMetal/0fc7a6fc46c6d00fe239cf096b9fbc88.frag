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

// Implementation of the GLSL radians() function
template<typename T>
inline T radians(T d)
{
    return d * T(0.01745329251);
}

struct buffer_t
{
    int u_blurType;
    float u_skew;
    float u_blurAmount;
    float u_blurOffset;
    float u_blurFalloff;
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
float _f3(thread const float& _p0)
{
    return (0.9999847412109375 * exp(((-0.5) * _p0) * _p0)) / 0.99997997283935546875;
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float& _p1)
{
    return ((_p0 - float2(0.5)) * float2x2(float2(1.0, sin(_p1)), float2(0.0, 1.0))) + float2(0.5);
}

static inline __attribute__((always_inline))
float _f0(thread const float2& _p0)
{
    return ((step(0.0, _p0.x) * step(0.0, _p0.y)) * step(_p0.x, 1.0)) * step(_p0.y, 1.0);
}

static inline __attribute__((always_inline))
float2 _f4(thread const float2& _p0, thread const float& _p1)
{
    float _142 = sin(_p1);
    float _145 = cos(_p1);
    return ((_p0 - float2(0.5)) * float2x2(float2(_145, -_142), float2(_142, _145))) + float2(0.5);
}

static inline __attribute__((always_inline))
float _f5(thread const float2& _p0, thread const float& _p1, thread const float& _p2, thread const float& _p3)
{
    float2 param = _p0;
    float param_1 = radians(_p2);
    float2 _t7 = _f4(param, param_1);
    return mix(0.0, 1.0, smoothstep(_p1 - _p3, _p1 + _p3, _t7.y));
}

static inline __attribute__((always_inline))
float2 _f2(thread const float2& _p0, thread const float& _p1, thread const float& _p2)
{
    float2 _t2 = (_p0 - float2(0.5)) * float2x2(float2(1.0, sin(_p1)), float2(0.0, 1.0));
    _t2.y /= _p2;
    float2 _122 = _t2;
    float2 _124 = _122 + float2(0.5);
    _t2 = _124;
    return _124;
}

static inline __attribute__((always_inline))
float4 _f6(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4, thread const float& _p5)
{
    float4 _t8 = float4(0.0);
    float _194 = mix(radians(_p2), 0.0, _p3);
    float _218 = mix(radians(_p2), radians(((sign(_p2) * mix(0.0, 180.0, abs(_p2 / 90.0) * _p3)) + _p2) / 2.0), _p3);
    float _225 = mix(0.5, 1.0, (1.0 - _p4) * (1.0 - _p3));
    float _231 = mix(1.0, 1.5, _p4 * _p3);
    float param = 0.0;
    float _238 = _f3(param);
    float _t15 = _238;
    float _t16 = _238;
    float2 param_1 = _p1;
    float param_2 = radians(_p2);
    float2 param_3 = _p1;
    float param_4 = radians(_p2);
    float2 param_5 = _f1(param_3, param_4);
    float4 _t17 = _p0.sample(_p0Smplr, _f1(param_1, param_2)) * _f0(param_5);
    float2 param_6 = _p1;
    float param_7 = _p5;
    float param_8 = 180.0;
    float param_9 = 0.100000001490116119384765625;
    _t17 *= (1.0 - _f5(param_6, param_7, param_8, param_9));
    for (int _t19 = 1; _t19 <= 72; _t19++)
    {
        if (_p3 == 0.0)
        {
            break;
        }
        float _293 = float(_t19) / 72.0;
        float2 param_10 = _p1;
        float param_11 = mix(_194, _218, _293);
        float param_12 = mix(_225, _231, _293);
        float2 _311 = _f2(param_10, param_11, param_12);
        float param_13 = 1.5 * (((float(_t19) / 72.0) * 2.0) - 1.0);
        _t15 = _f3(param_13);
        float2 param_14 = _311;
        float4 _t24 = _p0.sample(_p0Smplr, _311) * _f0(param_14);
        float2 param_15 = _p1;
        float param_16 = _p5;
        float param_17 = 180.0;
        float param_18 = 0.100000001490116119384765625;
        float4 _337 = _t24;
        float4 _338 = _337 * _f5(param_15, param_16, param_17, param_18);
        _t24 = _338;
        _t8 += ((_338 + _t17) * _t15);
        _t16 += _t15;
    }
    _t8 /= float4(_t16);
    if (_p3 == 0.0)
    {
        float2 param_19 = _p1;
        float param_20 = (_p2 * 3.141592502593994140625) / 180.0;
        float2 _369 = _f1(param_19, param_20);
        float2 param_21 = _369;
        _t8 = _p0.sample(_p0Smplr, _369) * _f0(param_21);
    }
    return fast::clamp(_t8, float4(0.0), float4(1.0));
}

static inline __attribute__((always_inline))
float4 _f7(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4, thread const float& _p5)
{
    float4 _t28 = float4(0.0);
    float _392 = mix(15.0, 90.0, _p4) * (1.0 - _p3);
    float _396 = mix(1.0, 1.2000000476837158203125, _p3);
    float param = 0.0;
    float _399 = _f3(param);
    float _t32 = _399;
    float2 _t33 = _p1 - float2(0.5, 0.0);
    _t33.y /= _396;
    float2 _411 = _t33;
    float2 _412 = _411 + float2(0.5, 0.0);
    _t33 = _412;
    float2 param_1 = _412;
    float param_2 = radians(_p2);
    float2 param_3 = _t33;
    float param_4 = radians(_p2);
    float2 param_5 = _f1(param_3, param_4);
    float4 _t34 = _p0.sample(_p0Smplr, _f1(param_1, param_2)) * _f0(param_5);
    float2 param_6 = _p1;
    float param_7 = _p5;
    float param_8 = 0.0;
    float param_9 = 0.00999999977648258209228515625;
    _t34 *= (1.0 - _f5(param_6, param_7, param_8, param_9));
    for (int _t35 = 1; _t35 <= 72; _t35++)
    {
        if (_t35 >= 72)
        {
            break;
        }
        float _459 = float(_t35) / 72.0;
        float2 param_10 = _p1;
        float param_11 = ((_p2 + mix(-_392, _392, _459)) * 3.141592502593994140625) / 180.0;
        float2 _t38 = _f1(param_10, param_11);
        float param_12 = 4.0 * ((_459 * 2.0) - 1.0);
        float2 _487 = _t38;
        float2 _492 = ((_487 - float2(0.5, 0.0)) / float2(mix(0.0, _396, _f3(param_12)) + 1.0)) + float2(0.5, 0.0);
        _t38 = _492;
        float2 param_13 = _492;
        float4 _t40 = _p0.sample(_p0Smplr, _492) * _f0(param_13);
        float2 param_14 = _p1;
        float param_15 = _p5;
        float param_16 = 0.0;
        float param_17 = 0.00999999977648258209228515625;
        float4 _508 = _t40;
        float4 _509 = _508 * _f5(param_14, param_15, param_16, param_17);
        _t40 = _509;
        _t28 += ((_509 + _t34) * _399);
        _t32 += _399;
    }
    _t28 /= float4(_t32);
    if (_p3 == 0.0)
    {
        float2 param_18 = _p1;
        float param_19 = radians(_p2);
        float2 _536 = _f1(param_18, param_19);
        float2 param_20 = _536;
        _t28 = _p0.sample(_p0Smplr, _536) * _f0(param_20);
    }
    return fast::clamp(_t28, float4(0.0), float4(1.0));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _582 = abs(mod(float2(in.v_uv.x, in.v_uv.y) - float2(1.0, 0.5), float2(2.0, 1.0)) - float2(1.0, 0.5));
    float4 _t45 = u_inputTexture.sample(u_inputTextureSmplr, _582);
    if (buffer.u_blurType == 0)
    {
        float2 param = _582;
        float param_1 = buffer.u_skew;
        float param_2 = buffer.u_blurAmount;
        float param_3 = buffer.u_blurOffset;
        float param_4 = buffer.u_blurFalloff;
        _t45 = _f6(u_inputTexture, u_inputTextureSmplr, param, param_1, param_2, param_3, param_4);
    }
    else
    {
        float2 param_5 = _582;
        float param_6 = buffer.u_skew;
        float param_7 = buffer.u_blurAmount;
        float param_8 = buffer.u_blurOffset;
        float param_9 = buffer.u_blurFalloff;
        _t45 = _f7(u_inputTexture, u_inputTextureSmplr, param_5, param_6, param_7, param_8, param_9);
    }
    out.o_fragColor = float4(_t45);
    return out;
}

