precision highp float;
precision highp int;

uniform float u_Cycle;
uniform vec4 u_ScreenParams;
uniform vec2 u_Offset;
uniform float u_Rotate;
uniform vec2 u_Scale;
uniform float u_type;
uniform float u_Complexity;
uniform float u_Evolution;
uniform float u_SubImpact;
uniform float u_SubScale;
uniform float u_SubRotate;
uniform vec2 u_SubOffset;

varying vec2 uv0;

vec2 _f3(inout vec2 _p0, float _p1)
{
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _361 = sin(_p1);
    float _364 = cos(_p1);
    _p0 -= vec2(0.5);
    _p0 = mat2(vec2(_364, _361), vec2(-_361, _364)) * _p0;
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
    float _116 = (_p1.x * 0.25) + _107;
    float _119 = floor(_116);
    float _t8 = _119;
    float _t9 = _119 + 1.0;
    bool _128 = u_Cycle >= 2.0;
    if (_128)
    {
        _t8 = floor(mod(_116, u_Cycle));
        _t9 = floor(mod(_116 + 1.0, u_Cycle));
    }
    vec2 _153 = fract(_p0 * ((34.532001495361328125 + (_t8 * 2.0)) + (_p1.y * 0.80309998989105224609375)));
    vec2 _163 = _153 + vec2(dot(_153, _153.yx + vec2(15.4340000152587890625)));
    vec2 _167 = _163.yx;
    vec2 _176 = vec2(_107);
    vec2 _t11 = fract((((_163 + _167) + vec2(0.5230000019073486328125)) * _167) + _176);
    vec2 _190 = fract(_p0 * ((34.532001495361328125 + (_t9 * 2.0)) + (_p1.y * 0.80309998989105224609375)));
    vec2 _199 = _190 + vec2(dot(_190, _190.yx + vec2(15.4340000152587890625)));
    vec2 _203 = _199.yx;
    vec2 _t13 = fract((((_199 + _203) + vec2(0.5230000019073486328125)) * _203) + _176);
    _t13.y += 1.0;
    float _230 = (mix(_t11.y, _t13.y, fract(_116)) * 3.141590118408203125) * 2.0;
    float _236 = (_p1.x * 2.0) + _107;
    float _239 = floor(_236);
    float _t17 = _239;
    float _t18 = _239 + 1.0;
    if (_128)
    {
        _t17 = floor(mod(_236, u_Cycle));
        _t18 = floor(mod(_236 + 1.0, u_Cycle));
    }
    vec2 _267 = fract(_p0 * ((34.532001495361328125 + (_t17 * 2.0)) + (_p1.y * 0.80309998989105224609375)));
    vec2 _276 = _267 + vec2(dot(_267, _267.yx + vec2(15.4340000152587890625)));
    vec2 _280 = _276.yx;
    vec2 _t20 = fract((((_276 + _280) + vec2(0.5230000019073486328125)) * _280) + _176);
    vec2 _302 = fract(_p0 * ((34.532001495361328125 + (_t18 * 2.0)) + (_p1.y * 0.80309998989105224609375)));
    vec2 _311 = _302 + vec2(dot(_302, _302.yx + vec2(15.4340000152587890625)));
    vec2 _315 = _311.yx;
    vec2 _t22 = fract((((_311 + _315) + vec2(0.5230000019073486328125)) * _315) + _176);
    return vec2(cos(_230), sin(_230)) * (mix(0.75, 1.0, mix(_t20.x, _t22.x, fract(_236))) * 1.0);
}

float _f4(vec2 _p0, vec2 _p1)
{
    vec2 _411 = (vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    vec2 _419 = floor((_p0 * _411) / vec2(100.0));
    vec2 _426 = fract((_p0 * _411) / vec2(100.0));
    vec2 param = _419 + vec2(0.0);
    vec2 param_1 = _p1;
    vec2 param_2 = _419 + vec2(1.0, 0.0);
    vec2 param_3 = _p1;
    vec2 param_4 = _419 + vec2(0.0, 1.0);
    vec2 param_5 = _p1;
    vec2 param_6 = _419 + vec2(1.0);
    vec2 param_7 = _p1;
    vec2 _t36 = smoothstep(vec2(0.0), vec2(1.0), _426);
    return (mix(mix(dot(_f2(param, param_1), _426 - vec2(0.0)), dot(_f2(param_2, param_3), _426 - vec2(1.0, 0.0)), _t36.x), mix(dot(_f2(param_4, param_5), _426 - vec2(0.0, 1.0)), dot(_f2(param_6, param_7), _426 - vec2(1.0)), _t36.x), _t36.y) * 0.5) + 0.5;
}

float _f5(inout vec2 _p0, float _p1, float _p2, float _p3, float _p4, float _p5, float _p6, vec2 _p7)
{
    vec2 _524 = (vec2(720.0) * u_ScreenParams.xy) / vec2(min(u_ScreenParams.x, u_ScreenParams.y));
    float _527 = floor(_p1);
    float _530 = fract(_p1);
    vec2 param = _p0;
    vec2 param_1 = vec2(_p2, 1.0 + _p6);
    float _t44 = 1.0;
    float _t45 = _p3;
    float _t46 = _f4(param, param_1) * 1.0;
    for (float _t47 = 2.0; _t47 <= 10.0; _t47 += 1.0)
    {
        if (_t47 > _527)
        {
            break;
        }
        _p0 -= (_p7 / _524);
        vec2 param_2 = _p0;
        float param_3 = (_p5 * 3.141592502593994140625) / 180.0;
        vec2 _579 = _f3(param_2, param_3);
        _p0 = _579;
        _p0 *= _p4;
        vec2 param_4 = _p0;
        vec2 param_5 = vec2(_p2, 1.0 + _p6);
        float _591 = _t45;
        _t44 += _591;
        _t45 = _591 * _p3;
        _t46 += (_f4(param_4, param_5) * _591);
    }
    _p0 -= (_p7 / _524);
    vec2 param_6 = _p0;
    float param_7 = (_p5 * 3.141592502593994140625) / 180.0;
    vec2 _615 = _f3(param_6, param_7);
    _p0 = _615;
    _p0 *= _p4;
    vec2 param_8 = _p0;
    vec2 param_9 = vec2(_p2, 1.0 + _p6);
    float _634 = _t44;
    float _635 = _634 + (_t45 * _530);
    _t44 = _635;
    float _637 = _t46;
    float _641 = (_637 + ((_f4(param_8, param_9) * _t45) * _530)) / _635;
    _t46 = _641;
    return clamp(_641, 0.0, 1.0);
}

vec4 _f1(vec2 _p0)
{
    return vec4(floor(_p0.x * 255.0) / 255.0, fract(_p0.x * 255.0), floor(_p0.y * 255.0) / 255.0, fract(_p0.y * 255.0));
}

void main()
{
    vec2 _654 = uv0 - u_Offset;
    vec2 _t48 = _654;
    vec2 param = _654;
    float param_1 = (u_Rotate * 3.141592502593994140625) / 180.0;
    vec2 _662 = _f3(param, param_1);
    _t48 = (_662 * (vec2(1.0) / u_Scale)) - vec2(10.0);
    float _t49 = 0.5;
    float _t50 = 0.5;
    if (u_type < 0.5)
    {
        float _681 = clamp(u_Complexity, 1.0, 10.0);
        float _686 = 100.0 / u_SubScale;
        vec2 param_2 = _t48;
        float param_3 = _681;
        float param_4 = u_Evolution;
        float param_5 = u_SubImpact;
        float param_6 = _686;
        float param_7 = u_SubRotate;
        float param_8 = 2.1099998950958251953125;
        vec2 param_9 = u_SubOffset;
        float _703 = _f5(param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9);
        _t49 = _703;
        vec2 param_10 = _t48;
        float param_11 = _681;
        float param_12 = u_Evolution;
        float param_13 = u_SubImpact;
        float param_14 = _686;
        float param_15 = u_SubRotate;
        float param_16 = 9.71000003814697265625;
        vec2 param_17 = u_SubOffset;
        float _722 = _f5(param_10, param_11, param_12, param_13, param_14, param_15, param_16, param_17);
        _t50 = _722;
    }
    else
    {
        float _728 = clamp(u_Complexity, 1.0, 10.0);
        float _730 = 100.0 / u_SubScale;
        vec2 param_18 = vec2(0.5, _t48.y);
        float param_19 = _728;
        float param_20 = u_Evolution;
        float param_21 = u_SubImpact;
        float param_22 = _730;
        float param_23 = u_SubRotate;
        float param_24 = 2.1099998950958251953125;
        vec2 param_25 = u_SubOffset;
        float _743 = _f5(param_18, param_19, param_20, param_21, param_22, param_23, param_24, param_25);
        _t49 = _743;
        vec2 param_26 = vec2(_t48.x, 0.5);
        float param_27 = _728;
        float param_28 = u_Evolution;
        float param_29 = u_SubImpact;
        float param_30 = _730;
        float param_31 = u_SubRotate;
        float param_32 = 9.71000003814697265625;
        vec2 param_33 = u_SubOffset;
        float _763 = _f5(param_26, param_27, param_28, param_29, param_30, param_31, param_32, param_33);
        _t50 = _763;
    }
    vec2 param_34 = vec2(_t49, _t50);
    gl_FragData[0] = _f1(param_34);
}

