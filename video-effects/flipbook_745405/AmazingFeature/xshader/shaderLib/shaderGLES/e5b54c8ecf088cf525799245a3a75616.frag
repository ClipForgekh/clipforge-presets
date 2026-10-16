precision highp float;
precision highp int;

uniform float u_sizex;
uniform float u_sizey;
uniform mediump sampler2D u_bgTex;

varying vec2 uv0;

void main()
{
    vec2 _t0 = uv0 - vec2(0.5);
    _t0.x *= u_sizex;
    _t0.y *= u_sizey;
    vec2 _33 = _t0;
    vec2 _35 = _33 + vec2(0.5);
    _t0 = _35;
    gl_FragData[0] = texture2D(u_bgTex, _35);
}

