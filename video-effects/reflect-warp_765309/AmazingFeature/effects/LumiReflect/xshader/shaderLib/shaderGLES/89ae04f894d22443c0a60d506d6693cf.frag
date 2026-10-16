precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform float u_lineOffsetX;
uniform float u_lineOffsetY;
uniform float u_reflectionAngle;
uniform mediump sampler2D u_inputTexture;

varying vec2 v_uv;

vec2 _f1(vec2 _p0, vec2 _p1, float _p2)
{
    vec2 _t1 = _p0 - _p1;
    float _53 = u_ScreenParams.x / u_ScreenParams.y;
    bool _56 = _53 < 1.0;
    vec2 _57;
    if (_56)
    {
        _57 = vec2(_53, 1.0);
    }
    else
    {
        _57 = vec2(1.0, 1.0 / _53);
    }
    _t1 = mat2(vec2(cos(_p2), sin(_p2)), vec2(-sin(_p2), cos(_p2))) * (_t1 * _57);
    vec2 _89;
    if (_56)
    {
        _89 = vec2(_53, 1.0);
    }
    else
    {
        _89 = vec2(1.0, 1.0 / _53);
    }
    vec2 _99 = _t1;
    vec2 _100 = _99 / _89;
    _t1 = _100;
    return _100 + _p1;
}

float _f0(vec2 _p0)
{
    vec2 _t0 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t0.x * _t0.y;
}

void main()
{
    float _124 = 1.0 / max(max(u_ScreenParams.x / u_ScreenParams.y, u_ScreenParams.y / u_ScreenParams.x) * 2.2000000476837158203125, 0.001000000047497451305389404296875);
    vec2 param = (((vec2(v_uv.x, 1.0 - v_uv.y) - vec2(0.5)) * _124) + vec2(0.5)) - (vec2(u_lineOffsetX, u_lineOffsetY) * _124);
    vec2 param_1 = vec2(0.5);
    float param_2 = u_reflectionAngle;
    vec2 _158 = _f1(param, param_1, param_2);
    vec2 param_3 = _158;
    gl_FragData[0] = texture2D(u_inputTexture, _158) * _f0(param_3);
}

