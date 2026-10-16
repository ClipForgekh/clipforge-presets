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
    float u_frqW;
    float u_phaseR;
    float u_phaseG;
    float u_phaseB;
    float u_ampW;
    float u_frqR;
    float u_seed;
    float u_ampRL;
    float u_ampRC;
    float u_brightness;
    float u_time;
    float u_ampR;
    float u_ampG;
    float u_ampB;
    float u_amp0;
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
float3 _f0(thread const float4& _p0)
{
    if (_p0.w <= 0.001000000047497451305389404296875)
    {
        return float3(0.0);
    }
    return _p0.xyz / float3(_p0.w);
}

static inline __attribute__((always_inline))
float3 _f1(thread const float& _p0, constant float& u_frqW, constant float& u_phaseR, constant float& u_phaseG, constant float& u_phaseB, constant float& u_ampW)
{
    return float3(cos(((_p0 * u_frqW) + u_phaseR) * 6.283185482025146484375), cos(((_p0 * u_frqW) + u_phaseG) * 6.283185482025146484375), cos(((_p0 * u_frqW) + u_phaseB) * 6.283185482025146484375)) * u_ampW;
}

static inline __attribute__((always_inline))
float3 _f2(thread float& _p0, constant float& u_frqR, constant float& u_seed, constant float& u_ampRL, constant float& u_ampRC)
{
    _p0 *= u_frqR;
    float _90 = mod(u_seed, 0.23000000417232513427734375);
    float _107 = mod(u_seed, 0.4699999988079071044921875);
    float _119 = mod(u_seed, 0.829999983310699462890625);
    float _136 = mod(u_seed, 3.0899999141693115234375);
    float _169 = mod(u_seed, 0.569999992847442626953125);
    float _185 = mod(u_seed, 1.87000000476837158203125);
    float _200 = mod(u_seed, 2.71000003814697265625);
    float3 _328 = float3((((0.0 + (sin((_p0 + _90) * 6.283185482025146484375) * 0.4000000059604644775390625)) + (sin(((_p0 * (1.730000019073486328125 + mod(u_seed, 0.2700000107288360595703125))) + _107) * 6.283185482025146484375) * 0.300000011920928955078125)) + (cos(((_p0 * (3.1700000762939453125 + _119)) + mod(u_seed, 1.16999995708465576171875)) * 6.283185482025146484375) * 0.20000000298023223876953125)) + (cos(((_p0 * (5.909999847412109375 + _136)) + mod(u_seed, 1.71000003814697265625)) * 6.283185482025146484375) * 0.100000001490116119384765625), (((0.0 + (cos((_p0 + mod(u_seed, 0.20999999344348907470703125)) * 6.283185482025146484375) * 0.4000000059604644775390625)) + (cos(((_p0 * (1.5299999713897705078125 + mod(u_seed, 0.17000000178813934326171875))) + _169) * 6.283185482025146484375) * 0.300000011920928955078125)) + (cos(((_p0 * (3.5699999332427978515625 + mod(u_seed, 0.730000019073486328125))) + _185) * 6.283185482025146484375) * 0.20000000298023223876953125)) + (sin(((_p0 * (5.110000133514404296875 + _136)) + _200) * 6.283185482025146484375) * 0.100000001490116119384765625), (((0.0 + (cos((_p0 + mod(u_seed, 0.20000000298023223876953125)) * 6.283185482025146484375) * 0.4000000059604644775390625)) + (cos(((_p0 * (0.9700000286102294921875 + _169)) + mod(u_seed, 1.4700000286102294921875)) * 6.283185482025146484375) * 0.300000011920928955078125)) + (sin(((_p0 * (2.1700000762939453125 + mod(u_seed, 1.33000004291534423828125))) + _185) * 6.283185482025146484375) * 0.20000000298023223876953125)) + (cos(((_p0 * (3.9100000858306884765625 + mod(u_seed, 2.0899999141693115234375))) + _200) * 6.283185482025146484375) * 0.100000001490116119384765625)) * u_ampRC;
    return (float3((((0.0 + (sin((_p0 + _90) * 6.283185482025146484375) * 0.4000000059604644775390625)) + (sin(((_p0 * (2.0299999713897705078125 + mod(u_seed, 0.100000001490116119384765625))) + mod(u_seed, 0.87000000476837158203125)) * 6.283185482025146484375) * 0.300000011920928955078125)) + (cos(((_p0 * (4.0 + _119)) + _107) * 6.283185482025146484375) * 0.20000000298023223876953125)) + (sin(((_p0 * (4.909999847412109375 + mod(u_seed, 4.090000152587890625))) + mod(u_seed, 0.709999978542327880859375)) * 6.283185482025146484375) * 0.100000001490116119384765625)) * u_ampRL) + _328;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _342 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t7 = _342;
    float4 param = _342;
    float3 _347 = _f0(param);
    float3 _t8 = _347;
    float param_1 = buffer.u_time;
    float param_2 = buffer.u_time;
    float3 _358 = _f2(param_2, buffer.u_frqR, buffer.u_seed, buffer.u_ampRL, buffer.u_ampRC);
    float3 _360 = _t8;
    float3 _378 = fast::clamp((_347 * buffer.u_brightness) + ((_f1(param_1, buffer.u_frqW, buffer.u_phaseR, buffer.u_phaseG, buffer.u_phaseB, buffer.u_ampW) + _358) * ((_360 * float3(buffer.u_ampR, buffer.u_ampG, buffer.u_ampB)) * buffer.u_amp0)), float3(0.0), float3(1.0));
    _t8 = _378;
    float _385 = _t7.w;
    float4 _386 = float4(_378, 1.0) * _385;
    _t7 = _386;
    out.o_fragColor = _386;
    return out;
}

