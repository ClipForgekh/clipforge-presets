precision highp float;
precision highp int;

uniform mediump int u_enableMatte;
uniform mediump sampler2D u_maskTexture;
uniform mediump int u_matteMode;
uniform mediump int u_blendMode;
uniform mediump int u_layerType;
uniform mediump int u_hasMatte;
uniform float u_layerOpacity;
uniform mediump int u_hasBlend;
uniform mediump int u_hasBaseTexture;
uniform mediump sampler2D u_baseTexure;
uniform mediump int u_hasSourceTexture;
uniform mediump int u_hasTrs;
uniform mat4 u_mvMat;
uniform mat4 u_pMat;
uniform float u_mirrorEdge;
uniform mediump sampler2D u_sourceTexture;
uniform float u_alpha;

varying vec2 uv0;

vec4 _f1(vec3 _p0, vec3 _p1, vec3 _p2, vec3 _p3, vec3 _p4)
{
    vec3 _72 = _p3 - _p2;
    vec3 _76 = _p4 - _p2;
    vec3 _80 = cross(_p1, _76);
    float _84 = dot(_72, _80);
    if (_84 <= 1.0000000116860974230803549289703e-07)
    {
        return vec4(-1.0);
    }
    vec3 _97 = _p0 - _p2;
    float _103 = dot(_97, _80) / _84;
    if ((_103 < 0.0) || (_103 > 1.0))
    {
        return vec4(-1.0);
    }
    vec3 _117 = cross(_97, _72);
    float _123 = dot(_p1, _117) / _84;
    bool _125 = _123 < 0.0;
    bool _133;
    if (!_125)
    {
        _133 = (_103 + _123) > 1.0;
    }
    else
    {
        _133 = _125;
    }
    if (_133)
    {
        return vec4(-1.0);
    }
    return vec4(_103, _123, dot(_76, _117) / _84, 1.0);
}

vec2 _f2(mat4 _p0, mat4 _p1, vec2 _p2)
{
    vec3 _172 = (_p0 * vec4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    vec3 _178 = (_p0 * vec4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _183 = (_p0 * vec4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _188 = (_p0 * vec4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    vec4 _199 = _p1 * vec4((_p2 * 2.0) - vec2(1.0), 0.0, 1.0);
    vec4 _t17 = _199;
    vec3 _216 = normalize((_199.xyz / vec3(_t17.w)) - vec3(0.0));
    vec3 param = vec3(0.0);
    vec3 param_1 = _216;
    vec3 _224 = (_p0 * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 param_2 = _224;
    vec3 param_3 = _172;
    vec3 param_4 = _183;
    vec4 _t21 = _f1(param, param_1, param_2, param_3, param_4);
    vec3 param_5 = vec3(0.0);
    vec3 param_6 = _216;
    vec3 param_7 = _188;
    vec3 param_8 = _178;
    vec3 _241 = (_p0 * vec4(10.0, 10.0, 0.0, 1.0)).xyz;
    vec3 param_9 = _241;
    vec4 _t22 = _f1(param_5, param_6, param_7, param_8, param_9);
    vec3 param_10 = vec3(0.0);
    vec3 param_11 = _216;
    vec3 param_12 = _224;
    vec3 param_13 = _183;
    vec3 param_14 = _172;
    vec4 _t23 = _f1(param_10, param_11, param_12, param_13, param_14);
    vec3 param_15 = vec3(0.0);
    vec3 param_16 = _216;
    vec3 param_17 = _188;
    vec3 param_18 = _241;
    vec3 param_19 = _178;
    vec4 _t24 = _f1(param_15, param_16, param_17, param_18, param_19);
    vec2 _407 = (((((((vec2(-4.5) * ((1.0 - _t21.x) - _t21.y)) + (vec2(5.5, -4.5) * _t21.x)) + (vec2(-4.5, 5.5) * _t21.y)) * step(0.0, _t21.w)) + ((((vec2(-4.5, 5.5) * ((1.0 - _t22.x) - _t22.y)) + (vec2(5.5, -4.5) * _t22.x)) + (vec2(5.5) * _t22.y)) * (step(_t21.w, 0.0) * step(0.0, _t22.w)))) + ((((vec2(-4.5) * ((1.0 - _t23.x) - _t23.y)) + (vec2(-4.5, 5.5) * _t23.x)) + (vec2(5.5, -4.5) * _t23.y)) * ((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(0.0, _t23.w)))) + ((((vec2(-4.5, 5.5) * ((1.0 - _t24.x) - _t24.y)) + (vec2(5.5) * _t24.x)) + (vec2(5.5, -4.5) * _t24.y)) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(0.0, _t24.w)))) + (vec2(-10000.0) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(_t24.w, 0.0)));
    return _407;
}

vec2 _f4(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f3(vec2 _p0)
{
    vec2 _t30 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t30.x * _t30.y;
}

float _f0(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

vec4 _f5(vec4 _p0)
{
    vec4 _t31 = vec4(0.0);
    if (u_enableMatte == 1)
    {
        _t31 = texture2D(u_maskTexture, uv0);
    }
    float _t32 = _t31.w;
    if (u_matteMode == 1)
    {
        vec3 param = _t31.xyz;
        _t32 = _f0(param);
    }
    else
    {
        if (u_matteMode == 2)
        {
            _t32 = 1.0 - _t31.w;
        }
        else
        {
            if (u_matteMode == 3)
            {
                vec3 param_1 = _t31.xyz;
                _t32 = 1.0 - _f0(param_1);
            }
        }
    }
    return _p0 * _t32;
}

float _f6(float _p0, float _p1)
{
    if (_p1 <= 0.0)
    {
        return 0.0;
    }
    if (_p0 >= 1.0)
    {
        return 1.0;
    }
    else
    {
        return min(1.0, _p1 / (1.0 - _p0));
    }
}

vec3 _f7(vec3 _p0, vec3 _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return vec3(_f6(param, param_1), _f6(param_2, param_3), _f6(param_4, param_5));
}

vec4 _f8(inout vec4 _p0, inout vec4 _p1)
{
    float _536 = _p0.w;
    vec4 _539 = _p0;
    vec3 _542 = _539.xyz / vec3(max(_536, 9.9999997473787516355514526367188e-06));
    _p0.x = _542.x;
    _p0.y = _542.y;
    _p0.z = _542.z;
    float _550 = _p1.w;
    vec4 _552 = _p1;
    vec3 _555 = _552.xyz / vec3(max(_550, 9.9999997473787516355514526367188e-06));
    _p1.x = _555.x;
    _p1.y = _555.y;
    _p1.z = _555.z;
    vec4 _t33 = _p1;
    if (u_blendMode == 12)
    {
        vec3 _580 = (_p0.xyz + _p1.xyz) - (_p0.xyz * _p1.xyz);
        _t33.x = _580.x;
        _t33.y = _580.y;
        _t33.z = _580.z;
    }
    else
    {
        if (u_blendMode == 15)
        {
            vec3 param = _p0.xyz;
            vec3 param_1 = _p1.xyz;
            vec3 _599 = _f7(param, param_1);
            _t33.x = _599.x;
            _t33.y = _599.y;
            _t33.z = _599.z;
        }
        else
        {
            _t33.x = _p0.xyz.x;
            _t33.y = _p0.xyz.y;
            _t33.z = _p0.xyz.z;
        }
    }
    vec4 _t34 = vec4(0.0);
    if (u_layerType == 1)
    {
        float _t35 = 1.0;
        if (u_hasMatte == 1)
        {
            vec4 param_2 = vec4(1.0);
            _t35 = _f5(param_2).w;
        }
        vec4 _646 = mix(_p1, vec4(_t33.xyz, _p0.w), vec4(u_layerOpacity * _t35));
        _t34 = _646;
        float _648 = _t34.w;
        vec3 _651 = _646.xyz * _648;
        _t34.x = _651.x;
        _t34.y = _651.y;
        _t34.z = _651.z;
    }
    else
    {
        vec3 _686 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t33.xyz * (_p0.w * _p1.w));
        _t34.x = _686.x;
        _t34.y = _686.y;
        _t34.z = _686.z;
        _t34.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t34;
}

void main()
{
    vec4 _t36 = vec4(0.0);
    bool _709 = u_hasBlend == 1;
    if (_709)
    {
        if (u_hasBaseTexture == 1)
        {
            _t36 = texture2D(u_baseTexure, uv0);
        }
        if (u_hasSourceTexture == 0)
        {
            gl_FragData[0] = _t36;
            return;
        }
    }
    vec4 _t37 = vec4(0.0);
    if (u_hasTrs == 1)
    {
        mat4 param = u_mvMat;
        mat4 param_1 = u_pMat;
        vec2 param_2 = uv0;
        vec2 _747 = _f2(param, param_1, param_2);
        float _751 = step(u_mirrorEdge, 0.5);
        vec2 param_3 = _747;
        vec2 _761 = (_747 * _751) + (_f4(param_3) * (1.0 - _751));
        vec2 param_4 = _761;
        _t37 = (texture2D(u_sourceTexture, _761) * u_alpha) * _f3(param_4);
    }
    else
    {
        if (u_hasSourceTexture == 1)
        {
            _t37 = texture2D(u_sourceTexture, uv0);
        }
    }
    if ((u_layerType != 1) && (u_hasMatte == 1))
    {
        vec4 param_5 = _t37;
        _t37 = _f5(param_5);
    }
    if (_709)
    {
        vec4 param_6 = _t37;
        vec4 param_7 = _t36;
        vec4 _799 = _f8(param_6, param_7);
        _t37 = _799;
    }
    gl_FragData[0] = _t37;
}

