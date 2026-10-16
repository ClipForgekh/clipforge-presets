precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump sampler2D inputImageTexture;
uniform float sharpenSize;
uniform float sharpenIntensity;
uniform mediump sampler2D blurImageTexture;
uniform float signalStrength;
uniform float destruction;

varying vec2 v_uv;

vec3 _f1(vec3 _p0)
{
    float _88 = ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
    return vec3(_88, (_p0.z - _88) * 0.564999997615814208984375, (_p0.x - _88) * 0.712999999523162841796875);
}

vec3 _f2(vec3 _p0)
{
    return vec3(_p0.x + (1.40299999713897705078125 * _p0.z), (_p0.x - (0.3440000116825103759765625 * _p0.y)) - (0.7139999866485595703125 * _p0.z), _p0.x + (1.769999980926513671875 * _p0.y));
}

vec2 _f4(vec4 _p0)
{
    return vec2(_p0.x + (_p0.y / 255.0), _p0.z + (_p0.w / 255.0));
}

vec3 _f0(vec3 _p0)
{
    vec4 _t0 = vec4(1.0, 0.666666686534881591796875, 0.3333333432674407958984375, 3.0);
    return mix(vec3(1.0), clamp(abs((fract(vec3(_p0.x) + vec3(1.0, 0.666666686534881591796875, 0.3333333432674407958984375)) * 6.0) - vec3(_t0.w)) - vec3(_t0.x), vec3(0.0), vec3(1.0)), vec3(_p0.y)) * _p0.z;
}

vec3 _f3(vec3 _p0)
{
    return mix(fract(_p0), _p0, step(abs(clamp(_p0, vec3(0.00999999977648258209228515625), vec3(0.9900000095367431640625)) - _p0), vec3(9.9999997473787516355514526367188e-06)));
}

void main()
{
    vec2 _t7 = vec2(1.0) / ((u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y))) * 720.0);
    mediump vec4 _205 = texture2D(inputImageTexture, v_uv);
    vec4 _t9 = _205;
    for (float _t10 = 1.0; _t10 <= 20.0; _t10 += 1.0)
    {
        if (_t10 > sharpenSize)
        {
            break;
        }
        _t9 += texture2D(inputImageTexture, v_uv - vec2(_t10 * _t7.x, 0.0));
    }
    vec4 _240 = _t9;
    vec4 _242 = _240 / vec4(sharpenSize + 1.0);
    _t9 = _242;
    vec3 param = _242.xyz;
    vec3 _t11 = _f1(param);
    vec3 param_1 = _205.xyz;
    vec3 _252 = _f1(param_1);
    vec3 _t12 = _252;
    vec3 _261 = _t11;
    vec2 _269 = mix(_252.yz, _261.yz, vec2(min(1.0, sharpenIntensity * 5.0)));
    _t11.y = _269.x;
    _t11.z = _269.y;
    _t11.x = _t12.x + (((_t12.x - _t11.x) * sharpenIntensity) * 40.0);
    vec3 param_2 = _t11;
    vec3 _289 = _f2(param_2);
    _t9.x = _289.x;
    _t9.y = _289.y;
    _t9.z = _289.z;
    vec4 param_3 = ((((((((((texture2D(blurImageTexture, v_uv) + texture2D(blurImageTexture, v_uv + vec2(0.0, 1.0 * _t7.y))) + texture2D(blurImageTexture, v_uv + vec2(0.0, (-1.0) * _t7.y))) + texture2D(blurImageTexture, v_uv + vec2(0.0, 2.0 * _t7.y))) + texture2D(blurImageTexture, v_uv + vec2(0.0, (-2.0) * _t7.y))) + texture2D(blurImageTexture, v_uv + vec2(1.0 * _t7.x, 0.0))) + texture2D(blurImageTexture, v_uv + vec2((-1.0) * _t7.x, 0.0))) + texture2D(blurImageTexture, v_uv + vec2(2.0 * _t7.x, 0.0))) + texture2D(blurImageTexture, v_uv + vec2((-2.0) * _t7.x, 0.0))) + texture2D(blurImageTexture, v_uv + vec2(3.0 * _t7.x, 0.0))) + texture2D(blurImageTexture, v_uv + vec2((-3.0) * _t7.x, 0.0))) / vec4(11.0);
    vec2 _t15 = _f4(param_3);
    vec3 param_4 = vec3(fract(_t15.y * 40.270000457763671875), 1.0, 0.800000011920928955078125);
    vec4 _423 = _t9;
    vec3 _435 = mix(_423.xyz, _f0(param_4), vec3(min(1.0, _t15.x * 2.0) * (1.0 - signalStrength)));
    _t9.x = _435.x;
    _t9.y = _435.y;
    _t9.z = _435.z;
    if (destruction > 0.5)
    {
        vec3 param_5 = _t9.xyz;
        vec3 _451 = _f3(param_5);
        _t9.x = _451.x;
        _t9.y = _451.y;
        _t9.z = _451.z;
    }
    gl_FragData[0] = clamp(_t9, vec4(0.0), vec4(1.0));
}

