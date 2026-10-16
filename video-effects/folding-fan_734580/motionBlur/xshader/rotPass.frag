precision highp float;

uniform sampler2D inputImageTexture;

uniform float baseTexWidth;
uniform float baseTexHeight;

varying vec2 uv;
uniform float rotVec[5];
uniform float preRotVec[5];
uniform float alphaVec[5];
uniform float satVec[5];

uniform float iTime;
#define blurRadius 32
const vec3 LuminanceFactor = vec3(0.208540, 0.702086, 0.089374);



float getRotVec(int i){
    if(i==0) return rotVec[0];
    if(i==1) return rotVec[1];
    if(i==2) return rotVec[2];
    if(i==3) return rotVec[3];
    if(i==4) return rotVec[4];
}
float getPreRotVec(int i){
    if(i==0) return preRotVec[0];
    if(i==1) return preRotVec[1];
    if(i==2) return preRotVec[2];
    if(i==3) return preRotVec[3];
    if(i==4) return preRotVec[4];
}
float getAlphaVec(int i){
    if(i==0) return alphaVec[0];
    if(i==1) return alphaVec[1];
    if(i==2) return alphaVec[2];
    if(i==3) return alphaVec[3];
    if(i==4) return alphaVec[4];
}
float getSatVec(int i){
    if(i==0) return satVec[0];
    if(i==1) return satVec[1];
    if(i==2) return satVec[2];
    if(i==3) return satVec[3];
    if(i==4) return satVec[4];
}

vec2 flip_uv(vec2 uv){
    return abs(mod(uv + 1., 2.) - 1.0);
}
/* Math 2D Transformations */
mat2 rotate2d(in float angle){
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c,-s, s, c);
}
vec2 getRotUV(float angle,vec2 uv,vec2 screenSize){
    vec2 newUV = uv - 0.5;
    newUV.x*=screenSize.x/screenSize.y;
    newUV*=rotate2d(angle);
    newUV.x/=screenSize.x/screenSize.y;
    return newUV + 0.5;
}
vec4 getSatCol(vec4 oriColor,float u_intensity){
    vec4 resColor = oriColor;

    // use a color vector to adjust saturation
    vec3 baseAdjustVec = LuminanceFactor * (1. - u_intensity);
    vec3 adjustVec = baseAdjustVec + vec3(u_intensity, 0., 0.);
    resColor.r = dot(oriColor.rgb, adjustVec);

    adjustVec = baseAdjustVec + vec3(0., u_intensity, 0.);
    resColor.g = dot(oriColor.rgb, adjustVec);

    adjustVec = baseAdjustVec + vec3(0., 0., u_intensity);
    resColor.b = dot(oriColor.rgb, adjustVec);
    return clamp(resColor, 0., 1.);
}
void main()
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    vec2 newUV = uv;
    float centerX = 0.1+floor(uv.x*5.)*0.2;
    
    newUV.x = (uv.x-centerX)+centerX;

    int id = int(floor(uv.x*5.));
    vec4 col = vec4(0.);
    float weight = 0.;
    float preRot = getPreRotVec(id);
    float rot = getRotVec(id);
    float alpha = getAlphaVec(id);
    float sat = getSatVec(id);

    for(int i=0;i<=blurRadius;i++){
        float j = float(i);
        float tempAngle = mix(preRot,rot,j/float(blurRadius));
        vec2 tempUV = getRotUV(tempAngle,newUV,screenSize);
        vec4 tempCol = texture2D(inputImageTexture,flip_uv(tempUV))*alpha;
        tempCol = getSatCol(tempCol,sat+1.);
         col += tempCol;
         weight++;
    }
    col/=weight;
    gl_FragColor = vec4(col);
}
