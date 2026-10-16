precision highp float;
precision highp int;

uniform float u_Cycle;
uniform vec4 u_ScreenParams;
uniform vec2 u_Offset;
uniform vec2 u_Scale;
uniform float u_Rotate;
uniform float u_Complexity;
uniform float u_Evolution;
uniform float u_SubImpact;
uniform float u_SubScale;
uniform float u_SubRotate;
uniform vec2 u_SubOffset;
uniform float u_Brightness;
uniform float u_Contrast;

varying vec2 v_uv;

vec2 _f2(inout vec2 _p0, float _p1)
{
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _202 = sin(_p1);
    float _205 = cos(_p1);
    _p0 -= vec2(0.5);
    _p0 = mat2(vec2(_205, _202), vec2(-_202, _205)) * _p0;
    _p0 += vec2(0.5);
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    return _p0;
}

float _f0(vec2 _p0)
{
    vec2 _43 = fract(_p0 * 1324.5179443359375);
    vec2 _t0 = _43 + vec2(dot(_43, _43.yx + vec2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

vec2 _f1(vec2 _p0, vec2 _p1)
{
    vec2 param = _p0;
    float _71 = _f0(param);
    float _78 = _p1.x + _71;
    float _81 = floor(_78);
    float _t4 = _81;
    float _t5 = _81 + 1.0;
    if (u_Cycle >= 2.0)
    {
        _t4 = floor(mod(_78, u_Cycle));
        _t5 = floor(mod(_78 + 1.0, u_Cycle));
    }
    vec2 _116 = fract(_p0 * ((34.532001495361328125 + (_t4 * 4.412000179290771484375)) + (_p1.y * 0.3973000049591064453125)));
    vec2 _126 = _116 + vec2(dot(_116, _116.yx + vec2(15.4340000152587890625)));
    vec2 _130 = _126.yx;
    vec2 _139 = vec2(_71);
    vec2 _153 = fract(_p0 * ((34.532001495361328125 + (_t5 * 4.412000179290771484375)) + (_p1.y * 0.3973000049591064453125)));
    vec2 _162 = _153 + vec2(dot(_153, _153.yx + vec2(15.4340000152587890625)));
    vec2 _166 = _162.yx;
    return (mix(fract((((_126 + _130) + vec2(0.5230000019073486328125)) * _130) + _139), fract((((_162 + _166) + vec2(0.5230000019073486328125)) * _166) + _139), vec2(fract(_78))) * 2.0) - vec2(1.0);
}

float _f3(vec2 _p0, vec2 _p1)
{
    vec2 _252 = (vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _260 = floor((_p0 * _252) / vec2(100.0));
    vec2 _267 = fract((_p0 * _252) / vec2(100.0));
    vec2 param = _260 + vec2(0.0);
    vec2 param_1 = _p1;
    vec2 param_2 = _260 + vec2(1.0, 0.0);
    vec2 param_3 = _p1;
    vec2 param_4 = _260 + vec2(0.0, 1.0);
    vec2 param_5 = _p1;
    vec2 param_6 = _260 + vec2(1.0);
    vec2 param_7 = _p1;
    vec2 _t21 = ((_267 * _267) * _267) * ((_267 * ((_267 * 6.0) - vec2(15.0))) + vec2(10.0));
    return (mix(mix(dot(_f1(param, param_1), _267 - vec2(0.0)), dot(_f1(param_2, param_3), _267 - vec2(1.0, 0.0)), _t21.x), mix(dot(_f1(param_4, param_5), _267 - vec2(0.0, 1.0)), dot(_f1(param_6, param_7), _267 - vec2(1.0)), _t21.x), _t21.y) * 0.5) + 0.5;
}

float _f4(inout vec2 _p0, float _p1, float _p2, float _p3, float _p4, float _p5, vec2 _p6)
{
    vec2 _373 = (vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    float _376 = floor(_p1);
    float _379 = fract(_p1);
    vec2 _387 = vec2(_p2, 1.0);
    vec2 param = _p0;
    vec2 param_1 = _387;
    float _t29 = 1.0;
    float _t30 = _p3;
    float _t31 = _f3(param, param_1) * 1.0;
    for (float _t32 = 2.0; _t32 <= 10.0; _t32 += 1.0)
    {
        if (_t32 > _376)
        {
            break;
        }
        _p0 -= (_p6 / _373);
        _p0 *= _p4;
        vec2 param_2 = _p0;
        float param_3 = (_p5 * 3.141592502593994140625) / 180.0;
        vec2 _428 = _f2(param_2, param_3);
        _p0 = _428;
        vec2 param_4 = _p0;
        vec2 param_5 = _387;
        float _435 = _t30;
        _t29 += _435;
        _t30 = _435 * _p3;
        _t31 += (_f3(param_4, param_5) * _435);
    }
    _p0 -= (_p6 / _373);
    _p0 *= _p4;
    vec2 param_6 = _p0;
    float param_7 = (_p5 * 3.141592502593994140625) / 180.0;
    vec2 _462 = _f2(param_6, param_7);
    _p0 = _462;
    vec2 param_8 = _p0;
    vec2 param_9 = _387;
    float _476 = _t29;
    float _477 = _476 + (_t30 * _379);
    _t29 = _477;
    float _479 = _t31;
    float _483 = (_479 + ((_f3(param_8, param_9) * _t30) * _379)) / _477;
    _t31 = _483;
    return clamp(_483, 0.0, 1.0);
}

void main()
{
    vec2 param = (v_uv - u_Offset) * (vec2(1.0) / u_Scale);
    float param_1 = (u_Rotate * 3.141592502593994140625) / 180.0;
    vec2 _510 = _f2(param, param_1);
    vec2 param_2 = _510 - vec2(10.0);
    float param_3 = clamp(u_Complexity, 1.0, 10.0);
    float param_4 = u_Evolution;
    float param_5 = u_SubImpact;
    float param_6 = 1.0 / u_SubScale;
    float param_7 = u_SubRotate;
    vec2 param_8 = u_SubOffset;
    float _537 = _f4(param_2, param_3, param_4, param_5, param_6, param_7, param_8);
    float _t34 = _537 + u_Brightness;
    if (u_Contrast > 0.0)
    {
        _t34 = ((_t34 - 0.5) * ((u_Contrast * 10.0) + 1.0)) + 0.5;
    }
    else
    {
        _t34 = ((_t34 - 0.5) * (u_Contrast + 1.0)) + 0.5;
    }
    float _561 = _t34;
    float _562 = clamp(_561, 0.0, 1.0);
    _t34 = _562;
    gl_FragData[0] = vec4(vec3(_562), 1.0);
}

