precision highp float;
precision highp int;

uniform float w;
uniform float h;
uniform mediump sampler2D u_inputImageTexture;
uniform float strength;

varying vec2 v_uv;

float _f0(vec2 _p0, vec2 _p1, float _p2)
{
    return length(max((abs(_p0) - _p1) + vec2(_p2), vec2(0.0))) - _p2;
}

void main()
{
    vec2 _37 = vec2(w, h);
    vec2 _t0 = _37;
    vec2 _67 = _37 / vec2(2.0);
    vec2 param = (v_uv * _37) - _67;
    vec2 param_1 = _67;
    float param_2 = strength * _t0.x;
    gl_FragData[0] = texture2D(u_inputImageTexture, v_uv) * (1.0 - smoothstep(0.0, 0.0, _f0(param, param_1, param_2)));
}

