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

vec4 _f3(vec3 _p0, vec3 _p1, vec3 _p2, vec3 _p3, vec3 _p4)
{
    vec3 _166 = _p3 - _p2;
    vec3 _170 = _p4 - _p2;
    vec3 _174 = cross(_p1, _170);
    float _178 = dot(_166, _174);
    if (_178 <= 1.0000000116860974230803549289703e-07)
    {
        return vec4(-1.0);
    }
    vec3 _190 = _p0 - _p2;
    float _196 = dot(_190, _174) / _178;
    if ((_196 < 0.0) || (_196 > 1.0))
    {
        return vec4(-1.0);
    }
    vec3 _209 = cross(_190, _166);
    float _215 = dot(_p1, _209) / _178;
    bool _217 = _215 < 0.0;
    bool _225;
    if (!_217)
    {
        _225 = (_196 + _215) > 1.0;
    }
    else
    {
        _225 = _217;
    }
    if (_225)
    {
        return vec4(-1.0);
    }
    return vec4(_196, _215, dot(_170, _209) / _178, 1.0);
}

vec2 _f4(mat4 _p0, mat4 _p1, vec2 _p2)
{
    vec3 _264 = (_p0 * vec4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    vec3 _270 = (_p0 * vec4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _275 = (_p0 * vec4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _280 = (_p0 * vec4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    vec4 _290 = _p1 * vec4((_p2 * 2.0) - vec2(1.0), 0.0, 1.0);
    vec4 _t17 = _290;
    vec3 _306 = normalize((_290.xyz / vec3(_t17.w)) - vec3(0.0));
    vec3 param = vec3(0.0);
    vec3 param_1 = _306;
    vec3 _314 = (_p0 * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 param_2 = _314;
    vec3 param_3 = _264;
    vec3 param_4 = _275;
    vec4 _t21 = _f3(param, param_1, param_2, param_3, param_4);
    vec3 param_5 = vec3(0.0);
    vec3 param_6 = _306;
    vec3 param_7 = _280;
    vec3 param_8 = _270;
    vec3 _331 = (_p0 * vec4(10.0, 10.0, 0.0, 1.0)).xyz;
    vec3 param_9 = _331;
    vec4 _t22 = _f3(param_5, param_6, param_7, param_8, param_9);
    vec3 param_10 = vec3(0.0);
    vec3 param_11 = _306;
    vec3 param_12 = _314;
    vec3 param_13 = _275;
    vec3 param_14 = _264;
    vec4 _t23 = _f3(param_10, param_11, param_12, param_13, param_14);
    vec3 param_15 = vec3(0.0);
    vec3 param_16 = _306;
    vec3 param_17 = _280;
    vec3 param_18 = _331;
    vec3 param_19 = _270;
    vec4 _t24 = _f3(param_15, param_16, param_17, param_18, param_19);
    vec2 _495 = (((((((vec2(-4.5) * ((1.0 - _t21.x) - _t21.y)) + (vec2(5.5, -4.5) * _t21.x)) + (vec2(-4.5, 5.5) * _t21.y)) * step(0.0, _t21.w)) + ((((vec2(-4.5, 5.5) * ((1.0 - _t22.x) - _t22.y)) + (vec2(5.5, -4.5) * _t22.x)) + (vec2(5.5) * _t22.y)) * (step(_t21.w, 0.0) * step(0.0, _t22.w)))) + ((((vec2(-4.5) * ((1.0 - _t23.x) - _t23.y)) + (vec2(-4.5, 5.5) * _t23.x)) + (vec2(5.5, -4.5) * _t23.y)) * ((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(0.0, _t23.w)))) + ((((vec2(-4.5, 5.5) * ((1.0 - _t24.x) - _t24.y)) + (vec2(5.5) * _t24.x)) + (vec2(5.5, -4.5) * _t24.y)) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(0.0, _t24.w)))) + (vec2(-10000.0) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(_t24.w, 0.0)));
    return _495;
}

vec2 _f6(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f5(vec2 _p0)
{
    vec2 _t30 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t30.x * _t30.y;
}

float _f2(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

vec4 _f7(vec4 _p0)
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
        _t32 = _f2(param);
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
                _t32 = 1.0 - _f2(param_1);
            }
        }
    }
    return _p0 * _t32;
}

float _f0(float _p0, float _p1)
{
    float _73;
    if (_p0 < 0.5)
    {
        _73 = _p1 - (((1.0 - (2.0 * _p0)) * _p1) * (1.0 - _p1));
    }
    else
    {
        float _92;
        if (_p1 < 0.25)
        {
            _92 = _p1 + ((((2.0 * _p0) - 1.0) * _p1) * ((((16.0 * _p1) - 12.0) * _p1) + 3.0));
        }
        else
        {
            _92 = _p1 + (((2.0 * _p0) - 1.0) * (sqrt(_p1) - _p1));
        }
        _73 = _92;
    }
    return _73;
}

vec3 _f1(vec3 _p0, vec3 _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return vec3(_f0(param, param_1), _f0(param_2, param_3), _f0(param_4, param_5));
}

float _f8(float _p0, float _p1)
{
    if (_p1 >= 1.0)
    {
        return 1.0;
    }
    else
    {
        if (_p0 <= 0.0)
        {
            return 0.0;
        }
        else
        {
            return 1.0 - min(1.0, (1.0 - _p1) / _p0);
        }
    }
}

vec3 _f9(vec3 _p0, vec3 _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return vec3(_f8(param, param_1), _f8(param_2, param_3), _f8(param_4, param_5));
}

vec4 _f10(inout vec4 _p0, inout vec4 _p1)
{
    float _625 = _p0.w;
    vec4 _628 = _p0;
    vec3 _631 = _628.xyz / vec3(max(_625, 9.9999997473787516355514526367188e-06));
    _p0.x = _631.x;
    _p0.y = _631.y;
    _p0.z = _631.z;
    float _639 = _p1.w;
    vec4 _641 = _p1;
    vec3 _644 = _641.xyz / vec3(max(_639, 9.9999997473787516355514526367188e-06));
    _p1.x = _644.x;
    _p1.y = _644.y;
    _p1.z = _644.z;
    vec4 _t33 = _p1;
    if (u_blendMode == 7)
    {
        vec3 param = _p0.xyz;
        vec3 param_1 = _p1.xyz;
        vec3 _665 = _f1(param, param_1);
        _t33.x = _665.x;
        _t33.y = _665.y;
        _t33.z = _665.z;
    }
    else
    {
        if (u_blendMode == 13)
        {
            vec3 param_2 = _p0.xyz;
            vec3 param_3 = _p1.xyz;
            vec3 _684 = _f9(param_2, param_3);
            _t33.x = _684.x;
            _t33.y = _684.y;
            _t33.z = _684.z;
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
            vec4 param_4 = vec4(1.0);
            _t35 = _f7(param_4).w;
        }
        vec4 _731 = mix(_p1, vec4(_t33.xyz, _p0.w), vec4(u_layerOpacity * _t35));
        _t34 = _731;
        float _733 = _t34.w;
        vec3 _736 = _731.xyz * _733;
        _t34.x = _736.x;
        _t34.y = _736.y;
        _t34.z = _736.z;
    }
    else
    {
        vec3 _771 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t33.xyz * (_p0.w * _p1.w));
        _t34.x = _771.x;
        _t34.y = _771.y;
        _t34.z = _771.z;
        _t34.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t34;
}

void main()
{
    vec4 _t36 = vec4(0.0);
    bool _794 = u_hasBlend == 1;
    if (_794)
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
        vec2 _832 = _f4(param, param_1, param_2);
        float _835 = step(u_mirrorEdge, 0.5);
        vec2 param_3 = _832;
        vec2 _845 = (_832 * _835) + (_f6(param_3) * (1.0 - _835));
        vec2 param_4 = _845;
        _t37 = (texture2D(u_sourceTexture, _845) * u_alpha) * _f5(param_4);
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
        _t37 = _f7(param_5);
    }
    if (_794)
    {
        vec4 param_6 = _t37;
        vec4 param_7 = _t36;
        vec4 _883 = _f10(param_6, param_7);
        _t37 = _883;
    }
    gl_FragData[0] = _t37;
}

