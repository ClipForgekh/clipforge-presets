precision highp float;

uniform sampler2D jiaosan;
uniform sampler2D jiaosan2;
varying vec2 uv;
uniform vec4 u_ScreenParams;
uniform float scale_1;
uniform float scale_2;
uniform float scale_3;
uniform float opacity_1;
uniform float opacity_2;
uniform float opacity_3;
uniform float baseTexWidth;
uniform float baseTexHeight;


void main()
{
    

    // vec2 baseTextureSize=vec2(u_ScreenParams.xy);

    // vec2 sucaiSize=vec2(100,100);
    vec2 baseTextureSize=vec2(baseTexWidth,baseTexHeight);
    vec2 sucaiSize=vec2(1,1);
    
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

    
    vec2 newUV1 =(tempSucaiUV-0.5)/scale_1+0.5;
    vec2 newUV2 =(tempSucaiUV-0.5)/scale_2+0.5;
    vec2 newUV3 =(tempSucaiUV-0.5)/scale_3+0.5;



    vec4 jiaosanCol =  texture2D(jiaosan, newUV1);
    vec4 jiaosanCol1 =  texture2D(jiaosan, newUV2);
    vec4 jiaosanCol2 = texture2D(jiaosan2, newUV3);

    jiaosanCol*=opacity_1;
    
    jiaosanCol2*=opacity_3;
    if(opacity_2==0.){
        jiaosanCol1*=opacity_2;
    }
    else
    {
        jiaosanCol1.a*=opacity_2;
        
        
    }



    jiaosanCol = mix(jiaosanCol,jiaosanCol1,jiaosanCol1.r);
    gl_FragColor = mix(jiaosanCol2,jiaosanCol,jiaosanCol.r);
}
