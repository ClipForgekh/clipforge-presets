precision highp float;
varying vec2 uv0;
uniform sampler2D u_InputTex;
uniform sampler2D FilterInputTex;
uniform float filterIns;
// uniform sampler2D _MainTex;
#define textureCoordinate uv0

vec4 lm_take_effect_filter(sampler2D filterTex,vec4 inputColor,float uniAlpha)
{
    highp vec4 textureColor=inputColor;//texture2D(inputTex,textureCoordinate);
    highp float blueColor=textureColor.b*63.;
    
    highp vec2 quad1;
    quad1.y=floor(floor(blueColor)/8.);
    quad1.x=floor(blueColor)-(quad1.y*8.);
    
    highp vec2 quad2;
    quad2.y=floor(ceil(blueColor)/8.);
    quad2.x=ceil(blueColor)-(quad2.y*8.);
    
    highp vec2 texPos1;
    texPos1.x=(quad1.x*1./8.)+.5/512.+((1./8.-1./512.)*textureColor.r);
    texPos1.y=(quad1.y*1./8.)+.5/512.+((1./8.-1./512.)*textureColor.g);
    
    highp vec2 texPos2;
    texPos2.x=(quad2.x*1./8.)+.5/512.+((1./8.-1./512.)*textureColor.r);
    texPos2.y=(quad2.y*1./8.)+.5/512.+((1./8.-1./512.)*textureColor.g);
    
    vec4 newColor1=texture2D(filterTex,texPos1);
    vec4 newColor2=texture2D(filterTex,texPos2);
    vec4 newColor=mix(newColor1,newColor2,fract(blueColor));
    newColor=mix(textureColor,vec4(newColor.rgb,textureColor.w),uniAlpha);
    return newColor;
}
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z +  (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
void main() {
  vec4 curColor=texture2D(u_InputTex,uv0);
  vec4 resultColor=lm_take_effect_filter(FilterInputTex , curColor , filterIns);
  vec3 hsv = rgb2hsv(resultColor.rgb);
  hsv.y -=0.35;
  resultColor.rgb = hsv2rgb(hsv);
  gl_FragColor= resultColor;
 
}
