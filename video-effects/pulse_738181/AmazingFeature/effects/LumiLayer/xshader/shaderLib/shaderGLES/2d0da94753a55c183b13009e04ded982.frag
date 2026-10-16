precision highp float;
precision highp int;

uniform float u_mirrorEdge;
uniform mediump sampler2D inputTex;
uniform float u_alpha;

varying vec2 v_uv;

vec2 _f1(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f0(vec2 _p0)
{
    vec2 _t0 = step(vec2(0.0), _p0) * step(_p0, vec2(1.2000000476837158203125));
    return _t0.x * _t0.y;
}

vec4 _f2(vec2 _p0, vec4 _p1)
{
    bool _61 = _p0.x > 1.230000019073486328125;
    bool _69;
    if (!_61)
    {
        _69 = _p0.x < (-0.23000000417232513427734375);
    }
    else
    {
        _69 = _61;
    }
    bool _76;
    if (!_69)
    {
        _76 = _p0.y > 1.230000019073486328125;
    }
    else
    {
        _76 = _69;
    }
    bool _83;
    if (!_76)
    {
        _83 = _p0.y < (-0.23000000417232513427734375);
    }
    else
    {
        _83 = _76;
    }
    if (_83)
    {
        return vec4(0.0);
    }
    else
    {
        return _p1;
    }
}

void main()
{
    float _97 = step(u_mirrorEdge, 0.5);
    vec2 param = v_uv;
    vec2 _109 = (v_uv * _97) + (_f1(param) * (1.0 - _97));
    mediump vec4 _117 = texture2D(inputTex, _109);
    vec2 param_1 = _109;
    vec4 _t3 = vec4(1.0);
    if (u_mirrorEdge > 0.5)
    {
        vec2 param_2 = v_uv;
        vec4 param_3 = _t3;
        vec2 param_4 = _109;
        _t3 = _f2(param_2, param_3) * _f0(param_4);
    }
    gl_FragData[0] = ((_117 * u_alpha) * _f0(param_1)) * _t3;
}

