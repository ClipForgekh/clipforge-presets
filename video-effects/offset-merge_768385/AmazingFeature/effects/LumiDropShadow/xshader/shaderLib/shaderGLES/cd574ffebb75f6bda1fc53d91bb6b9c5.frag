precision highp float;
precision highp int;

uniform float u_angle;
uniform float u_distance;
uniform vec2 u_screenSize;
uniform float u_scale;
uniform mediump sampler2D u_shadowTexture;
uniform mediump sampler2D u_shadowMaskTexture;
uniform mediump sampler2D u_inputTexture;
uniform float u_inputOpacity;
uniform float u_opacity;
uniform vec4 u_color;

varying vec2 v_uv;

vec2 _f1(vec2 _p0)
{
    float _80 = (u_angle * 3.141590118408203125) / 180.0;
    return _p0 + ((vec2(cos(_80), sin(_80)) * u_distance) / vec2(u_screenSize.x));
}

float _f0(mediump sampler2D _p0, inout vec2 _p1)
{
    vec2 _30 = _p1;
    _p1 = step(vec2(0.0), _p1) * step(_p1, vec2(1.0));
    vec4 _t0 = texture2D(_p0, _30) * (_p1.x * _p1.y);
    return ((_t0.x + (_t0.y / 255.0)) + (_t0.z / 65025.0)) + (_t0.w / 16581375.0);
}

vec4 _f2(mediump sampler2D _p0, inout vec2 _p1)
{
    vec2 _103 = _p1;
    _p1 = step(vec2(0.0), _p1) * step(_p1, vec2(1.0));
    return (texture2D(_p0, _103) * _p1.x) * _p1.y;
}

void main()
{
    vec2 param = v_uv;
    vec2 _124 = _f1(param);
    vec2 param_1 = ((_124 - vec2(0.5)) * u_scale) + vec2(0.5);
    float _139 = _f0(u_shadowTexture, param_1);
    vec4 _t7 = texture2D(u_shadowMaskTexture, _124);
    vec2 param_2 = v_uv;
    vec4 _150 = _f2(u_inputTexture, param_2);
    vec4 _t8 = _150;
    float _157 = clamp(_t8.w * u_inputOpacity, 0.0, 1.0);
    float _178 = clamp(((_139 * u_opacity) * u_color.w) * _t7.x, 0.0, 1.0);
    float _188 = 1.0 - _157;
    float _190 = _157 + (_178 * _188);
    vec3 _203;
    if (_190 > 9.9999997473787516355514526367188e-06)
    {
        _203 = ((_150.xyz * _157) + ((u_color.xyz * _178) * _188)) / vec3(_190);
    }
    else
    {
        _203 = vec3(0.0);
    }
    gl_FragData[0] = vec4(_203, _190);
}

