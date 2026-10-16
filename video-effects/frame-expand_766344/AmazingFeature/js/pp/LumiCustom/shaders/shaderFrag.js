exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform vec2 windowSize; // = vec2(0.62, 0.52) // 放映窗口初始可视区域尺寸
uniform vec4 frameColor; // = vec4(0.0, 0.0, 0.0, 1.0) // 窗框颜色（RGBA）
uniform float edgeSoftness; // = 0.002 [0.0, 0.02] // 窗框边缘柔和度
uniform float grainStrength; // = 0.025 [0.0, 0.08] // 轻微胶片颗粒强度

varying vec2 vUv; // 纹理坐标

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float rectMask(vec2 uv, vec2 center, vec2 halfSize, float blurEdge) {
    vec2 d = abs(uv - center) - halfSize;
    float dist = max(d.x, d.y);
    return 1.0 - smoothstep(0.0, max(blurEdge, 0.000001), dist);
}

float sineOut(float x) {
    return sin(x * 1.57079632679);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec4 effect(vec4 texel, float p) {
    const float tEstablishEnd = 0.18 / 1.72;
    const float tBuildEnd = 0.32 / 1.72;
    const float tHoldEnd = 0.86 / 1.72;
    const float tTransEnd = 1.40 / 1.72;
    const float tResolveEnd = 1.0;

    vec2 uv = handleUVBounds(vUv);
    vec2 center = vec2(0.5, 0.5);
    vec2 baseHalf = clamp(windowSize * 0.5, vec2(0.05), vec2(0.5));

    float openT = 0.0;
    if (p >= tHoldEnd && p < tTransEnd) {
        float local = (p - tHoldEnd) / (tTransEnd - tHoldEnd);
        openT = sineOut(clamp(local, 0.0, 1.0));
    } else if (p >= tTransEnd) {
        openT = 1.0;
    }

    vec2 currentHalf = mix(baseHalf, vec2(0.5), openT);
    float openingMask = rectMask(uv, center, currentHalf, edgeSoftness);
    float frameMask = 1.0 - openingMask;

    vec2 shutterCenter = vec2(0.5, mix(0.5, 1.5, openT));
    float shutterMask = rectMask(uv, shutterCenter, currentHalf, edgeSoftness);

    float occlusion = 0.0;
    if (p < tHoldEnd) {
        occlusion = 1.0;
    } else if (p < tTransEnd) {
        occlusion = max(frameMask, shutterMask);
    } else {
        occlusion = 0.0;
    }

    float grainStart = tHoldEnd;
    float grainEnd = 1.20 / 1.72;
    float grainOn = smoothstep(grainStart, grainStart + 0.03, p);
    float grainOff = 1.0 - smoothstep(grainEnd - 0.03, grainEnd, p);
    float grainFade = grainOn * grainOff;

    float n = hash12(uv * vec2(153.7, 271.9) + vec2(p * 47.3, p * 91.1)) - 0.5;
    vec3 grainTex = clamp(texel.rgb + n * grainStrength * grainFade, 0.0, 1.0);

    vec3 rgb = mix(grainTex, frameColor.rgb, occlusion);
    float a = mix(texel.a, frameColor.a, occlusion);

    if (p <= tEstablishEnd) {
        rgb = frameColor.rgb;
        a = frameColor.a;
    } else if (p > tEstablishEnd && p < tBuildEnd) {
        rgb = frameColor.rgb;
        a = frameColor.a;
    } else if (p >= tTransEnd && p <= tResolveEnd) {
        rgb = grainTex;
        a = texel.a;
    }

    return vec4(rgb, a);
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