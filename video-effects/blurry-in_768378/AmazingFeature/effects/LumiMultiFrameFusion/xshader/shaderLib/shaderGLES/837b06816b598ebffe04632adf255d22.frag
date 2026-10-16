precision highp float;
precision highp int;

uniform mediump sampler2D mergedTexture;
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
uniform float wSum1;
uniform float wSum;
uniform float frameNums;

varying vec2 v_uv;

void main()
{
    vec4 _258 = (((((((((((texture2D(mergedTexture, v_uv) * (wSum1 / wSum)) + (texture2D(inputImageTexture1, v_uv) * (max(frameNums - 16.0, 0.0) / wSum))) + (texture2D(inputImageTexture2, v_uv) * (max(frameNums - 17.0, 0.0) / wSum))) + (texture2D(inputImageTexture3, v_uv) * (max(frameNums - 18.0, 0.0) / wSum))) + (texture2D(inputImageTexture4, v_uv) * (max(frameNums - 19.0, 0.0) / wSum))) + (texture2D(inputImageTexture5, v_uv) * (max(frameNums - 20.0, 0.0) / wSum))) + (texture2D(inputImageTexture6, v_uv) * (max(frameNums - 21.0, 0.0) / wSum))) + (texture2D(inputImageTexture7, v_uv) * (max(frameNums - 22.0, 0.0) / wSum))) + (texture2D(inputImageTexture8, v_uv) * (max(frameNums - 23.0, 0.0) / wSum))) + (texture2D(inputImageTexture9, v_uv) * (max(frameNums - 24.0, 0.0) / wSum))) + (texture2D(inputImageTexture10, v_uv) * (max(frameNums - 25.0, 0.0) / wSum))) + (texture2D(inputImageTexture11, v_uv) * (max(frameNums - 26.0, 0.0) / wSum));
    gl_FragData[0] = (((_258 + (texture2D(inputImageTexture12, v_uv) * (max(frameNums - 27.0, 0.0) / wSum))) + (texture2D(inputImageTexture13, v_uv) * (max(frameNums - 28.0, 0.0) / wSum))) + (texture2D(inputImageTexture14, v_uv) * (max(frameNums - 29.0, 0.0) / wSum))) + (texture2D(inputImageTexture15, v_uv) * (max(frameNums - 30.0, 0.0) / wSum));
}

