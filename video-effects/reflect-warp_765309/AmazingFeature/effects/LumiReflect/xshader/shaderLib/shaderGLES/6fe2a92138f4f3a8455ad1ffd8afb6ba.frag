precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform float u_lineOffsetY;
uniform float u_fixDistance;
uniform float u_reflectionAngle;
uniform float u_lineOffsetX;
uniform float u_reflectionDistance;
uniform float u_reflectionFalloff;
uniform mediump sampler2D u_inputTexture;
uniform float u_opacity;
uniform vec3 u_tintColor;

varying vec2 v_uv;

vec2 _f0(inout vec2 _p0, vec2 _p1, float _p2)
{
    float _28 = sin(_p2);
    float _31 = cos(_p2);
    _p0 -= _p1;
    float _47 = u_ScreenParams.x / u_ScreenParams.y;
    bool _51 = _47 < 1.0;
    if (_51)
    {
        _p0.x *= _47;
    }
    else
    {
        _p0.y /= _47;
    }
    _p0 = mat2(vec2(_31, _28), vec2(-_28, _31)) * _p0;
    if (_51)
    {
        _p0.x /= _47;
    }
    else
    {
        _p0.y *= _47;
    }
    return _p0 + _p1;
}

float _f2(vec2 _p0, float _p1, float _p2)
{
    float _t3 = 0.0;
    if (_p2 < 0.5)
    {
        _t3 = smoothstep(0.0, (2.0 * _p1) * _p2, _p0.y);
    }
    else
    {
        _t3 = smoothstep((2.0 * _p1) * (_p2 - 0.5), _p1, _p0.y);
    }
    float _138 = _t3;
    float _139 = 1.0 - _138;
    _t3 = _139;
    return _139;
}

float _f1(vec2 _p0)
{
    return ((step(0.0, _p0.x) * step(0.0, _p0.y)) * step(_p0.x, 1.0)) * step(_p0.y, 1.0);
}

void main()
{
    vec2 _t5 = vec2(0.0, 1.0 - u_lineOffsetY);
    vec2 _180 = ((vec2(v_uv.x, 1.0 - v_uv.y) - vec2(0.5)) * (max(u_ScreenParams.x / u_ScreenParams.y, u_ScreenParams.y / u_ScreenParams.x) * 2.2000000476837158203125)) + vec2(0.5);
    vec2 _t6 = _180;
    vec2 param = vec2(_t6.x, _t6.y);
    vec2 param_1 = vec2(0.5);
    float param_2 = u_reflectionAngle;
    vec2 _205 = _f0(param, param_1, param_2);
    _t6 = _205 + vec2(u_lineOffsetX, _t5.y - 1.0);
    vec2 param_3 = _180 + vec2(0.0, (_t5.y - 1.0) - mix(0.0, 0.3499999940395355224609375, clamp(u_fixDistance, 0.0, 1.0)));
    float param_4 = u_reflectionDistance;
    float param_5 = u_reflectionFalloff;
    vec2 param_6 = _t6;
    vec4 _241 = ((texture2D(u_inputTexture, _t6) * _f1(param_6)) * u_opacity) * _f2(param_3, param_4, param_5);
    vec4 _t9 = _241;
    vec3 _248 = _241.xyz * u_tintColor;
    _t9.x = _248.x;
    _t9.y = _248.y;
    _t9.z = _248.z;
    gl_FragData[0] = _t9;
}

