precision highp float;
precision highp int;

uniform mediump int u_skipSample;
uniform mat4 u_mvMat0;
uniform mat4 u_pMat0;
uniform float u_mirrorEdge;
uniform mediump sampler2D u_inputTex;
uniform float u_alpha;
uniform mat4 u_mvMat1;
uniform mat4 u_pMat1;
uniform mat4 u_mvMat2;
uniform mat4 u_pMat2;
uniform mat4 u_mvMat3;
uniform mat4 u_pMat3;
uniform mat4 u_mvMat4;
uniform mat4 u_pMat4;
uniform mat4 u_mvMat5;
uniform mat4 u_pMat5;
uniform float u_samples;
uniform float u_dither;

varying vec2 uv0;

vec2 _f1(mat4 _p0, mat4 _p1, vec2 _p2)
{
    vec3 _62 = (_p0 * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec4 _84 = _p1 * vec4((_p2 * 2.0) - vec2(1.0), 0.0, 1.0);
    vec4 _t3 = _84;
    vec3 _100 = normalize((_84.xyz / vec3(_t3.w)) - vec3(0.0));
    vec3 _104 = (_p0 * vec4(10.0, -10.0, 0.0, 1.0)).xyz - _62;
    vec3 _108 = (_p0 * vec4(-10.0, 10.0, 0.0, 1.0)).xyz - _62;
    vec3 _112 = cross(_104, _108);
    float _116 = dot(_112, _100);
    if (_116 >= (-1.0000000116860974230803549289703e-07))
    {
        return vec2(-10000.0);
    }
    float _133 = dot(_62 - vec3(0.0), _112) / _116;
    if (_133 <= 0.0)
    {
        return vec2(-10000.0);
    }
    vec3 _148 = (vec3(0.0) + (_100 * _133)) - _62;
    float _152 = dot(_104, _104);
    float _156 = dot(_104, _108);
    float _160 = dot(_108, _108);
    float _164 = dot(_104, _148);
    float _168 = dot(_108, _148);
    float _176 = (_152 * _160) - (_156 * _156);
    if (abs(_176) <= 1.0000000116860974230803549289703e-07)
    {
        return vec2(-10000.0);
    }
    float _186 = 1.0 / _176;
    float _196 = ((_160 * _164) - (_156 * _168)) * _186;
    float _t21 = _196;
    float _206 = ((_152 * _168) - (_156 * _164)) * _186;
    float _t22 = _206;
    if ((((_196 < (-9.9999997473787516355514526367188e-06)) || (_196 > 1.000010013580322265625)) || (_206 < (-9.9999997473787516355514526367188e-06))) || (_206 > 1.000010013580322265625))
    {
        return vec2(-10000.0);
    }
    float _223 = _t21;
    float _224 = clamp(_223, 0.0, 1.0);
    _t21 = _224;
    float _225 = _t22;
    float _226 = clamp(_225, 0.0, 1.0);
    _t22 = _226;
    vec2 _232 = vec2(_224);
    return mix(mix(vec2(-4.5), vec2(5.5, -4.5), _232), mix(vec2(-4.5, 5.5), vec2(5.5), _232), vec2(_226));
}

vec2 _f0(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f2(vec2 _p0)
{
    return ((step(0.0, _p0.x) * step(0.0, _p0.y)) * step(_p0.x, 1.0)) * step(_p0.y, 1.0);
}

float _f4(float _p0, float _p1)
{
    vec2 _344 = fract(vec2(_p0, _p1) * 13.5170001983642578125);
    vec2 _t23 = _344 + vec2(dot(_344, _344.yx + vec2(22.5410003662109375)));
    return fract((_t23.x + _t23.y) * _t23.y);
}

vec2 _f3(float _p0, vec2 _p1, vec2 _p2, vec2 _p3, vec2 _p4, vec2 _p5, vec2 _p6)
{
    return ((((mix(_p1, _p2, vec2(_p0 * 5.0)) * step(_p0, 0.20000000298023223876953125)) + ((mix(_p2, _p3, vec2((_p0 * 5.0) - 1.0)) * (1.0 - step(_p0, 0.20000000298023223876953125))) * step(_p0, 0.4000000059604644775390625))) + ((mix(_p3, _p4, vec2((_p0 * 5.0) - 2.0)) * (1.0 - step(_p0, 0.4000000059604644775390625))) * step(_p0, 0.60000002384185791015625))) + ((mix(_p4, _p5, vec2((_p0 * 5.0) - 3.0)) * (1.0 - step(_p0, 0.60000002384185791015625))) * step(_p0, 0.800000011920928955078125))) + (mix(_p5, _p6, vec2((_p0 * 5.0) - 4.0)) * (1.0 - step(_p0, 0.800000011920928955078125)));
}

void main()
{
    if (u_skipSample == 1)
    {
        mat4 param = u_mvMat0;
        mat4 param_1 = u_pMat0;
        vec2 param_2 = uv0;
        vec2 _386 = _f1(param, param_1, param_2);
        float _391 = step(u_mirrorEdge, 0.5);
        vec2 param_3 = _386;
        vec2 _401 = (_386 * _391) + (_f0(param_3) * (1.0 - _391));
        vec2 param_4 = _401;
        gl_FragData[0] = (texture2D(u_inputTex, _401) * u_alpha) * _f2(param_4);
        return;
    }
    mat4 param_5 = u_mvMat0;
    mat4 param_6 = u_pMat0;
    vec2 param_7 = uv0;
    vec2 _426 = _f1(param_5, param_6, param_7);
    mat4 param_8 = u_mvMat1;
    mat4 param_9 = u_pMat1;
    vec2 param_10 = uv0;
    vec2 _436 = _f1(param_8, param_9, param_10);
    mat4 param_11 = u_mvMat2;
    mat4 param_12 = u_pMat2;
    vec2 param_13 = uv0;
    vec2 _446 = _f1(param_11, param_12, param_13);
    mat4 param_14 = u_mvMat3;
    mat4 param_15 = u_pMat3;
    vec2 param_16 = uv0;
    vec2 _456 = _f1(param_14, param_15, param_16);
    mat4 param_17 = u_mvMat4;
    mat4 param_18 = u_pMat4;
    vec2 param_19 = uv0;
    vec2 _466 = _f1(param_17, param_18, param_19);
    mat4 param_20 = u_mvMat5;
    mat4 param_21 = u_pMat5;
    vec2 param_22 = uv0;
    vec2 _476 = _f1(param_20, param_21, param_22);
    vec4 _t31 = vec4(0.0);
    for (float _t32 = 0.0; _t32 <= 50.0; _t32 += 1.0)
    {
        if (_t32 >= u_samples)
        {
            break;
        }
        float _t33 = _t32 / (u_samples - 1.0);
        float param_23 = _t32 + uv0.x;
        float param_24 = _t32 * uv0.y;
        float _518 = _t33;
        float _519 = _518 + ((u_dither * (_f4(param_23, param_24) - 0.5)) / u_samples);
        _t33 = _519;
        float param_25 = _519;
        vec2 param_26 = _426;
        vec2 param_27 = _436;
        vec2 param_28 = _446;
        vec2 param_29 = _456;
        vec2 param_30 = _466;
        vec2 param_31 = _476;
        vec2 _535 = _f3(param_25, param_26, param_27, param_28, param_29, param_30, param_31);
        float _537 = step(u_mirrorEdge, 0.5);
        vec2 param_32 = _535;
        vec2 _547 = (_535 * _537) + (_f0(param_32) * (1.0 - _537));
        vec2 param_33 = _547;
        _t31 += ((texture2D(u_inputTex, _547) * u_alpha) * _f2(param_33));
    }
    vec4 _562 = _t31;
    vec4 _564 = _562 / vec4(u_samples);
    _t31 = _564;
    gl_FragData[0] = _564;
}

