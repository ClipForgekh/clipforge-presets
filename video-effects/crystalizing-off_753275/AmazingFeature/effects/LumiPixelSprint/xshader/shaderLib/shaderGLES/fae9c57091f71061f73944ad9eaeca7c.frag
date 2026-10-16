#version 300 es
precision highp float;
precision highp int;

uniform float u_heightScale;
uniform mediump sampler2D u_depthMap;
uniform vec2 u_center;
uniform mediump sampler2D u_diffuseMap;
uniform mediump sampler2D u_sFilterTex;
uniform float u_intensity;

in vec3 v_tangentViewPos;
in vec3 v_tangentFragPos;
in vec2 v_uv;
layout(location = 0) out vec4 o_fragColor;

vec2 _f0(vec2 _p0)
{
    return abs(mod(_p0 + vec2(1.0), vec2(2.0)) - vec2(1.0));
}

vec2 _f1(vec2 _p0, vec3 _p1)
{
    float _60 = mix(64.0, 64.0, abs(dot(vec3(0.0, 0.0, 1.0), _p1)));
    float _64 = 0.4000000059604644775390625 / _60;
    float _t1 = _64;
    float _t3 = 0.0;
    vec2 _100 = (((_p1.xy / vec2(_p1.z)) * u_heightScale) * 0.4000000059604644775390625) / vec2(_60);
    vec2 _t6 = _100;
    vec2 _t8 = _p0;
    float _t9 = 1.0 - texture(u_depthMap, _p0).x;
    for (mediump int _t10 = 0; _t10 < 1024; _t10++)
    {
        if (_t3 >= _t9)
        {
            break;
        }
        float _137 = mix(0.1500000059604644775390625, 1.0, abs(_t3 - _t9));
        _t1 = _64 * _137;
        vec2 _145 = _100 * _137;
        _t6 = _145;
        vec2 _147 = _t8;
        vec2 _148 = _147 - _145;
        _t8 = _148;
        vec2 param = _148;
        _t9 = 1.0 - texture(u_depthMap, _f0(param)).x;
        _t3 += _t1;
    }
    vec2 _165 = _t8 + _t6;
    float _169 = _t9 - _t3;
    vec2 param_1 = _165;
    float _187 = _169 / (_169 - (((1.0 - texture(u_depthMap, _f0(param_1)).x) - _t3) + _t1));
    return (_165 * _187) + (_t8 * (1.0 - _187));
}

vec3 _f2(vec4 _p0)
{
    if (_p0.w == 0.0)
    {
        return vec3(0.0);
    }
    return _p0.xyz / vec3(_p0.w);
}

vec3 _f3(mediump sampler2D _p0, inout vec3 _p1)
{
    _p1 *= 63.0;
    vec2 _227 = vec2(floor(_p1.z), ceil(_p1.z));
    vec2 _t17 = _227;
    vec2 _232 = floor(_227 * 0.125);
    vec4 _t20 = (vec4(_227 - (_232 * 8.0), _232).xzyw * 0.125) + vec4(((_p1.xy + vec2(0.5)) * 0.001953125).xyxy);
    return mix(texture(_p0, vec2(_t20.x, 1.0 - _t20.y)).xyz, texture(_p0, vec2(_t20.z, 1.0 - _t20.w)).xyz, vec3(_p1.z - _t17.x));
}

vec4 _f4(vec4 _p0, mediump sampler2D _p1, float _p2)
{
    vec4 param = _p0;
    vec3 _299 = _f2(param);
    vec3 _t24 = _299;
    vec3 param_1 = _299;
    vec3 _303 = _f3(_p1, param_1);
    vec3 _304 = _t24;
    vec3 _308 = mix(_304, _303, vec3(_p2));
    _t24 = _308;
    return vec4(_308, 1.0) * _p0.w;
}

void main()
{
    vec2 param = ((v_uv - u_center) / vec2(mix(1.0, 2.5, pow(u_heightScale, 1.2000000476837158203125)))) + u_center;
    vec3 param_1 = normalize(v_tangentViewPos - v_tangentFragPos);
    vec2 param_2 = _f1(param, param_1);
    vec4 param_3 = texture(u_diffuseMap, _f0(param_2));
    float param_4 = u_intensity;
    o_fragColor = _f4(param_3, u_sFilterTex, param_4);
}

