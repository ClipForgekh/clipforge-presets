precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture0;
uniform mediump sampler2D u_inputTexture1;

varying vec2 v_uv;

void main()
{
    mediump vec4 _t0 = texture2D(u_inputTexture0, v_uv);
    mediump vec4 _24 = texture2D(u_inputTexture1, v_uv);
    if (v_uv.y < 0.5)
    {
        _t0 = vec4(0.0);
    }
    mediump vec4 _37 = _t0;
    mediump float _43 = _t0.w;
    mediump vec4 _46 = _37 + (_24 * (1.0 - _43));
    _t0 = _46;
    gl_FragData[0] = _46;
}

