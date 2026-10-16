precision highp float;

uniform sampler2D inputImageTexture;
uniform vec4 u_ScreenParams;
uniform sampler2D lineTexture;
uniform sampler2D noiseTexture;
uniform sampler2D darkAngleTexture;
uniform float lineMove;
uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float imgHSize;
uniform float lineIns;
uniform float blueIns;
uniform float darkAngleIns;
uniform float colnoiseIns;
uniform float innerGlowIns;
uniform float whiteIns;

varying vec2 uv;
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
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r,blend.r),blendScreen(base.g,blend.g),blendScreen(base.b,blend.b));
}
float blendOverlay(float base, float blend) {
    return base<0.5?(2.0*base*blend):(1.0-2.0*(1.0-base)*(1.0-blend));
}

vec3 blendOverlay(vec3 base, vec3 blend) {
    return vec3(blendOverlay(base.r,blend.r),blendOverlay(base.g,blend.g),blendOverlay(base.b,blend.b));
}
float n11(float a){
    return fract(122.41*sin((a*123.43+123.22)));
}
float noise11(float a){
    float x = fract(a);
    float n = floor(a);
    float t0 = n11(n);
    float t1 = n11(n+1.);
    return mix(t0,t1,smoothstep(0.,1.,x));
}
float fbsNoise(float a){
    return 0.5*noise11(a)+0.5*noise11(a*2.0)+0.25*noise11(a*4.0);
}
float uvPro(vec2 uv){
    return step(0.0,uv.x)*step(uv.x,1.0)*step(0.0,uv.y)*step(uv.y,1.0);
}

void main()
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    screenSize = screenSize.xy/min(screenSize.x,screenSize.y)*1080.;
    // float noiseSize = screenSize.y/50.;
    // float noise = fbsNoise(uv.y*noiseSize);
    vec2 imgUV = uv;
    imgUV.y = (imgUV.y-0.5)/imgHSize+0.5;
    float imgPro = uvPro(imgUV);
    // newUV.x+=(noise-0.5)*100./screenSize.x;
    
    vec4 col = texture2D(inputImageTexture,imgUV)*imgPro;

    vec2 noiseUV = uv;
    noiseUV = screenSize/vec2(1080,1080)*uv;
    vec4 noiseCol = texture2D(noiseTexture,fract(noiseUV))*imgPro;
    col.rgb = mix(col.rgb,blendLinearLight(col.rgb,noiseCol.rgb),colnoiseIns);

   
    vec4 darkAngleCol = texture2D(darkAngleTexture,uv)*imgPro;
    col.rgb = mix(col.rgb,blendLinearLight(col.rgb,darkAngleCol.rgb),darkAngleIns);

    vec3 blueCol = vec3(53,159,255)/255.*imgPro;
    col.rgb = mix(col.rgb,blendScreen(col.rgb,blueCol.rgb),blueIns);

    vec2 lineUV = uv;
    lineUV.y = screenSize.y/556.*uv.y+(lineMove-100.)/556.;
    // lineUV.y = 1.0-lineUV.y;
    vec4 lineCol = texture2D(lineTexture,fract(lineUV))*imgPro;
    col.rgb = mix(col.rgb,blendOverlay(col.rgb,lineCol.rgb),lineIns);

    float whiteMask = smoothstep(0.93,1.07,imgUV.x);
    whiteMask = max(whiteMask,smoothstep(0.07,-0.07,imgUV.x));
    whiteMask = max(whiteMask,smoothstep(0.03,-0.03,imgUV.y));
    whiteMask = max(whiteMask,smoothstep(0.97,1.03,imgUV.y));
    col.rgb = mix(col.rgb,blendScreen(col.rgb,vec3(whiteMask)*2.),innerGlowIns*uvPro(imgUV));

    col.rgb = mix(col.rgb,vec3(1),whiteIns*uvPro(imgUV));

    // col.rgb*=uvpro(rotUV);
    // col=vec4(noise11(uv.y*20.));
    gl_FragColor = vec4(col);
}
