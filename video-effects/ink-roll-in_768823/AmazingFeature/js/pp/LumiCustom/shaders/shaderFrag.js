exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float rollerWidth; // = 0.075 [0.02, 0.2] // 滚筒接触宽度
uniform float inkLag; // = 0.22 [0.0, 0.5] // 浅层区域上墨延迟
uniform float sheenStrength; // = 0.22 [0.0, 0.8] // 湿墨高光强度
uniform float textureAmount; // = 0.08 [0.0, 0.25] // 滚筒纹理强度

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float sinOut(float p) {
    return sin(p * 1.57079632679);
}

float quintOut(float p) {
    float q = 1.0 - p;
    return 1.0 - q * q * q * q * q;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    const float tRollEnd = 1.3 / 1.9;
    const float tLevelStart = 1.15 / 1.9;
    const float tLevelEnd = 1.7 / 1.9;
    const float tSettleStart = 1.6 / 1.9;
    const float tSettleEnd = 1.85 / 1.9;
    const float tGlowStart = 0.2 / 1.9;
    const float tGlowEnd = 1.0 / 1.9;

    float luma = dot(texel.rgb, vec3(0.299, 0.587, 0.114));
    float density = 1.0 - luma;

    float rollP = clamp(p / tRollEnd, 0.0, 1.0);
    float rollE = sinOut(rollP);
    float frontX = mix(-0.12, 1.12, rollE);

    float localDelay = (1.0 - density) * inkLag;
    float baseReveal = smoothstep(-0.02, 0.02, frontX - vUv.x - localDelay);

    float levelP = clamp((p - tLevelStart) / (tLevelEnd - tLevelStart), 0.0, 1.0);
    float levelE = quintOut(levelP);
    float reveal = clamp(baseReveal + (1.0 - baseReveal) * levelE, 0.0, 1.0);

    vec3 linoWhite = vec3(1.0);
    vec3 color = mix(linoWhite, texel.rgb, reveal);

    float rollActive = 1.0 - smoothstep(tRollEnd - 0.05, tRollEnd, p);
    float line = exp(-pow((vUv.x - frontX) / max(rollerWidth, 0.0001), 2.0));
    float sheenPattern = 0.65 + 0.35 * sin(vUv.y * 180.0 + vUv.x * 22.0);
    float sheen = sheenStrength * line * sheenPattern * rollActive * reveal;
    color = mix(color, vec3(1.0), clamp(sheen, 0.0, 0.5));

    float settleFade = 1.0 - smoothstep(tSettleStart, tSettleEnd, p);
    float texPattern = (sin(vUv.y * 420.0 + sin(vUv.x * 25.0) * 2.0) * 0.5 + 0.5);
    float texMod = (texPattern - 0.5) * 2.0 * textureAmount * settleFade * reveal;
    color *= (1.0 - 0.08 * texMod);

    float glowWindow = smoothstep(tGlowStart, tGlowStart + 0.04, p) * (1.0 - smoothstep(tGlowEnd - 0.06, tGlowEnd, p));
    color += texel.rgb * 0.06 * glowWindow * reveal;

    color = clamp(color, 0.0, 1.0);
    return vec4(color, texel.a);
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