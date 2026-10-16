precision highp float;

uniform sampler2D inputImageTexture2_2;
uniform sampler2D mixTex;
uniform sampler2D mixTex_2;

uniform float baseTexHeight; 
uniform float baseTexwh; 
uniform float photo;

varying vec2 uv0;


vec3 blendNormal(vec3 base, vec3 blend) {
    return blend;
}

vec3 blendNormal(vec3 base, vec3 blend, float opacity) {
    return base * opacity + blend * (1.0 - opacity);
}

float blendOverlay(float base, float blend) {
return base==0.?base:blend;
}

vec3 blendOverlay(vec3 base, vec3 blend) {
return vec3(blendOverlay(base.r,blend.r),blendOverlay(base.g,blend.g),blendOverlay(base.b,blend.b));
}

float uvProtect(vec2 uvTemp) 
{ 
return step(0.,uvTemp.x)*step(0.,uvTemp.y)*step(uvTemp.x,1.0)*step(uvTemp.y,1.0); 
} 
float blend(float base) 
{ 
    return base ==0.?base:1.; 
} 
vec3 blend(vec3 base) {
    return vec3(blend(base.r),blend(base.g),blend(base.b));
}
void main()
{
    vec2 uv1 = uv0;
    uv1 = vec2(uv1.x,uv1.y+baseTexHeight*1.24);
    vec2 uv2 = vec2(uv0.x,uv0.y);
    vec2 uv3 = vec2(1.-uv2.x,1.-uv2.y);
    uv3-=0.5;
    uv3.x+=0.5; 
    uv3.y+=photo*0.5;
    uv3*=0.5;  
    uv3+=0.5;
    if(baseTexwh==1.){
        uv1 = vec2(1.-(uv0.x),uv0.y+baseTexHeight*1.24);
    }
    vec4 col = texture2D(inputImageTexture2_2,uv3);
    uv1-=0.5;
    uv1*=0.80;
    uv1+=0.5;
    vec4 mixColor1 = texture2D(mixTex,uv1);
    mixColor1 = vec4(mixColor1.r,mixColor1.g ,mixColor1.b ,mixColor1.r);
    
    
    // col.rgb = mix(mixColor1.rgb,col.rgb,mixColor1.r);
    col = col*mixColor1;
    col.rgb = mix(vec3(1.0, 1.0, 1.0),col.rgb,0.5);
    vec4 col2 = col;
    col.rgb = blendNormal(col.rgb,col2.rgb,0.50);
    
    gl_FragColor = col;
}