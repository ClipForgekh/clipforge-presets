
precision highp float;
varying vec2 uv;
uniform sampler2D inputImageTexture;
uniform float centerX;
uniform float offset;
uniform float ins;
uniform vec4 u_ScreenParams;
void main()
{
    vec2 myuv = uv;
    myuv.x = 1.0-myuv.x;
    myuv.x *= ins;
    myuv.x += mix(offset*u_ScreenParams.y/u_ScreenParams.x,0.0,smoothstep(0.0,0.015*u_ScreenParams.y/u_ScreenParams.x,1.0-uv.x));
    myuv.y -=0.5;
    myuv.y /= 1.0+mix(10.0*offset,0.0,smoothstep(0.0,0.015*u_ScreenParams.y/u_ScreenParams.x,1.0-uv.x));
    myuv.y +=0.5;
    myuv.x = 1.0-myuv.x;

    // myuv.x =pow( myuv.x,ins);
    myuv.x = abs(myuv.x-centerX);
    // myuv.x = 1.0-myuv.x;
    vec4 col = texture2D(inputImageTexture,myuv);

    // vec2 oriUV = uv;
    // oriUV.x = abs(oriUV.x-centerX);
    // // oriUV.x=1.0-oriUV.x;
    // vec4 oriCol = texture2D(inputImageTexture,oriUV);
    // col=mix(oriCol,col,smoothstep(0.03,0.05,uv.x));
    gl_FragColor =vec4(col);

}
 