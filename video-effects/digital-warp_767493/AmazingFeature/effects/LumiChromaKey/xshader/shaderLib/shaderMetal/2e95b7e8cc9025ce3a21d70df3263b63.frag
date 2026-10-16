#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_threshold;
    float3 u_keyColor;
    float u_inputShadow;
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
float3 _f2(thread const float3& _p0)
{
    float3 _t3;
    _t3.x = ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
    _t3.y = ((((-0.147108018398284912109375) * _p0.x) + ((-0.2888040244579315185546875) * _p0.y)) + (0.43591201305389404296875 * _p0.z)) + 0.5;
    _t3.z = (((0.61477696895599365234375 * _p0.x) - (0.51479899883270263671875 * _p0.y)) - (0.0999779999256134033203125 * _p0.z)) + 0.5;
    return _t3;
}

static inline __attribute__((always_inline))
float3 _f3(thread const float3& _p0)
{
    float4 _172 = mix(float4(_p0.zy, -1.0, 0.666666686534881591796875), float4(_p0.yz, 0.0, -0.3333333432674407958984375), float4(step(_p0.z, _p0.y)));
    float4 _t5 = _172;
    float4 _t6 = mix(float4(_172.xyw, _p0.x), float4(_p0.x, _172.yzx), float4(step(_t5.x, _p0.x)));
    float _206 = _t6.x - fast::min(_t6.w, _t6.y);
    return float3(abs(_t6.z + ((_t6.w - _t6.y) / ((6.0 * _206) + 1.0000000133514319600180897396058e-10))), _206 / (_t6.x + 1.0000000133514319600180897396058e-10), _t6.x);
}

static inline __attribute__((always_inline))
float3 _f0(thread const float3& _p0)
{
    return float3((cos((_p0.x * 2.0) * 3.1415927410125732421875) * _p0.y) * _p0.z, (sin((_p0.x * 2.0) * 3.1415927410125732421875) * _p0.y) * _p0.z, (_p0.z * 1.7320499420166015625) / 3.0);
}

static inline __attribute__((always_inline))
float _f1(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    return fast::min(exp(_p0 * (_p1 - _p2)), 1.0);
}

static inline __attribute__((always_inline))
float _f4(thread const float4& _p0, thread const float3& _p1, thread const float& _p2, thread const float& _p3)
{
    float _t9 = 0.0;
    float3 param = _p0.xyz;
    float3 _t10 = _f2(param);
    float3 param_1 = _p1;
    float3 _244 = _f2(param_1);
    float3 _t11 = _244;
    float3 _t12 = _244;
    float _259 = fast::clamp(10.0 * (_p2 - 0.0500000007450580596923828125), 0.0, 1.0);
    float _276 = sqrt(((0.5 - _t11.y) * (0.5 - _t11.y)) + ((0.5 - _t11.z) * (0.5 - _t11.z)));
    float _283 = fast::max(1.0, fast::min(10.0, 2.0 / fast::max(0.100000001490116119384765625, _276)));
    _t12.y = ((_t11.y - 0.5) * (1.0 + ((_259 * _p2) * _283))) + 0.5;
    _t12.z = ((_t11.z - 0.5) * (1.0 + ((_259 * _p2) * _283))) + 0.5;
    _t10 = fast::clamp(_t10, float3(0.0), float3(1.0));
    float _316 = sqrt(_p2) * 1.7999999523162841796875;
    float _428 = fast::min(fast::max(_276, 0.0500000007450580596923828125), 0.60000002384185791015625);
    float _466 = fast::max(0.0, ((sqrt(((_t10.y - _t11.y) * (_t10.y - _t11.y)) + ((_t10.z - _t11.z) * (_t10.z - _t11.z))) + sqrt(((_t10.y - _t12.y) * (_t10.y - _t12.y)) + ((_t10.z - _t12.z) * (_t10.z - _t12.z)))) - sqrt(((_t12.y - _t11.y) * (_t12.y - _t11.y)) + ((_t12.z - _t11.z) * (_t12.z - _t11.z)))) - ((_428 * mix(1.0, _428, mix(fast::clamp((_t10.x * 1.0) / fast::max(0.20000000298023223876953125, _t11.x), 0.0, 1.0) * (1.0 - fast::clamp((_276 * _276) * 4.0, 0.0, 1.0)), 0.0, fast::clamp((_p2 - 0.4000000059604644775390625) * 5.0, 0.0, 1.0)))) * _316));
    float _t27 = fast::clamp(1.5 - (_276 * 20.0), 0.0, 1.0);
    float3 param_2 = _p0.xyz;
    float3 _t28 = _f3(param_2);
    float3 param_3 = _p1;
    float3 _t29 = _f3(param_3);
    float _529 = fast::clamp(15.0 * ((_t29.y * _t29.z) - 0.0199999995529651641845703125), 0.0, 1.0);
    float _t31 = 0.0;
    _t27 = mix(1.0, fast::max(_t27, 1.0 - _529), fast::clamp(3.0 * (_p2 - 0.1500000059604644775390625), 0.0, 1.0));
    if (_529 > 0.001000000047497451305389404296875)
    {
        _t31 = _529 * mix(1.0 - ((1.0 - fast::clamp((fast::min(abs(_t28.x - _t29.x), 1.0 - abs(_t28.x - _t29.x)) - (0.119999997317790985107421875 + (0.100000001490116119384765625 * fast::clamp((_p2 - 0.4000000059604644775390625) * 2.0, 0.0, 1.0)))) * 12.0, 0.0, 1.0)) * (1.0 - (1.0 - fast::clamp((10.0 + (50.0 * fast::clamp(_p2 - 0.4000000059604644775390625, 0.0, 1.0))) * ((_t28.y * _t28.z) - ((((_t29.y * _t29.z) - 0.100000001490116119384765625) * (1.0 - _p2)) * (1.0 - _p2))), 0.0, 1.0)))), 0.0, fast::clamp((_p2 - 0.85000002384185791015625) * 8.0, 0.0, 1.0));
        _t27 *= mix(1.0, 1.0 - fast::clamp(25.0 * ((_t29.y * _t29.z) - 0.25), 0.0, 1.0), fast::clamp((_p2 - 0.0) * 10.0, 0.0, 1.0));
    }
    float _646 = fast::max(_t31, fast::max((14.2856998443603515625 * ((abs(_t10.x - _t11.x) / fast::max(1.0 - _t11.x, _t11.x)) - ((0.20000000298023223876953125 * _316) * _316))) * _t27, pow(fast::max((1.0 / mix(0.0500000007450580596923828125, fast::max(0.100000001490116119384765625, (0.180000007152557373046875 - ((0.100000001490116119384765625 * _t10.x) * _t11.x)) + 0.00999999977648258209228515625), _259)) * _466, 0.0), 2.0 - (1.39999997615814208984375 * _276))));
    _t9 = fast::min(_646, fast::clamp(((_646 - 0.5) * (fast::clamp((_p2 - 0.5) * 4.0, 0.0, 1.0) + 1.0)) + 0.4000000059604644775390625, 0.0, 1.0));
    if (_p3 > 0.001000000047497451305389404296875)
    {
        float3 param_4 = _p0.xyz;
        float3 param_5 = _f3(param_4);
        float param_6 = 30.0;
        float param_7 = mix(2.3093941211700439453125, 2.0, 1.0 / (1.0 + exp(-((_p3 - 0.300000011920928955078125) * 4.0))));
        float param_8 = length(_f0(param_5) - float3(0.0, 0.0, 2.309400081634521484375));
        _t9 = fast::max(1.0 - _f1(param_6, param_7, param_8), _t9);
    }
    float _702 = _t9;
    float _706 = fast::clamp((_702 - 0.20000000298023223876953125) * 1.25, 0.0, 1.0);
    _t9 = _706;
    return _706;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    if (buffer.u_threshold < 0.001000000047497451305389404296875)
    {
        out.o_fragColor = float4(1.0);
    }
    else
    {
        float4 param = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
        float3 param_1 = buffer.u_keyColor;
        float param_2 = buffer.u_threshold;
        float param_3 = buffer.u_inputShadow;
        float _744 = _f4(param, param_1, param_2, param_3);
        out.o_fragColor = float4(_744, _744, _744, 1.0);
    }
    return out;
}

