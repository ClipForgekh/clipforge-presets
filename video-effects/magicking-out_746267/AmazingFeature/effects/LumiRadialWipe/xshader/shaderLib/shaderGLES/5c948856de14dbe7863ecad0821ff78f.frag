precision highp float;
precision highp int;

uniform mediump sampler2D u_mask;
uniform mediump sampler2D u_inputTexture;

varying vec2 v_uv;

void main()
{
    vec4 _t0 = texture2D(u_mask, v_uv);
    gl_FragData[0] = texture2D(u_inputTexture, v_uv) * _t0.x;
}

