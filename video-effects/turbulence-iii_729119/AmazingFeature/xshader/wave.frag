precision highp float;

uniform sampler2D sdfImageTexture;
uniform sampler2D inputImageTexture;
uniform sampler2D filterTex;
varying vec2 uv;
uniform vec4 u_ScreenParams;

uniform float stepIns;
uniform float waveIns;
uniform float waveProgressIns;
uniform float filterIns;
uniform sampler2D _MainTex;

uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float opacity;
uniform float light_opacity;
mat2 rotMat(float angle){
    float sinA = sin(angle);
    float cosA = cos(angle);
    return mat2(cosA,-sinA,
                sinA,cosA);
}

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
float mySmoothstep(float a,float b,float x){
    float t = (x-a)/(b-a);
    return clamp(t,0.,1.);
}
// float getSDF(vec2 uv){
//     vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
//     vec2 mySize = screenSize.xy/min(screenSize.y,screenSize.y)*1080.;
    
//     vec2 baseTextureSize=vec2(baseTexWidth,baseTexHeight);
//     vec2 sucaiSize=vec2(1,1);
//     vec2 fullBlendAnchor=baseTextureSize*.5;
//     float scale=1.;
//     float baseAspectRatio=baseTextureSize.y/baseTextureSize.x;
//     float blendAspectRatio=sucaiSize.y/sucaiSize.x;
//     if(baseAspectRatio>=blendAspectRatio){
//         scale=baseTextureSize.y/sucaiSize.y;
//     }else{
//         scale=baseTextureSize.x/sucaiSize.x;
//     }
//     vec2 baseTextureCoord=uv*baseTextureSize;
//     vec2 tempSucaiUV=(baseTextureCoord-fullBlendAnchor)/(sucaiSize*scale)+vec2(.5);
//     tempSucaiUV.y = 1.0-tempSucaiUV.y;
//     vec2 sucaiUV = tempSucaiUV;

//     float outD= length((sucaiUV-0.5)/outSize+0.5-0.5);
//     outD=(smoothstep(outVEC1.x,outVEC1.y,outD)-smoothstep(outVEC2.x,outVEC2.y,outD))*outIns;

//     // vec4 inOCol = texture2D(inOTex,sucaiUV);
//     float inD= length((sucaiUV-0.5)/inSize+0.5-0.5);
//     inD=(smoothstep(inVEC1.x,inVEC1.y,inD)-smoothstep(inVEC2.x,inVEC2.y,inD))*inIns;

//     float resultD = 0.5;
//     resultD = mix(resultD,1.0,inD*2.);
//     resultD = mix(resultD,1.0,outD);
//     // vec4 resultCol = vec4(inD+outD);
//     return resultD;
// }
// vec4 getCol(vec2 uv){
//      vec2 mySize = vec2(baseTexWidth,baseTexHeight)/min(baseTexWidth,baseTexHeight)*1080.;
//     vec2 offset = vec2(stepIns)/mySize;
//     // Time varying pixel color
//     float gray1 = getSDF(uv+vec2(1,0)*offset);
//     float gray11 = getSDF(uv-vec2(1,0)*offset);
//     float gray2 = getSDF(uv+vec2(0,1)*offset);
//     float gray22 = getSDF(uv-vec2(0,1)*offset);

//     vec2 grad=vec2(gray11-gray1,gray22-gray2)*10.*waterIns*waterAdjustIns*mix(getSDF(uv),1.0,0.2);
//     vec2 lastUV = mirror(uv+grad);
//     vec4 resultCol = texture2D(inputImageTexture,lastUV);
//     return resultCol;
// }

float blendLinearBurn(float base, float blend) {
   return max(base+blend-1.0,0.0);
}

float blendLinearDodge(float base, float blend) {
    return min(base+blend,1.0);
}

float blendLinearLight(float base, float blend) {
    return blend<0.5?base:blendLinearDodge(base,(2.0*(blend-0.5)));
    // return blend<0.5?base:blendLinearDodge(base,(2.0*(blend-0.5)));
}

vec3 blendLinearLight(vec3 base, vec3 blend) {
    return vec3(blendLinearLight(base.r,blend.r),blendLinearLight(base.g,blend.g),blendLinearLight(base.b,blend.b));
}
vec4 getCol(vec2 uv){
    
    vec2 mySize = u_ScreenParams.xy/min(u_ScreenParams.x,u_ScreenParams.y)*720.;
    float ratio = max(u_ScreenParams.x,u_ScreenParams.y)/min(u_ScreenParams.x,u_ScreenParams.y);
    vec2 offset = vec2(1.0*stepIns*ratio)/mySize;
    
    // Time varying pixel color
    float gray1 = deCode(texture2D(sdfImageTexture,uv+vec2(1,0)*offset));
    float gray11 = deCode(texture2D(sdfImageTexture,uv-vec2(1,0)*offset));
    float gray2 = deCode(texture2D(sdfImageTexture,uv+vec2(0,1)*offset));
    float gray22 = deCode(texture2D(sdfImageTexture,uv-vec2(0,1)*offset));

    vec2 grad=vec2(gray11-gray1,gray22-gray2)*10.*waveIns*waveProgressIns*deCode(texture2D(sdfImageTexture,uv));
    vec2 lastUV = mirror(uv+grad);
    
    vec4 resultCol = texture2D(inputImageTexture,lastUV);
    // resultCol = Sat(resultCol);
    return resultCol;
}
void main()
{
    
    vec2 offset = vec2(1.)/u_ScreenParams.xy;
    // vec4 resultCol = getCol(uv);
    vec4 resultCol = getCol(uv)+getCol(uv+offset*vec2(0.5,0))+getCol(uv+offset*vec2(0,0.5))+getCol(uv+offset*vec2(0.5,0.5));
    resultCol/=4.;

    vec2 baseTextureSize=vec2(baseTexWidth,baseTexHeight);
    vec2 sucaiSize=vec2(1,1);
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
    vec2 sucaiUV = tempSucaiUV;
    // vec2 tempSucaiUV=(baseTextureCoord-fullBlendAnchor)/(sucaiSize*scale)+vec2(.5);
    // tempSucaiUV.y = 1.0-tempSucaiUV.y;
    // vec2 sucaiUV = tempSucaiUV;

    vec4 sucaiCol = texture2D(_MainTex,sucaiUV);
    sucaiCol.rgb*=light_opacity;
    sucaiCol.rgb=clamp(sucaiCol.rgb/sucaiCol.a,0.,1.);
    resultCol.rgb = mix(resultCol.rgb,blendLinearLight(resultCol.rgb,sucaiCol.rgb),sucaiCol.a);
    // resultCol = takeEffectFilter(filterTex,resultCol,filterIns);
    resultCol.rgb*=opacity;
    gl_FragColor = resultCol;
}
