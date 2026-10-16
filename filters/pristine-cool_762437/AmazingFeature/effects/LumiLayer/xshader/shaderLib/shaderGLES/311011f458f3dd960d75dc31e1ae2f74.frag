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

vec4 _f4(vec3 _p0, vec3 _p1, vec3 _p2, vec3 _p3, vec3 _p4)
{
    vec3 _235 = _p3 - _p2;
    vec3 _239 = _p4 - _p2;
    vec3 _243 = cross(_p1, _239);
    float _247 = dot(_235, _243);
    if (_247 <= 1.0000000116860974230803549289703e-07)
    {
        return vec4(-1.0);
    }
    vec3 _259 = _p0 - _p2;
    float _265 = dot(_259, _243) / _247;
    if ((_265 < 0.0) || (_265 > 1.0))
    {
        return vec4(-1.0);
    }
    vec3 _277 = cross(_259, _235);
    float _283 = dot(_p1, _277) / _247;
    bool _285 = _283 < 0.0;
    bool _293;
    if (!_285)
    {
        _293 = (_265 + _283) > 1.0;
    }
    else
    {
        _293 = _285;
    }
    if (_293)
    {
        return vec4(-1.0);
    }
    return vec4(_265, _283, dot(_239, _277) / _247, 1.0);
}

vec2 _f5(mat4 _p0, mat4 _p1, vec2 _p2)
{
    vec3 _332 = (_p0 * vec4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    vec3 _338 = (_p0 * vec4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _343 = (_p0 * vec4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _348 = (_p0 * vec4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    vec4 _358 = _p1 * vec4((_p2 * 2.0) - vec2(1.0), 0.0, 1.0);
    vec4 _t20 = _358;
    vec3 _374 = normalize((_358.xyz / vec3(_t20.w)) - vec3(0.0));
    vec3 param = vec3(0.0);
    vec3 param_1 = _374;
    vec3 _382 = (_p0 * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 param_2 = _382;
    vec3 param_3 = _332;
    vec3 param_4 = _343;
    vec4 _t24 = _f4(param, param_1, param_2, param_3, param_4);
    vec3 param_5 = vec3(0.0);
    vec3 param_6 = _374;
    vec3 param_7 = _348;
    vec3 param_8 = _338;
    vec3 _399 = (_p0 * vec4(10.0, 10.0, 0.0, 1.0)).xyz;
    vec3 param_9 = _399;
    vec4 _t25 = _f4(param_5, param_6, param_7, param_8, param_9);
    vec3 param_10 = vec3(0.0);
    vec3 param_11 = _374;
    vec3 param_12 = _382;
    vec3 param_13 = _343;
    vec3 param_14 = _332;
    vec4 _t26 = _f4(param_10, param_11, param_12, param_13, param_14);
    vec3 param_15 = vec3(0.0);
    vec3 param_16 = _374;
    vec3 param_17 = _348;
    vec3 param_18 = _399;
    vec3 param_19 = _338;
    vec4 _t27 = _f4(param_15, param_16, param_17, param_18, param_19);
    vec2 _563 = (((((((vec2(-4.5) * ((1.0 - _t24.x) - _t24.y)) + (vec2(5.5, -4.5) * _t24.x)) + (vec2(-4.5, 5.5) * _t24.y)) * step(0.0, _t24.w)) + ((((vec2(-4.5, 5.5) * ((1.0 - _t25.x) - _t25.y)) + (vec2(5.5, -4.5) * _t25.x)) + (vec2(5.5) * _t25.y)) * (step(_t24.w, 0.0) * step(0.0, _t25.w)))) + ((((vec2(-4.5) * ((1.0 - _t26.x) - _t26.y)) + (vec2(-4.5, 5.5) * _t26.x)) + (vec2(5.5, -4.5) * _t26.y)) * ((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(0.0, _t26.w)))) + ((((vec2(-4.5, 5.5) * ((1.0 - _t27.x) - _t27.y)) + (vec2(5.5) * _t27.x)) + (vec2(5.5, -4.5) * _t27.y)) * (((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(_t26.w, 0.0)) * step(0.0, _t27.w)))) + (vec2(-10000.0) * (((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(_t26.w, 0.0)) * step(_t27.w, 0.0)));
    return _563;
}

vec2 _f7(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f6(vec2 _p0)
{
    vec2 _t33 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t33.x * _t33.y;
}

float _f2(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

vec4 _f8(vec4 _p0)
{
    vec4 _t34 = vec4(0.0);
    if (u_enableMatte == 1)
    {
        _t34 = texture2D(u_maskTexture, uv0);
    }
    float _t35 = _t34.w;
    if (u_matteMode == 1)
    {
        vec3 param = _t34.xyz;
        _t35 = _f2(param);
    }
    else
    {
        if (u_matteMode == 2)
        {
            _t35 = 1.0 - _t34.w;
        }
        else
        {
            if (u_matteMode == 3)
            {
                vec3 param_1 = _t34.xyz;
                _t35 = 1.0 - _f2(param_1);
            }
        }
    }
    return _p0 * _t35;
}

float _f0(float _p0, float _p1)
{
    float _74;
    if (_p0 < 0.5)
    {
        _74 = _p1 - (((1.0 - (2.0 * _p0)) * _p1) * (1.0 - _p1));
    }
    else
    {
        float _93;
        if (_p1 < 0.25)
        {
            _93 = _p1 + ((((2.0 * _p0) - 1.0) * _p1) * ((((16.0 * _p1) - 12.0) * _p1) + 3.0));
        }
        else
        {
            _93 = _p1 + (((2.0 * _p0) - 1.0) * (sqrt(_p1) - _p1));
        }
        _74 = _93;
    }
    return _74;
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

vec3 _f3(inout vec3 _p0, inout float _p1)
{
    vec3 param = _p0;
    _p0 += vec3(_p1 - _f2(param));
    vec3 param_1 = _p0;
    _p1 = _f2(param_1);
    float _185 = min(_p0.x, min(_p0.y, _p0.z));
    float _188 = _p0.x;
    float _190 = _p0.y;
    float _192 = _p0.z;
    float _194 = max(_188, max(_190, _192));
    if (_185 < 0.0)
    {
        _p0 = mix(vec3(_p1, _p1, _p1), _p0, vec3(_p1 / (_p1 - _185)));
    }
    if (_194 > 1.0)
    {
        _p0 = mix(vec3(_p1, _p1, _p1), _p0, vec3((1.0 - _p1) / (_194 - _p1)));
    }
    return _p0;
}

vec3 _f9(vec3 _p0, vec3 _p1)
{
    vec3 param = _p1;
    vec3 param_1 = _p0;
    float param_2 = _f2(param);
    vec3 _654 = _f3(param_1, param_2);
    return _654;
}

vec4 _f10(inout vec4 _p0, inout vec4 _p1)
{
    float _658 = _p0.w;
    vec4 _661 = _p0;
    vec3 _664 = _661.xyz / vec3(max(_658, 9.9999997473787516355514526367188e-06));
    _p0.x = _664.x;
    _p0.y = _664.y;
    _p0.z = _664.z;
    float _672 = _p1.w;
    vec4 _674 = _p1;
    vec3 _677 = _674.xyz / vec3(max(_672, 9.9999997473787516355514526367188e-06));
    _p1.x = _677.x;
    _p1.y = _677.y;
    _p1.z = _677.z;
    vec4 _t36 = _p1;
    if (u_blendMode == 7)
    {
        vec3 param = _p0.xyz;
        vec3 param_1 = _p1.xyz;
        vec3 _698 = _f1(param, param_1);
        _t36.x = _698.x;
        _t36.y = _698.y;
        _t36.z = _698.z;
    }
    else
    {
        if (u_blendMode == 11)
        {
            vec3 param_2 = _p0.xyz;
            vec3 param_3 = _p1.xyz;
            vec3 _717 = _f9(param_2, param_3);
            _t36.x = _717.x;
            _t36.y = _717.y;
            _t36.z = _717.z;
        }
        else
        {
            _t36.x = _p0.xyz.x;
            _t36.y = _p0.xyz.y;
            _t36.z = _p0.xyz.z;
        }
    }
    vec4 _t37 = vec4(0.0);
    if (u_layerType == 1)
    {
        float _t38 = 1.0;
        if (u_hasMatte == 1)
        {
            vec4 param_4 = vec4(1.0);
            _t38 = _f8(param_4).w;
        }
        vec4 _764 = mix(_p1, vec4(_t36.xyz, _p0.w), vec4(u_layerOpacity * _t38));
        _t37 = _764;
        float _766 = _t37.w;
        vec3 _769 = _764.xyz * _766;
        _t37.x = _769.x;
        _t37.y = _769.y;
        _t37.z = _769.z;
    }
    else
    {
        vec3 _804 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t36.xyz * (_p0.w * _p1.w));
        _t37.x = _804.x;
        _t37.y = _804.y;
        _t37.z = _804.z;
        _t37.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t37;
}

void main()
{
    vec4 _t39 = vec4(0.0);
    bool _827 = u_hasBlend == 1;
    if (_827)
    {
        if (u_hasBaseTexture == 1)
        {
            _t39 = texture2D(u_baseTexure, uv0);
        }
        if (u_hasSourceTexture == 0)
        {
            gl_FragData[0] = _t39;
            return;
        }
    }
    vec4 _t40 = vec4(0.0);
    if (u_hasTrs == 1)
    {
        mat4 param = u_mvMat;
        mat4 param_1 = u_pMat;
        vec2 param_2 = uv0;
        vec2 _865 = _f5(param, param_1, param_2);
        float _868 = step(u_mirrorEdge, 0.5);
        vec2 param_3 = _865;
        vec2 _878 = (_865 * _868) + (_f7(param_3) * (1.0 - _868));
        vec2 param_4 = _878;
        _t40 = (texture2D(u_sourceTexture, _878) * u_alpha) * _f6(param_4);
    }
    else
    {
        if (u_hasSourceTexture == 1)
        {
            _t40 = texture2D(u_sourceTexture, uv0);
        }
    }
    if ((u_layerType != 1) && (u_hasMatte == 1))
    {
        vec4 param_5 = _t40;
        _t40 = _f8(param_5);
    }
    if (_827)
    {
        vec4 param_6 = _t40;
        vec4 param_7 = _t39;
        vec4 _916 = _f10(param_6, param_7);
        _t40 = _916;
    }
    gl_FragData[0] = _t40;
}

