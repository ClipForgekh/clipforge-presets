precision highp float;
varying highp vec2 uv0;

uniform sampler2D inputImageTexture;
uniform sampler2D scaleTexture;
uniform sampler2D maskTexture;
uniform sampler2D infoTexture;
uniform float rotate;
uniform float featherStart;
uniform float featherEnd;
uniform float blurSize;
uniform float outputType;
uniform float reverseSort;
uniform float cycle;
uniform vec2 size_;
uniform float rotation;
uniform vec2 scale_int;
uniform vec2 pos_int;
#define SIZE 256.0


#define PI 3.1415926
vec2 rotateFun(vec2 uv, float theta)
{
    float sint = sin(theta);
    float cost = cos(theta);
    mat2 rot = mat2(
        cost, sint,
        -sint, cost
    );
    uv -= 0.5;
    uv = rot * uv;
    uv += 0.5;
    return uv;
}
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
    newUV.y-=(moveSize.y/screenSize.y-0.5);
    // newUV=(newUV-0.5)/size+0.5;
    newUV-=0.5;
    newUV*= scale(size.x,size.y);
    newUV.x*=screenSize.x/screenSize.y;
    float angle_1 = radians(angle);
    newUV*=rotMat(angle_1);
    newUV.x/=screenSize.x/screenSize.y;
    
    newUV+=0.5;
    return newUV;
}
void main() {
    float newrotate = -atan(size_.x/size_.y);
    float nomalrotate = -atan(3.0 / 3.0);
    float theta = (rotate * PI / 180.0) + (newrotate - nomalrotate)  ;
    vec2 new_uv = rotateFun(uv0, -theta);
    vec2 uv_0 = uv0;
    float scale = max(abs(cos(theta)) + abs(sin(theta)), abs(sin(theta)) + abs(cos(theta)));
    // if (fract(rotate / 90.0) != 0.0)
    // {
    //     scale *= 1.01;
    //     uv_0 -= 0.5;
    //     uv_0 /= (1.01);
    //     uv_0 += 0.5;
    // }
    new_uv -= 0.5;
    new_uv /= scale;

    new_uv += 0.5;
    // new_uv = changUV(new_uv,pos_int,vec2(1080.,1080.),scale_int,rotation);
    vec4 info0 = texture2D(infoTexture, new_uv);
    float leftP = info0.x / (info0.x + info0.y);
    float rightP = info0.y / (info0.x + info0.y);

    float mask = texture2D(maskTexture, new_uv).r;
    vec4 ori = texture2D(inputImageTexture, uv_0);
    vec4 res = texture2D(scaleTexture, new_uv);

    if (outputType > 0.5 && outputType <= 1.5)
    {
        gl_FragColor = vec4(mask, mask, mask, ori.a);
        return;
    }
    if (outputType > 1.5 && outputType <= 2.5)
    {
        float left = info0.x * (SIZE-1.0);
        float right = info0.y * (SIZE-1.0);
        float sortIdx = left;
        if (reverseSort > 0.5)
        {
            sortIdx = right;
        }
        sortIdx = mod(sortIdx+floor(left+right+1.0)*mod(cycle,1.0), floor(left+right+1.0));

        gl_FragColor = vec4(sortIdx/floor(left+right+1.0));
        gl_FragColor.a = ori.a;
        return;
    }

    if (blurSize > 1.0)
    {
        float wSum = 1.0;
        for (float i = 1.0; i < 50.0; i+=1.0)
        {
            if(i > blurSize) break;
            float w = texture2D(maskTexture, new_uv+i*vec2(1.0/SIZE, 0.0)).r;
            if(w < 0.5) break;
            res += texture2D(scaleTexture, new_uv+i*vec2(1.0/SIZE, 0.0)) * w;
            wSum += w;
        }
        for (float i = 1.0; i < 50.0; i+=1.0)
        {
            if(i > blurSize) break;
            float w = texture2D(maskTexture, new_uv-i*vec2(1.0/SIZE, 0.0)).r;
            if(w < 0.5) break;
            res += texture2D(scaleTexture, new_uv-i*vec2(1.0/SIZE, 0.0)) * w;
            wSum += w;
        }
        res /= wSum;
    }

    leftP = featherStart < 0.01? 1.0 : smoothstep(0.0, featherStart, leftP);
    rightP = featherEnd < 0.01? 1.0 : smoothstep(0.0, featherEnd, rightP);
    
    mask *= min(leftP, rightP);
    gl_FragColor = mix(ori, res, mask);
    // gl_FragColor = vec4(mask, mask, mask, 1.0);
}