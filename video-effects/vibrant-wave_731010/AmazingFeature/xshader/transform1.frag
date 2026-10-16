precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputImage;
uniform sampler2D transformTex;
uniform vec2 moveSize1;
uniform vec2 screenSize;
uniform vec2 size1;
uniform float angle1;
uniform float angle2;
uniform float opacity1;

uniform vec2 size2;
uniform vec2 moveSize2;

uniform float u_Intensity;
uniform float u_Alpha;
uniform float u_Offset;
uniform float u_GrayscaleCorrect;
uniform float use_linear_light;

vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}
mat2 rotMat(float angle)
{
    float sinA = sin(angle);
    float cosA = cos(angle);
    return mat2(cosA,-sinA,sinA,cosA);
}
mat2 scale(float scale_X,float scale_Y)
{
    return mat2(1.0/(scale_X + 0.000001),0.,0.,1.0/(scale_Y + 0.000001));
}
vec2 changUV(vec2 uv,vec2 moveSize,vec2 screenSize,vec2 size,float angle)
{
    vec2 newUV = uv;
    newUV.x-=(moveSize.x/screenSize.x-0.5);
    newUV.y+=(moveSize.y/screenSize.y-0.5);
    newUV-=0.5;
    newUV.x*=screenSize.x/screenSize.y;
    float angle_1 = radians(angle);
    newUV*=rotMat(angle_1);
    newUV.x/=screenSize.x/screenSize.y;
    // newUV*= scale(size.x,size.y);
    newUV+=0.5;
    return flip_uv(newUV);
}
void Exposure(inout vec4 col, float _intensity, float _offset, float _gray_scale_correct, float _linear){
    if(_linear<0.5) col.rgb = pow(col.rgb, vec3(2.2));
    col.rgb *= pow(2.0, _intensity);
    col.rgb += _offset;
    vec3 s = sign(col.rgb);
    col.rgb = pow(abs(col.rgb), vec3(1.0 / _gray_scale_correct)) * s;
    s = sign(col.rgb);
    if (_linear<0.5) col.rgb = pow(abs(col.rgb), vec3(0.454545454545)) * s;
}
void main()
{
    vec2 uv1 = uv0;
    uv1 = changUV(uv0,moveSize1,vec2(1080,1080),vec2(1.,1. ),angle1);
    vec4 inputColor = texture2D(inputImage,uv1);
    Exposure(inputColor, u_Intensity, 0., 1., 0.);
    gl_FragColor = inputColor;
}
