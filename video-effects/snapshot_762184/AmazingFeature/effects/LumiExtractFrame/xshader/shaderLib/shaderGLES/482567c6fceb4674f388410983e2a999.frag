precision highp float;
precision highp int;

uniform mediump sampler2D u_InputTexture;

varying vec2 uv0;

void main()
{
    gl_FragData[0] = texture2D(u_InputTexture, uv0);
}

