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
    vec3 _158 = _p3 - _p2;
    vec3 _162 = _p4 - _p2;
    vec3 _166 = cross(_p1, _162);
    float _170 = dot(_158, _166);
    if (_170 <= 1.0000000116860974230803549289703e-07)
    {
        return vec4(-1.0);
    }
    vec3 _182 = _p0 - _p2;
    float _188 = dot(_182, _166) / _170;
    if ((_188 < 0.0) || (_188 > 1.0))
    {
        return vec4(-1.0);
    }
    vec3 _201 = cross(_182, _158);
    float _207 = dot(_p1, _201) / _170;
    bool _209 = _207 < 0.0;
    bool _217;
    if (!_209)
    {
        _217 = (_188 + _207) > 1.0;
    }
    else
    {
        _217 = _209;
    }
    if (_217)
    {
        return vec4(-1.0);
    }
    return vec4(_188, _207, dot(_162, _201) / _170, 1.0);
}

vec2 _f4(mat4 _p0, mat4 _p1, vec2 _p2)
{
    vec3 _256 = (_p0 * vec4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    vec3 _262 = (_p0 * vec4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _267 = (_p0 * vec4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _272 = (_p0 * vec4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    vec4 _282 = _p1 * vec4((_p2 * 2.0) - vec2(1.0), 0.0, 1.0);
    vec4 _t17 = _282;
    vec3 _298 = normalize((_282.xyz / vec3(_t17.w)) - vec3(0.0));
    vec3 param = vec3(0.0);
    vec3 param_1 = _298;
    vec3 _306 = (_p0 * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 param_2 = _306;
    vec3 param_3 = _256;
    vec3 param_4 = _267;
    vec4 _t21 = _f3(param, param_1, param_2, param_3, param_4);
    vec3 param_5 = vec3(0.0);
    vec3 param_6 = _298;
    vec3 param_7 = _272;
    vec3 param_8 = _262;
    vec3 _323 = (_p0 * vec4(10.0, 10.0, 0.0, 1.0)).xyz;
    vec3 param_9 = _323;
    vec4 _t22 = _f3(param_5, param_6, param_7, param_8, param_9);
    vec3 param_10 = vec3(0.0);
    vec3 param_11 = _298;
    vec3 param_12 = _306;
    vec3 param_13 = _267;
    vec3 param_14 = _256;
    vec4 _t23 = _f3(param_10, param_11, param_12, param_13, param_14);
    vec3 param_15 = vec3(0.0);
    vec3 param_16 = _298;
    vec3 param_17 = _272;
    vec3 param_18 = _323;
    vec3 param_19 = _262;
    vec4 _t24 = _f3(param_15, param_16, param_17, param_18, param_19);
    vec2 _487 = (((((((vec2(-4.5) * ((1.0 - _t21.x) - _t21.y)) + (vec2(5.5, -4.5) * _t21.x)) + (vec2(-4.5, 5.5) * _t21.y)) * step(0.0, _t21.w)) + ((((vec2(-4.5, 5.5) * ((1.0 - _t22.x) - _t22.y)) + (vec2(5.5, -4.5) * _t22.x)) + (vec2(5.5) * _t22.y)) * (step(_t21.w, 0.0) * step(0.0, _t22.w)))) + ((((vec2(-4.5) * ((1.0 - _t23.x) - _t23.y)) + (vec2(-4.5, 5.5) * _t23.x)) + (vec2(5.5, -4.5) * _t23.y)) * ((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(0.0, _t23.w)))) + ((((vec2(-4.5, 5.5) * ((1.0 - _t24.x) - _t24.y)) + (vec2(5.5) * _t24.x)) + (vec2(5.5, -4.5) * _t24.y)) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(0.0, _t24.w)))) + (vec2(-10000.0) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(_t24.w, 0.0)));
    return _487;
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
    float _65;
    if (_p0 < 0.5)
    {
        _65 = _p1 - (((1.0 - (2.0 * _p0)) * _p1) * (1.0 - _p1));
    }
    else
    {
        float _84;
        if (_p1 < 0.25)
        {
            _84 = _p1 + ((((2.0 * _p0) - 1.0) * _p1) * ((((16.0 * _p1) - 12.0) * _p1) + 3.0));
        }
        else
        {
            _84 = _p1 + (((2.0 * _p0) - 1.0) * (sqrt(_p1) - _p1));
        }
        _65 = _84;
    }
    return _65;
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

vec4 _f8(inout vec4 _p0, inout vec4 _p1)
{
    float _573 = _p0.w;
    vec4 _576 = _p0;
    vec3 _579 = _576.xyz / vec3(max(_573, 9.9999997473787516355514526367188e-06));
    _p0.x = _579.x;
    _p0.y = _579.y;
    _p0.z = _579.z;
    float _587 = _p1.w;
    vec4 _589 = _p1;
    vec3 _592 = _589.xyz / vec3(max(_587, 9.9999997473787516355514526367188e-06));
    _p1.x = _592.x;
    _p1.y = _592.y;
    _p1.z = _592.z;
    vec4 _t33 = _p1;
    if (u_blendMode == 1)
    {
        vec3 _610 = _p0.xyz + _p1.xyz;
        _t33.x = _610.x;
        _t33.y = _610.y;
        _t33.z = _610.z;
    }
    else
    {
        if (u_blendMode == 7)
        {
            vec3 param = _p0.xyz;
            vec3 param_1 = _p1.xyz;
            vec3 _629 = _f1(param, param_1);
            _t33.x = _629.x;
            _t33.y = _629.y;
            _t33.z = _629.z;
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
            _t35 = _f7(param_2).w;
        }
        vec4 _676 = mix(_p1, vec4(_t33.xyz, _p0.w), vec4(u_layerOpacity * _t35));
        _t34 = _676;
        float _678 = _t34.w;
        vec3 _681 = _676.xyz * _678;
        _t34.x = _681.x;
        _t34.y = _681.y;
        _t34.z = _681.z;
    }
    else
    {
        vec3 _716 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t33.xyz * (_p0.w * _p1.w));
        _t34.x = _716.x;
        _t34.y = _716.y;
        _t34.z = _716.z;
        _t34.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t34;
}

void main()
{
    vec4 _t36 = vec4(0.0);
    bool _739 = u_hasBlend == 1;
    if (_739)
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
        vec2 _777 = _f4(param, param_1, param_2);
        float _780 = step(u_mirrorEdge, 0.5);
        vec2 param_3 = _777;
        vec2 _790 = (_777 * _780) + (_f6(param_3) * (1.0 - _780));
        vec2 param_4 = _790;
        _t37 = (texture2D(u_sourceTexture, _790) * u_alpha) * _f5(param_4);
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
    if (_739)
    {
        vec4 param_6 = _t37;
        vec4 param_7 = _t36;
        vec4 _828 = _f8(param_6, param_7);
        _t37 = _828;
    }
    gl_FragData[0] = _t37;
}

