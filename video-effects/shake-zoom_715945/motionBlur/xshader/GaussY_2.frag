precision highp float;

varying vec2 uv;

uniform sampler2D inputImageTexture;
uniform sampler2D u_albedo;
uniform sampler2D oriTexture;
uniform sampler2D noiseTex;
uniform int inputWidth;
uniform int inputHeight;
uniform float blurSize;
uniform float slider_value;
uniform float noisIns;
uniform int blurRadius;
uniform float intensity;
uniform float lightIns;
#define textureCoordinate uv
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r,blend.r),blendScreen(base.g,blend.g),blendScreen(base.b,blend.b));
}
float random (vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))* 43758.5453123);
}

float noise (vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}
vec4 addNoise(vec2 uv,vec4 color1,float dis){
    float strengthPower = 1.0*slider_value;
    float strength = 16.0 * strengthPower;
    float x = (uv.x + 4.0) * (uv.y + 4.0) * ((mod(1.0,100.0)+3.0)* 10.0);
    vec4 grain =vec4(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01) - 0.005) *strength;
    //vec4 color1 = texture2D(inputImageTexture,uv);
    vec4 resultCol = color1 + grain * slider_value*dis ;
    //gl_FragColor = clamp(gl_FragColor, 0.0, gl_FragColor.a);
    return vec4(resultCol);
}
void main()
{
    vec2 screenSize = vec2(inputWidth,inputHeight);

    float half_gaussian_weight[9];
    
    half_gaussian_weight[0]= 0.2; //0.2;//0.137401;
    half_gaussian_weight[1]= 0.19;//0.2;//0.125794;
    half_gaussian_weight[2]= 0.17;//0.2;//0.106483;
    half_gaussian_weight[3]= 0.15;//0.2;//0.080657;
    half_gaussian_weight[4]= 0.13;//0.2;//0.054670;
    half_gaussian_weight[5]= 0.11;//0.2;//0.033159;
    half_gaussian_weight[6]= 0.08;//0.2;//0.017997;
    half_gaussian_weight[7]= 0.05;//0.2;//0.008741;
    half_gaussian_weight[8]= 0.02;//0.2;//0.003799;
    
    vec4 sum            = vec4(0.0);
    vec4 result         = vec4(0.0);
    vec2 unit_uv        = vec2(blurSize/screenSize.x,blurSize/screenSize.y)*1.25;
    vec4 centerPixel    = texture2D(inputImageTexture, textureCoordinate)*half_gaussian_weight[0];
    float  sum_weight   = half_gaussian_weight[0];
    
    //vertical
    for(int i=1;i<=4;i++)
    {
        vec2 curBottomCoordinate    = textureCoordinate+vec2(0.0,float(i))*unit_uv;
        vec2 curTopCoordinate       = textureCoordinate+vec2(0.0,float(-i))*unit_uv;
        sum+=texture2D(inputImageTexture,curBottomCoordinate)*half_gaussian_weight[i];
        sum+=texture2D(inputImageTexture,curTopCoordinate)*half_gaussian_weight[i];
        sum_weight+=half_gaussian_weight[i]*2.0;
    }
    
    result = (sum+centerPixel)/sum_weight;
    vec4 baseColor = texture2D(u_albedo, textureCoordinate); 

    vec4 screenColor = lightIns*baseColor;
    vec4 resultCol = mix(baseColor,screenColor, result.r * intensity);

    gl_FragColor = resultCol;

}
