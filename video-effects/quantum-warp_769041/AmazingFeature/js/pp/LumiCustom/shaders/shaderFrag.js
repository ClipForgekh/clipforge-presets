exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float burstSharpness; // = 1.3 [0.5, 4.0] // 能量爆裂锐度
uniform float energyIntensity; // = 1.0 [0.2, 2.0] // 能量光辉强度

varying vec2 vUv;

const float PI = 3.14159265;
const float TWO_PI = 6.2831853;

float tween(float p) {
    return 1.0 - pow(1.0 - clamp(p, 0.0, 1.0), 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec4 effect(vec4 texel, float p) {
    float effectStrength = 1.0 - p;
    vec2 center = vec2(0.5);
    vec2 aspectVec = getSDFCoordinate(vUv, center);
    float radius = length(aspectVec);
    float baseAngle = atan(aspectVec.y, aspectVec.x + 1e-6);
    float dynamicSwirl = effectStrength * (0.6 + 0.4 * smoothstep(0.0, 0.7, p));
    float radialFactor = 1.0 - exp(-radius * burstSharpness * 4.0);
    float swirlMod = sin(p * TWO_PI * 1.5 - radius * 18.0);
    float swirlAngle = baseAngle + dynamicSwirl * radialFactor * (0.6 + 0.4 * swirlMod);
    float burstCurve = sin(clamp(p, 0.0, 1.0) * PI);
    float compress = effectStrength * 0.25;
    float radialScale = 1.0 + burstCurve * (0.45 * burstSharpness) - compress;
    vec2 swirlVec = vec2(cos(swirlAngle), sin(swirlAngle)) * radius * radialScale;
    vec2 delta = swirlVec;
    if (ratio > 1.0) delta.y *= ratio;
    else delta.x /= ratio;
    vec2 distortedUV = handleUVBounds(center + delta);
    vec4 warped = texture2D(tDiffuse, distortedUV);
    vec2 dir = vec2(cos(baseAngle), sin(baseAngle));
    vec2 uvDir = dir;
    if (ratio > 1.0) uvDir.y *= ratio;
    else uvDir.x /= ratio;
    float dirLen = max(length(uvDir), 1e-4);
    uvDir /= dirLen;
    float streakDistance = 0.02 * burstSharpness * (0.4 + 0.6 * burstCurve);
    vec2 sampleUV1 = handleUVBounds(center + delta + uvDir * streakDistance);
    vec2 sampleUV2 = handleUVBounds(center + delta - uvDir * streakDistance * 0.5);
    vec4 streakBlend = (warped + texture2D(tDiffuse, sampleUV1) + texture2D(tDiffuse, sampleUV2)) / 3.0;
    float core = exp(-pow(radius * burstSharpness * 4.0, 2.0));
    float corona = exp(-pow((radius - 0.25 * radialScale) * burstSharpness * 6.0, 2.0));
    float angleBands = fract((baseAngle / TWO_PI) * 8.0 + p * 2.5);
    float streakPattern = pow(clamp(1.0 - abs(angleBands - 0.5) * 2.0, 0.0, 1.0), 4.0);
    float ripple = 0.5 + 0.5 * sin(radius * 60.0 - p * 25.0);
    vec3 colorBlue = vec3(0.1, 0.6, 1.0);
    vec3 colorCyan = vec3(0.0, 0.9, 1.0);
    vec3 colorPurple = vec3(0.6, 0.2, 0.9);
    vec3 colorWhite = vec3(1.0);
    vec3 baseEnergy = mix(colorBlue, colorPurple, clamp(radius * 2.0, 0.0, 1.0));
    baseEnergy = mix(baseEnergy, colorCyan, 0.5 + 0.5 * sin(p * TWO_PI + radius * 10.0));
    baseEnergy = mix(baseEnergy, colorWhite, pow(core, 0.5));
    float energyStrength = energyIntensity * (effectStrength * 0.9 + burstCurve * (1.2 - 0.6 * p));
    float energyField = core + 0.6 * corona + 0.3 * streakPattern * ripple;
    vec3 energyEmission = baseEnergy * energyStrength * energyField + colorWhite * streakPattern * burstCurve * 0.4 * energyIntensity;
    vec3 chargedBase = mix(warped.rgb, streakBlend.rgb, clamp(burstCurve * 0.45 + effectStrength * 0.2, 0.0, 0.75));
    vec3 finalRGB = min(chargedBase + energyEmission, vec3(1.0));
    return vec4(finalRGB, warped.a);
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