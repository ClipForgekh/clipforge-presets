precision highp float;
precision highp int;

uniform float u_intensity;
uniform float u_angle;
uniform float u_scaleX;
uniform float u_scaleY;
uniform float u_quality;
uniform float u_regionIns;
uniform float u_lightIns;
uniform float u_baseTexWidth;
uniform float u_baseTexHeight;
uniform mediump sampler2D u_inputTex;
uniform float u_blurSize;

varying vec2 v_uv;

mat2 _f0(float _p0)
{
    float _35 = sin(_p0);
    float _38 = cos(_p0);
    return mat2(vec2(_38, -_35), vec2(_35, _38));
}

float _f1(vec2 _p0)
{
    return (_p0.x * _p0.x) + pow((_p0.y + 1.5) - (2.2999999523162841796875 * sqrt(abs(_p0.x))), 2.0);
}

float _f2(vec2 _p0)
{
    vec2 param = _p0;
    return step(_f1(param), 75.0);
}

vec4 _f3(mediump sampler2D _p0, vec2 _p1, float _p2, vec2 _p3)
{
    bool _87 = u_intensity < 0.00999999977648258209228515625;
    if (_87)
    {
        return texture2D(_p0, _p1);
    }
    vec4 _t4 = vec4(0.0);
    vec4 _t6 = vec4(0.0);
    vec4 _t7 = vec4(0.4000000059604644775390625);
    float param = u_angle;
    mat2 _121 = _f0(param);
    vec2 _134 = (vec2(2.4444444179534912109375, 1.83333337306976318359375) * vec2(u_scaleX, u_scaleY)) * vec2(_p2);
    vec2 _138 = vec2(1.0) / _p3;
    float _146 = mix(2.0, 0.5, u_intensity) * mix(2.0, 1.0, u_quality);
    float _157 = max(5.0, (10.0 / _146) * mix(0.699999988079071044921875, 1.0, u_quality));
    float _161 = mix(0.699999988079071044921875, 1.0, u_regionIns);
    for (float _t14 = 0.0; _t14 < 30.0; _t14 += 1.0)
    {
        if ((_t14 > _157) || (u_intensity < 0.300000011920928955078125))
        {
            break;
        }
        for (float _t15 = 0.0; _t15 < 30.0; _t15 += 1.0)
        {
            if (_t15 > _157)
            {
                break;
            }
            vec2 _207 = vec2(mix(-9.0, 9.0, _t14 / _157), mix(-7.0, 11.0, _t15 / _157));
            vec2 _t16 = _207;
            vec2 param_1 = _207;
            if (_f2(param_1) < 0.5)
            {
                continue;
            }
            vec2 _216 = _t16;
            vec2 _217 = _216 - vec2(0.0, 1.5);
            _t16 = _217;
            mediump vec4 _232 = texture2D(_p0, _p1 - ((((_217 * 0.5) * _134) * _121) * _138));
            _t4 = max(_t4, _232 * _161);
            vec4 _246 = ((pow(_232, vec4(9.0)) * 539.45001220703125) + vec4(0.4000000059604644775390625)) * u_regionIns;
            _t6 += (_246 * _232);
            _t7 += _246;
        }
    }
    float _271 = max(floor((24.0 / _146) * mix(0.300000011920928955078125, 1.0, clamp(u_quality * 1.5, 0.0, 1.0))), 7.0);
    float _276 = _271 + (mod(_271, 2.0) + 1.0);
    for (float _t20 = 0.0; _t20 < 70.0; _t20 += 1.0)
    {
        if ((_t20 > _276) || _87)
        {
            break;
        }
        float _298 = _t20 / _276;
        float _t21 = _298;
        if (_298 < 0.1500000059604644775390625)
        {
            _t21 = mix(0.0, 0.0500000007450580596923828125, _t21 / 0.1500000059604644775390625);
        }
        else
        {
            if (_t21 < 0.85000002384185791015625)
            {
                _t21 = mix(0.0500000007450580596923828125, 0.949999988079071044921875, (_t21 - 0.1500000059604644775390625) / 0.699999988079071044921875);
            }
            else
            {
                _t21 = mix(0.949999988079071044921875, 1.0, (_t21 - 0.85000002384185791015625) / 0.1500000059604644775390625);
            }
        }
        float _328 = mix(-8.659999847412109375, 8.659999847412109375, _t21);
        float _332 = 75.0 - (_328 * _328);
        if (_332 < 0.0)
        {
            continue;
        }
        mediump vec4 _368 = texture2D(_p0, _p1 - ((((vec2(_328, ((sqrt(_332) - 1.5) + (2.2999999523162841796875 * sqrt(abs(_328)))) - 1.5) * 0.5) * _134) * _121) * _138));
        _t4 = max(_t4, _368);
        vec4 _377 = (pow(_368, vec4(9.0)) * 539.45001220703125) + vec4(0.4000000059604644775390625);
        _t6 += (_377 * _368);
        _t7 += _377;
    }
    for (float _t27 = 0.0; _t27 < 70.0; _t27 += 1.0)
    {
        if ((_t27 > _276) || _87)
        {
            break;
        }
        float _408 = _t27 / _276;
        float _t28 = _408;
        if (_408 < 0.1500000059604644775390625)
        {
            _t28 = mix(0.0, 0.0500000007450580596923828125, _t28 / 0.1500000059604644775390625);
        }
        else
        {
            if (_t28 < 0.85000002384185791015625)
            {
                _t28 = mix(0.0500000007450580596923828125, 0.949999988079071044921875, (_t28 - 0.1500000059604644775390625) / 0.699999988079071044921875);
            }
            else
            {
                _t28 = mix(0.949999988079071044921875, 1.0, (_t28 - 0.85000002384185791015625) / 0.1500000059604644775390625);
            }
        }
        float _432 = mix(-8.659999847412109375, 8.659999847412109375, _t28);
        float _436 = 75.0 - (_432 * _432);
        if (_436 < 0.0)
        {
            continue;
        }
        float _450 = abs(_432);
        mediump vec4 _479 = texture2D(_p0, _p1 - ((((vec2(_432, ((((-sqrt(_436)) - 1.5) + (2.2999999523162841796875 * sqrt(_450))) + (smoothstep(1.2999999523162841796875, 0.0, _450) * 0.699999988079071044921875)) - 1.5) * 0.5) * _134) * _121) * _138));
        _t4 = max(_t4, _479);
        vec4 _488 = (pow(_479, vec4(9.0)) * 539.45001220703125) + vec4(0.4000000059604644775390625);
        _t6 += (_488 * _479);
        _t7 += _488;
    }
    vec4 _505 = clamp(_t6 / _t7, vec4(0.0), vec4(1.0));
    return vec4(mix(_505, _t4, clamp(_505 * u_lightIns, vec4(0.0), vec4(1.0))));
}

void main()
{
    vec2 param = v_uv;
    float param_1 = u_blurSize;
    vec2 param_2 = (vec2(u_baseTexWidth, u_baseTexHeight) / vec2(min(u_baseTexWidth, u_baseTexHeight))) * 720.0;
    gl_FragData[0] = _f3(u_inputTex, param, param_1, param_2);
}

