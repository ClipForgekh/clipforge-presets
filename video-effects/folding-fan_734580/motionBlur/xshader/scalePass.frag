precision highp float;

uniform sampler2D inputImageTexture;
varying vec2 uv;
uniform float scale;

#define textureCoordinate uv
uniform float baseTexWidth;
uniform float baseTexHeight;
float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}
vec2 flip_uv(vec2 uv){
    return abs(mod(uv + 1., 2.) - 1.0);
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
    vec2 newUV = (uv-0.5)/scale+0.5;
    vec4 resultCol = texture2D(inputImageTexture, flip_uv(newUV));


    gl_FragColor = vec4(resultCol);
}