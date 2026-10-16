
precision highp float;
varying vec2 uv;
uniform sampler2D inputImageTexture;
uniform float RGBins;
uniform vec4 u_ScreenParams;
uniform vec4 u_AlbedoColor1;
uniform vec4 u_AlbedoColor2;



void main()
{
    vec2 myuv = uv;

    vec4 col = texture2D(inputImageTexture,myuv);
    vec4 col2 = texture2D(inputImageTexture,myuv+vec2(RGBins,0.0)/u_ScreenParams.xy);
    col.r=col2.r;
    gl_FragColor =vec4(col);

}
 