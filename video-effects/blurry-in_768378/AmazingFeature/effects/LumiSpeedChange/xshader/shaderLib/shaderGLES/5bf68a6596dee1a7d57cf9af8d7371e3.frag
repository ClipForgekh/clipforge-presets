precision highp float;
precision highp int;

uniform mediump sampler2D u_mergedTexture;
uniform mediump sampler2D u_inputImageTexture1;
uniform mediump sampler2D u_inputImageTexture2;
uniform mediump sampler2D u_inputImageTexture3;
uniform mediump sampler2D u_inputImageTexture4;
uniform mediump sampler2D u_inputImageTexture5;
uniform mediump sampler2D u_inputImageTexture6;
uniform mediump sampler2D u_inputImageTexture7;
uniform mediump sampler2D u_inputImageTexture8;
uniform mediump sampler2D u_inputImageTexture9;
uniform mediump sampler2D u_inputImageTexture10;
uniform mediump sampler2D u_inputImageTexture11;
uniform mediump sampler2D u_inputImageTexture12;
uniform mediump sampler2D u_inputImageTexture13;
uniform mediump sampler2D u_inputImageTexture14;
uniform mediump sampler2D u_inputImageTexture15;
uniform float u_wSum1;
uniform float u_wSum;
uniform float u_frameNums;

varying vec2 v_uv;

void main()
{
    vec4 _257 = (((((((((((texture2D(u_mergedTexture, v_uv) * (u_wSum1 / u_wSum)) + (texture2D(u_inputImageTexture1, v_uv) * (max(u_frameNums - 16.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture2, v_uv) * (max(u_frameNums - 17.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture3, v_uv) * (max(u_frameNums - 18.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture4, v_uv) * (max(u_frameNums - 19.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture5, v_uv) * (max(u_frameNums - 20.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture6, v_uv) * (max(u_frameNums - 21.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture7, v_uv) * (max(u_frameNums - 22.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture8, v_uv) * (max(u_frameNums - 23.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture9, v_uv) * (max(u_frameNums - 24.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture10, v_uv) * (max(u_frameNums - 25.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture11, v_uv) * (max(u_frameNums - 26.0, 0.0) / u_wSum));
    gl_FragData[0] = (((_257 + (texture2D(u_inputImageTexture12, v_uv) * (max(u_frameNums - 27.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture13, v_uv) * (max(u_frameNums - 28.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture14, v_uv) * (max(u_frameNums - 29.0, 0.0) / u_wSum))) + (texture2D(u_inputImageTexture15, v_uv) * (max(u_frameNums - 30.0, 0.0) / u_wSum));
}

