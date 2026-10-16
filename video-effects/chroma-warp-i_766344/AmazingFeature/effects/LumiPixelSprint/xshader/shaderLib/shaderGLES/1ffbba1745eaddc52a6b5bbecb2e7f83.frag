#version 300 es
precision highp float;
precision highp int;

uniform mediump sampler2D u_inputImageTexture;
uniform mediump sampler2D u_depthFilter;

in vec2 v_uv;
layout(location = 0) out vec4 o_fragColor;

vec3 _f0(vec4 _p0)
{
    return _p0.xyz / vec3(max(_p0.w, 9.9999999747524270787835121154785e-07));
}

vec3 _f1(mediump sampler2D _p0, inout vec3 _p1)
{
    _p1 *= 63.0;
    vec2 _58 = vec2(floor(_p1.z), ceil(_p1.z));
    vec2 _t2 = _58;
    vec2 _63 = floor(_58 * 0.125);
    vec4 _t5 = (vec4(_58 - (_63 * 8.0), _63).xzyw * 0.125) + vec4(((_p1.xy + vec2(0.5)) * 0.001953125).xyxy);
    return mix(texture(_p0, vec2(_t5.x, 1.0 - _t5.y)).xyz, texture(_p0, vec2(_t5.z, 1.0 - _t5.w)).xyz, vec3(_p1.z - _t2.x));
}

vec4 _f2(vec4 _p0, mediump sampler2D _p1, float _p2)
{
    vec4 param = _p0;
    vec3 _133 = _f0(param);
    vec3 _t9 = _133;
    vec3 param_1 = _133;
    vec3 _137 = _f1(_p1, param_1);
    vec3 _138 = _t9;
    vec3 _142 = mix(_138, _137, vec3(_p2));
    _t9 = _142;
    return vec4(_142, 1.0) * _p0.w;
}

void main()
{
    vec4 param = texture(u_inputImageTexture, v_uv);
    float param_1 = 2.0;
    o_fragColor = _f2(param, u_depthFilter, param_1);
}

