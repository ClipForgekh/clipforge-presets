precision highp float;

uniform sampler2D inputImageTexture;
uniform float blurSize;
varying vec2 uv;

#define textureCoordinate uv
uniform float baseTexWidth;
uniform float baseTexHeight;

uniform float posX;
uniform float posY;
uniform float blurIns;


float normpdf(in float x, in float sigma)
{
    
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}
mat2 rotMat(float angle){
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c,-s,s,c);
}
float uvpro(vec2 uv){
    return step(0.,uv.x)*step(uv.x,1.0)*step(0.,uv.y)*step(uv.y,1.0);
}
float mirror(float x){
    return abs(mod(x-1.0,2.0)-1.0);
}
vec2 mirror(vec2 uv){
    return vec2(mirror(uv.x),mirror(uv.y));
}
vec2 getOriUV(vec2 uv){
    vec2 tempUV = uv;
    tempUV.y=0.45*tempUV.y;
    return tempUV;
}
void main()
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    vec2 mySize = screenSize.xy/min(screenSize.x,screenSize.y)*1080.;

    float imgBlurIns = blurIns;
    vec2 offset = vec2(blurSize*imgBlurIns,0)/1080.;
    float weight0 = normpdf(0.0,8.);


    vec2 moveSize = screenSize.xy/min(screenSize.x,screenSize.x)*1080.;
    vec2 imgMove = vec2(posX,-posY);
    vec2 resultUV = uv-0.5*imgMove/moveSize;

    vec4 resultCol = texture2D(inputImageTexture, getOriUV(resultUV))*uvpro(getOriUV(resultUV))*weight0;
    float num = weight0;
    for(int i = 1 ;i <= 16 ;i++){
        float j = float(i);
        float tempWeight = normpdf(j,8.);
        vec2 tempUV = resultUV+j*offset;
        resultCol+= texture2D(inputImageTexture, getOriUV(tempUV))*uvpro(getOriUV(tempUV))*tempWeight;
        num+=tempWeight;
        tempUV = resultUV-j*offset;
        resultCol+= texture2D(inputImageTexture, getOriUV(tempUV))*uvpro(getOriUV(tempUV))*tempWeight;
        num+=tempWeight;
    }
    resultCol/=num;
    // resultCol = ExposureLighten(resultCol,lightIns);

    gl_FragColor = vec4(resultCol);
}