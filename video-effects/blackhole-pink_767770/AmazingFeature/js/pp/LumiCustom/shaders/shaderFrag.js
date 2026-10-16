exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float vortexStrength; // = 1.2 [0.2, 3.0] // 旋涡扭曲强度
uniform float radialStretch; // = 0.8 [0.0, 2.0] // 向心拉伸强度
uniform float coreDarkness; // = 0.85 [0.0, 1.0] // 奇点暗化强度
uniform vec3 glowColor; // = vec3(0.95, 0.45, 0.20) // 热晕颜色

varying vec2 vUv;

const float PI = 3.14159265;

float easeInOutQuad(float x) {
    return x < 0.5 ? 2.0 * x * x : 1.0 - pow(-2.0 * x + 2.0, 2.0) * 0.5;
}

float undoEaseInOutQuad(float y) {
    float clampedY = clamp(y, 0.0, 1.0);
    if (clampedY <= 0.5) {
        return sqrt(clampedY * 0.5);
    }
    return 1.0 - sqrt((1.0 - clampedY) * 0.5);
}

float ramp(float p, float start, float end) {
    float duration = max(end - start, 0.0001);
    float t = clamp((p - start) / duration, 0.0, 1.0);
    return easeInOutQuad(t);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) {
        p.y /= ratio;
    } else {
        p.x *= ratio;
    }
    return p;
}

vec4 effect(vec4 texel, float easedProgress) {
    float baseProgress = undoEaseInOutQuad(easedProgress);
    vec2 center = vec2(0.5);
    vec2 sdfCoord = getSDFCoordinate(vUv, center);
    float radius = length(sdfCoord);
    float angle = atan(sdfCoord.y, sdfCoord.x);
    float radiusClamp = clamp(radius, 0.0, 1.2);
    float innerFalloff = pow(1.0 - clamp(radiusClamp, 0.0, 1.0), 1.5);

    float singularityOpen = ramp(baseProgress, 0.0, 0.15);
    float diskFormation = ramp(baseProgress, 0.125, 0.55);
    float collapseBurst = ramp(baseProgress, 0.45, 0.55);
    float collapseTaper = ramp(baseProgress, 0.55, 0.6);
    float vanishCollapse = ramp(baseProgress, 0.6, 0.8);
    float fadeToBlack = ramp(baseProgress, 0.75, 1.0);

    float angleOffset = -vortexStrength * (diskFormation * innerFalloff * 4.0 + collapseBurst * (0.5 + innerFalloff) * 8.0);
    float taperedAngleOffset = mix(angleOffset, angleOffset * 0.4, collapseTaper);
    float newAngle = angle + taperedAngleOffset;

    float pulledRadius = mix(radiusClamp, radiusClamp * (1.0 - radialStretch * innerFalloff), diskFormation);
    pulledRadius = mix(pulledRadius, pulledRadius * (1.0 - 0.85 * innerFalloff), collapseBurst);
    pulledRadius *= (1.0 - vanishCollapse * (0.85 + 0.15 * innerFalloff));

    float spinDrop = collapseTaper;
    float spinFadeOut = ramp(baseProgress, 0.6, 1.0);
    float spinStrength = vortexStrength * mix(collapseBurst, 0.4 * collapseBurst, spinDrop);
    spinStrength *= (1.0 - spinFadeOut);

    vec3 accumColor = vec3(0.0);
    float accumWeight = 0.0;
    for (int i = 0; i < 5; ++i) {
        float t = (float(i) - 2.0) * 0.5;
        float weight = 1.0 - abs(t) * 0.25;
        float sampleAngle = newAngle + t * spinStrength;
        float sampleRadius = pulledRadius * (1.0 + abs(t) * 0.12 * diskFormation);
        vec2 polar = vec2(cos(sampleAngle), sin(sampleAngle)) * sampleRadius;
        if (ratio > 1.0) {
            polar.y *= ratio;
        } else {
            polar.x /= ratio;
        }
        vec2 sampleUV = polar + center;
        sampleUV = handleUVBounds(sampleUV);
        accumColor += texture2D(tDiffuse, sampleUV).rgb * weight;
        accumWeight += weight;
    }
    vec3 warpedColor = accumColor / max(accumWeight, 0.0001);

    float singularityRadius = singularityOpen * mix(0.05, 0.18, diskFormation);
    singularityRadius = mix(singularityRadius, singularityRadius * 0.2, vanishCollapse);
    float innerCore = 1.0 - smoothstep(singularityRadius, singularityRadius + 0.03, radiusClamp);
    float coreDimmer = 1.0 - innerCore * singularityOpen * coreDarkness;

    float diskBandCenter = mix(0.35, 0.18, collapseBurst);
    float diskSharpness = mix(40.0, 90.0, collapseBurst);
    float diskRing = exp(-pow((radiusClamp - diskBandCenter) * diskSharpness, 2.0)) * diskFormation;
    vec3 diskGlowColor = mix(vec3(0.32, 0.12, 0.45), glowColor, collapseBurst);
    warpedColor += diskGlowColor * diskRing * 0.8;

    float glowRise = ramp(baseProgress, 0.125, 0.55);
    float glowFade = ramp(baseProgress, 0.55, 1.0);
    float glowStrength = glowRise * (1.0 - glowFade);
    float radialGlow = exp(-pow(radiusClamp * (3.5 - glowStrength * 1.5), 2.0));
    vec3 glowContribution = glowColor * glowStrength * radialGlow;
    warpedColor += glowContribution;

    float colorShift = ramp(baseProgress, 0.125, 0.55) * (1.0 - ramp(baseProgress, 0.55, 1.0));
    vec3 purpleTarget = vec3(0.45, 0.18, 0.75);
    float luminance = dot(warpedColor, vec3(0.299, 0.587, 0.114));
    vec3 psychedelic = mix(vec3(luminance), purpleTarget, 0.6);
    warpedColor = mix(warpedColor, psychedelic, colorShift * 0.7);

    float vignetteStrength = ramp(baseProgress, 0.0, 0.55) * (1.0 - ramp(baseProgress, 0.55, 1.0));
    float vignette = smoothstep(0.45, 0.85, length(vUv - center));
    warpedColor *= (1.0 - vignetteStrength * vignette * 0.9);

    float exposureLift = ramp(baseProgress, 0.45, 0.55);
    float exposureReturn = ramp(baseProgress, 0.55, 0.75);
    float exposureDrop = ramp(baseProgress, 0.75, 1.0);
    float exposure = 1.0 + exposureLift * 0.6;
    exposure = mix(exposure, 1.05, exposureReturn);
    exposure = mix(exposure, 1.0, exposureDrop);
    warpedColor *= exposure;

    warpedColor *= coreDimmer;
    warpedColor = mix(warpedColor, vec3(0.0), fadeToBlack);
    warpedColor = clamp(warpedColor, 0.0, 1.0);

    float alpha = texel.a;
    alpha *= (1.0 - vanishCollapse * 0.95);
    alpha *= (1.0 - fadeToBlack);
    float borderMask = getHardBoundaryMask(vUv);
    alpha *= borderMask;

    return vec4(warpedColor * borderMask, alpha);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = easeInOutQuad(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);
    vec4 finalColor = effectColor;
    gl_FragColor = finalColor;
}
//===end_frag_code===
`;