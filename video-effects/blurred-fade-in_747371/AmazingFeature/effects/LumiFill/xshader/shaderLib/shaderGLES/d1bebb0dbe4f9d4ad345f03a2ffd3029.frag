precision highp float;
precision highp int;

uniform mediump sampler2D u_InputTexture;
uniform mediump float u_Reverse;
uniform mediump float u_Alpha;
uniform mediump vec3 u_Color;

varying vec2 v_uv;

void main()
{
    mediump vec4 _t0 = texture2D(u_InputTexture, v_uv);
    gl_FragData[0] = vec4(u_Color, 1.0) * (abs(u_Reverse - _t0.w) * u_Alpha);
}

