precision highp float;
precision highp int;

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
uniform mediump sampler2D u_inputImageTexture16;
uniform float u_frameNums;
uniform float u_wSum1;

varying vec2 v_uv;

void main()
{
    vec4 _258 = (((((((((((texture2D(u_inputImageTexture1, v_uv) * (max(u_frameNums - 0.0, 0.0) / u_wSum1)) + (texture2D(u_inputImageTexture2, v_uv) * (max(u_frameNums - 1.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture3, v_uv) * (max(u_frameNums - 2.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture4, v_uv) * (max(u_frameNums - 3.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture5, v_uv) * (max(u_frameNums - 4.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture6, v_uv) * (max(u_frameNums - 5.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture7, v_uv) * (max(u_frameNums - 6.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture8, v_uv) * (max(u_frameNums - 7.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture9, v_uv) * (max(u_frameNums - 8.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture10, v_uv) * (max(u_frameNums - 9.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture11, v_uv) * (max(u_frameNums - 10.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture12, v_uv) * (max(u_frameNums - 11.0, 0.0) / u_wSum1));
    gl_FragData[0] = (((_258 + (texture2D(u_inputImageTexture13, v_uv) * (max(u_frameNums - 12.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture14, v_uv) * (max(u_frameNums - 13.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture15, v_uv) * (max(u_frameNums - 14.0, 0.0) / u_wSum1))) + (texture2D(u_inputImageTexture16, v_uv) * (max(u_frameNums - 15.0, 0.0) / u_wSum1));
}

