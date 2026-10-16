exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float blurMedium; // = 0.012 [0.0, 0.05] // 中等方向模糊强度
uniform float blurLow; // = 0.003 [0.0, 0.02] // 低方向模糊强度
uniform vec4 glowColor; // = vec4(0.45, 0.9, 1.0, 1.0) // 领先边缘辉光颜色
uniform float glowStrength; // = 0.4 [0.0, 1.5] // 辉光强度
uniform vec4 borderColor; // = vec4(0.2, 0.85, 1.0, 1.0) // Neon边框颜色
uniform float borderWidth; // = 0.03 [0.005, 0.08] // 边框宽度（3%）
uniform float borderGlow; // = 0.16 [0.0, 1.0] // 边框发光强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 5.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 directionalBlur(vec2 uv, float amount) {
    vec2 dir = vec2(-1.0, 0.0);
    vec2 stepUV = vec2(amount, amount / max(ratio, 0.0001)) * dir;
    vec4 sum = vec4(0.0);
    float total = 0.0;

    float w0 = 0.22; sum += texture2D(tDiffuse, handleUVBounds(uv + stepUV * -3.0)) * w0; total += w0;
    float w1 = 0.16; sum += texture2D(tDiffuse, handleUVBounds(uv + stepUV * -2.0)) * w1; total += w1;
    float w2 = 0.12; sum += texture2D(tDiffuse, handleUVBounds(uv + stepUV * -1.0)) * w2; total += w2;
    float w3 = 0.20; sum += texture2D(tDiffuse, handleUVBounds(uv)) * w3; total += w3;
    float w4 = 0.12; sum += texture2D(tDiffuse, handleUVBounds(uv + stepUV * 1.0)) * w4; total += w4;
    float w5 = 0.10; sum += texture2D(tDiffuse, handleUVBounds(uv + stepUV * 2.0)) * w5; total += w5;
    float w6 = 0.08; sum += texture2D(tDiffuse, handleUVBounds(uv + stepUV * 3.0)) * w6; total += w6;

    return sum / total;
}

vec4 effect(vec4 texel, float p) {
    const float tStart = 0.0869565;  // 0.2 / 2.3
    const float tEnterEnd = 0.6086957; // 1.4 / 2.3
    const float tOverEnd = 0.7826087;  // 1.8 / 2.3

    float xOffset = -1.2;
    float blurAmt = 0.0;
    float glowAmt = 0.0;

    if (p < tStart) {
        xOffset = -1.2;
        blurAmt = 0.0;
        glowAmt = 0.0;
    } else if (p < tEnterEnd) {
        float k = (p - tStart) / (tEnterEnd - tStart);
        xOffset = mix(-1.2, 0.0, k);
        blurAmt = mix(0.0, blurMedium, k);
        glowAmt = mix(0.0, 1.0, k);
    } else if (p < tOverEnd) {
        float k = (p - tEnterEnd) / (tOverEnd - tEnterEnd);
        xOffset = mix(0.0, 0.06, smoothstep(0.0, 1.0, k));
        blurAmt = mix(blurMedium, blurMedium * 0.75, k);
        glowAmt = mix(1.0, 0.55, k);
    } else {
        float k = (p - tOverEnd) / (1.0 - tOverEnd);
        xOffset = mix(0.06, 0.0, smoothstep(0.0, 1.0, k));
        blurAmt = mix(blurMedium * 0.75, blurLow, k);
        glowAmt = mix(0.55, 0.1, k);
    }

    vec2 sourceUV = vUv - vec2(xOffset, 0.0);
    vec2 sampleUV = handleUVBounds(sourceUV);
    float contentMask = getHardBoundaryMask(sourceUV);

    vec4 baseCol = texture2D(tDiffuse, sampleUV);
    vec4 blurCol = directionalBlur(sampleUV, blurAmt);
    float blurMix = clamp(blurAmt / max(blurMedium, 0.0001), 0.0, 1.0);
    vec4 movingCol = mix(baseCol, blurCol, blurMix) * contentMask;

    float leadX = 1.0 + xOffset;
    float streak = exp(-pow((vUv.x - leadX) / 0.012, 2.0));
    float streakY = smoothstep(0.02, 0.25, vUv.y) * (1.0 - smoothstep(0.75, 0.98, vUv.y));
    float streakVisible = step(0.0, leadX) * step(leadX, 1.1);
    vec3 glowAdd = glowColor.rgb * glowStrength * glowAmt * streak * streakY * streakVisible * contentMask;

    float d = min(min(vUv.x, 1.0 - vUv.x), min(vUv.y, 1.0 - vUv.y));
    float edge = 1.0 - smoothstep(borderWidth, borderWidth + 0.01, d);
    float neonPulse = 0.85 + 0.15 * (1.0 - p);
    float borderAnim = (1.0 - p);
    vec3 borderAdd = borderColor.rgb * borderGlow * edge * neonPulse * borderAnim;

    vec3 finalRgb = movingCol.rgb + glowAdd + borderAdd;
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    if (p >= 0.9999) {
        return texel;
    }

    return vec4(finalRgb, movingCol.a);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);

    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;

    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);

    vec4 finalColor = effectColor;

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;