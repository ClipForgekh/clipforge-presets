precision highp float;
precision highp int;

uniform mediump sampler2D inputImageTexture;

varying vec2 uv0;

void main()
{
    gl_FragData[0] = texture2D(inputImageTexture, uv0);
}

