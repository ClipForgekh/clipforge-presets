precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTexture;
uniform float xOffset;
uniform float yOffset;
uniform float ymask;
uniform float scaleIns;
uniform vec4 u_ScreenParams;
uniform float noiseIns;
uniform sampler2D noiseTex;
uniform sampler2D lightine;
uniform sampler2D _seqline;
uniform sampler2D basetex;
uniform sampler2D extracttex;
uniform sampler2D noiseTexture;
uniform float op;
uniform float op1;
uniform float noiseInsX;
uniform float noiseInsY;

vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv+1.,2.)-1.);
}

mat2 scale(float scaleIns){
    return mat2(1.0/(scaleIns + 0.000001),0.,0.,1.0/(scaleIns + 0.000001));
}



const vec3 C0 = vec3(0.0);
const vec3 C1 = vec3(1.0);
const vec3 C_2 = vec3(0.5);


vec3 unpremultiply (vec3 color, float alpha) {
    float eq0 = step(0.0, -alpha);
    return color / (alpha + eq0) * (1.0 - eq0);
}

vec3 blend_1013 (vec3 dst, vec3 src) {
    return min(dst + src, C1);
}

vec3 blend_1021 (vec3 dst, vec3 src) {
    return C1 - (C1 - dst) * (C1 - src);
}

vec4 applyBlend0 (vec4 dst0, vec4 src0, float opacity) {
    src0 *= opacity;
    return src0 + dst0 * (1.0 - src0.a);
}

vec4 applyBlend1013 (vec4 dst0, vec4 src0, float opacity) {
    src0 *= opacity;
    vec3 dst = unpremultiply(dst0.rgb, dst0.a);
    vec3 src = unpremultiply(src0.rgb, src0.a);
    src = blend_1013(dst, src);
    dst = mix(dst, src, src0.a);
    return vec4(dst, 1.0) * dst0.a;
}

vec4 applyBlend1021 (vec4 dst0, vec4 src0, float opacity) {
    src0 *= opacity;
    vec3 dst = unpremultiply(dst0.rgb, dst0.a);
    vec3 src = unpremultiply(src0.rgb, src0.a);
    src = blend_1021(dst, src);
    dst = mix(dst, src, src0.a);
    return vec4(dst, 1.0) * dst0.a;
}

vec2 scaleuv (vec2 uv)
{
    vec2 newuv = uv;
    newuv -= 0.5;
    newuv = newuv*vec2(0.75 , 0.75);

    newuv += 0.5;
    return newuv;
}

void main()
{



    vec2 uv = uv0;

    vec4 noiseColor = texture2D(noiseTexture, uv);
    float noiseInsX = 80.0;
    float noiseInsY = 0.0;
    vec2 imgUV = uv + vec2(noiseColor.r - 0.5, 0.0) * noiseInsX / u_ScreenParams.x + vec2(0.0, noiseColor.g - 0.5) * noiseInsY / u_ScreenParams.y;
    //vec4 imgColor = texture2D(inputImageTexture, imgUV);




    float d = 100.0;
    //float ymask1 = 0.5;
    float smoothIns = d/u_ScreenParams.y/2.;
    float smoothmask =  smoothstep(ymask -smoothIns, ymask +smoothIns,1.0-uv0.y);
    
    vec2 translate=vec2(xOffset,yOffset);
    vec2 uv1=uv0;
    uv1=uv1-translate;
    uv1 -= 0.5;
    uv1=uv1/vec2(scaleIns, 1.0);
    uv1 += 0.5;

    vec2 newuv1 = scaleuv( uv0 );
    vec4 base = texture2D(basetex , newuv1);

    vec4 seq = texture2D(_seqline,1.0-uv0);
    vec4 black = vec4(0.0,0.0,0.0,1.0);
    

    base *= op;
    black *= op1;
    vec4 mixtex = base  + black;
    //vec4 mixtex = base ;
    
    vec4 noiseCol = texture2D(noiseTex,uv1);
    uv1 = uv1 + vec2(0.0, noiseCol.r - 0.5) * - noiseIns / u_ScreenParams.y;
   
    vec2 newuv2 = scaleuv( imgUV );
    vec4 col1 = texture2D(inputTexture,newuv2);

    //float maskpass = smoothmask ;

    vec4 mixpass = mix(  col1 ,mixtex , 1.0 - smoothmask );

    vec4 seqpass = vec4(seq.r, seq.g, seq.b, seq.a);

    //vec4 fincol = clamp(seqpass + mixpass,0.0,1.0);
    float seqa = clamp(seq.g *0.33 + seq.b*0.33 +seq.r*0.33, 0.0, 1.0);

    vec4 fincol = applyBlend1013(mixpass, seq,seqa);
    //vec4 fincol = mix(mixpass, seq,seq.b);
    // vec4 fincol = vec4(1.0);
    // fincol.rgb = blend_1021(mixpass.rgb, seq.rgb);

    //vec4 fincol = mixpass + seq*0.5;
    gl_FragColor=fincol;
}
