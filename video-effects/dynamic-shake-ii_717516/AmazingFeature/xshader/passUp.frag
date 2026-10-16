precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform float baseTexHeight;
uniform float baseTexWidth;
uniform float rotateAlpha;
uniform float stepValue;
uniform float sampleCount;
uniform float factor;
uniform float flip;

#define SQRT2 1.414214
#define PI 3.1415926

vec2 rotate(vec2 point, float angle, vec2 center)
{
    float anglePI = angle * PI / 180.0;
    mat2 rot = mat2( cos(anglePI), sin(anglePI), 
                    -sin(anglePI), cos(anglePI) );
    point -= center;
    point.y *= float(baseTexHeight) / float(baseTexWidth);
    point = rot * point;
    point.y /= float(baseTexHeight) / float(baseTexWidth);
    point += center;
    return point ;
}

vec4 rotateBlur(vec2 uv, float sampleCount, float range, vec2 center)
{
    int count = int(floor(sampleCount));
    vec4 result = vec4(0.0);
    vec2 OffsetL = vec2(0.0);
    vec2 OffsetR = vec2(0.0);
    float sum_weights = 0.0;
    
    vec4 src = texture2D(inputTex, uv);
    result = texture2D(inputTex, uv);
    sum_weights += 1.0;

    float l = length(uv - center);
    OffsetL =  rotate(uv, range / float(count), center);
    OffsetR =  rotate(uv, -range / float(count), center);
    float _rotateAlpha = 1.0;
    for (int i = 1; i < 25; ++i)
    {
        if (i > count)
        {
            break;
        }
        
        result +=  texture2D(inputTex, OffsetL) * _rotateAlpha;
        result +=  texture2D(inputTex, OffsetR) * _rotateAlpha;
        OffsetL =  rotate(OffsetL, range / float(count) , center);
        OffsetR =  rotate(OffsetR, -range / float(count) , center);
        sum_weights += 2.0 * _rotateAlpha;
        _rotateAlpha *= rotateAlpha ;
    }

    result /= sum_weights;
    float baseRatio = float(baseTexWidth) / float(baseTexHeight);
    uv -= 0.5;
    uv.y /= baseRatio;
    uv += 0.5;
    float radius = length(uv - center);
    result = mix(src, result, 0.95);
    float k = smoothstep(stepValue/10.0 - 0.2, stepValue/10.0 + 0.1 , radius/SQRT2);
    result = mix(src, result, k);
    // result.a = 1.0;
    return result;
}

void main()
{
    vec2 uv1 = uv0;
    uv1.x = (uv1.x - .5) / 3. + .5;
    uv1.x = uv1.x * mix(1., -1., step(.5, flip));

    vec2 center = vec2(.5);
    float l = length(center - uv0);
    vec4 colSrc = rotateBlur(fract(uv1), sampleCount, factor * 10., center);
    vec4 baseColor = texture2D(inputTex, fract(uv1));
    colSrc = mix(baseColor, colSrc, 1.0);
    gl_FragColor = colSrc;
    // gl_FragColor.a = baseColor.a;
    // gl_FragColor = vec4(1.);
}
