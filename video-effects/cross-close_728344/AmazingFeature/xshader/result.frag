precision highp float;

uniform sampler2D inputImageTexture;
uniform sampler2D bgmaskTexture;
uniform sampler2D mixTex1;
uniform sampler2D mixTex2;

varying vec2 uv0;

uniform float baseTexHeight;
uniform float baseTexwh;
uniform float motino_uv;



float blendOverlay(float base, float blend) {
return base==0.?blend:base;
}

vec3 blendOverlay(vec3 base, vec3 blend) {
return vec3(blendOverlay(base.r,blend.r),blendOverlay(base.g,blend.g),blendOverlay(base.b,blend.b));
}

float uvProtect(vec2 uvTemp) 
{ 
return step(0.,uvTemp.x)*step(0.,uvTemp.y)*step(uvTemp.x,1.0)*step(uvTemp.y,1.0); 
} 
void main()
{
    vec2 uv5 = vec2(uv0.x+0.1,uv0.y-baseTexHeight*1.24);
    vec2 uv7 = vec2(uv0.x+0.1,uv0.y+baseTexHeight*1.24);

    vec2 uv1 = uv0;
    uv1-=0.5;
    uv1 = vec2(uv1.x,uv1.y * motino_uv);
    uv1+=0.5;
    
    vec4 col = vec4(0.0, 0.0, 0.0, 1.0);
    if(baseTexwh==1.){
        uv5 = vec2(1.-(uv0.x-0.1),uv0.y-baseTexHeight*1.24);
        uv7 = vec2(1.-(uv0.x-0.1),uv0.y+baseTexHeight*1.24);
        col = texture2D(inputImageTexture,uv1);
    }
    vec2 uv6 = vec2(uv5.x,1. - uv5.y );

    uv6-=0.5;
    uv6*=0.80;
    uv6+=0.5;

    uv7-=0.5;
    uv7*=0.80;
    uv7+=0.5;

    vec4 bgmaskColor1 = texture2D(bgmaskTexture,uv6);
    vec4 bgmaskColor2 = texture2D(bgmaskTexture,uv7);
    vec4 mixColor_1 = texture2D(mixTex1,uv0);
    vec4 mixColor_2 = texture2D(mixTex2,uv0);
    
    col.rgb = mix(col.rgb ,mixColor_1.rgb , bgmaskColor1.r);
    col.rgb = mix(col.rgb,mixColor_2.rgb , bgmaskColor2.r);
    gl_FragColor = col;
}