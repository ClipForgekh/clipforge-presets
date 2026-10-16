precision highp float;

uniform sampler2D _MainTex;
varying vec2 uv;
uniform vec4 u_ScreenParams;
uniform vec2 wh;

void main()
{
    vec2 baseTextureSize=vec2(wh);
    vec2 sucaiSize=vec2(100,100);
    vec2 fullBlendAnchor=baseTextureSize*.5;
    float scale=1.;
    float baseAspectRatio=baseTextureSize.y/baseTextureSize.x;
    float blendAspectRatio=sucaiSize.y/sucaiSize.x;
    if(baseAspectRatio>=blendAspectRatio){
        scale=baseTextureSize.y/sucaiSize.y;
    }else{
        scale=baseTextureSize.x/sucaiSize.x;
    }
    vec2 baseTextureCoord=uv*baseTextureSize;
    vec2 tempSucaiUV=(baseTextureCoord-fullBlendAnchor)/(sucaiSize*scale)+vec2(.5);
    tempSucaiUV.y = 1.0-tempSucaiUV.y;
    gl_FragColor = texture2D(_MainTex, tempSucaiUV);;
}
