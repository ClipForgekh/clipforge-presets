exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float dotDensity; // = 140.0 [60.0, 260.0]
uniform float separationStrength; // = 1.0 [0.2, 2.0]
uniform float glowStrength; // = 2.2 [0.0, 4.0]
uniform float scatterStrength; // = 1.25 [0.2, 2.5]

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    return p < 0.5
        ? 4.0 * p * p * p
        : 1.0 - pow(-2.0 * p + 2.0, 3.0) * 0.5;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec4 effect(vec4 texel, float p) {
    float cleanEnd = 0.15;
    float halfEnd = 0.55;
    float glowStart = 0.40;
    float glowEnd = 0.80;
    float scatterStart = 0.55;

    float halftoneT = clamp((p - cleanEnd) / max(halfEnd - cleanEnd, 0.0001), 0.0, 1.0);
    float glowT = clamp((p - glowStart) / max(glowEnd - glowStart, 0.0001), 0.0, 1.0);
    float scatterT = clamp((p - scatterStart) / max(1.0 - scatterStart, 0.0001), 0.0, 1.0);

    float cols = dotDensity;
    float sepBase = 1.0 / cols;
    float sep = sepBase * mix(1.0, 2.6 * separationStrength, halftoneT);

    vec2 gid = floor(vUv / sep);
    vec2 cellCenter = (gid + 0.5) * sep;
    float rnd = hash21(gid);

    float dir = sign(cellCenter.x - 0.5);
    dir = (abs(dir) < 0.001) ? (rnd > 0.5 ? 1.0 : -1.0) : dir;

    float scatterEase = pow(scatterT, 1.15);
    vec2 scatterOffset = vec2(
        dir * (0.25 + 0.75 * rnd) * scatterStrength * scatterEase,
        (rnd - 0.5) * 0.35 * scatterStrength * scatterEase
    );

    vec2 uvScatter = vUv - scatterOffset;
    vec2 gidS = floor(uvScatter / sep);
    vec2 cellCenterS = (gidS + 0.5) * sep;

    vec2 imgUV = handleUVBounds(cellCenterS);
    vec3 src = texture2D(tDiffuse, imgUV).rgb;
    float lum = dot(src, vec3(0.299, 0.587, 0.114));

    float rBase = sep * (0.18 + 0.34 * lum);
    float r = rBase * mix(1.15, 0.62, halftoneT);
    float d = length(uvScatter - cellCenterS);

    float dotMask = 1.0 - smoothstep(r, r + sep * 0.16, d);
    float halo = exp(-d / max(sep * 0.65, 0.0001));

    vec3 red = vec3(1.0, 0.05, 0.10);
    vec3 halftoneColor = red * dotMask * (0.35 + 1.25 * lum);
    vec3 neonGlow = red * halo * (0.15 + 1.4 * lum) * glowStrength * glowT;

    vec3 dotsColor = clamp(halftoneColor + neonGlow, 0.0, 1.0);
    float dotsAlpha = clamp(dotMask + halo * 0.45 * glowT, 0.0, 1.0);

    vec3 stageColor = mix(texel.rgb, dotsColor, halftoneT);
    float stageAlpha = mix(texel.a, dotsAlpha, halftoneT);

    float vanish = pow(1.0 - scatterT, 3.2);
    stageColor *= vanish;
    stageAlpha *= vanish;

    return vec4(stageColor, stageAlpha);
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