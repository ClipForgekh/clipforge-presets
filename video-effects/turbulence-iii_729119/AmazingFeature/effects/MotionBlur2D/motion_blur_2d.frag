precision highp float;
varying highp vec2 uv0;

uniform sampler2D inputImageTexture;
uniform vec4 u_ScreenParams;

uniform vec2 PrevScale;
uniform vec2 PrevOffset;
uniform float PrevRotate;
uniform vec2 CurrScale;
uniform vec2 CurrOffset;
uniform float CurrRotate;
uniform float vIntensity;
uniform float vCenter;
uniform float minSamples;
uniform float maxSamples;
uniform vec2 offsetPoints[17];
uniform float curveOffset;


uniform float inputWidth;
uniform float inputHeight;
uniform float scale_1;
uniform float scale_2;

uniform float u_Intensity;
uniform float u_Offset;
uniform float u_GrayscaleCorrect;
uniform float use_linear_light;

#define kSamplesPerFrame 256.0
#define PI 3.1415926
vec2 Affine(vec2 uv, float theta, vec2 offset, vec2 scale)
{
   // offset
    uv.x -= offset.x;
    uv.y += offset.y;
    // rotate
    uv -= 0.5;
    uv.y *= u_ScreenParams.y / u_ScreenParams.x;
    float sint = sin(theta);
    float cost = cos(theta);
    mat2 rot = mat2(
        cost, sint,
        -sint, cost
    );
    uv = rot * uv;
    uv.y *= u_ScreenParams.x / u_ScreenParams.y;
    // scale
    uv = uv * (1. / scale);
    
    uv += 0.5;
    return uv;
}


vec2 getOffsetPoints(int index)
{
    vec2 res = offsetPoints[16];
    for (int i = 0; i < 17; i++)
    {
        if (index == i)
        {
            res = offsetPoints[i];
            break;
        }
    }
    return res;
}

vec2 flip_uv(vec2 uv) 
{
 return abs(mod(uv + 1., 2.) - 1.0);
}

void Exposure(inout vec4 col, float _intensity, float _offset, float _gray_scale_correct, float _linear){
    if(_linear<0.5) col.rgb = pow(col.rgb, vec3(2.2));
    col.rgb *= pow(2.0, _intensity);
    col.rgb += u_Offset;
    vec3 s = sign(col.rgb);
    col.rgb = pow(abs(col.rgb), vec3(1.0 / _gray_scale_correct)) * s;
    s = sign(col.rgb);
    if (_linear<0.5) col.rgb = pow(abs(col.rgb), vec3(0.454545454545)) * s;
}

vec2 changUV(vec2 uv,vec2 moveSize,vec2 screenSize,float size_1,float size_2,float angle){
    vec2 newUV = uv;
    // newUV-=moveSize/screenSize;

    newUV.x=(newUV.x-0.5)/size_1+0.5;
    newUV.y=(newUV.y-0.5)/size_2+0.5;

    // newUV-=0.5;
    // newUV.x*=screenSize.x/screenSize.y;
    // newUV*=rotMat(angle);
    // newUV.x/=screenSize.x/screenSize.y;
    // newUV+=0.5;

    return flip_uv(newUV);
}


vec2 interOffset(float k)
{
    float idx = (k+2.0) * 4.0;
    vec2 res = vec2(0.0);
    if (idx < 0.0)
    {
        vec2 a = getOffsetPoints(0);
        vec2 b = getOffsetPoints(1);
        res = a - idx * (a-b);
    }
    else if(idx >= 16.0)
    {
        vec2 a = getOffsetPoints(16);
        vec2 b = getOffsetPoints(15);
        res = a + (idx-16.0) * (a-b);
    }
    else
    {
        float idx_1 = floor(idx);
        float idx_2 = fract(idx);
        vec2 a = getOffsetPoints(int(idx_1));
        vec2 b = getOffsetPoints(int(idx_1+1.0));
        res = mix(a, b, idx_2);
    }

    return res;
}


void main() {
    vec2 currUV = Affine(uv0, CurrRotate * PI / 180.0, CurrOffset, CurrScale);
    vec2 PrevUV = Affine(uv0, PrevRotate * PI / 180.0, PrevOffset, PrevScale);
    vec2 velocity = (PrevUV-currUV)*vIntensity;
    float distance = length(velocity);
    float mins = max(minSamples, 2.0);
    float maxs = max(maxSamples, mins);
    // float samples = floor(mins + (maxs - mins)*smoothstep(0.0, 0.2, distance));
    float samples = maxs;

    vec4 result = vec4(0.0);
    vec2 target = vec2(0.0);
    for (float i = 0.0; i < kSamplesPerFrame; i+=1.0) {
        if (i >= samples) break;
        float rotate = CurrRotate + (PrevRotate - CurrRotate) * (vIntensity * (i / (samples - 1.0)-1.0) - vCenter);
        vec2 offset;
        if (curveOffset < 0.5)
        {
            offset = CurrOffset + (PrevOffset - CurrOffset) * (vIntensity * (i / (samples - 1.0)-1.0) - vCenter);
        }
        else
        {
            offset = interOffset(vIntensity * (i / (samples - 1.0)-1.0) - vCenter);
        }
        vec2 scale = CurrScale + (PrevScale - CurrScale) * (vIntensity * (i / (samples - 1.0)-1.0) - vCenter);
        
        target = Affine(uv0, rotate * PI / 180.0, offset, scale);
        // vec2 newUV = changUV(target,vec2(inputWidth,inputHeight ),vec2(1080.,1080.),scale_1,scale_2,0.0); 

        result += texture2D(inputImageTexture, flip_uv(target));

    }
    result = result / (samples);
    // if (result.a > 0.0) result.rgb /= result.a;
    Exposure(result, u_Intensity, u_Offset, u_GrayscaleCorrect, use_linear_light);
    gl_FragColor = result;
}