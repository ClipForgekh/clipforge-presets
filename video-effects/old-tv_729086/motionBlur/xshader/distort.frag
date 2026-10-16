precision highp float;

uniform sampler2D inputImageTexture;
varying vec2 uv;
uniform vec4 u_ScreenParams;
uniform float distortIns;
uniform sampler2D displacementTexture;
uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float displaymentIns;
float n11(float a){
    return fract(122.41*sin((a*123.43+123.22)));
}
vec2 flip_uv(vec2 uv){
    return abs(mod(uv + 1., 2.) - 1.0);
}

float noise11(float a){
    float x = fract(a);
    x = x * x * x *(x *(x*6.-15.)+10.);
    float n = floor(a);
    float t0 = n11(n);
    float t1 = n11(n+1.);
    
    return mix(t0,t1,x);
}
float fbsNoise(float a){
    return 0.5*noise11(a)+0.25*noise11(a*2.0)+0.15*noise11(a*4.0);
}
float uvPro(vec2 uv){
    return step(0.0,uv.x)*step(uv.x,1.0)*step(0.0,uv.y)*step(uv.y,1.0);
}
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r,blend.r),blendScreen(base.g,blend.g),blendScreen(base.b,blend.b));
}

void main()
{

    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    screenSize = screenSize.xy/min(screenSize.x,screenSize.y)*1080.;
    
    float noiseSize = screenSize.y/50.;
    float noise = fbsNoise(uv.y*noiseSize);
    vec2 newUV = uv;
    newUV.x+=(noise-0.5)*100./screenSize.x*distortIns;
    // newUV = fract(newUV);

    float displacementCol = texture2D(displacementTexture,uv).r;
    newUV.x+=(displacementCol-0.5)*2.0*1.1*displaymentIns/screenSize.x;
    

    vec4 resultCol = texture2D(inputImageTexture, newUV)*uvPro(newUV);

    // float whiteMask = smoothstep(0.95,1.05,newUV.x);
    // whiteMask = max(whiteMask,smoothstep(0.05,-0.05,newUV.x));
    // whiteMask = max(whiteMask,smoothstep(0.03,-0.03,newUV.y));
    // whiteMask = max(whiteMask,smoothstep(0.97,1.03,newUV.y));
    // resultCol.rgb = mix(resultCol.rgb,blendScreen(resultCol.rgb,vec3(whiteMask)),0.3*uvPro(newUV));
    

    gl_FragColor = vec4(resultCol);
}