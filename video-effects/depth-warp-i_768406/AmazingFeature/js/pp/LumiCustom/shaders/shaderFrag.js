exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 原始线性进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float distortionStrength; // = 1.0 [0.0, 2.0] // 中心失真强度
uniform float depthFactor; // = 1.0 [0.0, 3.0] // 深度视差强度
uniform float reliefStrength; // = 1.0 [0.0, 2.0] // 高光阴影夸张强度

varying vec2 vUv;

float tween(float p) {
    return p < 0.5 ? 4.0 * p * p * p : 1.0 - pow(-2.0 * p + 2.0, 3.0) * 0.5;
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

vec2 aspectToUV(vec2 aspectUV) {
    vec2 uv = aspectUV;
    if (ratio > 1.0) {
        uv.y -= (1.0 - 1.0 / ratio) * 0.5;
        uv.y *= ratio;
    } else {
        uv.x -= (1.0 - ratio) * 0.5;
        uv.x /= ratio;
    }
    return uv;
}

vec4 effect(vec4 texel, float easedProgress) {
    float linearProgress = clamp(progress, 0.0, 1.0);

    vec2 center = vec2(0.5);
    vec2 aspectUV = getAspectCorrectUV(vUv);
    vec2 aspectOffset = aspectUV - center;
    float radius = length(aspectOffset);

    float earlyWindow = 1.0 - smoothstep(0.12, 0.2, linearProgress);
    float depthRise = smoothstep(0.15, 0.25, linearProgress);
    float depthCollapse = smoothstep(0.5, 0.775, linearProgress);
    float depthAmount = depthRise * (1.0 - depthCollapse);

    float totalDistortion = max(earlyWindow, depthAmount) * distortionStrength;

    float compressionMix = smoothstep(0.175, 0.55, linearProgress);
    float centralCompression = mix(0.35, 1.0, compressionMix);
    vec2 compressedAspect = aspectOffset * centralCompression;

    float swirlStrength = earlyWindow * 4.0;
    float swirlWeight = (1.0 - smoothstep(0.0, 0.7, radius));
    float swirlAngle = swirlStrength * swirlWeight * 0.8;
    float s = sin(swirlAngle);
    float c = cos(swirlAngle);
    vec2 swirledAspect = vec2(
        compressedAspect.x * c - compressedAspect.y * s,
        compressedAspect.x * s + compressedAspect.y * c
    );

    vec2 parallaxDir = radius > 0.0001 ? aspectOffset / radius : vec2(0.0);
    float pseudoDepth = clamp(1.0 - radius * 0.9 + (dot(texel.rgb, vec3(0.299, 0.587, 0.114)) - 0.5) * 0.35, 0.0, 1.0);
    float radialFalloff = exp(-radius * 3.5);
    float parallaxMagnitude = totalDistortion * depthFactor * (0.12 * radialFalloff + 0.08 * pseudoDepth);
    vec2 parallaxOffset = parallaxDir * parallaxMagnitude;

    vec2 distortedAspect = swirledAspect + parallaxOffset;
    distortedAspect = mix(distortedAspect, aspectOffset, depthCollapse);

    vec2 distortedAspectUV = distortedAspect + center;
    vec2 distortedUV = aspectToUV(distortedAspectUV);
    distortedUV = handleUVBounds(distortedUV);

    vec4 distortedColor = texture2D(tDiffuse, distortedUV);
    float borderMask = getHardBoundaryMask(distortedUV);

    float highlightRampUp = smoothstep(0.275, 0.35, linearProgress);
    float highlightRelease = smoothstep(0.775, 0.95, linearProgress);
    float highlightAmount = highlightRampUp * (1.0 - highlightRelease) * reliefStrength;

    float depthCue = clamp(pseudoDepth * 0.9 + totalDistortion * 0.4, 0.0, 1.0);
    vec3 lit = distortedColor.rgb;
    float shadowExp = 1.0 + highlightAmount * 0.9;
    float lightExp = max(0.05, 1.0 - highlightAmount * 0.65);
    vec3 shadowed = pow(lit + 1e-4, vec3(shadowExp));
    vec3 brightened = pow(lit + 1e-4, vec3(lightExp));
    vec3 reliefColor = mix(shadowed, brightened, depthCue);
    vec3 shaded = mix(lit, reliefColor, highlightAmount);
    shaded = clamp(shaded, 0.0, 1.0);

    float revealStart = smoothstep(0.0, 0.05, linearProgress);
    float revealGrow = smoothstep(0.0, 0.35, linearProgress);
    float maskRadius = mix(0.1, 1.2, revealGrow);
    float centerMask = 1.0 - smoothstep(maskRadius, maskRadius + 0.1, radius);
    float coverage = clamp(max(revealStart * centerMask, smoothstep(0.4, 0.6, linearProgress)), 0.0, 1.0);

    float settle = smoothstep(0.85, 1.0, linearProgress);
    vec3 transitionColor = mix(vec3(0.0), shaded, coverage);
    vec3 finalRGB = mix(transitionColor, texel.rgb, settle);
    finalRGB = clamp(finalRGB, 0.0, 1.0);

    float finalAlpha = texel.a * mix(0.0, 1.0, coverage) * borderMask;
    return vec4(finalRGB, finalAlpha);
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