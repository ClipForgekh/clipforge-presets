
uniform vec2 u_controlPoints[110];
uniform float u_xCount;
uniform float u_yCount;

attribute vec3 a_position;
varying vec2 v_uv;
attribute vec2 a_texcoord0;

vec2 _f0(int _p0)
{
    vec2 _t0 = vec2(0.0);
    for (int _t1 = 0; _t1 < 110; _t1++)
    {
        if (_p0 == _t1)
        {
            _t0 = u_controlPoints[_t1];
            break;
        }
    }
    return _t0;
}

vec2 _f1(vec2 _p0, vec2 _p1, vec2 _p2, vec2 _p3, float _p4)
{
    vec2 _91 = mix(_p1, _p2, vec2(_p4));
    return mix(mix(mix(_p0, _p1, vec2(_p4)), _91, vec2(_p4)), mix(_91, mix(_p2, _p3, vec2(_p4)), vec2(_p4)), vec2(_p4));
}

vec4 _f2(vec2 _p0, vec2 _p1, vec2 _p2, vec2 _p3, vec2 _p4, vec2 _p5, vec2 _p6, vec2 _p7, vec2 _p8, vec2 _p9, vec2 _p10, vec2 _p11, vec2 _p12, vec2 _p13, vec2 _p14, vec2 _p15, vec2 _p16)
{
    vec2 param = _p13;
    vec2 param_1 = _p14;
    vec2 param_2 = _p15;
    vec2 param_3 = _p16;
    float param_4 = _p0.y;
    vec2 _130 = _f1(param, param_1, param_2, param_3, param_4);
    vec2 _t7 = _130;
    vec2 param_5 = _p9;
    vec2 param_6 = _p10;
    vec2 param_7 = _p11;
    vec2 param_8 = _p12;
    float param_9 = _p0.y;
    vec2 _143 = _f1(param_5, param_6, param_7, param_8, param_9);
    vec2 _t8 = _143;
    vec2 _t9 = smoothstep(vec2(0.0), vec2(1.0), _p0.yy);
    vec2 _183 = vec2(mix(-mix(_p1.x, _p5.x, _t9.y), 1.0 - mix(_p4.x, _p8.x, _t9.y), _p0.x) + mix(_t8.x, _t7.x - 1.0, _p0.x), 0.0);
    vec2 param_10 = _143;
    vec2 param_11 = mix(_p2, _p6, vec2(_t9.y, _p0.y)) + _183;
    vec2 param_12 = mix(_p3, _p7, vec2(_t9.y, _p0.y)) + _183;
    vec2 param_13 = _130;
    float param_14 = _p0.x;
    vec2 param_15 = _p5;
    vec2 param_16 = _p6;
    vec2 param_17 = _p7;
    vec2 param_18 = _p8;
    float param_19 = _p0.x;
    vec2 _235 = _f1(param_15, param_16, param_17, param_18, param_19);
    vec2 _t17 = _235;
    vec2 param_20 = _p1;
    vec2 param_21 = _p2;
    vec2 param_22 = _p3;
    vec2 param_23 = _p4;
    float param_24 = _p0.x;
    vec2 _248 = _f1(param_20, param_21, param_22, param_23, param_24);
    vec2 _t18 = _248;
    vec2 _t19 = smoothstep(vec2(0.0), vec2(1.0), _p0.xx);
    vec2 _286 = vec2(0.0, mix(-mix(_p9.y, _p13.y, _t19.x), 1.0 - mix(_p12.y, _p16.y, _t19.x), _p0.y) + mix(_t18.y, _t17.y - 1.0, _p0.y));
    vec2 param_25 = _248;
    vec2 param_26 = mix(_p10, _p14, vec2(_p0.x, _t19.x)) + _286;
    vec2 param_27 = mix(_p11, _p15, vec2(_p0.x, _t19.x)) + _286;
    vec2 param_28 = _235;
    float param_29 = _p0.y;
    return vec4(_f1(param_10, param_11, param_12, param_13, param_14), _f1(param_25, param_26, param_27, param_28, param_29));
}

void main()
{
    vec2 _t27 = (a_position.xy * 0.5) + vec2(0.5);
    float _351 = u_xCount - 1.0;
    float _357 = min(floor(_t27.x * _351), u_xCount - 2.0);
    float _360 = _t27.y;
    float _363 = u_yCount - 1.0;
    float _368 = min(floor(_360 * _363), u_yCount - 2.0);
    int _375 = int((_357 * u_yCount) + _368);
    int _383 = _375 + int(u_yCount);
    int _390 = _375 * 5;
    int _391 = _390 + 0;
    int param = _391;
    int param_1 = _390 + 2;
    int _403 = _383 * 5;
    int param_2 = _403 + 4;
    int _411 = _403 + 0;
    int param_3 = _411;
    int _416 = (_375 + 1) * 5;
    int _417 = _416 + 0;
    int param_4 = _417;
    int param_5 = _416 + 2;
    int _428 = (_383 + 1) * 5;
    int param_6 = _428 + 4;
    int _435 = _428 + 0;
    int param_7 = _435;
    int param_8 = _391;
    int param_9 = _390 + 3;
    int param_10 = _416 + 1;
    int param_11 = _417;
    int param_12 = _411;
    int param_13 = _403 + 3;
    int param_14 = _428 + 1;
    int param_15 = _435;
    _t27.x = (_t27.x - (_357 / _351)) * _351;
    _t27.y = (_t27.y - (_368 / _363)) * _363;
    vec2 param_16 = _t27;
    vec2 param_17 = _f0(param);
    vec2 param_18 = _f0(param_1);
    vec2 param_19 = _f0(param_2);
    vec2 param_20 = _f0(param_3);
    vec2 param_21 = _f0(param_4);
    vec2 param_22 = _f0(param_5);
    vec2 param_23 = _f0(param_6);
    vec2 param_24 = _f0(param_7);
    vec2 param_25 = _f0(param_8);
    vec2 param_26 = _f0(param_9);
    vec2 param_27 = _f0(param_10);
    vec2 param_28 = _f0(param_11);
    vec2 param_29 = _f0(param_12);
    vec2 param_30 = _f0(param_13);
    vec2 param_31 = _f0(param_14);
    vec2 param_32 = _f0(param_15);
    vec4 _t50 = _f2(param_16, param_17, param_18, param_19, param_20, param_21, param_22, param_23, param_24, param_25, param_26, param_27, param_28, param_29, param_30, param_31, param_32);
    gl_Position = vec4((vec2(_t50.x, _t50.w) * 2.0) - vec2(1.0), 0.0, 1.0);
    v_uv = a_texcoord0;
}

