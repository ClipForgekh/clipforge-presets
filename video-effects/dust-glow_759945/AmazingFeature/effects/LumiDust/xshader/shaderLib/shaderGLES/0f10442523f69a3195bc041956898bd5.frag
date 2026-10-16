precision highp float;
precision highp int;

uniform float u_Cycle;
uniform vec4 u_ScreenParams;
uniform vec2 u_Offset;
uniform float u_Rotate;
uniform vec2 u_Scale;
uniform float u_Complexity;
uniform float u_Evolution;
uniform float u_SubImpact;
uniform float u_SubScale;
uniform float u_SubRotate;
uniform vec2 u_SubOffset;
uniform float u_Brightness;
uniform float u_Contrast;

varying vec2 uv0;

vec2 _f3(inout vec2 _p0, float _p1)
{
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _277 = sin(_p1);
    float _280 = cos(_p1);
    _p0 -= vec2(0.5);
    _p0 = mat2(vec2(_280, _277), vec2(-_277, _280)) * _p0;
    _p0 += vec2(0.5);
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    return _p0;
}

float _f0(vec2 _p0)
{
    vec2 _49 = fract(_p0 * 1324.5179443359375);
    vec2 _t0 = _49 + vec2(dot(_49, _49.yx + vec2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

vec2 _f2(vec2 _p0, vec2 _p1)
{
    vec2 param = _p0;
    float _107 = _f0(param);
    vec2 _117 = vec2((_p1.x * 0.125) + (_107 * 0.5));
    vec2 _t6 = _117;
    vec2 _120 = floor(_117);
    vec2 _t7 = _120;
    vec2 _t8 = _120 + vec2(1.0);
    if (u_Cycle >= 2.0)
    {
        vec2 _136 = vec2(u_Cycle);
        _t7 = mod(_t7, _136);
        _t8 = mod(_t8, _136);
    }
    vec2 _169 = fract(_p0 * ((vec2(17.2660007476806640625) + (_t7 * 1.0)) + vec2((_p1.y * 0.80309998989105224609375) * 0.5)));
    vec2 _174 = fract(_p0 * ((vec2(17.2660007476806640625) + (_t8 * 1.0)) + vec2((_p1.y * 0.80309998989105224609375) * 0.5)));
    vec2 _186 = _169 + vec2(dot(_169, _169.yx + vec2(7.71700000762939453125)) * 0.699999988079071044921875);
    vec2 _196 = _174 + vec2(dot(_174, _174.yx + vec2(7.71700000762939453125)) * 0.699999988079071044921875);
    vec2 _200 = _186.yx;
    vec2 _209 = vec2(_107);
    vec2 _t13 = fract((((_186 + _200) + vec2(0.26150000095367431640625)) * _200) + _209);
    vec2 _215 = _196.yx;
    vec2 _t14 = fract((((_196 + _215) + vec2(0.26150000095367431640625)) * _215) + _209);
    float _241 = mix(_t13.y, _t14.y + 0.5, smoothstep(0.0, 1.0, fract(_t6.x))) * 6.28318023681640625;
    return vec2(cos(_241), sin(_241)) * mix(0.85000002384185791015625, 1.0, smoothstep(0.0, 1.0, fract((_p1.x + (_107 * 0.300000011920928955078125)) * 7.672500133514404296875)));
}

float _f4(vec2 _p0, vec2 _p1)
{
    vec2 _329 = _p0 * ((vec2(7.19999980926513671875) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y)));
    vec2 _332 = floor(_329);
    vec2 _335 = fract(_329);
    vec2 param = _332 + vec2(0.0);
    vec2 param_1 = _p1;
    vec2 param_2 = _332 + vec2(1.0, 0.0);
    vec2 param_3 = _p1;
    vec2 param_4 = _332 + vec2(0.0, 1.0);
    vec2 param_5 = _p1;
    vec2 param_6 = _332 + vec2(1.0);
    vec2 param_7 = _p1;
    vec2 _t33 = smoothstep(vec2(0.0), vec2(1.0), _335);
    return (mix(mix(dot(_f2(param, param_1), _335 - vec2(0.0)), dot(_f2(param_2, param_3), _335 - vec2(1.0, 0.0)), _t33.x), mix(dot(_f2(param_4, param_5), _335 - vec2(0.0, 1.0)), dot(_f2(param_6, param_7), _335 - vec2(1.0)), _t33.x), _t33.y) * 0.5) + 0.5;
}

float _f5(inout vec2 _p0, float _p1, float _p2, float _p3, float _p4, float _p5, float _p6, vec2 _p7)
{
    float _437 = floor(_p1);
    float _440 = fract(_p1);
    vec2 _449 = _p7 / ((vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y)));
    float _455 = (_p5 * 3.141592502593994140625) / 180.0;
    float _458 = sin(_455);
    float _461 = cos(_455);
    mat2 _470 = mat2(vec2(_461, _458), vec2(-_458, _461));
    vec2 param = _p0;
    vec2 param_1 = vec2(_p2, 1.0 + _p6);
    float _t51 = 1.0;
    float _t52 = _p3;
    float _t53 = _f4(param, param_1) * 1.0;
    for (float _t54 = 2.0; _t54 <= 10.0; _t54 += 1.0)
    {
        if (_t54 > _437)
        {
            break;
        }
        _p0 -= _449;
        _p0 -= vec2(0.5);
        _p0 = _470 * _p0;
        _p0 += vec2(0.5);
        _p0 *= _p4;
        vec2 param_2 = _p0;
        vec2 param_3 = vec2(_p2, 1.0 + _p6);
        float _524 = _t52;
        _t51 += _524;
        _t52 = _524 * _p3;
        _t53 += (_f4(param_2, param_3) * _524);
    }
    _p0 -= _449;
    _p0 -= vec2(0.5);
    _p0 = _470 * _p0;
    _p0 += vec2(0.5);
    _p0 *= _p4;
    vec2 param_4 = _p0;
    vec2 param_5 = vec2(_p2, 1.0 + _p6);
    float _567 = _t51;
    float _568 = _567 + (_t52 * _440);
    _t51 = _568;
    float _570 = _t53;
    float _574 = (_570 + ((_f4(param_4, param_5) * _t52) * _440)) / _568;
    _t53 = _574;
    return clamp(_574, 0.0, 1.0);
}

vec4 _f1(vec2 _p0)
{
    return vec4(floor(_p0.x * 255.0) / 255.0, fract(_p0.x * 255.0), floor(_p0.y * 255.0) / 255.0, fract(_p0.y * 255.0));
}

void main()
{
    vec2 _587 = uv0 - u_Offset;
    vec2 _t55 = _587;
    vec2 param = _587;
    float param_1 = (u_Rotate * 3.141592502593994140625) / 180.0;
    vec2 _595 = _f3(param, param_1);
    vec2 _604 = (_595 * (vec2(1.0) / u_Scale)) - vec2(10.0);
    _t55 = _604;
    float _t56 = 0.5;
    float _t57 = 0.5;
    float _609 = clamp(u_Complexity, 1.0, 10.0);
    float _615 = 100.0 / u_SubScale;
    vec2 param_2 = _604;
    float param_3 = _609;
    float param_4 = u_Evolution;
    float param_5 = u_SubImpact;
    float param_6 = _615;
    float param_7 = u_SubRotate;
    float param_8 = 2.1099998950958251953125;
    vec2 param_9 = u_SubOffset;
    float _632 = _f5(param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9);
    _t56 = _632;
    vec2 param_10 = _t55;
    float param_11 = _609;
    float param_12 = u_Evolution;
    float param_13 = u_SubImpact;
    float param_14 = _615;
    float param_15 = u_SubRotate;
    float param_16 = 9.71000003814697265625;
    vec2 param_17 = u_SubOffset;
    float _651 = _f5(param_10, param_11, param_12, param_13, param_14, param_15, param_16, param_17);
    _t56 += u_Brightness;
    _t57 = _651 + u_Brightness;
    if (u_Contrast > 0.0)
    {
        float _668 = (u_Contrast * 10.0) + 1.0;
        _t56 = ((_t56 - 0.5) * _668) + 0.5;
        _t57 = ((_t57 - 0.5) * _668) + 0.5;
    }
    else
    {
        float _682 = u_Contrast + 1.0;
        _t56 = ((_t56 - 0.5) * _682) + 0.5;
        _t57 = ((_t57 - 0.5) * _682) + 0.5;
    }
    float _691 = _t56;
    float _692 = clamp(_691, 0.0, 1.0);
    _t56 = _692;
    float _693 = _t57;
    float _694 = clamp(_693, 0.0, 1.0);
    _t57 = _694;
    vec2 param_18 = vec2(_692, _694);
    gl_FragData[0] = _f1(param_18);
}

