precision highp float;

uniform sampler2D inputImageTexture;
varying vec2 uv;
uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float blurSize;
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
    return vec4(a1/255.,a2/255.,a3/255.,0.);
}
float deCode(vec4 a){
    return a.x+a.y/255.+a.z/(255.*255.);
}
void main()
{
    vec2 mySize = vec2(baseTexWidth,baseTexHeight)/min(baseTexWidth,baseTexHeight)*1080.;
    vec2 offset = vec2(0,1)*vec2(blurSize)/mySize;

    float weight0 = normpdf(0.0,5.);
    float resultGray = deCode(texture2D(inputImageTexture, uv))*weight0;
    float num = weight0;
    for(int i = 1 ;i <= 5 ;i++){
        float j = float(i);
        float tempWeight = normpdf(j,5.);
        resultGray+=deCode(texture2D(inputImageTexture, uv+j*offset))*tempWeight;
        resultGray+=deCode(texture2D(inputImageTexture, uv-j*offset))*tempWeight;
        num+=2.0*tempWeight;
    }
    resultGray/=num;
    // float gray = length(uv);
    // gray = deCode(enCode(gray));
    gl_FragColor = vec4(enCode(resultGray));
}