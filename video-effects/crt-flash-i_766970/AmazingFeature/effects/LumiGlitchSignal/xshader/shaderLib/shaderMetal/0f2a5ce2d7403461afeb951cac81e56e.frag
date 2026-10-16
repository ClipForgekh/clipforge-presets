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
    float4 u_ScreenParams;
    float randomSeed;
    float hueNoise;
    float chromaNoise;
    float chromaloss;
    float destruction;
    float moireSize;
    float moireSpeed;
    float time;
    float moireNoise;
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
float _f0(thread const float2& _p0)
{
    float2 _51 = fract(_p0 * 1324.5179443359375);
    float2 _t0 = _51 + float2(dot(_51, _51.yx + float2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float& _p1)
{
    float2 param = _p0;
    float2 _88 = fract(_p0 * (34.532001495361328125 + (_p1 * 0.3973000049591064453125)));
    float2 _98 = _88 + float2(dot(_88, _88.yx + float2(15.4340000152587890625)));
    float2 _102 = _98.yx;
    return (fract((((_98 + _102) + float2(0.5230000019073486328125)) * _102) + float2(_f0(param))) * 2.0) - float2(1.0);
}

static inline __attribute__((always_inline))
float _f2(thread const float2& _p0, thread const float& _p1, constant float4& u_ScreenParams)
{
    float2 _138 = (float2(720.0) * u_ScreenParams.xy) / float2(fast::min(u_ScreenParams.x, u_ScreenParams.y));
    float2 _146 = floor((_p0 * _138) / float2(100.0));
    float2 _153 = fract((_p0 * _138) / float2(100.0));
    float2 param = _146 + float2(0.0);
    float param_1 = _p1;
    float2 param_2 = _146 + float2(1.0, 0.0);
    float param_3 = _p1;
    float2 param_4 = _146 + float2(0.0, 1.0);
    float param_5 = _p1;
    float2 param_6 = _146 + float2(1.0);
    float param_7 = _p1;
    float2 _t12 = ((_153 * _153) * _153) * ((_153 * ((_153 * 6.0) - float2(15.0))) + float2(10.0));
    return (mix(mix(dot(_f1(param, param_1), _153 - float2(0.0)), dot(_f1(param_2, param_3), _153 - float2(1.0, 0.0)), _t12.x), mix(dot(_f1(param_4, param_5), _153 - float2(0.0, 1.0)), dot(_f1(param_6, param_7), _153 - float2(1.0)), _t12.x), _t12.y) * 0.5) + 0.5;
}

static inline __attribute__((always_inline))
float3 _f5(thread const float3& _p0)
{
    float _549 = fast::min(fast::min(_p0.x, _p0.y), _p0.z);
    float _558 = fast::max(fast::max(_p0.x, _p0.y), _p0.z);
    float _562 = _558 - _549;
    float _566 = _558 + _549;
    float3 _t42 = float3(0.0, 0.0, _566 / 2.0);
    if (_562 != 0.0)
    {
        if (_t42.z < 0.5)
        {
            _t42.y = _562 / _566;
        }
        else
        {
            _t42.y = _562 / ((2.0 - _558) - _549);
        }
        float _600 = _562 / 2.0;
        float _603 = (((_558 - _p0.x) / 6.0) + _600) / _562;
        float _614 = (((_558 - _p0.y) / 6.0) + _600) / _562;
        float _625 = (((_558 - _p0.z) / 6.0) + _600) / _562;
        if (_p0.x == _558)
        {
            _t42.x = _625 - _614;
        }
        else
        {
            if (_p0.y == _558)
            {
                _t42.x = (0.3333333432674407958984375 + _603) - _625;
            }
            else
            {
                _t42.x = (0.666666686534881591796875 + _614) - _603;
            }
        }
        _t42.x = fract(_t42.x);
    }
    return _t42;
}

static inline __attribute__((always_inline))
float3 _f4(thread float& _p0)
{
    _p0 = fract(_p0);
    return fast::clamp(float3(abs((_p0 * 6.0) - 3.0) - 1.0, 2.0 - abs((_p0 * 6.0) - 2.0), 2.0 - abs((_p0 * 6.0) - 4.0)), float3(0.0), float3(1.0));
}

static inline __attribute__((always_inline))
float3 _f6(thread const float3& _p0)
{
    if (_p0.y == 0.0)
    {
        return float3(_p0.z);
    }
    else
    {
        float _t46;
        if (_p0.z < 0.5)
        {
            _t46 = _p0.z * (1.0 + _p0.y);
        }
        else
        {
            _t46 = (_p0.z + _p0.y) - (_p0.y * _p0.z);
        }
        float _702 = (2.0 * _p0.z) - _t46;
        float param = _p0.x;
        float3 _707 = _f4(param);
        return float3(_702) + (_707 * (_t46 - _702));
    }
}

static inline __attribute__((always_inline))
float3 _f8(thread const float3& _p0)
{
    return mix(fract(_p0), _p0, step(abs(fast::clamp(_p0, float3(0.00999999977648258209228515625), float3(0.9900000095367431640625)) - _p0), float3(9.9999997473787516355514526367188e-06)));
}

static inline __attribute__((always_inline))
float _f7(thread const float3& _p0)
{
    return ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
}

static inline __attribute__((always_inline))
float _f3(thread const float3& _p0)
{
    float3 _253 = floor(_p0);
    float3 _257 = _p0 - _253;
    float3 _t15 = _257;
    float3 _261 = _257 - float3(1.0);
    float3 _t16 = _261;
    float3 _269 = _253 - (floor(_253 * 0.0144927538931369781494140625) * 69.0);
    float3 _278 = step(_269, float3(67.5)) * (_269 + float3(1.0));
    float4 _293 = float4(_269.xy, _278.xy) + float4(50.0, 161.0, 50.0, 161.0);
    float4 _296 = _293 * _293;
    float4 _301 = _296.xzxz * _296.yyww;
    float3 _320 = float3(float3(1.0) / (float3(635.2987060546875, 682.35748291015625, 668.926513671875) + (_269.zzz * float3(48.50038909912109375, 65.29412078857421875, 63.934600830078125))));
    float3 _331 = float3(float3(1.0) / (float3(635.2987060546875, 682.35748291015625, 668.926513671875) + (_278.zzz * float3(48.50038909912109375, 65.29412078857421875, 63.934600830078125))));
    float4 _372 = fract(_301 * _320.xxxx) - float4(0.499989986419677734375);
    float4 _376 = fract(_301 * _320.yyyy) - float4(0.499989986419677734375);
    float4 _380 = fract(_301 * _320.zzzz) - float4(0.499989986419677734375);
    float4 _384 = fract(_301 * _331.xxxx) - float4(0.499989986419677734375);
    float4 _388 = fract(_301 * _331.yyyy) - float4(0.499989986419677734375);
    float4 _392 = fract(_301 * _331.zzzz) - float4(0.499989986419677734375);
    float3 _479 = ((_257 * _257) * _257) * ((_257 * ((_257 * 6.0) - float3(15.0))) + float3(10.0));
    float3 _t35 = _479;
    float2 _490 = _479.xy;
    float4 _502 = float4(_490, float2(float2(1.0) - _490));
    return dot(mix(rsqrt(((_372 * _372) + (_376 * _376)) + (_380 * _380)) * (((float2(_t15.x, _t16.x).xyxy * _372) + (float2(_t15.y, _t16.y).xxyy * _376)) + (_257.zzzz * _380)), rsqrt(((_384 * _384) + (_388 * _388)) + (_392 * _392)) * (((float2(_t15.x, _t16.x).xyxy * _384) + (float2(_t15.y, _t16.y).xxyy * _388)) + (_261.zzzz * _392)), float4(_t35.z)), _502.zxzx * _502.wwyy) * 1.1547005176544189453125;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _765 = ((buffer.randomSeed + buffer.hueNoise) + buffer.chromaNoise) + buffer.chromaloss;
    float4 _t51 = inputImageTexture.sample(inputImageTextureSmplr, in.v_uv);
    float2 _785 = (in.v_uv * float2(2.3255813121795654296875, 112.35955047607421875)) - float2(10.0);
    float2 param = _785;
    float param_1 = _765;
    float2 param_2 = _785 - float2(1.0099999904632568359375, 0.1369999945163726806640625);
    float param_3 = _765;
    float2 param_4 = _785 - float2(1.730000019073486328125, 0.658999979496002197265625);
    float param_5 = _765;
    float2 param_6 = float2(_765, in.v_uv.y);
    float2 param_7 = float2(_765 + 17.0, in.v_uv.y);
    float2 param_8 = float2(_765 + 19.0, in.v_uv.y);
    float2 param_9 = float2(_765 + 23.0, in.v_uv.y);
    float _855 = (_f0(param_9) * 0.9900000095367431640625) + 0.001000000047497451305389404296875;
    float3 param_10 = _t51.xyz;
    float3 _t60 = _f5(param_10);
    if (((_f0(param_6) * 0.9900000095367431640625) + 0.001000000047497451305389404296875) < buffer.hueNoise)
    {
        _t60.x = (_f0(param_7) * 0.9900000095367431640625) + 0.001000000047497451305389404296875;
        _t60.y *= (1.0 - (buffer.hueNoise / 3.0));
    }
    float4 _875 = _t51;
    float3 param_11 = _t60;
    float3 _882 = mix(_875.xyz, _f6(param_11), float3(buffer.hueNoise));
    _t51.x = _882.x;
    _t51.y = _882.y;
    _t51.z = _882.z;
    float _893 = dot(_t51.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float3 _t62 = float3(_f2(param, param_1, buffer.u_ScreenParams), _f2(param_2, param_3, buffer.u_ScreenParams), _f2(param_4, param_5, buffer.u_ScreenParams));
    float _904 = buffer.chromaNoise * 0.0500000007450580596923828125;
    _t62.x *= (0.920000016689300537109375 + ((_893 * 0.0500000007450580596923828125) + _904));
    _t62.y *= (0.85000002384185791015625 + ((_893 * 0.180000007152557373046875) + _904));
    float3 param_12 = _t62;
    _t62 = _f5(param_12);
    float _929 = buffer.chromaNoise * 10.0;
    _t62.y = fast::min(1.0, _t62.y * (1.0 + _929));
    float3 param_13 = _t62;
    float3 _940 = fast::clamp(_f6(param_13), float3(0.0), float3(1.0));
    _t62 = _940;
    float4 _941 = _t51;
    float3 _947 = mix(_941.xyz, _940, float3(buffer.chromaNoise * 0.5));
    _t51.x = _947.x;
    _t51.y = _947.y;
    _t51.z = _947.z;
    float _961 = _t62.x;
    float _972 = _t62.y;
    float _983 = _t62.z;
    float _994;
    if (_t51.x < 0.5)
    {
        _994 = (2.0 * _t51.x) * _t62.x;
    }
    else
    {
        _994 = 1.0 - ((2.0 * (1.0 - _t51.x)) * (1.0 - _t62.x));
    }
    float _1017;
    if (_t51.y < 0.5)
    {
        _1017 = (2.0 * _t51.y) * _t62.y;
    }
    else
    {
        _1017 = 1.0 - ((2.0 * (1.0 - _t51.y)) * (1.0 - _t62.y));
    }
    float _1040;
    if (_t51.z < 0.5)
    {
        _1040 = (2.0 * _t51.z) * _t62.z;
    }
    else
    {
        _1040 = 1.0 - ((2.0 * (1.0 - _t51.z)) * (1.0 - _t62.z));
    }
    float3 _1060 = float3(_994, _1017, _1040);
    float4 _1062 = _t51;
    float3 _1081 = mix(_1060, float3(1.0) - ((float3(1.0) - _1060) * (float3(1.0) - float3(fast::max(1.0 - ((1.0 - _961) / 0.5), 0.0), fast::max(1.0 - ((1.0 - _972) / 0.5), 0.0), fast::max(1.0 - ((1.0 - _983) / 0.5), 0.0)))), float3(0.5 * smoothstep(0.588235318660736083984375, 0.509803950786590576171875, dot(_1062.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)))));
    _t62 = _1081;
    float3 _1090 = mix(_1062.xyz, _1081, float3(fast::min(0.800000011920928955078125, _929)));
    _t51.x = _1090.x;
    _t51.y = _1090.y;
    _t51.z = _1090.z;
    float3 param_14 = _t51.xyz;
    _t60 = _f5(param_14);
    if (((_f0(param_8) * 0.9900000095367431640625) + 0.001000000047497451305389404296875) < buffer.chromaloss)
    {
        _t60.y *= ((1.0 - smoothstep(0.0, 1.0 - buffer.chromaloss, _855)) * fast::min(1.0, 1.2999999523162841796875 - (buffer.chromaloss * 1.0)));
    }
    else
    {
        _t60.y *= (smoothstep(0.0, buffer.chromaloss, _855) * fast::min(1.0, 1.2999999523162841796875 - (buffer.chromaloss * 1.0)));
    }
    float3 param_15 = _t60;
    float3 _1136 = _f6(param_15);
    _t51.x = _1136.x;
    _t51.y = _1136.y;
    _t51.z = _1136.z;
    if (buffer.destruction > 0.5)
    {
        float3 param_16 = _t51.xyz;
        float3 _1151 = _f8(param_16);
        _t51.x = _1151.x;
        _t51.y = _1151.y;
        _t51.z = _1151.z;
    }
    float2 _t67 = float2(1.0) / ((buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y))) * 720.0);
    float3 param_17 = (inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(0.0, _t67.y))) - inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(0.0, -_t67.y)))).xyz;
    float3 param_18 = (inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(_t67.x, 0.0))) - inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + float2(-_t67.x, 0.0)))).xyz;
    float3 param_19 = float3(in.v_uv * (5.0 - (4.5 * buffer.moireSize)), _765 + (buffer.moireSpeed * buffer.time));
    float _1246 = mod(((_f3(param_19) + 1.0) / 2.0) * 200.0, 1.0);
    float _1248 = 2.0 * _1246;
    float _1254 = mix(_1248, 2.0 - _1248, step(0.5, _1246));
    float4 _1255 = _t51;
    float3 _1277 = mix(_1255.xyz, _1255.xyz - float3(0.100000001490116119384765625), float3((((_1254 * _1254) * _1254) * fast::max(0.0, 1.0 - ((abs(_f7(param_17)) + abs(_f7(param_18))) * 20.0))) * buffer.moireNoise));
    _t51.x = _1277.x;
    _t51.y = _1277.y;
    _t51.z = _1277.z;
    out.o_fragColor = _t51;
    return out;
}

