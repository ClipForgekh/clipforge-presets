exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform int sproutCount; // = 12 [4, 16] // 总芽片数量
uniform float outerRotateMax; // = 48.0 [10.0, 90.0] // 外环芽片最大外翻角度(度)
uniform float innerRotateMax; // = 36.0 [10.0, 90.0] // 内环芽片最大内扣角度(度)
uniform float dispStrengthMax; // = 0.14 [0.0, 0.5] // 芽片边缘最大扰动强度
uniform float saturationBoost; // = 0.08 [0.0, 0.5] // 芽片饱和度提升值

varying vec2 vUv;

#define PI 3.14159265359

float cubicInOut(float t) {
    return t < 0.5 ? 4.0 * t * t * t : 1.0 - pow(-2.0 * t + 2.0, 3.0) / 2.0;
}

float quadraticOut(float t) {
    return 1.0 - (1.0 - t) * (1.0 - t);
}

float swingEasing(float t) {
    float swing = sin(t * PI * 2.0) * 0.15;
    return cubicInOut(t) + swing * (1.0 - t);
}

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 getAspectCorrectUV(vec2 uv) {
    vec2 aspectUV = uv;
    if (ratio > 1.0) {
        aspectUV.y /= ratio;
        aspectUV.y += (1.0 - 1.0 / ratio) * 0.5;
    } else {
        aspectUV.x *= ratio;
        aspectUV.x += (1.0 - ratio) * 0.5;
    }
    return aspectUV;
}

vec3 adjustSaturation(vec3 color, float saturation) {
    float gray = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(gray), color, saturation);
}

float tween(float progress) {
    return progress;
}

vec4 effect(vec4 texel, float progress) {
    // 时间节点映射（总时长3s）
    const float t1 = 0.1267; // 0.38s 开始展开
    const float t2 = 0.4;    // 1.2s  展开结束，开始滑行
    const float t3 = 0.7;    // 2.1s  滑行结束，开始回归
    const float t4 = 0.9267; // 2.78s 回归结束，定帧

    // 首尾直接返回原图
    if (progress < t1 || progress >= t4) return texel;

    // 计算各阶段进度
    float expandProgress = 0.0;
    float swingProgress = 0.0;
    float recoverProgress = 0.0;
    float dispProgress = 0.0;
    float satProgress = 0.0;
    float brightness = 1.0;

    if (progress >= t1 && progress < t2) {
        // 展开阶段
        float t = (progress - t1) / (t2 - t1);
        expandProgress = cubicInOut(t);
        dispProgress = quadraticOut(t);
        satProgress = quadraticOut(t);
        brightness = mix(1.0, 0.78, expandProgress);
    } else if (progress >= t2 && progress < t3) {
        // 滑行摇摆阶段
        float t = (progress - t2) / (t3 - t2);
        expandProgress = 1.0;
        swingProgress = swingEasing(t);
        dispProgress = t < 0.4 ? quadraticOut(t/0.4) : (t < 0.75 ? 1.0 : 1.0 - quadraticOut((t-0.75)/0.25));
        satProgress = 1.0;
        brightness = 0.78;
    } else if (progress >= t3 && progress < t4) {
        // 回归阶段
        float t = (progress - t3) / (t4 - t3);
        expandProgress = 1.0 - cubicInOut(t);
        dispProgress = 1.0 - quadraticOut(t);
        satProgress = 1.0 - quadraticOut(t);
        brightness = mix(0.78, 1.0, cubicInOut(t));
    }

    // 坐标转换
    vec2 uv = getAspectCorrectUV(vUv);
    vec2 p = uv - 0.5;
    float len = length(p);
    float angle = atan(p.y, p.x) + PI;

    // 划分芽片区域
    int totalSprouts = sproutCount;
    float segmentAngle = 2.0 * PI / float(totalSprouts);
    float segment = floor(angle / segmentAngle);
    float segAngle = mod(angle, segmentAngle) - segmentAngle * 0.5;

    bool isOuterRing = mod(segment, 3.0) != 0.0;
    bool isSproutArea = len > 0.3 && len < 0.8;

    // 芽片变换计算
    vec2 sproutUV = vUv;
    float rotateAngle = 0.0;
    float offset = 0.0;
    float swingOffset = swingProgress * 0.1;

    if (isOuterRing) {
        rotateAngle = radians(outerRotateMax) * expandProgress * sign(segAngle);
        offset = expandProgress * 0.2 + swingOffset;
    } else {
        rotateAngle = radians(innerRotateMax) * expandProgress * sign(segAngle) * -1.0;
        offset = expandProgress * 0.1 + swingOffset * 0.5;
    }

    // 应用变换
    if (isSproutArea) {
        float s = sin(rotateAngle);
        float c = cos(rotateAngle);
        vec2 offsetDir = vec2(cos(segment * segmentAngle), sin(segment * segmentAngle));
        p += offsetDir * offset;
        p = vec2(dot(p, vec2(c, -s)), dot(p, vec2(s, c)));
        sproutUV = p + 0.5;

        // 边缘扰动
        float disp = rand(uv * 10.0 + progress * 5.0) * dispStrengthMax * dispProgress;
        sproutUV += vec2(disp, disp / ratio);
    }

    sproutUV = handleUVBounds(sproutUV);
    vec4 sproutColor = texture2D(tDiffuse, sproutUV);
    float mask = getHardBoundaryMask(sproutUV);

    // 颜色调整
    vec3 finalColor = texel.rgb;
    float finalAlpha = texel.a;

    if (isSproutArea && mask > 0.0) {
        vec3 saturated = adjustSaturation(sproutColor.rgb, 1.0 + saturationBoost * satProgress);
        finalColor = saturated;
        finalAlpha = sproutColor.a * mask;
    }

    // 全局亮度调整
    finalColor *= brightness;

    return vec4(finalColor, finalAlpha);
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