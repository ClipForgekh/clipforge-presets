precision highp float;

uniform sampler2D inputImageTexture;
uniform float blurSize;
uniform float blurIns;
uniform float rotAngle;
uniform float blurAngle;
varying vec2 uv;

#define textureCoordinate uv
uniform float baseTexWidth;
uniform float baseTexHeight;
float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}
mat2 rotMat(float angle){
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c,-s,s,c);
}
void main()
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    vec2 mySize = screenSize.xy/min(screenSize.x,screenSize.y)*720.;
    vec2 offset = vec2(0.0,1.)*rotMat(rotAngle+blurAngle)*vec2(blurSize*blurIns)/mySize;
    float weight0 = normpdf(0.0,8.);
    vec4 resultCol = texture2D(inputImageTexture, uv)*weight0;
    float num = weight0;
    for(int i = 1 ;i <= 16 ;i++){
        float j = float(i);
        float tempWeight = normpdf(j,8.);
        resultCol+= texture2D(inputImageTexture, uv+j*offset)*tempWeight;
        resultCol+= texture2D(inputImageTexture, uv-j*offset)*tempWeight;
        num+=2.0*tempWeight;
    }
    resultCol/=num;

    gl_FragColor = vec4(resultCol);
}