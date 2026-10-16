exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float slitWidth; // = 0.02 [0.005, 0.2] // 初始中央缝隙宽度占屏幕宽度的比例

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec4 effect(vec4 texel, float easedProgress) {
    float linearProgress = 1.0 - pow(max(1.0 - easedProgress, 0.0), 0.33333334);
    const float phase1End = 0.2;
    const float phase2End = 0.625;
    const float leftPhase2Target = 0.85;
    const float rightPhase2Target = 0.95;
    float leftReveal = 0.0;
    float rightReveal = 0.0;

    if (linearProgress <= phase1End) {
        leftReveal = 0.0;
        rightReveal = 0.0;
    } else if (linearProgress <= phase2End) {
        float local = (linearProgress - phase1End) / (phase2End - phase1End);
        float easedLocal = local * local * (3.0 - 2.0 * local);
        leftReveal = easedLocal * leftPhase2Target;
        float boosted = min(1.0, easedLocal * 1.1);
        rightReveal = boosted * rightPhase2Target;
    } else {
        float local = (linearProgress - phase2End) / (1.0 - phase2End);
        float easedLocal = local * local * (3.0 - 2.0 * local);
        leftReveal = mix(leftPhase2Target, 1.0, easedLocal);
        rightReveal = mix(rightPhase2Target, 1.0, easedLocal);
    }

    leftReveal = clamp(leftReveal, 0.0, 1.0);
    rightReveal = clamp(rightReveal, 0.0, 1.0);

    float safeSlit = clamp(slitWidth, 0.001, 0.5);
    float halfSlit = safeSlit * 0.5;
    float leftBoundaryStart = 0.5 - halfSlit;
    float rightBoundaryStart = 0.5 + halfSlit;
    float leftBoundary = mix(leftBoundaryStart, 0.0, leftReveal);
    float rightBoundary = mix(rightBoundaryStart, 1.0, rightReveal);

    float mask = step(leftBoundary, vUv.x) * step(vUv.x, rightBoundary);
    vec3 revealedColor = texel.rgb * mask;
    float alpha = texel.a * mask;

    return vec4(revealedColor, alpha);
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