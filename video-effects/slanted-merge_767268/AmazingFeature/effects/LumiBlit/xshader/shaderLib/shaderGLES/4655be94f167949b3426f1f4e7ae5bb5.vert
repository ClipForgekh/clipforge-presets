
uniform vec3 u_anchorPoint;
uniform vec4 u_ScreenParams;
uniform vec3 u_fragScale;
uniform vec3 u_fragRotation;
uniform vec3 u_fragTranslation;
uniform mat4 u_MVP;

attribute vec2 a_position;
varying vec2 v_uv;
attribute vec2 a_texcoord0;

mat3 _f2(float _p0)
{
    float _63 = cos(_p0);
    float _66 = sin(_p0);
    return mat3(vec3(_63, -_66, 0.0), vec3(_66, _63, 0.0), vec3(0.0, 0.0, 1.0));
}

mat3 _f1(float _p0)
{
    float _46 = cos(_p0);
    float _49 = sin(_p0);
    return mat3(vec3(_46, 0.0, _49), vec3(0.0, 1.0, 0.0), vec3(-_49, 0.0, _46));
}

mat3 _f0(float _p0)
{
    float _27 = cos(_p0);
    float _30 = sin(_p0);
    return mat3(vec3(1.0, 0.0, 0.0), vec3(0.0, _27, -_30), vec3(0.0, _30, _27));
}

mat3 _f3(vec3 _p0)
{
    vec3 _t6 = radians(_p0);
    float param = _t6.z;
    float param_1 = _t6.y;
    float param_2 = _t6.x;
    return (_f2(param) * _f1(param_1)) * _f0(param_2);
}

void main()
{
    vec3 _t7 = u_anchorPoint;
    vec3 _t9 = vec3(a_position, 0.0) - u_anchorPoint;
    float _130 = 1.0 / (u_ScreenParams.y / max(u_ScreenParams.x, 1.0));
    _t9.x *= _130;
    _t7.x *= _130;
    vec3 param = u_fragRotation;
    gl_Position = u_MVP * vec4(((_f3(param) * (_t9 * u_fragScale)) + u_fragTranslation) + _t7, 1.0);
    v_uv = a_texcoord0;
}

