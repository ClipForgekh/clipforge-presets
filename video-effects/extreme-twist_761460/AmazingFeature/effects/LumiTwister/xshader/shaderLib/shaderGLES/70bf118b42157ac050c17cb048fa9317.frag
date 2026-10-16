precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTexture;
uniform mediump sampler2D u_inputTexture1;

varying vec2 v_uv;

void main()
{
    mediump vec4 _19 = texture2D(u_inputTexture, v_uv);
    vec4 _t0 = _19;
    gl_FragData[0] = mix(_19, texture2D(u_inputTexture1, v_uv), vec4(1.0 - _t0.w));
}

