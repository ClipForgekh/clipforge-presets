exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float compression; // = 0.25 [0.1, 0.6] // 初始压缩比例
uniform float depthOffset; // = 0.05 [0.0, 0.2] // 深度平移强度
uniform float depthRotation; // = 0.08 [0.0, 0.3] // 深度旋转强度
uniform float depthSkew; // = 0.06 [0.0, 0.2] // 深度倾斜强度
uniform vec2 initialOffset; // = vec2(0.05, -0.04) // 初始画面偏移

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
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

vec2 restoreFromSDFCoordinate(vec2 p) {
    if (ratio > 1.0) {
        p.y *= ratio;
    } else {
        p.x /= ratio;
    }
    return p;
}

vec4 effect(vec4 texel, float easedProgress) {
    float rawProgress = 1.0 - pow(max(1.0 - easedProgress, 0.0), 0.3333333);
    float baseIntensity = 1.0 - easedProgress;

    float compressPhase = 1.0 - smoothstep(0.0, 0.3, rawProgress);
    float parallaxPhase = smoothstep(0.3, 0.65, rawProgress);
    float settlePhase = smoothstep(0.65, 0.85, rawProgress);
    float alignPhase = smoothstep(0.85, 1.0, rawProgress);

    float depthEnvelope = parallaxPhase * (1.0 - settlePhase);
    depthEnvelope *= 0.2 + 0.8 * baseIntensity;

    float depth = dot(texel.rgb, vec3(0.299, 0.587, 0.114));
    float depthCentered = depth - 0.5;

    vec2 p = getSDFCoordinate(vUv, vec2(0.5));

    float scaleMix = clamp(compressPhase + baseIntensity, 0.0, 1.0);
    float scale = mix(1.0, compression, scaleMix);
    scale = mix(scale, 1.02, parallaxPhase * 0.5 * baseIntensity);
    scale = mix(scale, 1.0, alignPhase);
    p *= scale;

    float skewIntensity = depthSkew * depthCentered * depthEnvelope;
    p.x += skewIntensity;
    p.y += skewIntensity * 0.65;

    float rotation = depthCentered * depthRotation * depthEnvelope;
    rotation += (0.5 - rawProgress) * 0.05 * (compressPhase + depthEnvelope);
    rotation *= (1.0 - alignPhase);
    float s = sin(rotation);
    float c = cos(rotation);
    p = vec2(c * p.x - s * p.y, s * p.x + c * p.y);

    vec2 uv = restoreFromSDFCoordinate(p) + vec2(0.5);

    vec2 depthShift = depthCentered * vec2(depthOffset, depthOffset * 0.7) * depthEnvelope;
    vec2 globalDrift = initialOffset * (compressPhase + 0.5 * parallaxPhase) * (1.0 - alignPhase);
    globalDrift *= 0.5 + 0.5 * baseIntensity;

    uv += depthShift + globalDrift;
    uv = handleUVBounds(uv);

    vec4 sampled = texture2D(tDiffuse, uv);

    float reveal = smoothstep(0.0, 0.15, rawProgress);
    reveal = mix(reveal, 1.0, parallaxPhase);
    reveal = mix(reveal, 1.0, alignPhase);
    reveal = clamp(reveal, 0.0, 1.0);

    vec4 color = mix(vec4(0.0), sampled, reveal);
    float settleBlend = alignPhase * (1.0 - 0.5 * baseIntensity);
    return mix(color, texel, settleBlend);
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