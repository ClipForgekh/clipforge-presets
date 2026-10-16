precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTexture;
uniform sampler2D u_MaskTexture;
uniform int u_MatteMode;
uniform sampler2D filtertex;
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
    newColor=mix(textureColor,vec4(newColor.rgb,textureColor.w),1.);
    return newColor;
}
float getLuminosity(vec3 color)
{
    return dot(color, vec3(0.299, 0.587, 0.114));
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
void main()
{
    vec4 inputColor = texture2D(u_InputTexture, uv0);
    vec4 maskColor = texture2D(u_MaskTexture, uv0);

    float factor = maskColor.a;
    if (u_MatteMode == 1)
    {
        factor = getLuminosity(inputColor.rgb);
    }
    else if (u_MatteMode == 2)
    {
        factor = 1.0 - maskColor.a;
    }
    else if (u_MatteMode == 3)
    {
        factor = 1.0 - getLuminosity(inputColor.rgb);
    }
    vec4 res = inputColor*factor;
    res = lm_take_effect_filter(filtertex,res,1.);
    vec3 hsv = rgb2hsv(res.rgb); 
    hsv.y+=0.1;
    res.rgb = hsv2rgb(hsv);
    gl_FragColor = res;
}
