precision highp float;

uniform sampler2D inputImageTexture;
uniform float blurSize;
uniform float blurIns;
varying vec2 uv;

#define textureCoordinate uv
uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float exposure;
float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}
mat2 rotMat(float angle){
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c,-s,s,c);
}
vec4 Exposure(vec4 inputCol, float _intensity, float _offset, float _gray_scale_correct, float _linear){
    vec4 col = inputCol;
    if(_linear<0.5) col.rgb = pow(col.rgb, vec3(2.2));
    col.rgb *= pow(2.0, _intensity);
    col.rgb += _offset;
    vec3 s = sign(col.rgb);
    col.rgb = pow(abs(col.rgb), vec3(1.0 / _gray_scale_correct)) * s;
    s = sign(col.rgb);
    if (_linear<0.5) col.rgb = pow(abs(col.rgb), vec3(0.454545454545)) * s;
    return col;
}
void main()
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    vec2 mySize = screenSize.xy/min(screenSize.x,screenSize.y)*720.;
    vec2 offset = vec2(0,blurSize*blurIns)/mySize;
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
    resultCol = Exposure(resultCol,exposure,0.,1.,0.);
    

    gl_FragColor = vec4(resultCol);
}