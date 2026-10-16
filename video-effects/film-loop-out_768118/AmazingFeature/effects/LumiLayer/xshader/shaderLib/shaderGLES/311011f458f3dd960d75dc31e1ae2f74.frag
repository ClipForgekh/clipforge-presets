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

vec4 _f2(vec3 _p0, vec3 _p1, vec3 _p2, vec3 _p3, vec3 _p4)
{
    vec3 _146 = _p3 - _p2;
    vec3 _150 = _p4 - _p2;
    vec3 _154 = cross(_p1, _150);
    float _158 = dot(_146, _154);
    if (_158 <= 1.0000000116860974230803549289703e-07)
    {
        return vec4(-1.0);
    }
    vec3 _170 = _p0 - _p2;
    float _176 = dot(_170, _154) / _158;
    if ((_176 < 0.0) || (_176 > 1.0))
    {
        return vec4(-1.0);
    }
    vec3 _188 = cross(_170, _146);
    float _194 = dot(_p1, _188) / _158;
    bool _196 = _194 < 0.0;
    bool _204;
    if (!_196)
    {
        _204 = (_176 + _194) > 1.0;
    }
    else
    {
        _204 = _196;
    }
    if (_204)
    {
        return vec4(-1.0);
    }
    return vec4(_176, _194, dot(_150, _188) / _158, 1.0);
}

vec2 _f3(mat4 _p0, mat4 _p1, vec2 _p2)
{
    vec3 _243 = (_p0 * vec4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    vec3 _249 = (_p0 * vec4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _254 = (_p0 * vec4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    vec3 _259 = (_p0 * vec4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    vec4 _270 = _p1 * vec4((_p2 * 2.0) - vec2(1.0), 0.0, 1.0);
    vec4 _t20 = _270;
    vec3 _286 = normalize((_270.xyz / vec3(_t20.w)) - vec3(0.0));
    vec3 param = vec3(0.0);
    vec3 param_1 = _286;
    vec3 _294 = (_p0 * vec4(-10.0, -10.0, 0.0, 1.0)).xyz;
    vec3 param_2 = _294;
    vec3 param_3 = _243;
    vec3 param_4 = _254;
    vec4 _t24 = _f2(param, param_1, param_2, param_3, param_4);
    vec3 param_5 = vec3(0.0);
    vec3 param_6 = _286;
    vec3 param_7 = _259;
    vec3 param_8 = _249;
    vec3 _311 = (_p0 * vec4(10.0, 10.0, 0.0, 1.0)).xyz;
    vec3 param_9 = _311;
    vec4 _t25 = _f2(param_5, param_6, param_7, param_8, param_9);
    vec3 param_10 = vec3(0.0);
    vec3 param_11 = _286;
    vec3 param_12 = _294;
    vec3 param_13 = _254;
    vec3 param_14 = _243;
    vec4 _t26 = _f2(param_10, param_11, param_12, param_13, param_14);
    vec3 param_15 = vec3(0.0);
    vec3 param_16 = _286;
    vec3 param_17 = _259;
    vec3 param_18 = _311;
    vec3 param_19 = _249;
    vec4 _t27 = _f2(param_15, param_16, param_17, param_18, param_19);
    vec2 _475 = (((((((vec2(-4.5) * ((1.0 - _t24.x) - _t24.y)) + (vec2(5.5, -4.5) * _t24.x)) + (vec2(-4.5, 5.5) * _t24.y)) * step(0.0, _t24.w)) + ((((vec2(-4.5, 5.5) * ((1.0 - _t25.x) - _t25.y)) + (vec2(5.5, -4.5) * _t25.x)) + (vec2(5.5) * _t25.y)) * (step(_t24.w, 0.0) * step(0.0, _t25.w)))) + ((((vec2(-4.5) * ((1.0 - _t26.x) - _t26.y)) + (vec2(-4.5, 5.5) * _t26.x)) + (vec2(5.5, -4.5) * _t26.y)) * ((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(0.0, _t26.w)))) + ((((vec2(-4.5, 5.5) * ((1.0 - _t27.x) - _t27.y)) + (vec2(5.5) * _t27.x)) + (vec2(5.5, -4.5) * _t27.y)) * (((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(_t26.w, 0.0)) * step(0.0, _t27.w)))) + (vec2(-10000.0) * (((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(_t26.w, 0.0)) * step(_t27.w, 0.0)));
    return _475;
}

vec2 _f5(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f4(vec2 _p0)
{
    vec2 _t33 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t33.x * _t33.y;
}

float _f0(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

vec4 _f6(vec4 _p0)
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
        _t35 = _f0(param);
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
                _t35 = 1.0 - _f0(param_1);
            }
        }
    }
    return _p0 * _t35;
}

vec3 _f1(inout vec3 _p0, inout float _p1)
{
    vec3 param = _p0;
    _p0 += vec3(_p1 - _f0(param));
    vec3 param_1 = _p0;
    _p1 = _f0(param_1);
    float _94 = min(_p0.x, min(_p0.y, _p0.z));
    float _97 = _p0.x;
    float _99 = _p0.y;
    float _101 = _p0.z;
    float _103 = max(_97, max(_99, _101));
    if (_94 < 0.0)
    {
        _p0 = mix(vec3(_p1, _p1, _p1), _p0, vec3(_p1 / (_p1 - _94)));
    }
    if (_103 > 1.0)
    {
        _p0 = mix(vec3(_p1, _p1, _p1), _p0, vec3((1.0 - _p1) / (_103 - _p1)));
    }
    return _p0;
}

vec3 _f7(vec3 _p0, vec3 _p1)
{
    vec3 param = _p1;
    vec3 param_1 = _p0;
    float param_2 = _f0(param);
    vec3 _566 = _f1(param_1, param_2);
    return _566;
}

vec4 _f8(inout vec4 _p0, inout vec4 _p1)
{
    float _570 = _p0.w;
    vec4 _573 = _p0;
    vec3 _576 = _573.xyz / vec3(max(_570, 9.9999997473787516355514526367188e-06));
    _p0.x = _576.x;
    _p0.y = _576.y;
    _p0.z = _576.z;
    float _584 = _p1.w;
    vec4 _586 = _p1;
    vec3 _589 = _586.xyz / vec3(max(_584, 9.9999997473787516355514526367188e-06));
    _p1.x = _589.x;
    _p1.y = _589.y;
    _p1.z = _589.z;
    vec4 _t36 = _p1;
    if (u_blendMode == 1)
    {
        vec3 _607 = _p0.xyz + _p1.xyz;
        _t36.x = _607.x;
        _t36.y = _607.y;
        _t36.z = _607.z;
    }
    else
    {
        if (u_blendMode == 2)
        {
            vec3 _623 = _p0.xyz * _p1.xyz;
            _t36.x = _623.x;
            _t36.y = _623.y;
            _t36.z = _623.z;
        }
        else
        {
            if (u_blendMode == 6)
            {
                vec3 _640 = max(_p0.xyz, _p1.xyz);
                _t36.x = _640.x;
                _t36.y = _640.y;
                _t36.z = _640.z;
            }
            else
            {
                if (u_blendMode == 11)
                {
                    vec3 param = _p0.xyz;
                    vec3 param_1 = _p1.xyz;
                    vec3 _659 = _f7(param, param_1);
                    _t36.x = _659.x;
                    _t36.y = _659.y;
                    _t36.z = _659.z;
                }
                else
                {
                    _t36.x = _p0.xyz.x;
                    _t36.y = _p0.xyz.y;
                    _t36.z = _p0.xyz.z;
                }
            }
        }
    }
    vec4 _t37 = vec4(0.0);
    if (u_layerType == 1)
    {
        float _t38 = 1.0;
        if (u_hasMatte == 1)
        {
            vec4 param_2 = vec4(1.0);
            _t38 = _f6(param_2).w;
        }
        vec4 _706 = mix(_p1, vec4(_t36.xyz, _p0.w), vec4(u_layerOpacity * _t38));
        _t37 = _706;
        float _708 = _t37.w;
        vec3 _711 = _706.xyz * _708;
        _t37.x = _711.x;
        _t37.y = _711.y;
        _t37.z = _711.z;
    }
    else
    {
        vec3 _746 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t36.xyz * (_p0.w * _p1.w));
        _t37.x = _746.x;
        _t37.y = _746.y;
        _t37.z = _746.z;
        _t37.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t37;
}

void main()
{
    vec4 _t39 = vec4(0.0);
    bool _769 = u_hasBlend == 1;
    if (_769)
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
        vec2 _807 = _f3(param, param_1, param_2);
        float _811 = step(u_mirrorEdge, 0.5);
        vec2 param_3 = _807;
        vec2 _821 = (_807 * _811) + (_f5(param_3) * (1.0 - _811));
        vec2 param_4 = _821;
        _t40 = (texture2D(u_sourceTexture, _821) * u_alpha) * _f4(param_4);
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
        _t40 = _f6(param_5);
    }
    if (_769)
    {
        vec4 param_6 = _t40;
        vec4 param_7 = _t39;
        vec4 _859 = _f8(param_6, param_7);
        _t40 = _859;
    }
    gl_FragData[0] = _t40;
}

