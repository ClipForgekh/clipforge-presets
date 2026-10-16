precision highp float;
uniform sampler2D inputImageTexture_2;
uniform sampler2D inputImageTexture;
uniform sampler2D mixTex;
uniform float baseTexHeight; 
uniform float baseTexwh; 
uniform float photo;
uniform float photo2;
uniform float width;
uniform float height;
uniform sampler2D mixTex_2;
uniform float motino_uv;
varying vec2 uv0;

vec3 blendNormal(vec3 base, vec3 blend) {
    return blend;
}

vec3 blendNormal(vec3 base, vec3 blend, float opacity) {
    return base * opacity + blend * (1.0 - opacity);
}
void main()
{
    float intensity =  1.;
    if(width>height){
        intensity = height/width;
    }
    
    vec2 baseTextureSize=vec2 (width,height);
    vec2 sucaiSize=vec2(540,540);
    vec2 fullBlendAnchor=baseTextureSize*.5;
    float scale=1.;
    float baseAspectRatio=baseTextureSize.y/baseTextureSize.x;
    float blendAspectRatio=sucaiSize.y/sucaiSize.x;
    if(baseAspectRatio>=blendAspectRatio){
        scale=baseTextureSize.y/sucaiSize.y;
    }else{
        scale=baseTextureSize.y/sucaiSize.x;
    }
    vec2 baseTextureCoord=uv0*baseTextureSize;
    vec2 tempSucaiUV=(baseTextureCoord-fullBlendAnchor)/(sucaiSize*scale)+vec2(.5);
    // tempSucaiUV.y = 1.0-tempSucaiUV.y;
   tempSucaiUV = vec2(uv0.x,uv0.y );

    vec2 newuv = uv0;
    newuv-=0.5;
    newuv = vec2(newuv.x,newuv.y * motino_uv);
    newuv+=0.5;

    vec2 uv2 = vec2(tempSucaiUV.x,tempSucaiUV.y-baseTexHeight*1.24);
    vec2 uv3 = vec2(1.-uv0.x,(1.-uv0.y));
    uv3-=0.5;
    uv3.x-=0.5; 
    uv3.y+=photo*0.5;
    uv3*=0.5;  
    uv3+=0.5;

    vec2 uv4 = uv0;
    uv4 = vec2(tempSucaiUV.x,tempSucaiUV.y+baseTexHeight*1.24);
    vec2 uv5 = vec2(uv0.x,uv0.y);
    vec2 uv6 = vec2(1.-uv5.x,1.-uv5.y);
    uv6-=0.5;
    uv6.x+=0.5; 
    uv6.y+=photo2*0.5;
    uv6*=0.5;  
    uv6+=0.5;
    vec4 input_Color = vec4(0.,0.,0.,0.);
    if(baseTexwh==1.){
        uv2 = vec2(1.-(tempSucaiUV.x),tempSucaiUV.y-baseTexHeight*1.24);
        uv4 = vec2(1.-(tempSucaiUV.x),tempSucaiUV.y+baseTexHeight*1.24);
        input_Color = texture2D(inputImageTexture,newuv);
    }
    vec4 col3 = texture2D(inputImageTexture_2,uv6);
    uv4-=0.5;
    uv4*=0.80;
    uv4+=0.5;
    
    vec2 uv1 = vec2(uv2.x,1. - uv2.y );
    vec4 col = texture2D(inputImageTexture_2,uv3);

    uv1-=0.5;
    uv1*=0.80;
    uv1+=0.5;
    vec4 mixColor = texture2D(mixTex,uv1);

    // col = col*mixColor;
    col.rgb = mix(vec3(0.0, 0.0, 0.0),col.rgb,0.34);


   
    // input_Color.rbg =  input_Color.rbg*(1.-mixColor.a)+col.rgb;
    input_Color= mix(input_Color ,col , mixColor.r);


    ////////

    vec4 mixColor1 = texture2D(mixTex,uv4);
    // mixColor1 = vec4(mixColor1.r,mixColor1.g ,mixColor1.b ,mixColor1.r);
    // col3 = col3*mixColor1;
    col3.rgb = mix(vec3(1.0, 1.0, 1.0),col3.rgb,0.5);


    input_Color = mix(input_Color, col3, mixColor1.a);
    gl_FragColor = input_Color;
}