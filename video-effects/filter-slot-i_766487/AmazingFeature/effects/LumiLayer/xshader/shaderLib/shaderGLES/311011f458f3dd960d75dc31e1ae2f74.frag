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
    vec3 _80 = _p3 - _p2;
    vec3 _84 = _p4 - _p2;
    vec3 _88 = cross(_p1, _84);
    float _92 = dot(_80, _88);
    if (_92 <= 1.0000000116860974230803549289703e-07)
    {
        return vec4(-1.0);
    }
    vec3 _105 = _p0 - _p2;
    float _111 = dot(_105, _88) / _92;
    if ((_111 < 0.0) || (_111 > 1.0))
    {
        return vec4(-1.0);
    }
    vec3 _125 = cross(_105, _80);
    float _131 = dot(_p1, _125) / _92;
    bool _133 = _131 < 0.0;
    bool _141;
    if (!_133)
    {
        _141 = (_111 + _131) > 1.0;
    }
    else
    {
        _141 = _133;
    }
    if (_141)
    {
        return vec4(-1.0);
    }
    return vec4(_111, _131, dot(_84, _125) / _92, 1.0);
}

vec2 _f2(mat4 _p0, mat4 _p1, vec2 _p2)
{
    vec3 _180 = (_p0 * vec4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    vec3 _186 = (_p0 * vec4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _191 = (_p0 * vec4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _196 = (_p0 * vec4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    vec4 _207 = _p1 * vec4((_p2 * 2.0) - vec2(1.0), 0.0, 1.0);
    vec4 _t17 = _207;
    vec3 _224 = normalize((_207.xyz / vec3(_t17.w)) - vec3(0.0));
    vec3 param = vec3(0.0);
    vec3 param_1 = _224;
    vec3 _232 = (_p0 * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 param_2 = _232;
    vec3 param_3 = _180;
    vec3 param_4 = _191;
    vec4 _t21 = _f1(param, param_1, param_2, param_3, param_4);
    vec3 param_5 = vec3(0.0);
    vec3 param_6 = _224;
    vec3 param_7 = _196;
    vec3 param_8 = _186;
    vec3 _249 = (_p0 * vec4(10.0, 10.0, 0.0, 1.0)).xyz;
    vec3 param_9 = _249;
    vec4 _t22 = _f1(param_5, param_6, param_7, param_8, param_9);
    vec3 param_10 = vec3(0.0);
    vec3 param_11 = _224;
    vec3 param_12 = _232;
    vec3 param_13 = _191;
    vec3 param_14 = _180;
    vec4 _t23 = _f1(param_10, param_11, param_12, param_13, param_14);
    vec3 param_15 = vec3(0.0);
    vec3 param_16 = _224;
    vec3 param_17 = _196;
    vec3 param_18 = _249;
    vec3 param_19 = _186;
    vec4 _t24 = _f1(param_15, param_16, param_17, param_18, param_19);
    vec2 _415 = (((((((vec2(-4.5) * ((1.0 - _t21.x) - _t21.y)) + (vec2(5.5, -4.5) * _t21.x)) + (vec2(-4.5, 5.5) * _t21.y)) * step(0.0, _t21.w)) + ((((vec2(-4.5, 5.5) * ((1.0 - _t22.x) - _t22.y)) + (vec2(5.5, -4.5) * _t22.x)) + (vec2(5.5) * _t22.y)) * (step(_t21.w, 0.0) * step(0.0, _t22.w)))) + ((((vec2(-4.5) * ((1.0 - _t23.x) - _t23.y)) + (vec2(-4.5, 5.5) * _t23.x)) + (vec2(5.5, -4.5) * _t23.y)) * ((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(0.0, _t23.w)))) + ((((vec2(-4.5, 5.5) * ((1.0 - _t24.x) - _t24.y)) + (vec2(5.5) * _t24.x)) + (vec2(5.5, -4.5) * _t24.y)) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(0.0, _t24.w)))) + (vec2(-10000.0) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(_t24.w, 0.0)));
    return _415;
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

float _f7(float _p0, float _p1)
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

float _f8(float _p0, float _p1)
{
    float _541;
    if (_p0 <= 0.5)
    {
        float param = _p1;
        float param_1 = 2.0 * _p0;
        _541 = _f6(param, param_1);
    }
    else
    {
        float param_2 = _p1;
        float param_3 = 2.0 * (_p0 - 0.5);
        _541 = _f7(param_2, param_3);
    }
    return _541;
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
    float _587 = _p0.w;
    vec4 _590 = _p0;
    vec3 _593 = _590.xyz / vec3(max(_587, 9.9999997473787516355514526367188e-06));
    _p0.x = _593.x;
    _p0.y = _593.y;
    _p0.z = _593.z;
    float _601 = _p1.w;
    vec4 _603 = _p1;
    vec3 _606 = _603.xyz / vec3(max(_601, 9.9999997473787516355514526367188e-06));
    _p1.x = _606.x;
    _p1.y = _606.y;
    _p1.z = _606.z;
    vec4 _t33 = _p1;
    if (u_blendMode == 2)
    {
        vec3 _624 = _p0.xyz * _p1.xyz;
        _t33.x = _624.x;
        _t33.y = _624.y;
        _t33.z = _624.z;
    }
    else
    {
        if (u_blendMode == 17)
        {
            vec3 param = _p0.xyz;
            vec3 param_1 = _p1.xyz;
            vec3 _643 = _f9(param, param_1);
            _t33.x = _643.x;
            _t33.y = _643.y;
            _t33.z = _643.z;
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
        vec4 _690 = mix(_p1, vec4(_t33.xyz, _p0.w), vec4(u_layerOpacity * _t35));
        _t34 = _690;
        float _692 = _t34.w;
        vec3 _695 = _690.xyz * _692;
        _t34.x = _695.x;
        _t34.y = _695.y;
        _t34.z = _695.z;
    }
    else
    {
        vec3 _730 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t33.xyz * (_p0.w * _p1.w));
        _t34.x = _730.x;
        _t34.y = _730.y;
        _t34.z = _730.z;
        _t34.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t34;
}

void main()
{
    vec4 _t36 = vec4(0.0);
    bool _753 = u_hasBlend == 1;
    if (_753)
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
        vec2 _791 = _f2(param, param_1, param_2);
        float _794 = step(u_mirrorEdge, 0.5);
        vec2 param_3 = _791;
        vec2 _804 = (_791 * _794) + (_f4(param_3) * (1.0 - _794));
        vec2 param_4 = _804;
        _t37 = (texture2D(u_sourceTexture, _804) * u_alpha) * _f3(param_4);
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
    if (_753)
    {
        vec4 param_6 = _t37;
        vec4 param_7 = _t36;
        vec4 _842 = _f10(param_6, param_7);
        _t37 = _842;
    }
    gl_FragData[0] = _t37;
}

