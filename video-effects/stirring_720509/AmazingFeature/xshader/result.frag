precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTex;
uniform sampler2D u_maskTex;
uniform float u_Alpha;
uniform vec2 u_inputOffset;
uniform vec2 u_inputScale;
uniform float u_inputWarpIntensity;
uniform float u_rotationAxis1;
uniform float u_rotationAxis2;
uniform float u_inputRotation1;
uniform float u_inputRotation2;
#define PI 3.1415926
const float pi = 3.1415926;

uniform float u_maskTextureScale;
uniform vec4 u_ScreenParams;
uniform vec2 u_maskTextureSize;
uniform vec2 u_maskOffsetRange;

vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}
mat2 rotate(float angle){
    return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}
float sdRoundedBox( in vec2 p, in vec2 b, in vec4 r )
{
    r.xy = (p.x>0.0)?r.xy : r.zw;
    r.x  = (p.y>0.0)?r.x  : r.y;
    vec2 q = abs(p)-b+r.x;
    return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - r.x;
}

vec2 xiruUV(vec2 nowUV,float intensity)
{
    vec2 dir = (nowUV - 0.5);
    float l = sdRoundedBox(dir * 2.0, vec2(0.5), vec4(0.5)) + 0.5;
    float l1 = max(abs(dir.x), abs(dir.y)) * 2.0;
    float x = smoothstep(0.0, 1.0, l1);
    l = l1 * x + l * (1. - x);
    return dir * pow(1.0 / l, intensity) + 0.5;
}

vec2 quadDeformation(vec2 nowUV, float rotationAxis, float rotation)
{
    vec2 uv = nowUV-.5;
    float k1Cos = cos(rotationAxis+pi/2.);
    float k2Cos = cos(rotationAxis);
    if(abs(k1Cos)<0.001){
        float nowSign = sign(k1Cos);
        if(abs(nowSign)<0.001)
            k1Cos = 0.001;
        else
            k1Cos = nowSign * 0.001;
    }
    if(abs(k2Cos)<0.001){
        float nowSign = sign(k2Cos);
        if(abs(nowSign)<0.001)
            k2Cos = 0.001;
        else
            k2Cos = nowSign * 0.001;
    }
    float k1 = sin(rotationAxis+pi/2.)/k1Cos;
    float k2 = sin(rotationAxis)/k2Cos;
    float b2 = uv.y - k2 * uv.x;
    vec2 intersection = vec2(0.);
    intersection.x = b2/max(abs(k1-k2),0.001)*sign(k1-k2);
    intersection.y = intersection.x*k1;
    vec2 nowPoint2Intersection = uv-intersection;
    vec2 newCoordinateSystemNewpoint = rotate(rotation) * nowPoint2Intersection + intersection + 0.5;
    return newCoordinateSystemNewpoint;
}
void main()
{
    vec2 uv = (uv0-0.5)/u_inputScale+0.5;
    uv = quadDeformation(uv,u_rotationAxis1,u_inputRotation1);
    uv = quadDeformation(uv,u_rotationAxis2,u_inputRotation2);
    uv = xiruUV(uv,u_inputWarpIntensity);
    uv = flip_uv(uv);
    vec4 resultColor = texture2D(u_inputTex, uv);
    gl_FragColor = vec4(resultColor);
    // gl_FragColor = vec4(maskOffset,0,1);
}