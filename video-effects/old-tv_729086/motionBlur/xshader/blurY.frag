precision highp float;

uniform sampler2D inputImageTexture;
varying vec2 uv;

uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float blurRadius;
uniform float blurIns;
uniform float blurRadiusAdjust;

float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}
void main()
{

    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    screenSize = screenSize.xy/min(screenSize.x,screenSize.y)*540.;
    vec2 offset = vec2(0,blurIns*1.5)/screenSize;
    float weight0 = normpdf(0.,4.);
    vec4 col = texture2D(inputImageTexture,uv);
    // col.rgb*=col.a;
    col=pow(col,vec4(2.4));
    col*=weight0;
    float sunWeight = weight0;
    
    for(int i =1;i<65;i++){
        float j =float(i);
        if(j+0.5>(blurRadius*0.25*blurRadiusAdjust))break;
        float tempWeight = normpdf(j/(blurRadius*0.25*blurRadiusAdjust)*16.,4.);
        vec4 colA = texture2D(inputImageTexture,uv+offset*j);
        // colA.rgb*=colA.a;
        colA=pow(colA,vec4(2.4));
        col+=tempWeight*colA;

        vec4 colB = texture2D(inputImageTexture,uv-offset*j);
        // colB.rgb*=colB.a;
        colB=pow(colB,vec4(2.4));
        col+=tempWeight*colB;
        
        sunWeight+=2.*tempWeight;
    }
    col/=sunWeight;
    col=pow(col,vec4(1./2.4));
    gl_FragColor = vec4(col);
}