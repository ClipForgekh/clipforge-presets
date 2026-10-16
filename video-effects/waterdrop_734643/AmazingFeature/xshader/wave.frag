precision highp float;

uniform sampler2D sdfImageTexture;
uniform sampler2D inputImageTexture;
varying vec2 uv;
uniform vec4 u_ScreenParams;
uniform vec2 wh;
uniform float stepIns;
uniform float waveIns;
uniform float waveProgressIns;
uniform float filterIns;

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

vec4 getCol(vec2 uv){
    vec2 mySize = wh/min(wh.x,wh.y)*720.;
    float ratio = max(wh.x,wh.y)/min(wh.x,wh.y);
    vec2 offset = vec2(1.0*stepIns*ratio)/mySize;
    
    // Time varying pixel color
    float gray1 = deCode(texture2D(sdfImageTexture,uv+vec2(1,0)*offset));
    float gray11 = deCode(texture2D(sdfImageTexture,uv-vec2(1,0)*offset));
    float gray2 = deCode(texture2D(sdfImageTexture,uv+vec2(0,1)*offset));
    float gray22 = deCode(texture2D(sdfImageTexture,uv-vec2(0,1)*offset));

    vec2 grad=vec2(gray11-gray1,gray22-gray2)*5.*waveIns*waveProgressIns*deCode(texture2D(sdfImageTexture,uv));
    vec2 lastUV = mirror(uv+grad);
    vec4 resultCol = texture2D(inputImageTexture,lastUV);
    return resultCol;
}
void main()
{

    vec2 offset = vec2(1.)/wh;
    // vec4 resultCol = getCol(uv);
    vec4 resultCol = getCol(uv)+getCol(uv+offset*vec2(0.5,0))+getCol(uv+offset*vec2(0,0.5))+getCol(uv+offset*vec2(0.5,0.5));
    resultCol/=4.;
    gl_FragColor = resultCol;
}
