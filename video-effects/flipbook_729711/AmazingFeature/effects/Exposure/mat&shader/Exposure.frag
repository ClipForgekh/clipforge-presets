precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform float u_Intensity;
uniform float u_Alpha;
uniform float u_Offset;
uniform float u_GrayscaleCorrect;
uniform float use_linear_light;
uniform vec4 u_ScreenParams;
uniform float noiseInsY;
uniform float noiseInsX;
uniform float ABC;
uniform float AX;
uniform float SX;
uniform sampler2D noiseTexture;


void Exposure(inout vec4 col, float _intensity, float _offset, float _gray_scale_correct, float _linear){
    if(_linear<0.5) col.rgb = pow(col.rgb, vec3(2.2));
    col.rgb *= pow(2.0, _intensity);
    col.rgb += u_Offset;
    vec3 s = sign(col.rgb);
    col.rgb = pow(abs(col.rgb), vec3(1.0 / _gray_scale_correct)) * s;
    s = sign(col.rgb);
    if (_linear<0.5) col.rgb = pow(abs(col.rgb), vec3(0.454545454545)) * s;
}
vec4 deleteGrad(sampler2D texture, vec2 uv){
    vec2 texCoord1 = uv;

    vec4 result = vec4(0.0);
    if(clamp(texCoord1, 0.0, 1.0) == texCoord1){
        result += texture2D(texture, texCoord1);
    }
    return result;
}
vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}
void main()
{
    vec2 uv = uv0;
    vec2 uv1 = uv0;
    uv1-=0.5;
    uv1=uv1/SX;
    uv1+=0.5;

    uv1+=vec2(AX,0.0);
    uv1=flip_uv(uv1);

    vec4 noiseColor = texture2D(noiseTexture, uv1);
    // vec2 imgUV = uv + vec2(0.0, noiseColor.g - 0.5) * noiseInsY / u_ScreenParams.y;
    vec2 imgUV = uv + vec2(0.0, noiseColor.g - 0.5) * noiseInsY*ABC/u_ScreenParams.y;
    vec4 res = texture2D(u_InputTex, imgUV); 
    Exposure(res, u_Intensity, u_Offset, u_GrayscaleCorrect, use_linear_light);
    gl_FragColor = res;
    gl_FragColor.rgb = clamp(gl_FragColor.rgb, 0.0, gl_FragColor.a);
}
