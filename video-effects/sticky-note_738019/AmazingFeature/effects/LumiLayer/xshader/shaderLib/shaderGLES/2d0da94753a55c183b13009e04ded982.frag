precision highp float;
precision highp int;

uniform float u_mirrorEdge;
uniform mediump sampler2D inputTex;
uniform float u_alpha;

varying vec2 v_uv;

vec2 uvMirror(vec2 x)
{
    return abs(mod(x - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float uvProtect(vec2 uv)
{
    vec2 _26 = step(vec2(0.0), uv) * step(uv, vec2(1.0));
    return _26.x * _26.y;
}

void main()
{
    float _54 = step(u_mirrorEdge, 0.5);
    vec2 param = v_uv;
    vec2 _66 = (v_uv * _54) + (uvMirror(param) * (1.0 - _54));
    vec2 param_1 = _66;
    gl_FragData[0] = (texture2D(inputTex, _66) * u_alpha) * uvProtect(param_1);
}

