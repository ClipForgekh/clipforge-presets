exports.shearSkewFrag=`
precision highp float;

uniform sampler2D u_inputTexture;
uniform vec4 u_ScreenParams;
uniform float u_skew;
uniform float u_blurAmount;
uniform float u_blurOffset;
uniform float u_blurFalloff;
uniform float u_blurType;

varying vec2 v_uv;

#define PI 3.1415926
#define MAX_SAMPLE 72
const float EPS = 1e-3;

float uvProtect(vec2 uvTemp) {
    // 【核心修复】防止斜切变形后将边缘脏像素带入画面并无限拉伸
    vec2 s = step(vec2(0.001), uvTemp) * step(uvTemp, vec2(0.999));
    return s.x * s.y;
}

vec2 shearSkew(vec2 uv, float skew) {
    float a = sin(skew);
    mat2 shearMatrix = mat2(1.0, a, 0.0, 1.0);
    return (uv - 0.5) * shearMatrix + 0.5;
}

vec2 directionSkew(vec2 uv, float skew, float scale) {
    vec2 skewUV = uv;
    skewUV -= 0.5;
    mat2 shearMatrix = mat2(1.0, sin(skew), 0.0, 1.0);
    skewUV = skewUV * shearMatrix; 
    skewUV.y /= scale;
    skewUV += 0.5;
    return skewUV;
}

float normDis(float x) {
    return (2.50659 / sqrt(2.0 * PI)) * exp((-0.5 * x * x)) / 0.99998;
}

vec2 rotate2(vec2 uv, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    mat2 rotationMatrix = mat2(c, -s, s, c);
    return (uv - 0.5) * rotationMatrix + 0.5;
}

float linearWipe(vec2 uv, float progress, float rotation, float feather) {
    vec2 p = rotate2(uv, radians(rotation));
    return mix(0.0, 1.0, smoothstep(progress - feather, progress + feather, p.y));
}

vec4 directionSkewBlur(sampler2D tex, vec2 uv, float skew, float blurAmount, float blurOffset, float blurFalloff) {
    vec4 result = vec4(0.0);
    float minAngle = radians(skew / 10.0);
    minAngle = mix(radians(skew), 0.0, blurAmount);
    float biasAngle = mix(0.0, 180.0, abs(skew / 90.0) * blurAmount);
    float maxAngle = radians((sign(skew) * biasAngle + skew) / 2.0);
    maxAngle = mix(radians(skew), maxAngle, blurAmount);

    float minScale = mix(0.5, 1.0, (1.0 - blurOffset) * (1.0 - blurAmount));
    float maxScale = mix(1.0, 1.5, blurOffset * blurAmount);
    
    float weight = normDis(0.0);
    float sumWeight = weight;
    
    vec4 oriColor = texture2D(tex, shearSkew(uv, radians(skew))) * uvProtect(shearSkew(uv, radians(skew)));
    float progress = blurFalloff;
    oriColor *= 1.0 - linearWipe(uv, progress, 180.0, 0.1);

    for (int i = 1; i <= MAX_SAMPLE; i++) {
        if (blurAmount == 0.0) break;
        
        float fi = float(i);
        float a = fi / float(MAX_SAMPLE);
        float angle = mix(minAngle, maxAngle, a);
        float scale = mix(minScale, maxScale, a);
        vec2 skewUV = directionSkew(uv, angle, scale);
        
        float w = normDis(1.5 * (fi / float(MAX_SAMPLE) * 2.0 - 1.0));
        vec4 blurColor = texture2D(tex, skewUV) * uvProtect(skewUV);
        blurColor *= linearWipe(uv, progress, 180.0, 0.1);
        
        result += w * (blurColor + oriColor);
        sumWeight += w;
    }

    result /= sumWeight;

    if (blurAmount == 0.0) {
        vec2 skewUV = shearSkew(uv, skew * PI / 180.0);
        result = texture2D(tex, skewUV) * uvProtect(skewUV);
    }

    return clamp(result, 0.0, 1.0);
}

vec4 skewBlur(sampler2D tex, vec2 uv, float skew, float blurAmount, float blurOffset, float blurFalloff) {
    vec4 result = vec4(0.0);

    float biasAngle = mix(15.0, 90.0, blurOffset) * blurAmount;
    float biasScale = mix(1.0, 1.2, blurAmount);
    float weight = normDis(0.0);
    float sumWeight = weight;

    vec2 oriUV = uv - vec2(0.5, 0.0);
    oriUV.y /= biasScale;
    oriUV += vec2(0.5, 0.0);
    vec4 oriColor = texture2D(tex, shearSkew(oriUV, radians(skew))) * uvProtect(shearSkew(oriUV, radians(skew)));
    oriColor *= 1.0 - linearWipe(uv, blurFalloff, 0.0, 0.01);
    
    for (int i = 1; i <= MAX_SAMPLE; i++) {
        if (i >= MAX_SAMPLE) break;

        float fi = float(i);
        float a = fi / float(MAX_SAMPLE);
        
        float angle = mix(-biasAngle, biasAngle, a);
        vec2 skewUV = shearSkew(uv, (skew + angle) * PI / 180.0);
        
        float scale = mix(0.0, biasScale, normDis(4.0 * (a * 2.0 - 1.0))) + 1.0;
        skewUV = (skewUV - vec2(0.5, 0.0)) / scale + vec2(0.5, 0.0);

        vec4 blurColor = texture2D(tex, skewUV) * uvProtect(skewUV);
        blurColor *= linearWipe(uv, blurFalloff, 0.0, 0.01);
        result += weight * (blurColor + oriColor);
        sumWeight += weight;
    }

    result /= sumWeight;

    if (blurAmount == 0.0) {
        vec2 skewUV = shearSkew(uv, radians(skew));
        result = texture2D(tex, skewUV) * uvProtect(skewUV);
    }
    return clamp(result, 0.0, 1.0);
}

void main() {
    float fixScale = max(u_ScreenParams.x / u_ScreenParams.y, u_ScreenParams.y / u_ScreenParams.x) * 2.0;
    vec2 mirrorLine = vec2(2.0, 1.0);
    vec2 uv = abs(mod(vec2(v_uv.x, v_uv.y) - vec2(1.0, 0.5), mirrorLine) - vec2(1.0, 0.5));
    vec4 color = texture2D(u_inputTexture, uv);

    if (u_blurType < 0.5) { 
        color = directionSkewBlur(u_inputTexture, uv, u_skew, u_blurAmount, u_blurOffset, u_blurFalloff);
    } else {
        color = skewBlur(u_inputTexture, uv, u_skew, u_blurAmount, u_blurOffset, u_blurFalloff);
    }

    gl_FragColor = color;
}
`;exports.source=exports.shearSkewFrag;