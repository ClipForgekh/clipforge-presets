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
    vec4 _260 = _p1 * vec4((_p2 * 2.0) - vec2(1.0), 0.0, 1.0);
    vec4 _t13 = _260;
    vec3 _276 = normalize((_260.xyz / vec3(_t13.w)) - vec3(0.0));
    vec3 _279 = (_p0 * vec4(10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 _282 = _279 + vec3(9.9999997473787516355514526367188e-06, 0.0, 0.0);
    vec3 _284 = (_p0 * vec4(-10.0, 10.0, 0.0, 1.0)).xyz;
    vec3 _286 = _284 + vec3(0.0, 9.9999997473787516355514526367188e-06, 0.0);
    vec3 param = vec3(0.0);
    vec3 param_1 = _276;
    vec3 _293 = (_p0 * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 param_2 = _293;
    vec3 param_3 = _282;
    vec3 param_4 = _286;
    vec4 _t17 = _f3(param, param_1, param_2, param_3, param_4);
    vec3 _300 = _284 - vec3(9.9999997473787516355514526367188e-06, 0.0, 0.0);
    vec3 _303 = _279 - vec3(0.0, 9.9999997473787516355514526367188e-06, 0.0);
    vec3 param_5 = vec3(0.0);
    vec3 param_6 = _276;
    vec3 param_7 = _300;
    vec3 param_8 = _303;
    vec3 _312 = (_p0 * vec4(10.0, 10.0, 0.0, 1.0)).xyz;
    vec3 param_9 = _312;
    vec4 _t18 = _f3(param_5, param_6, param_7, param_8, param_9);
    vec3 param_10 = vec3(0.0);
    vec3 param_11 = _276;
    vec3 param_12 = _293;
    vec3 param_13 = _286;
    vec3 param_14 = _282;
    vec4 _t19 = _f3(param_10, param_11, param_12, param_13, param_14);
    vec3 param_15 = vec3(0.0);
    vec3 param_16 = _276;
    vec3 param_17 = _300;
    vec3 param_18 = _312;
    vec3 param_19 = _303;
    vec4 _t20 = _f3(param_15, param_16, param_17, param_18, param_19);
    vec2 _484 = (((((((vec2(-4.5) * ((1.0 - _t17.x) - _t17.y)) + (vec2(5.5, -4.5) * _t17.x)) + (vec2(-4.5, 5.5) * _t17.y)) * step(0.0, _t17.w)) + ((((vec2(-4.5, 5.5) * ((1.0 - _t18.x) - _t18.y)) + (vec2(5.5, -4.5) * _t18.x)) + (vec2(5.5) * _t18.y)) * (step(_t17.w, 0.0) * step(0.0, _t18.w)))) + ((((vec2(-4.5) * ((1.0 - _t19.x) - _t19.y)) + (vec2(-4.5, 5.5) * _t19.x)) + (vec2(5.5, -4.5) * _t19.y)) * ((step(_t17.w, 0.0) * step(_t18.w, 0.0)) * step(0.0, _t19.w)))) + ((((vec2(-4.5, 5.5) * ((1.0 - _t20.x) - _t20.y)) + (vec2(5.5) * _t20.x)) + (vec2(5.5, -4.5) * _t20.y)) * (((step(_t17.w, 0.0) * step(_t18.w, 0.0)) * step(_t19.w, 0.0)) * step(0.0, _t20.w)))) + (vec2(-10000.0) * (((step(_t17.w, 0.0) * step(_t18.w, 0.0)) * step(_t19.w, 0.0)) * step(_t20.w, 0.0)));
    return _484;
}

vec2 _f6(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f5(vec2 _p0)
{
    vec2 _t26 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t26.x * _t26.y;
}

float _f2(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

vec4 _f7(vec4 _p0)
{
    vec4 _t27 = vec4(0.0);
    if (u_enableMatte == 1)
    {
        _t27 = texture2D(u_maskTexture, uv0);
    }
    float _t28 = _t27.w;
    if (u_matteMode == 1)
    {
        vec3 param = _t27.xyz;
        _t28 = _f2(param);
    }
    else
    {
        if (u_matteMode == 2)
        {
            _t28 = 1.0 - _t27.w;
        }
        else
        {
            if (u_matteMode == 3)
            {
                vec3 param_1 = _t27.xyz;
                _t28 = 1.0 - _f2(param_1);
            }
        }
    }
    return _p0 * _t28;
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
    float _570 = _p0.w;
    vec4 _572 = _p0;
    vec3 _575 = _572.xyz / vec3(max(_570, 9.9999997473787516355514526367188e-06));
    _p0.x = _575.x;
    _p0.y = _575.y;
    _p0.z = _575.z;
    float _583 = _p1.w;
    vec4 _585 = _p1;
    vec3 _588 = _585.xyz / vec3(max(_583, 9.9999997473787516355514526367188e-06));
    _p1.x = _588.x;
    _p1.y = _588.y;
    _p1.z = _588.z;
    vec4 _t29 = _p1;
    if (u_blendMode == 7)
    {
        vec3 param = _p0.xyz;
        vec3 param_1 = _p1.xyz;
        vec3 _609 = _f1(param, param_1);
        _t29.x = _609.x;
        _t29.y = _609.y;
        _t29.z = _609.z;
    }
    else
    {
        _t29.x = _p0.xyz.x;
        _t29.y = _p0.xyz.y;
        _t29.z = _p0.xyz.z;
    }
    vec4 _t30 = vec4(0.0);
    if (u_layerType == 1)
    {
        float _t31 = 1.0;
        if (u_hasMatte == 1)
        {
            vec4 param_2 = vec4(1.0);
            _t31 = _f7(param_2).w;
        }
        vec4 _656 = mix(_p1, vec4(_t29.xyz, _p0.w), vec4(u_layerOpacity * _t31));
        _t30 = _656;
        float _658 = _t30.w;
        vec3 _661 = _656.xyz * _658;
        _t30.x = _661.x;
        _t30.y = _661.y;
        _t30.z = _661.z;
    }
    else
    {
        vec3 _696 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t29.xyz * (_p0.w * _p1.w));
        _t30.x = _696.x;
        _t30.y = _696.y;
        _t30.z = _696.z;
        _t30.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t30;
}

void main()
{
    vec4 _t32 = vec4(0.0);
    bool _719 = u_hasBlend == 1;
    if (_719)
    {
        if (u_hasBaseTexture == 1)
        {
            _t32 = texture2D(u_baseTexure, uv0);
        }
        if (u_hasSourceTexture == 0)
        {
            gl_FragData[0] = _t32;
            return;
        }
    }
    vec4 _t33 = vec4(0.0);
    if (u_hasTrs == 1)
    {
        mat4 param = u_mvMat;
        mat4 param_1 = u_pMat;
        vec2 param_2 = uv0;
        vec2 _757 = _f4(param, param_1, param_2);
        float _760 = step(u_mirrorEdge, 0.5);
        vec2 param_3 = _757;
        vec2 _770 = (_757 * _760) + (_f6(param_3) * (1.0 - _760));
        vec2 param_4 = _770;
        _t33 = (texture2D(u_sourceTexture, _770) * u_alpha) * _f5(param_4);
    }
    else
    {
        if (u_hasSourceTexture == 1)
        {
            _t33 = texture2D(u_sourceTexture, uv0);
        }
    }
    if ((u_layerType != 1) && (u_hasMatte == 1))
    {
        vec4 param_5 = _t33;
        _t33 = _f7(param_5);
    }
    if (_719)
    {
        vec4 param_6 = _t33;
        vec4 param_7 = _t32;
        vec4 _808 = _f8(param_6, param_7);
        _t33 = _808;
    }
    gl_FragData[0] = _t33;
}

