precision highp float;
precision highp int;

uniform mediump sampler2D u_backTex;
uniform mediump sampler2D u_frontTex;
uniform vec2 u_inCornerPosition;
uniform vec2 u_inFoldPosition;
uniform float u_foldRadius;
uniform float u_classicUi;

varying vec2 v_uv0;

vec3 getLineFrom2Pts(vec2 p1, vec2 p2)
{
    return vec3(p1.y - p2.y, p2.x - p1.x, p1.x * p2.y + (-(p1.y * p2.x)));
}

vec4 getParallelLineFromDistance(vec3 line, float dist)
{
    float _238 = sqrt(line.x * line.x + (line.y * line.y));
    return vec4(line.x, line.y, dist * _238 + line.z, (-dist) * _238 + line.z);
}

float crossProduct(vec2 a, vec2 b)
{
    return a.x * b.y + (-(a.y * b.x));
}

float distancePtToLine(vec2 pt, vec3 line)
{
    return abs((line.x * pt.x + (line.y * pt.y)) + line.z) / sqrt(line.x * line.x + (line.y * line.y));
}

float cut(vec2 u)
{
    return ((step(0.0, u.x) * step(u.x, 1.0)) * step(0.0, u.y)) * step(u.y, 1.0);
}

vec2 symmetryPtByLine(vec2 pt, vec3 line)
{
    float _130 = line.y * line.y;
    float _155 = line.x * line.x + _130;
    return vec2(((line.y * line.y + (-(line.x * line.x))) * pt.x + (-((2.0 * line.x) * (line.y * pt.y + line.z)))) / _155, ((line.x * line.x + (-_130)) * pt.y + (-((2.0 * line.y) * (line.x * pt.x + line.z)))) / _155);
}

void cylinderMapping(vec2 i_uv, vec2 cornerPos, vec2 foldPos, float foldRadius, float classicUi, inout vec4 io_res)
{
    float _266 = foldPos.x + 9.9999999392252902907785028219223e-09;
    float _269 = foldPos.y + 9.9999999392252902907785028219223e-09;
    vec2 _270 = vec2(_266, _269);
    vec2 _749;
    if (cornerPos.y >= 1.0)
    {
        vec2 _699 = cornerPos;
        _699.y = max(foldPos.y + 0.001000010059215128421783447265625, cornerPos.y);
        _749 = _699;
    }
    else
    {
        _749 = cornerPos;
    }
    vec2 _750;
    if (_749.y <= 0.0)
    {
        vec2 _704 = _749;
        _704.y = min(foldPos.y + (-0.000999990035779774188995361328125), _749.y);
        _750 = _704;
    }
    else
    {
        _750 = _749;
    }
    vec2 _751;
    if (_750.x >= 1.0)
    {
        vec2 _709 = _750;
        _709.x = max(foldPos.x + 0.001000010059215128421783447265625, _750.x);
        _751 = _709;
    }
    else
    {
        _751 = _750;
    }
    vec2 _752;
    if (_751.x <= 0.0)
    {
        vec2 _714 = _751;
        _714.x = min(foldPos.x + (-0.000999990035779774188995361328125), _751.x);
        _752 = _714;
    }
    else
    {
        _752 = _751;
    }
    float _323 = max(foldRadius, 9.9999999392252902907785028219223e-09);
    vec2 _334 = (_752 + _270) * 0.5;
    float _339 = _323 * 1.57079637050628662109375;
    vec2 param = _752;
    vec2 param_1 = _270;
    vec3 _345 = getLineFrom2Pts(param, param_1);
    float _348 = _345.y;
    float _350 = _345.x;
    float _351 = -_350;
    float _371 = sign(_348 / (9.9999999392252902907785028219223e-09 - _350));
    vec3 _389 = vec3(_348, _351, _350 * _334.y + (-(_348 * _334.x)));
    vec3 _753;
    if (classicUi > 0.5)
    {
        vec3 param_2 = _389;
        float param_3 = 0.0;
        _753 = getParallelLineFromDistance(param_2, param_3).xyw;
    }
    else
    {
        _753 = vec3(_348, _351, _350 * _269 + (-(_348 * _266)));
    }
    vec3 param_4 = _389;
    float param_5 = _339;
    vec4 _404 = getParallelLineFromDistance(param_4, param_5);
    vec3 _405 = _404.xyw;
    vec3 param_6 = _405;
    float param_7 = _323;
    vec3 _754;
    float _765;
    if (_371 < 0.0)
    {
        bool _423 = (_753.z - _404.w) > 0.0;
        vec3 _755;
        if (_423)
        {
            vec3 _733 = _405;
            _733.z = _753.z;
            vec3 param_8 = _733;
            float param_9 = _323;
            _755 = _733;
        }
        else
        {
            _755 = _405;
        }
        _765 = float(_423);
        _754 = _755;
    }
    else
    {
        bool _441 = (_404.w - _753.z) < 0.0;
        vec3 _756;
        if (_441)
        {
            vec3 _738 = _405;
            _738.z = _753.z;
            vec3 param_10 = _738;
            float param_11 = _323;
            _756 = _738;
        }
        else
        {
            _756 = _405;
        }
        _765 = float(_441);
        _754 = _756;
    }
    float _456 = -_754.z;
    vec2 _469 = vec2(((-_754.y) * _752.y + _456) / (_754.x + 9.9999999392252902907785028219223e-09), _752.y);
    vec2 _486 = vec2(_752.x, ((-_754.x) * _752.x + _456) / (_754.y + 9.9999999392252902907785028219223e-09));
    bvec2 _788 = bvec2(_371 > 0.0);
    vec2 _791 = vec2(_788.x ? _486.x : _469.x, _788.y ? _486.y : _469.y);
    vec2 param_12 = _791 - vec2(_788.x ? _469.x : _486.x, _788.y ? _469.y : _486.y);
    vec2 param_13 = _791 - i_uv;
    float _506 = float(crossProduct(param_12, param_13) > 0.0);
    vec2 param_14 = i_uv;
    vec3 param_15 = _754;
    float _512 = distancePtToLine(param_14, param_15);
    float _521 = step(_512, _323 + 0.001000000047497451305389404296875);
    vec2 _542 = clamp(i_uv + (normalize(-normalize(_270 - _752)) * ((asin(_512 / _323) * _521) * _323 + (-_512))), vec2(-10.0), vec2(10.0));
    vec2 param_16 = _542;
    mediump vec4 _560 = texture2D(u_backTex, mix(_542 * cut(param_16), i_uv, vec2(_506)));
    vec2 param_17 = _542;
    vec4 _568 = _560 * clamp(_506 + cut(param_17), 0.0, 1.0);
    vec4 _578 = _568 * step(_512, _323 + 9.9999997473787516355514526367188e-05);
    vec3 _768;
    if (_765 > 0.5)
    {
        vec3 param_18 = _754;
        float param_19 = _339;
        _768 = getParallelLineFromDistance(param_18, param_19).xyz;
    }
    else
    {
        _768 = _389;
    }
    vec2 param_20 = i_uv;
    vec3 param_21 = _768;
    vec2 _606 = symmetryPtByLine(param_20, param_21);
    vec2 param_22 = _606;
    vec2 param_23 = _542;
    vec3 param_24 = _768;
    vec2 _618 = symmetryPtByLine(param_23, param_24);
    vec2 param_25 = _618;
    float _625 = cut(param_25) * (1.0 - _506);
    io_res = mix(texture2D(u_frontTex, mix(_606, _618, vec2(_625 * _521))) * clamp(_625 * _521 + (_506 * cut(param_22)), 0.0, 1.0), io_res, vec4(io_res.w));
    io_res = mix(mix(_568 * _506, _578, vec4(_578.w)), io_res, vec4(io_res.w));
}

void main()
{
    vec2 param = v_uv0;
    vec2 param_1 = u_inCornerPosition;
    vec2 param_2 = u_inFoldPosition;
    float param_3 = u_foldRadius;
    float param_4 = u_classicUi;
    vec4 param_5 = vec4(0.0);
    cylinderMapping(param, param_1, param_2, param_3, param_4, param_5);
    vec2 param_6 = v_uv0;
    gl_FragData[0] = param_5 * cut(param_6);
}

