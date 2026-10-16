precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex0;
uniform sampler2D u_InputTex;
uniform sampler2D u_InputTex2;
uniform sampler2D u_GlowBlurTex1;
uniform sampler2D u_GlowBlurTex2;
uniform sampler2D u_GlowBlurTex3;
uniform sampler2D u_GlowBlurTex4;
uniform sampler2D u_GlowBlurTex5;
uniform sampler2D u_GlowBlurTex6;
uniform sampler2D u_GlowBlurTex7;
uniform sampler2D u_GlowBlurTex8;
uniform float u_GlowIntensity;
uniform vec4 u_TextColor;
uniform float opcity2;



// screen
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r,blend.r),blendScreen(base.g,blend.g),blendScreen(base.b,blend.b));
}




void main()
{
    vec4 oriColor = texture2D(u_InputTex, uv0);
    vec4 blurColor1 = texture2D(u_GlowBlurTex1, uv0);
    vec4 blurColor2 = texture2D(u_GlowBlurTex2, uv0);
    vec4 blurColor3 = texture2D(u_GlowBlurTex3, uv0);
    vec4 blurColor4 = texture2D(u_GlowBlurTex4, uv0);
    vec4 blurColor5 = texture2D(u_GlowBlurTex5, uv0);
    vec4 blurColor6 = texture2D(u_GlowBlurTex6, uv0);
    vec4 blurColor7 = texture2D(u_GlowBlurTex7, uv0);
    vec4 blurColor8 = texture2D(u_GlowBlurTex8, uv0);
    float intensity = pow(u_GlowIntensity * 0.5, 1./2.4);
    vec4 dis1 = clamp(blurColor1 * intensity, 0.0, 1.0);
    vec4 dis2 = clamp(blurColor2 * intensity, 0.0, 1.0);
    vec4 dis3 = clamp(blurColor3 * intensity, 0.0, 1.0);
    vec4 dis4 = clamp(blurColor4 * intensity, 0.0, 1.0);
    vec4 dis5 = clamp(blurColor5 * intensity, 0.0, 1.0);
    vec4 dis6 = clamp(blurColor6 * intensity, 0.0, 1.0);
    vec4 dis7 = clamp(blurColor7 * intensity, 0.0, 1.0);
    vec4 dis8 = clamp(blurColor8 * intensity, 0.0, 1.0);
    dis1 = 1. - (1. - dis1) * (1. - dis2);
    dis1 = 1. - (1. - dis1) * (1. - dis3);
    dis1 = 1. - (1. - dis1) * (1. - dis4);
    dis1 = 1. - (1. - dis1) * (1. - dis5);
    dis1 = 1. - (1. - dis1) * (1. - dis6);
    dis1 = 1. - (1. - dis1) * (1. - dis7);
    dis1 = 1. - (1. - dis1) * (1. - dis8);
    vec4 glowColor = clamp(vec4(dis1) * max(intensity, 1.0), 0.0, 1.0);
    oriColor = (1. - (1. - glowColor) * (1. - oriColor));
    vec4 oriColor2 = texture2D(u_InputTex2, uv0);
    vec4 inputColor = texture2D(u_InputTex0, uv0);
    // gl_FragColor = vec4(mix(oriColor.rgb,clamp(blendNormal(oriColor.rgb, oriColor2.rgb),0.,1.),opcity2), inputColor.a);
    vec4 res = vec4(mix(oriColor.rgb,clamp(blendScreen(oriColor.rgb, oriColor2.rgb),0.,1.),opcity2), inputColor.a);
    // res.rgb = mix(res.rgb,vec3(1.,1. ,1.) ,opcity2*0.5);
    gl_FragColor = res;
}