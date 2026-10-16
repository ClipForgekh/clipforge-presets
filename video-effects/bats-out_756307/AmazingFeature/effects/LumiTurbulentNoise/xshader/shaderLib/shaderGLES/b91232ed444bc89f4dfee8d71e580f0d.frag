precision highp float;
precision highp int;

uniform float u_cycle;
uniform vec4 u_ScreenParams;
uniform float u_interpolationUVMap;
uniform float u_type;
uniform vec2 u_offset;
uniform vec2 u_scale;
uniform float u_rotate;
uniform float u_complexity;
uniform float u_evolution;
uniform float u_subImpact;
uniform float u_subScale;
uniform float u_subRotate;
uniform vec2 u_subOffset;
uniform float u_brightness;
uniform float u_contrast;

varying vec2 uv0;

vec2 _f2(inout vec2 _p0, float _p1)
{
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _217 = sin(_p1);
    float _220 = cos(_p1);
    _p0 -= vec2(0.5);
    _p0 = mat2(vec2(_220, _217), vec2(-_217, _220)) * _p0;
    _p0 += vec2(0.5);
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    return _p0;
}

float _f0(vec2 _p0)
{
    vec2 _58 = fract(_p0 * 1324.5179443359375);
    vec2 _t0 = _58 + vec2(dot(_58, _58.yx + vec2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

vec2 _f1(vec2 _p0, vec2 _p1)
{
    vec2 param = _p0;
    float _86 = _f0(param);
    float _93 = _p1.x + _86;
    float _96 = floor(_93);
    float _t4 = _96;
    float _t5 = _96 + 1.0;
    if (u_cycle >= 2.0)
    {
        _t4 = floor(mod(_93, u_cycle));
        _t5 = floor(mod(_93 + 1.0, u_cycle));
    }
    vec2 _131 = fract(_p0 * ((34.532001495361328125 + (_t4 * 4.412000179290771484375)) + (_p1.y * 0.3973000049591064453125)));
    vec2 _141 = _131 + vec2(dot(_131, _131.yx + vec2(15.4340000152587890625)));
    vec2 _145 = _141.yx;
    vec2 _154 = vec2(_86);
    vec2 _168 = fract(_p0 * ((34.532001495361328125 + (_t5 * 4.412000179290771484375)) + (_p1.y * 0.3973000049591064453125)));
    vec2 _177 = _168 + vec2(dot(_168, _168.yx + vec2(15.4340000152587890625)));
    vec2 _181 = _177.yx;
    return (mix(fract((((_141 + _145) + vec2(0.5230000019073486328125)) * _145) + _154), fract((((_177 + _181) + vec2(0.5230000019073486328125)) * _181) + _154), vec2(fract(_93))) * 2.0) - vec2(1.0);
}

float _f4(vec2 _p0, vec2 _p1)
{
    vec2 _387 = (vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _394 = floor((_p0 * _387) / vec2(100.0));
    vec2 _402 = fract((_p0 * _387) / vec2(u_interpolationUVMap));
    vec2 param = _394 + vec2(0.0);
    vec2 param_1 = _p1;
    vec2 param_2 = _394 + vec2(1.0, 0.0);
    vec2 param_3 = _p1;
    vec2 param_4 = _394 + vec2(0.0, 1.0);
    vec2 param_5 = _p1;
    vec2 param_6 = _394 + vec2(1.0);
    vec2 param_7 = _p1;
    vec2 _t31 = smoothstep(vec2(0.0), vec2(1.0), _402);
    return (mix(mix(dot(_f1(param, param_1), _402 - vec2(0.0)), dot(_f1(param_2, param_3), _402 - vec2(1.0, 0.0)), _t31.x), mix(dot(_f1(param_4, param_5), _402 - vec2(0.0, 1.0)), dot(_f1(param_6, param_7), _402 - vec2(1.0)), _t31.x), _t31.y) * 0.5) + 0.5;
}

float _f6(inout vec2 _p0, float _p1, float _p2, float _p3, float _p4, float _p5, float _p6, vec2 _p7)
{
    vec2 _629 = (vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _t43 = _629;
    float _632 = floor(_p1);
    vec2 _643 = vec2(_p2, 1.0);
    vec2 param = _p0;
    vec2 param_1 = _643;
    float _t49 = 1.0;
    float _t50 = _p3;
    float _t51 = _f4(param, param_1) * 1.0;
    for (float _t52 = 2.0; _t52 <= 7.0; _t52 += 1.0)
    {
        if (_t52 > _632)
        {
            break;
        }
        _p0 -= (_p7 / _629);
        vec2 param_2 = _p0;
        float param_3 = (_p5 * 3.141592502593994140625) / 180.0;
        vec2 _680 = _f2(param_2, param_3);
        _p0 = _680;
        _p0 *= _p4;
        vec2 param_4 = _p0 + vec2(1.0 / _t43.x, 0.0);
        vec2 param_5 = _643;
        vec2 param_6 = _p0 - vec2(1.0 / _t43.x, 0.0);
        vec2 param_7 = _643;
        vec2 param_8 = _p0 + vec2(0.0, 1.0 / _t43.y);
        vec2 param_9 = _643;
        vec2 param_10 = _p0 - vec2(0.0, 1.0 / _t43.y);
        vec2 param_11 = _643;
        _p0 -= vec2(_f4(param_6, param_7) - _f4(param_4, param_5), _f4(param_10, param_11) - _f4(param_8, param_9));
        vec2 param_12 = _p0;
        vec2 param_13 = _643;
        float _749 = _t50;
        _t49 += _749;
        _t50 = _749 * _p3;
        _t51 += (_f4(param_12, param_13) * _749);
    }
    float _763 = _t51;
    float _764 = _763 / _t49;
    _t51 = _764;
    return clamp(_764, 0.0, 1.0);
}

float _f3(vec2 _p0, vec2 _p1)
{
    vec2 _267 = (vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _275 = floor((_p0 * _267) / vec2(100.0));
    vec2 _284 = fract((_p0 * _267) / vec2(u_interpolationUVMap));
    vec2 param = _275 + vec2(0.0);
    vec2 param_1 = _p1;
    vec2 param_2 = _275 + vec2(1.0, 0.0);
    vec2 param_3 = _p1;
    vec2 param_4 = _275 + vec2(0.0, 1.0);
    vec2 param_5 = _p1;
    vec2 param_6 = _275 + vec2(1.0);
    vec2 param_7 = _p1;
    vec2 _t21 = smoothstep(vec2(0.0), vec2(1.0), _284);
    float _361 = mix(mix(dot(_f1(param, param_1), _284 - vec2(0.0)), dot(_f1(param_2, param_3), _284 - vec2(1.0, 0.0)), _t21.x), mix(dot(_f1(param_4, param_5), _284 - vec2(0.0, 1.0)), dot(_f1(param_6, param_7), _284 - vec2(1.0)), _t21.x), _t21.y);
    float _365;
    if (u_type == 1.0)
    {
        _365 = abs(_361);
    }
    else
    {
        _365 = (_361 * 0.5) + 0.5;
    }
    return _365;
}

float _f5(inout vec2 _p0, float _p1, float _p2, float _p3, float _p4, float _p5, float _p6, vec2 _p7)
{
    vec2 _493 = (vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    float _496 = floor(_p1);
    float _499 = fract(_p1);
    vec2 _507 = vec2(_p2, 1.0);
    vec2 param = _p0;
    vec2 param_1 = _507;
    float _t39 = 1.0;
    float _t40 = _p3;
    float _t41 = _f3(param, param_1) * 1.0;
    for (float _t42 = 2.0; _t42 <= 10.0; _t42 += 1.0)
    {
        if (_t42 > _496)
        {
            break;
        }
        _p0 -= (_p7 / _493);
        _p0 *= _p4;
        vec2 param_2 = _p0;
        float param_3 = (_p5 * 3.141592502593994140625) / 180.0;
        vec2 _549 = _f2(param_2, param_3);
        _p0 = _549;
        vec2 param_4 = _p0;
        vec2 param_5 = _507;
        float _556 = _t40;
        _t39 += _556;
        _t40 = _556 * _p3;
        _t41 += (_f3(param_4, param_5) * _556);
    }
    _p0 -= (_p7 / _493);
    _p0 *= _p4;
    vec2 param_6 = _p0;
    float param_7 = (_p5 * 3.141592502593994140625) / 180.0;
    vec2 _583 = _f2(param_6, param_7);
    _p0 = _583;
    vec2 param_8 = _p0;
    vec2 param_9 = _507;
    _t39 += (_t40 * _499);
    _t41 += ((_f3(param_8, param_9) * _t40) * _499);
    if (u_type == 0.0)
    {
        _t41 /= _t39;
    }
    else
    {
        _t41 = (_t41 * 0.60000002384185791015625) + 0.300000011920928955078125;
    }
    return clamp(_t41, 0.0, 1.0);
}

void main()
{
    vec2 _783 = (uv0 - u_offset) * (vec2(1.0) / u_scale);
    vec2 _t58 = _783;
    vec2 param = _783;
    float param_1 = (u_rotate * 3.141592502593994140625) / 180.0;
    vec2 _791 = _f2(param, param_1);
    _t58 = _791 - vec2(10.0);
    float _t61 = 0.0;
    if (u_type == 2.0)
    {
        vec2 param_2 = _t58;
        float param_3 = clamp(u_complexity, 1.0, 10.0);
        float param_4 = u_evolution;
        float param_5 = u_subImpact;
        float param_6 = 1.0 / u_subScale;
        float param_7 = u_subRotate;
        float param_8 = 2.1099998950958251953125;
        vec2 param_9 = u_subOffset;
        float _826 = _f6(param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9);
        _t61 = _826;
    }
    else
    {
        vec2 param_10 = _t58;
        float param_11 = clamp(u_complexity, 1.0, 10.0);
        float param_12 = u_evolution;
        float param_13 = u_subImpact;
        float param_14 = 1.0 / u_subScale;
        float param_15 = u_subRotate;
        float param_16 = 2.1099998950958251953125;
        vec2 param_17 = u_subOffset;
        float _845 = _f5(param_10, param_11, param_12, param_13, param_14, param_15, param_16, param_17);
        _t61 = _845;
    }
    _t61 += u_brightness;
    if (u_contrast > 0.0)
    {
        _t61 = ((_t61 - 0.5) * ((u_contrast * 10.0) + 1.0)) + 0.5;
    }
    else
    {
        _t61 = ((_t61 - 0.5) * (u_contrast + 1.0)) + 0.5;
    }
    float _869 = _t61;
    float _870 = clamp(_869, 0.0, 1.0);
    _t61 = _870;
    gl_FragData[0] = vec4(vec3(_870), 1.0);
}

