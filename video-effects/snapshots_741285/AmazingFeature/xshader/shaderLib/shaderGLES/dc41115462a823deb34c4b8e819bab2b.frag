precision highp float;
precision highp int;

uniform mediump float w;
uniform mediump float h;
uniform mediump float strength;
uniform mediump sampler2D u_inputImageTexture;

varying vec2 v_uv;

mediump float _f0(mediump vec2 _p0, mediump vec2 _p1, mediump float _p2)
{
    return length(max((abs(_p0) - _p1) + vec2(_p2), vec2(0.0))) - _p2;
}

void main()
{
    mediump vec2 _37 = vec2(w, h);
    mediump vec2 _t1 = _37;
    mediump vec2 _44 = _37 / vec2(2.0);
    mediump vec2 param = (v_uv * _37) - _44;
    mediump vec2 param_1 = _44;
    mediump float param_2 = strength * _t1.x;
    gl_FragData[0] = texture2D(u_inputImageTexture, v_uv) * (1.0 - smoothstep(0.0, 0.0, _f0(param, param_1, param_2)));
}

