precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform float randomSeed;
uniform float hueNoise;
uniform float chromaNoise;
uniform float chromaloss;
uniform mediump sampler2D inputImageTexture;
uniform float destruction;
uniform float moireSize;
uniform float moireSpeed;
uniform float time;
uniform float moireNoise;

varying vec2 v_uv;

float _f0(vec2 _p0)
{
    vec2 _51 = fract(_p0 * 1324.5179443359375);
    vec2 _t0 = _51 + vec2(dot(_51, _51.yx + vec2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

vec2 _f1(vec2 _p0, float _p1)
{
    vec2 param = _p0;
    vec2 _88 = fract(_p0 * (34.532001495361328125 + (_p1 * 0.3973000049591064453125)));
    vec2 _98 = _88 + vec2(dot(_88, _88.yx + vec2(15.4340000152587890625)));
    vec2 _102 = _98.yx;
    return (fract((((_98 + _102) + vec2(0.5230000019073486328125)) * _102) + vec2(_f0(param))) * 2.0) - vec2(1.0);
}

float _f2(vec2 _p0, float _p1)
{
    vec2 _138 = (vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _146 = floor((_p0 * _138) / vec2(100.0));
    vec2 _153 = fract((_p0 * _138) / vec2(100.0));
    vec2 param = _146 + vec2(0.0);
    float param_1 = _p1;
    vec2 param_2 = _146 + vec2(1.0, 0.0);
    float param_3 = _p1;
    vec2 param_4 = _146 + vec2(0.0, 1.0);
    float param_5 = _p1;
    vec2 param_6 = _146 + vec2(1.0);
    float param_7 = _p1;
    vec2 _t12 = ((_153 * _153) * _153) * ((_153 * ((_153 * 6.0) - vec2(15.0))) + vec2(10.0));
    return (mix(mix(dot(_f1(param, param_1), _153 - vec2(0.0)), dot(_f1(param_2, param_3), _153 - vec2(1.0, 0.0)), _t12.x), mix(dot(_f1(param_4, param_5), _153 - vec2(0.0, 1.0)), dot(_f1(param_6, param_7), _153 - vec2(1.0)), _t12.x), _t12.y) * 0.5) + 0.5;
}

vec3 _f5(vec3 _p0)
{
    float _549 = min(min(_p0.x, _p0.y), _p0.z);
    float _558 = max(max(_p0.x, _p0.y), _p0.z);
    float _562 = _558 - _549;
    float _566 = _558 + _549;
    vec3 _t42 = vec3(0.0, 0.0, _566 / 2.0);
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

vec3 _f4(inout float _p0)
{
    _p0 = fract(_p0);
    return clamp(vec3(abs((_p0 * 6.0) - 3.0) - 1.0, 2.0 - abs((_p0 * 6.0) - 2.0), 2.0 - abs((_p0 * 6.0) - 4.0)), vec3(0.0), vec3(1.0));
}

vec3 _f6(vec3 _p0)
{
    if (_p0.y == 0.0)
    {
        return vec3(_p0.z);
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
        vec3 _707 = _f4(param);
        return vec3(_702) + (_707 * (_t46 - _702));
    }
}

vec3 _f8(vec3 _p0)
{
    return mix(fract(_p0), _p0, step(abs(clamp(_p0, vec3(0.00999999977648258209228515625), vec3(0.9900000095367431640625)) - _p0), vec3(9.9999997473787516355514526367188e-06)));
}

float _f7(vec3 _p0)
{
    return ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
}

float _f3(vec3 _p0)
{
    vec3 _253 = floor(_p0);
    vec3 _257 = _p0 - _253;
    vec3 _t15 = _257;
    vec3 _261 = _257 - vec3(1.0);
    vec3 _t16 = _261;
    vec3 _269 = _253 - (floor(_253 * 0.0144927538931369781494140625) * 69.0);
    vec3 _278 = step(_269, vec3(67.5)) * (_269 + vec3(1.0));
    vec4 _293 = vec4(_269.xy, _278.xy) + vec4(50.0, 161.0, 50.0, 161.0);
    vec4 _296 = _293 * _293;
    vec4 _301 = _296.xzxz * _296.yyww;
    vec3 _320 = vec3(vec3(1.0) / (vec3(635.2987060546875, 682.35748291015625, 668.926513671875) + (_269.zzz * vec3(48.50038909912109375, 65.29412078857421875, 63.934600830078125))));
    vec3 _331 = vec3(vec3(1.0) / (vec3(635.2987060546875, 682.35748291015625, 668.926513671875) + (_278.zzz * vec3(48.50038909912109375, 65.29412078857421875, 63.934600830078125))));
    vec4 _372 = fract(_301 * _320.xxxx) - vec4(0.499989986419677734375);
    vec4 _376 = fract(_301 * _320.yyyy) - vec4(0.499989986419677734375);
    vec4 _380 = fract(_301 * _320.zzzz) - vec4(0.499989986419677734375);
    vec4 _384 = fract(_301 * _331.xxxx) - vec4(0.499989986419677734375);
    vec4 _388 = fract(_301 * _331.yyyy) - vec4(0.499989986419677734375);
    vec4 _392 = fract(_301 * _331.zzzz) - vec4(0.499989986419677734375);
    vec3 _479 = ((_257 * _257) * _257) * ((_257 * ((_257 * 6.0) - vec3(15.0))) + vec3(10.0));
    vec3 _t35 = _479;
    vec2 _490 = _479.xy;
    vec4 _502 = vec4(_490, vec2(vec2(1.0) - _490));
    return dot(mix(inversesqrt(((_372 * _372) + (_376 * _376)) + (_380 * _380)) * (((vec2(_t15.x, _t16.x).xyxy * _372) + (vec2(_t15.y, _t16.y).xxyy * _376)) + (_257.zzzz * _380)), inversesqrt(((_384 * _384) + (_388 * _388)) + (_392 * _392)) * (((vec2(_t15.x, _t16.x).xyxy * _384) + (vec2(_t15.y, _t16.y).xxyy * _388)) + (_261.zzzz * _392)), vec4(_t35.z)), _502.zxzx * _502.wwyy) * 1.1547005176544189453125;
}

void main()
{
    float _765 = ((randomSeed + hueNoise) + chromaNoise) + chromaloss;
    vec4 _t51 = texture2D(inputImageTexture, v_uv);
    vec2 _785 = (v_uv * vec2(2.3255813121795654296875, 112.35955047607421875)) - vec2(10.0);
    vec2 param = _785;
    float param_1 = _765;
    vec2 param_2 = _785 - vec2(1.0099999904632568359375, 0.1369999945163726806640625);
    float param_3 = _765;
    vec2 param_4 = _785 - vec2(1.730000019073486328125, 0.658999979496002197265625);
    float param_5 = _765;
    vec2 param_6 = vec2(_765, v_uv.y);
    vec2 param_7 = vec2(_765 + 17.0, v_uv.y);
    vec2 param_8 = vec2(_765 + 19.0, v_uv.y);
    vec2 param_9 = vec2(_765 + 23.0, v_uv.y);
    float _855 = (_f0(param_9) * 0.9900000095367431640625) + 0.001000000047497451305389404296875;
    vec3 param_10 = _t51.xyz;
    vec3 _t60 = _f5(param_10);
    if (((_f0(param_6) * 0.9900000095367431640625) + 0.001000000047497451305389404296875) < hueNoise)
    {
        _t60.x = (_f0(param_7) * 0.9900000095367431640625) + 0.001000000047497451305389404296875;
        _t60.y *= (1.0 - (hueNoise / 3.0));
    }
    vec4 _875 = _t51;
    vec3 param_11 = _t60;
    vec3 _882 = mix(_875.xyz, _f6(param_11), vec3(hueNoise));
    _t51.x = _882.x;
    _t51.y = _882.y;
    _t51.z = _882.z;
    float _893 = dot(_t51.xyz, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    vec3 _t62 = vec3(_f2(param, param_1), _f2(param_2, param_3), _f2(param_4, param_5));
    float _904 = chromaNoise * 0.0500000007450580596923828125;
    _t62.x *= (0.920000016689300537109375 + ((_893 * 0.0500000007450580596923828125) + _904));
    _t62.y *= (0.85000002384185791015625 + ((_893 * 0.180000007152557373046875) + _904));
    vec3 param_12 = _t62;
    _t62 = _f5(param_12);
    float _929 = chromaNoise * 10.0;
    _t62.y = min(1.0, _t62.y * (1.0 + _929));
    vec3 param_13 = _t62;
    vec3 _940 = clamp(_f6(param_13), vec3(0.0), vec3(1.0));
    _t62 = _940;
    vec4 _941 = _t51;
    vec3 _947 = mix(_941.xyz, _940, vec3(chromaNoise * 0.5));
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
    vec3 _1060 = vec3(_994, _1017, _1040);
    vec4 _1062 = _t51;
    vec3 _1081 = mix(_1060, vec3(1.0) - ((vec3(1.0) - _1060) * (vec3(1.0) - vec3(max(1.0 - ((1.0 - _961) / 0.5), 0.0), max(1.0 - ((1.0 - _972) / 0.5), 0.0), max(1.0 - ((1.0 - _983) / 0.5), 0.0)))), vec3(0.5 * smoothstep(0.588235318660736083984375, 0.509803950786590576171875, dot(_1062.xyz, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)))));
    _t62 = _1081;
    vec3 _1090 = mix(_1062.xyz, _1081, vec3(min(0.800000011920928955078125, _929)));
    _t51.x = _1090.x;
    _t51.y = _1090.y;
    _t51.z = _1090.z;
    vec3 param_14 = _t51.xyz;
    _t60 = _f5(param_14);
    if (((_f0(param_8) * 0.9900000095367431640625) + 0.001000000047497451305389404296875) < chromaloss)
    {
        _t60.y *= ((1.0 - smoothstep(0.0, 1.0 - chromaloss, _855)) * min(1.0, 1.2999999523162841796875 - (chromaloss * 1.0)));
    }
    else
    {
        _t60.y *= (smoothstep(0.0, chromaloss, _855) * min(1.0, 1.2999999523162841796875 - (chromaloss * 1.0)));
    }
    vec3 param_15 = _t60;
    vec3 _1136 = _f6(param_15);
    _t51.x = _1136.x;
    _t51.y = _1136.y;
    _t51.z = _1136.z;
    if (destruction > 0.5)
    {
        vec3 param_16 = _t51.xyz;
        vec3 _1151 = _f8(param_16);
        _t51.x = _1151.x;
        _t51.y = _1151.y;
        _t51.z = _1151.z;
    }
    vec2 _t67 = vec2(1.0) / ((u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y))) * 720.0);
    vec3 param_17 = (texture2D(inputImageTexture, v_uv + vec2(0.0, _t67.y)) - texture2D(inputImageTexture, v_uv + vec2(0.0, -_t67.y))).xyz;
    vec3 param_18 = (texture2D(inputImageTexture, v_uv + vec2(_t67.x, 0.0)) - texture2D(inputImageTexture, v_uv + vec2(-_t67.x, 0.0))).xyz;
    vec3 param_19 = vec3(v_uv * (5.0 - (4.5 * moireSize)), _765 + (moireSpeed * time));
    float _1246 = mod(((_f3(param_19) + 1.0) / 2.0) * 200.0, 1.0);
    float _1248 = 2.0 * _1246;
    float _1254 = mix(_1248, 2.0 - _1248, step(0.5, _1246));
    vec4 _1255 = _t51;
    vec3 _1277 = mix(_1255.xyz, _1255.xyz - vec3(0.100000001490116119384765625), vec3((((_1254 * _1254) * _1254) * max(0.0, 1.0 - ((abs(_f7(param_17)) + abs(_f7(param_18))) * 20.0))) * moireNoise));
    _t51.x = _1277.x;
    _t51.y = _1277.y;
    _t51.z = _1277.z;
    gl_FragData[0] = _t51;
}

