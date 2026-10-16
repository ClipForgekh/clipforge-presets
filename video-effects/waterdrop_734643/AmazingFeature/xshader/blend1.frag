precision highp float;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture1;
uniform sampler2D inputImageTexture2;
uniform sampler2D animTexture;
varying vec2 uv;
uniform vec4 u_ScreenParams;
uniform vec2 wh;
uniform sampler2D _MainTex;
// uniform sampler2D _MainTex1;
uniform float u_scale;
uniform float u_opt;

float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}
vec4 enCode(float a){
    float a1 = floor(a*255.);
    float b1 = fract(a*255.);
    float a2 = floor(b1*255.);
    float b2 = fract(b1*255.);
    float a3 = floor(b2*255.);
    float b3 = fract(b2*255.);
    return vec4(a1/255.,a2/255.,a3/255.,b3);
}
float deCode(vec4 a){
    return a.x+a.y/255.+a.z/(255.*255.)+a.w/(255.*255.*255.);
}
float mirror(float x){
    return abs(mod(x-1.0,2.0)-1.0);
}
vec2 mirror(vec2 uv){
    return vec2(mirror(uv.x),mirror(uv.y));
}


void main()
{

    vec2 baseTextureSize=vec2(wh);
    vec2 sucaiSize=vec2(600,600);
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


    vec2 scaleuv = uv;
    scaleuv -=0.5 ;
    scaleuv = scaleuv/u_scale;
    scaleuv += 0.5;

    vec4 resultCol = texture2D(inputImageTexture,scaleuv);
    float alpha = resultCol.a;
    vec4 result3 = texture2D(inputImageTexture2,scaleuv);
    resultCol = vec4(resultCol.rgb*u_opt,alpha);
    vec4 resultCol1 = texture2D(inputImageTexture1,uv);
    vec4 resultCol2 = mix(resultCol,resultCol1,resultCol1.a);
    vec4 animColor = texture2D(_MainTex,tempSucaiUV);
    // vec4 animcolor1 = texture2D(_MainTex1,tempSucaiUV);

    resultCol = animColor + resultCol2;
    // resultCol = resultCol + animcolor1;

    resultCol = clamp(resultCol,vec4(0.0),vec4(1.0));
    gl_FragColor = vec4(resultCol.rgb,max(resultCol1.a,alpha*u_opt));;
}
