exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform vec3 accentColor; // = vec3(0.95, 0.86, 0.65) // 高级金色调
uniform float trailIntensity; // = 1.0 [0.2, 2.0] // 光迹亮度
uniform float veilSoftness; // = 0.35 [0.1, 0.6] // 幕帘柔和度
uniform float starSize; // = 0.18 [0.05, 0.35] // 星形尺寸

varying vec2 vUv;

// 缓入缓出（三次）曲线：Cubic.InOut
float tween(float p) {
    return p < 0.5 ? 4.0 * p * p * p : 1.0 - pow(-2.0 * p + 2.0, 3.0) * 0.5;
}

// 边界处理函数（默认留黑）
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 【强制使用】坐标空间转换函数
vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

// 将方向向量适配屏幕比例
vec2 applyAspectToVector(vec2 dir) {
    vec2 adjusted = dir;
    if (ratio > 1.0) adjusted.y /= ratio;
    else adjusted.x *= ratio;
    return adjusted;
}

// 计算局部进度
float computeLocalProgress(float gProgress, float start, float duration) {
    float d = max(duration, 0.0001);
    return clamp((gProgress - start) / d, 0.0, 1.0);
}

// 高级星形光晕
float starFlare(vec2 uv, vec2 center, float size, float sharpness) {
    vec2 p = getSDFCoordinate(uv, center) / max(size, 0.0001);
    float r2 = dot(p, p);
    float core = exp(-r2 * sharpness * 2.2);
    float cross = exp(-abs(p.x) * sharpness) + exp(-abs(p.y) * sharpness);
    float diag = exp(-abs(p.x + p.y) * sharpness * 0.6) + exp(-abs(p.x - p.y) * sharpness * 0.6);
    float ring = exp(-pow(r2, 0.7) * sharpness * 0.8);
    return clamp(core + 0.35 * cross + 0.25 * diag + 0.2 * ring, 0.0, 1.0);
}

// 丝滑光迹
float cascadeTrail(vec2 uv, vec2 headPos, vec2 direction, float span, float width, float fade) {
    if (span <= 0.0) return 0.0;
    vec2 aspectDir = applyAspectToVector(direction);
    float dirLen = max(length(aspectDir), 0.0001);
    vec2 nDir = aspectDir / dirLen;
    vec2 rel = getSDFCoordinate(uv, headPos);
    float along = dot(rel, nDir);
    if (along > 0.0) return 0.0;
    float normalized = clamp(-along / span, 0.0, 1.0);
    float lateral = dot(rel, vec2(-nDir.y, nDir.x));
    float lateralAtten = exp(-pow(abs(lateral) / max(width, 0.0001), 2.0));
    float longitudinal = pow(1.0 - normalized, 1.4) * smoothstep(0.0, 0.15, normalized);
    return longitudinal * lateralAtten * fade;
}

vec4 effect(vec4 texel, float progress) {
    float intensity = 1.0 - progress;
    vec3 baseUnderlay = mix(vec3(0.02, 0.015, 0.03), accentColor, 0.08);

    vec2 start1 = vec2(0.48, -0.12);
    vec2 end1 = vec2(0.72, 0.92);
    vec2 start2 = vec2(0.43, -0.02);
    vec2 end2 = vec2(0.70, 1.02);
    vec2 start3 = vec2(0.50, 0.05);
    vec2 end3 = vec2(0.82, 1.12);

    vec2 dir1 = end1 - start1;
    vec2 dir2 = end2 - start2;
    vec2 dir3 = end3 - start3;

    float s1 = computeLocalProgress(progress, 0.0, 0.72);
    float s2 = computeLocalProgress(progress, 0.18, 0.68);
    float s3 = computeLocalProgress(progress, 0.40, 0.60);

    vec2 head1 = mix(start1, end1, s1);
    vec2 head2 = mix(start2, end2, s2);
    vec2 head3 = mix(start3, end3, s3);

    float len1 = length(applyAspectToVector(dir1)) * s1 * 1.08;
    float len2 = length(applyAspectToVector(dir2)) * s2 * 1.05;
    float len3 = length(applyAspectToVector(dir3)) * s3 * 1.10;

    float trailFade = trailIntensity * (0.85 + 0.15 * smoothstep(0.65, 1.0, progress));

    float trail1 = cascadeTrail(vUv, head1, dir1, len1, 0.08, trailFade * intensity);
    float trail2 = cascadeTrail(vUv, head2, dir2, len2, 0.09, trailFade * intensity);
    float trail3 = cascadeTrail(vUv, head3, dir3, len3, 0.10, trailFade * (0.6 + 0.4 * s3));

    float starGate1 = smoothstep(0.02, 0.12, s1);
    float starGate2 = smoothstep(0.02, 0.12, s2);
    float starGate3 = smoothstep(0.02, 0.12, s3);

    float star1 = starFlare(vUv, head1, starSize, 6.0) * starGate1 * (0.6 + 0.4 * intensity);
    float star2 = starFlare(vUv, head2, starSize * 0.92, 6.5) * starGate2 * (0.5 + 0.5 * intensity);
    float star3 = starFlare(vUv, head3, starSize * 0.88, 7.5) * starGate3 * (0.4 + 0.6 * s3);

    float finalBurst = starFlare(vUv, head3, starSize * 0.75, 9.0) * smoothstep(0.78, 1.0, progress) * (1.0 - progress) * 5.0;

    float trailSum = trail1 + trail2 + trail3;
    float sparkleSum = star1 + star2 + star3;

    float layeredVeil = 1.0 - exp(- (trailSum * (2.6 * veilSoftness) + sparkleSum * 0.9));
    float reveal = clamp(layeredVeil + smoothstep(0.92, 1.0, progress), 0.0, 1.0);

    vec3 color = mix(baseUnderlay, texel.rgb, reveal);
    float highlightLum = (star1 * 0.8 + star2 * 0.9 + star3 * 1.1 + finalBurst) * (0.4 + 0.6 * trailIntensity);
    color += accentColor * highlightLum * (0.6 * intensity + 0.4 * smoothstep(0.85, 0.99, progress));

    float finalAlpha = texel.a * reveal;
    return vec4(color, finalAlpha);
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