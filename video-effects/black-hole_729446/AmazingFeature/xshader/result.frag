precision highp float;

uniform sampler2D inputImageTexture;
uniform sampler2D _MainTex;
uniform sampler2D u_maskTex;
uniform sampler2D u_hsTex;
uniform sampler2D u_hdTex;

varying vec2 uv;

uniform vec2 u_ScreenSize;
uniform float u_blackAlpha;
uniform float u_maskScale;
uniform float u_hdAlpha;
uniform float u_hdScale;
uniform float u_hsAlpha;
uniform float u_hsScale;
uniform float u_GlitchAlpha;
uniform float u_glitchBlack;
uniform float u_abc;

vec4 blendAdd(vec4 src, vec4 dst, float intensity)
{
    float newAlpha = src.a + dst.a * (1. - src.a);
    // newAlpha = 1.;
    vec3 newRGB = clamp((src.rgb + dst.rgb)/clamp(newAlpha, 0.001, 1.), vec3(0.), vec3(1.)) * min(newAlpha,1.);
    // return mix(dst, vec4(newRGB, newAlpha), intensity);
    return clamp(mix(dst, vec4(src.rgb + dst.rgb, newAlpha), intensity),vec4(0.),vec4(1.));
}

float uvProtect(vec2 uvTemp)
{
    return step(0.,uvTemp.x)*step(0.,uvTemp.y)*step(uvTemp.x,1.0)*step(uvTemp.y,1.0);
}

void main()
{
   
    vec4 resColor = texture2D(inputImageTexture, uv);
    // gl_FragColor = resColor;
    // return;
    resColor.rgb = mix(vec3(0),resColor.rgb,1.-u_blackAlpha);

    vec2 sucaiUV = uv;
    if(u_ScreenSize.x > u_ScreenSize.y)
        sucaiUV.y = (sucaiUV.y-0.5) * u_ScreenSize.y/u_ScreenSize.x + 0.5;
    else
        sucaiUV.x = (sucaiUV.x-0.5) * u_ScreenSize.x/u_ScreenSize.y + 0.5;

    vec2 mask_uv = (sucaiUV - 0.5)/max(0.001,u_maskScale) + 0.5;
    float maskAlpha = texture2D(u_maskTex,mask_uv).a;
    resColor.rgb = mix(vec3(0),resColor.rgb,maskAlpha);
    resColor.a *= maskAlpha;

    vec2 hd_uv = (sucaiUV - 0.5)/max(0.001,u_hdScale) + 0.5;
    vec4 hd_Color = texture2D(u_hdTex, hd_uv)*uvProtect(hd_uv);
    hd_Color = resColor * (1. - hd_Color.a) + hd_Color;
    resColor = mix(resColor, hd_Color, u_hdAlpha);
    
    vec2 hs_uv = (sucaiUV - 0.5)/max(0.001,u_hsScale) + 0.5;
    vec4 hs_Color = texture2D(u_hsTex, hs_uv)*uvProtect(hs_uv);
    resColor = blendAdd(hs_Color, resColor, u_hsAlpha);
    // resColor = mix(resColor, hs_Color + resColor, u_hsAlpha*u_abc);

    // vec2 glitch_uv = vec2(uv.x,1.-uv.y);
    // if(u_ScreenSize.x > u_ScreenSize.y)
    //     glitch_uv.x = (glitch_uv.x-0.5) * u_ScreenSize.x/u_ScreenSize.y + 0.5;
    // else
    //     glitch_uv.y = (glitch_uv.y-0.5) * u_ScreenSize.y/u_ScreenSize.x + 0.5;

    vec4 glitch_Color = texture2D(_MainTex, sucaiUV) * uvProtect(sucaiUV);
    resColor = blendAdd(glitch_Color, resColor, u_GlitchAlpha);
    resColor = mix(resColor, vec4(0), u_glitchBlack);
    gl_FragColor = resColor;
    // gl_FragColor = hd_Color;
    // gl_FragColor =  vec4(1.);
    // gl_FragColor = hs_Color * u_hsAlpha;
}