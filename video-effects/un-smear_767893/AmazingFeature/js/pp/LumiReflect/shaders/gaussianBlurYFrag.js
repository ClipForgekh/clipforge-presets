exports.gaussianBlurYFrag=`
precision highp float;

uniform sampler2D u_inputTexture;
uniform sampler2D u_inputTexture2;
uniform vec4 u_ScreenParams;
uniform float u_reflectionAngle;
uniform float u_blurAmount;
uniform float u_blendStyle;
uniform float u_sampleY;
uniform float u_sigmaY;
uniform float u_stepY;
uniform float u_gamma;
uniform float u_lineOffsetY;
uniform float u_lineOffsetX;
uniform float u_maskFalloff;

varying vec2 v_uv;

#define PI 3.1415926
#define MAX_SAMPLE 72
const float EPS = 1e-3;

float uvProtect(vec2 uvTemp) {
    // 【核心修复】防止模糊时产生垂直/水平拉伸线条
    vec2 s = step(vec2(0.001), uvTemp) * step(uvTemp, vec2(0.999));
    return s.x * s.y;
}

vec4 blendNormal(vec4 srcColor, vec4 baseColor) {
    vec3 srcRGB = srcColor.rgb / max(srcColor.a, EPS);
    vec3 baseRGB = baseColor.rgb / max(baseColor.a, EPS);
    float outAlpha = srcColor.a + baseColor.a * (1.0 - srcColor.a);
    vec3 outRGB = baseRGB * baseColor.a * (1.0 - srcColor.a) + 
                  srcRGB * srcColor.a * (1.0 - baseColor.a) +
                  srcRGB * srcColor.a * baseColor.a;
    return vec4(outRGB, outAlpha);
}

float getGaussianWeight(float x, float sigma) {
    float v = x / sigma;
    return exp(-0.5 * v * v);
}

vec4 getColor(sampler2D tex, vec2 uv) {
    // 【核心修复】将 uvProtect 与采样绑定。只要越界，直接变透明，切断边缘拉伸！
    vec4 color = texture2D(tex, uv) * uvProtect(uv);
    return vec4(pow(max(color.rgb, vec3(0.0)), vec3(u_gamma)), color.a);
}

vec4 gaussianBlurY(sampler2D tex, vec2 oriUV, float uvymask) {
    if (u_blurAmount < EPS) {
        return texture2D(tex, oriUV);
    }

    vec4 sumColor = getColor(tex, oriUV);
    float sumWeight = getGaussianWeight(0.0, u_sigmaY * uvymask);
    float effectiveSamples = min(u_sampleY * uvymask, float(MAX_SAMPLE));
    float stepSize = u_stepY * uvymask;
    float sigma = u_sigmaY * uvymask;
    
    for (int k = 1; k <= MAX_SAMPLE; k++) {
        float fk = float(k);
        if (fk >= effectiveSamples) break;
        
        float y = fk * stepSize;
        float weight = (fk < 0.1 * float(MAX_SAMPLE)) ? 1.0 : getGaussianWeight(y, sigma);
        
        vec2 upperUV = oriUV - vec2(0.0, y);
        vec4 upperColor = (upperUV.y < 0.0) ? getColor(u_inputTexture2, vec2(upperUV.x, 0.0)) : getColor(tex, upperUV);
        
        vec2 lowerUV = oriUV + vec2(0.0, y);
        vec4 lowerColor = (lowerUV.y > 1.0) ? getColor(u_inputTexture2, vec2(lowerUV.x, 1.0)) : getColor(tex, lowerUV);

        sumColor += weight * (upperColor + lowerColor);
        sumWeight += 2.0 * weight;
    }

    vec4 result = sumColor / sumWeight;
    result.rgb = pow(max(result.rgb, vec3(0.0)), vec3(1.0 / u_gamma));
    return result;
}

vec2 rotate(vec2 uv, vec2 center, float angle) {
    vec2 centered = uv - center;
    float ratio = u_ScreenParams.x / u_ScreenParams.y;
    centered *= (ratio < 1.0) ? vec2(ratio, 1.0) : vec2(1.0, 1.0 / ratio);
    mat2 rotMat = mat2(cos(angle), sin(angle), -sin(angle), cos(angle));
    centered = rotMat * centered;
    centered /= (ratio < 1.0) ? vec2(ratio, 1.0) : vec2(1.0, 1.0 / ratio);
    return centered + center;
}

void main() {
    float fixScale = max(u_ScreenParams.x / u_ScreenParams.y, u_ScreenParams.y / u_ScreenParams.x) * 2.2;
    float invFixScale = 1.0 / max(fixScale, EPS);

    vec2 uv = vec2(v_uv.x, 1.0 - v_uv.y);
    uv = ((uv - 0.5) * invFixScale + 0.5) - vec2(u_lineOffsetX, u_lineOffsetY) * invFixScale;
    uv = rotate(uv, vec2(0.5), u_reflectionAngle);
    
    float mirror = 1.0 - step(0.5, uv.y);
    float blurMask = 1.0 - smoothstep(0.01, u_maskFalloff + 0.1, v_uv.y);
    vec4 blurColor = clamp(gaussianBlurY(u_inputTexture, v_uv, blurMask), 0.0, 1.0);
    vec4 oriColor = texture2D(u_inputTexture2, v_uv);
    
    vec4 finalColor;
    if (u_blendStyle < 0.5) { 
        finalColor = mix(blurColor, oriColor, mirror);
    } else if (u_blendStyle < 1.5) { 
        finalColor = blendNormal(oriColor, blurColor * (1.0 - mirror));
    } else { 
        finalColor = blurColor * clamp(1.0 - mirror, 0.0, 1.0);
    }

    gl_FragColor = finalColor;
}
`;exports.source=exports.gaussianBlurYFrag;