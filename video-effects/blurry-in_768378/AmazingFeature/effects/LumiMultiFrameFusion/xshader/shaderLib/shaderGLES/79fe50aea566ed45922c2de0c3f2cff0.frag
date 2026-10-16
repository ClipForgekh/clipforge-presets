precision highp float;
precision highp int;

uniform mediump sampler2D inputImageTexture1;
uniform mediump sampler2D inputImageTexture2;
uniform mediump sampler2D inputImageTexture3;
uniform mediump sampler2D inputImageTexture4;
uniform mediump sampler2D inputImageTexture5;
uniform mediump sampler2D inputImageTexture6;
uniform mediump sampler2D inputImageTexture7;
uniform mediump sampler2D inputImageTexture8;
uniform mediump sampler2D inputImageTexture9;
uniform mediump sampler2D inputImageTexture10;
uniform mediump sampler2D inputImageTexture11;
uniform mediump sampler2D inputImageTexture12;
uniform mediump sampler2D inputImageTexture13;
uniform mediump sampler2D inputImageTexture14;
uniform mediump sampler2D inputImageTexture15;
uniform mediump sampler2D inputImageTexture16;
uniform float frameNums;
uniform float wSum1;

varying vec2 v_uv;

void main()
{
    vec4 _259 = (((((((((((texture2D(inputImageTexture1, v_uv) * (max(frameNums - 0.0, 0.0) / wSum1)) + (texture2D(inputImageTexture2, v_uv) * (max(frameNums - 1.0, 0.0) / wSum1))) + (texture2D(inputImageTexture3, v_uv) * (max(frameNums - 2.0, 0.0) / wSum1))) + (texture2D(inputImageTexture4, v_uv) * (max(frameNums - 3.0, 0.0) / wSum1))) + (texture2D(inputImageTexture5, v_uv) * (max(frameNums - 4.0, 0.0) / wSum1))) + (texture2D(inputImageTexture6, v_uv) * (max(frameNums - 5.0, 0.0) / wSum1))) + (texture2D(inputImageTexture7, v_uv) * (max(frameNums - 6.0, 0.0) / wSum1))) + (texture2D(inputImageTexture8, v_uv) * (max(frameNums - 7.0, 0.0) / wSum1))) + (texture2D(inputImageTexture9, v_uv) * (max(frameNums - 8.0, 0.0) / wSum1))) + (texture2D(inputImageTexture10, v_uv) * (max(frameNums - 9.0, 0.0) / wSum1))) + (texture2D(inputImageTexture11, v_uv) * (max(frameNums - 10.0, 0.0) / wSum1))) + (texture2D(inputImageTexture12, v_uv) * (max(frameNums - 11.0, 0.0) / wSum1));
    gl_FragData[0] = (((_259 + (texture2D(inputImageTexture13, v_uv) * (max(frameNums - 12.0, 0.0) / wSum1))) + (texture2D(inputImageTexture14, v_uv) * (max(frameNums - 13.0, 0.0) / wSum1))) + (texture2D(inputImageTexture15, v_uv) * (max(frameNums - 14.0, 0.0) / wSum1))) + (texture2D(inputImageTexture16, v_uv) * (max(frameNums - 15.0, 0.0) / wSum1));
}

