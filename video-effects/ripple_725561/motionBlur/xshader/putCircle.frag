precision highp float;
varying vec2 uv;
uniform sampler2D inputImageTexture;
uniform sampler2D inOTex;
uniform sampler2D outOTex;

uniform float baseTexWidth;
uniform float baseTexHeight;

uniform float imgSize;
uniform float outSize;
uniform float outIns;
uniform float inSize;
uniform float inIns;
uniform vec2 outVEC1;
uniform vec2 outVEC2;
uniform vec2 inVEC1;
uniform vec2 inVEC2;
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
    vec4 inOCol = texture2D(inOTex,(sucaiUV-0.5)/inSize+0.5)*inIns;
    vec4 outOCol = texture2D(outOTex,(sucaiUV-0.5)/outSize+0.5)*outIns;
    float outD= length((sucaiUV-0.5)/outSize+0.5-0.5);
    outD=(smoothstep(outVEC1.x,outVEC1.y,outD)-smoothstep(outVEC2.x,outVEC2.y,outD))*outIns;

    // vec4 inOCol = texture2D(inOTex,sucaiUV);
    float inD= length((sucaiUV-0.5)/inSize+0.5-0.5);
    inD=(smoothstep(inVEC1.x,inVEC1.y,inD)-smoothstep(inVEC2.x,inVEC2.y,inD))*inIns;

    // vec4 resultCol = vec4(inD+outD);
    vec4 resultCol = vec4(inOCol.r+outOCol.r);

    gl_FragColor = vec4(enCode(resultCol.r));
    

    // inD = mix(inD,inOCol.r,step(uv.x,0.5));
    // gl_FragColor = vec4(inD);
}
// }
