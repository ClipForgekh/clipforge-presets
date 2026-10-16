precision highp float;

uniform sampler2D inputImageTexture;

uniform sampler2D sdfImageTexture;
varying vec2 uv;
uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float waterIns;
uniform float stepIns;
uniform float waterImgIns;
uniform float waterAdjustIns;
// uniform vec3 lightVec;
uniform float outSize;
uniform float outIns;
uniform float inSize;
uniform float inIns;
uniform vec2 outVEC1;
uniform vec2 outVEC2;
uniform vec2 inVEC1;
uniform vec2 inVEC2;
uniform sampler2D _MainTex;
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
float mirror(float x){
    return abs(mod(x-1.0,2.0)-1.0);
}
vec2 mirror(vec2 uv){
    return vec2(mirror(uv.x),mirror(uv.y));
}
// vec4 getCol(vec2 uv){
//      vec2 mySize = vec2(baseTexWidth,baseTexHeight)/min(baseTexWidth,baseTexHeight)*1080.;
//     vec2 offset = vec2(stepIns)/mySize;
//     // Time varying pixel color
//     float gray1 = deCode(texture2D(sdfImageTexture,uv+vec2(1,0)*offset));
//     float gray11 = deCode(texture2D(sdfImageTexture,uv-vec2(1,0)*offset));
//     float gray2 = deCode(texture2D(sdfImageTexture,uv+vec2(0,1)*offset));
//     float gray22 = deCode(texture2D(sdfImageTexture,uv-vec2(0,1)*offset));

//     vec2 grad=vec2(gray11-gray1,gray22-gray2)*10.*waterIns*waterAdjustIns*deCode(texture2D(sdfImageTexture,uv));
//     vec2 lastUV = mirror(uv+grad);
//     vec4 resultCol = texture2D(inputImageTexture,lastUV);
//     // resultCol.rgb+=(deCode(texture2D(sdfImageTexture,uv))-0.5);
//     // resultCol.rgb=vec3(deCode(texture2D(sdfImageTexture,uv))-0.5);
//     return resultCol;
// }

float mySmoothstep(float a,float b,float x){
    float t = (x-a)/(b-a);
    return clamp(t,0.,1.);
}
float getSDF(vec2 uv){
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    vec2 mySize = screenSize.xy/min(screenSize.y,screenSize.y)*1080.;
    
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

    float outD= length((sucaiUV-0.5)/outSize+0.5-0.5);
    outD=(smoothstep(outVEC1.x,outVEC1.y,outD)-smoothstep(outVEC2.x,outVEC2.y,outD))*outIns;

    // vec4 inOCol = texture2D(inOTex,sucaiUV);
    float inD= length((sucaiUV-0.5)/inSize+0.5-0.5);
    inD=(smoothstep(inVEC1.x,inVEC1.y,inD)-smoothstep(inVEC2.x,inVEC2.y,inD))*inIns;

    float resultD = 0.5;
    resultD = mix(resultD,1.0,inD*2.);
    resultD = mix(resultD,1.0,outD);
    // vec4 resultCol = vec4(inD+outD);
    return resultD;
}
vec4 getCol(vec2 uv){
     vec2 mySize = vec2(baseTexWidth,baseTexHeight)/min(baseTexWidth,baseTexHeight)*1080.;
    vec2 offset = vec2(stepIns)/mySize;
    // Time varying pixel color
    float gray1 = getSDF(uv+vec2(1,0)*offset);
    float gray11 = getSDF(uv-vec2(1,0)*offset);
    float gray2 = getSDF(uv+vec2(0,1)*offset);
    float gray22 = getSDF(uv-vec2(0,1)*offset);

    vec2 grad=vec2(gray11-gray1,gray22-gray2)*10.*waterIns*waterAdjustIns*mix(getSDF(uv),1.0,0.2);
    vec2 lastUV = mirror(uv+grad);
    vec4 resultCol = texture2D(inputImageTexture,lastUV);
    return resultCol;
}

float blendOverlay(float base, float blend) {
    return base<0.5?(2.0*base*blend):(1.0-2.0*(1.0-base)*(1.0-blend));
}

vec3 blendOverlay(vec3 base, vec3 blend) {
    return vec3(blendOverlay(base.r,blend.r),blendOverlay(base.g,blend.g),blendOverlay(base.b,blend.b));
}
float blendLinearBurn(float base, float blend) {
    return max(base+blend-1.0,0.0);
}

vec3 blendLinearBurn(vec3 base, vec3 blend) {
    return max(base+blend-vec3(1.0),vec3(0.0));
}

// linear dodge
float blendLinearDodge(float base, float blend) {
    return min(base+blend,1.0);
}

vec3 blendLinearDodge(vec3 base, vec3 blend) {
    return min(base+blend,vec3(1.0));
}

// linear light
float blendLinearLight(float base, float blend) {
    return blend<0.5?blendLinearBurn(base,(2.0*blend)):blendLinearDodge(base,(2.0*(blend-0.5)));
}

vec3 blendLinearLight(vec3 base, vec3 blend) {
    return vec3(blendLinearLight(base.r,blend.r),blendLinearLight(base.g,blend.g),blendLinearLight(base.b,blend.b));
}
void main()
{
    vec2 mySize = vec2(baseTexWidth,baseTexHeight)/min(baseTexWidth,baseTexHeight)*1080.;
    vec2 offset = vec2(1.)/mySize;
    // vec4 resultCol = getCol(uv);
    vec4 resultCol = getCol(uv)+getCol(uv+offset*vec2(1,0))+getCol(uv+offset*vec2(0,1))+getCol(uv+offset*vec2(1,1));
    resultCol/=4.;
    // resultCol = getCol(uv);
    // resultCol=mix(resultCol,getCol(uv),step(uv.x,0.5));
    // float gray = length(uv);
    // gray = deCode(enCode(gray));
    // gl_FragColor = vec4(enCode(resultGray));
   
    // vec2 grad = getGrad(uv);
    resultCol = mix(texture2D(inputImageTexture,uv),resultCol,waterImgIns);


    // vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    // vec2 mySize = screenSize.xy/min(screenSize.y,screenSize.y)*1080.;
    
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
    vec4 sucaiCol = texture2D(_MainTex,sucaiUV);
    sucaiCol.rgb=clamp(sucaiCol.rgb/sucaiCol.a,0.,1.);
    resultCol.rgb = mix(resultCol.rgb,blendLinearLight(resultCol.rgb,sucaiCol.rgb),sucaiCol.a);
    // resultCol.rgb+=dot(vec3(grad,deCode(texture2D(sdfImageTexture,uv))),lightVec);
    // grad = abs(grad);
    // gl_FragColor = vec4(grad,0,1);
    // resultCol  = vec4(abs(dot(grad,vec2(1,-1))));
     gl_FragColor = vec4(resultCol);

    // float d = deCode(texture2D(sdfImageTexture,uv));
    // d=mix(d,getSDF(uv),step(uv.x,0.5));
    // gl_FragColor = vec4(d);
    // vec4 testCol = vec4(deCode(texture2D(sdfImageTexture,uv+vec2(1,1)*offset)));
    // testCol = mix(testCol,vec4(getGrad(uv)*2.0+0.5,0,1),step(uv.x,0.5));
    // gl_FragColor = vec4(getSDF(uv));


}