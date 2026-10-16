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

vec4 _f1(vec3 _p0, vec3 _p1, vec3 _p2, vec3 _p3, vec3 _p4)
{
    vec3 _67 = _p3 - _p2;
    vec3 _71 = _p4 - _p2;
    vec3 _75 = cross(_p1, _71);
    float _79 = dot(_67, _75);
    if (_79 <= 1.0000000116860974230803549289703e-07)
    {
        return vec4(-1.0);
    }
    vec3 _92 = _p0 - _p2;
    float _98 = dot(_92, _75) / _79;
    if ((_98 < 0.0) || (_98 > 1.0))
    {
        return vec4(-1.0);
    }
    vec3 _111 = cross(_92, _67);
    float _117 = dot(_p1, _111) / _79;
    bool _119 = _117 < 0.0;
    bool _127;
    if (!_119)
    {
        _127 = (_98 + _117) > 1.0;
    }
    else
    {
        _127 = _119;
    }
    if (_127)
    {
        return vec4(-1.0);
    }
    return vec4(_98, _117, dot(_71, _111) / _79, 1.0);
}

vec2 _f2(mat4 _p0, mat4 _p1, vec2 _p2)
{
    vec3 _167 = (_p0 * vec4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    vec3 _173 = (_p0 * vec4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _178 = (_p0 * vec4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _183 = (_p0 * vec4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    vec4 _193 = _p1 * vec4((_p2 * 2.0) - vec2(1.0), 0.0, 1.0);
    vec4 _t17 = _193;
    vec3 _210 = normalize((_193.xyz / vec3(_t17.w)) - vec3(0.0));
    vec3 param = vec3(0.0);
    vec3 param_1 = _210;
    vec3 _218 = (_p0 * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 param_2 = _218;
    vec3 param_3 = _167;
    vec3 param_4 = _178;
    vec4 _t21 = _f1(param, param_1, param_2, param_3, param_4);
    vec3 param_5 = vec3(0.0);
    vec3 param_6 = _210;
    vec3 param_7 = _183;
    vec3 param_8 = _173;
    vec3 _235 = (_p0 * vec4(10.0, 10.0, 0.0, 1.0)).xyz;
    vec3 param_9 = _235;
    vec4 _t22 = _f1(param_5, param_6, param_7, param_8, param_9);
    vec3 param_10 = vec3(0.0);
    vec3 param_11 = _210;
    vec3 param_12 = _218;
    vec3 param_13 = _178;
    vec3 param_14 = _167;
    vec4 _t23 = _f1(param_10, param_11, param_12, param_13, param_14);
    vec3 param_15 = vec3(0.0);
    vec3 param_16 = _210;
    vec3 param_17 = _183;
    vec3 param_18 = _235;
    vec3 param_19 = _173;
    vec4 _t24 = _f1(param_15, param_16, param_17, param_18, param_19);
    vec2 _401 = (((((((vec2(-4.5) * ((1.0 - _t21.x) - _t21.y)) + (vec2(5.5, -4.5) * _t21.x)) + (vec2(-4.5, 5.5) * _t21.y)) * step(0.0, _t21.w)) + ((((vec2(-4.5, 5.5) * ((1.0 - _t22.x) - _t22.y)) + (vec2(5.5, -4.5) * _t22.x)) + (vec2(5.5) * _t22.y)) * (step(_t21.w, 0.0) * step(0.0, _t22.w)))) + ((((vec2(-4.5) * ((1.0 - _t23.x) - _t23.y)) + (vec2(-4.5, 5.5) * _t23.x)) + (vec2(5.5, -4.5) * _t23.y)) * ((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(0.0, _t23.w)))) + ((((vec2(-4.5, 5.5) * ((1.0 - _t24.x) - _t24.y)) + (vec2(5.5) * _t24.x)) + (vec2(5.5, -4.5) * _t24.y)) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(0.0, _t24.w)))) + (vec2(-10000.0) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(_t24.w, 0.0)));
    return _401;
}

vec2 _f0(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f3(vec2 _p0)
{
    return ((step(0.0, _p0.x) * step(0.0, _p0.y)) * step(_p0.x, 1.0)) * step(_p0.y, 1.0);
}

float _f5(float _p0, float _p1)
{
    vec2 _503 = fract(vec2(_p0, _p1) * 13.5170001983642578125);
    vec2 _t30 = _503 + vec2(dot(_503, _503.yx + vec2(22.5410003662109375)));
    return fract((_t30.x + _t30.y) * _t30.y);
}

vec2 _f4(float _p0, vec2 _p1, vec2 _p2, vec2 _p3, vec2 _p4, vec2 _p5, vec2 _p6)
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
        vec2 _545 = _f2(param, param_1, param_2);
        float _550 = step(u_mirrorEdge, 0.5);
        vec2 param_3 = _545;
        vec2 _560 = (_545 * _550) + (_f0(param_3) * (1.0 - _550));
        vec2 param_4 = _560;
        gl_FragData[0] = (texture2D(u_inputTex, _560) * u_alpha) * _f3(param_4);
        return;
    }
    mat4 param_5 = u_mvMat0;
    mat4 param_6 = u_pMat0;
    vec2 param_7 = uv0;
    vec2 _585 = _f2(param_5, param_6, param_7);
    mat4 param_8 = u_mvMat1;
    mat4 param_9 = u_pMat1;
    vec2 param_10 = uv0;
    vec2 _595 = _f2(param_8, param_9, param_10);
    mat4 param_11 = u_mvMat2;
    mat4 param_12 = u_pMat2;
    vec2 param_13 = uv0;
    vec2 _605 = _f2(param_11, param_12, param_13);
    mat4 param_14 = u_mvMat3;
    mat4 param_15 = u_pMat3;
    vec2 param_16 = uv0;
    vec2 _615 = _f2(param_14, param_15, param_16);
    mat4 param_17 = u_mvMat4;
    mat4 param_18 = u_pMat4;
    vec2 param_19 = uv0;
    vec2 _625 = _f2(param_17, param_18, param_19);
    mat4 param_20 = u_mvMat5;
    mat4 param_21 = u_pMat5;
    vec2 param_22 = uv0;
    vec2 _635 = _f2(param_20, param_21, param_22);
    vec4 _t38 = vec4(0.0);
    for (float _t39 = 0.0; _t39 <= 256.0; _t39 += 1.0)
    {
        if (_t39 >= u_samples)
        {
            break;
        }
        float _t40 = _t39 / (u_samples - 1.0);
        float param_23 = _t39 + uv0.x;
        float param_24 = _t39 * uv0.y;
        float _677 = _t40;
        float _678 = _677 + ((u_dither * (_f5(param_23, param_24) - 0.5)) / u_samples);
        _t40 = _678;
        float param_25 = _678;
        vec2 param_26 = _585;
        vec2 param_27 = _595;
        vec2 param_28 = _605;
        vec2 param_29 = _615;
        vec2 param_30 = _625;
        vec2 param_31 = _635;
        vec2 _694 = _f4(param_25, param_26, param_27, param_28, param_29, param_30, param_31);
        float _696 = step(u_mirrorEdge, 0.5);
        vec2 param_32 = _694;
        vec2 _706 = (_694 * _696) + (_f0(param_32) * (1.0 - _696));
        vec2 param_33 = _706;
        _t38 += ((texture2D(u_inputTex, _706) * u_alpha) * _f3(param_33));
    }
    vec4 _721 = _t38;
    vec4 _723 = _721 / vec4(u_samples);
    _t38 = _723;
    gl_FragData[0] = _723;
}

