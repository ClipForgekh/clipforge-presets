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
    // resultUV=(resultUV-0.5)/imgSize+0.5;

    vec4 resultCol = texture2D(inputImageTexture, resultUV)*uvpro(resultUV)*weight0;
    float num = weight0;
    for(int i = 1 ;i <= 16 ;i++){
        float j = float(i);
        float tempWeight = normpdf(j,8.);
        vec2 tempUV = resultUV+j*offset;
        resultCol+= texture2D(inputImageTexture, tempUV)*uvpro(tempUV)*tempWeight;
        num+=tempWeight;
        tempUV = resultUV-j*offset;
        resultCol+= texture2D(inputImageTexture, tempUV)*uvpro(tempUV)*tempWeight;
        num+=tempWeight;
    }
    resultCol/=num;
    
    // resultCol = ExposureLighten(resultCol,lightIns);

    gl_FragColor = vec4(resultCol);
}