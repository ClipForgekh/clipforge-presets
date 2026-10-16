precision lowp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTexture;
uniform vec2 pos1;
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
vec2 changUV2(vec2 uv,vec2 moveSize,vec2 screenSize,vec2 size,float angle)
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
    return newUV;
}
vec4 Dtpt(vec2 tiledUV,vec4 color)
{
    if (tiledUV.x > 1.48 || tiledUV.x < -0.48 ||tiledUV.y > 1.48 || tiledUV.y < -0.48) {
        
        return vec4(0.0, 0.0, 0.0, 0.0);
    } else {
       return color;
    }
    // return color;
}

void main()
{
    vec2 uv1 = changUV(uv0,pos1,vec2(1080,1080),vec2(1.,1.),0.);
    vec2 uv2 = changUV2(uv0,pos1,vec2(1080,1080),vec2(1.,1.),0.);
    vec4 inputColor = texture2D(u_InputTexture,uv1);
    inputColor = Dtpt(uv2,inputColor);
    gl_FragColor = inputColor;
}
