exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float glitchStrength; // = 0.85 [0.0, 1.5] // 故障强度
uniform float particleDensity; // = 180.0 [40.0, 320.0] // 粒子密度
uniform vec4 laserColor; // = vec4(1.0, 0.0, 0.75, 1.0) // 激光颜色RGBA

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

float noise2(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash12(i);
    float b = hash12(i + vec2(1.0, 0.0));
    float c = hash12(i + vec2(0.0, 1.0));
    float d = hash12(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

vec3 sampleChromatic(vec2 uv, float amt) {
    vec2 off = vec2(amt, 0.0);
    vec2 uvR = handleUVBounds(uv + off);
    vec2 uvG = handleUVBounds(uv);
    vec2 uvB = handleUVBounds(uv - off);
    return vec3(texture2D(tDiffuse, uvR).r, texture2D(tDiffuse, uvG).g, texture2D(tDiffuse, uvB).b);
}

vec4 effect(vec4 texel, float p) {
    if (p <= 0.125) return texel;
    if (p >= 0.75) return vec4(0.0, 0.0, 0.0, 1.0);

    vec2 uv = vUv;
    float holdEnd = 0.125;
    float scanEnd = 0.50;
    float shatterStart = 0.375;
    float shatterEnd = 0.625;
    float suckStart = 0.575;
    float suckEnd = 0.75;

    float scanT = clamp((p - holdEnd) / (scanEnd - holdEnd), 0.0, 1.0);
    float laserX = mix(-0.2, 1.2, scanT);
    float converted = smoothstep(-0.04, 0.02, laserX - uv.x);

    float lineNoise = (noise2(vec2(uv.y * 220.0, p * 300.0)) - 0.5);
    float blockNoise = (noise2(vec2(floor(uv.y * 36.0), floor((uv.x + p) * 24.0))) - 0.5);
    float gAmt = converted * glitchStrength * (0.003 + 0.02 * abs(lineNoise) + 0.015 * abs(blockNoise));

    vec2 glitchUV = uv;
    glitchUV.x += gAmt * (lineNoise * 1.6 + blockNoise * 0.9);
    glitchUV.y += gAmt * 0.4 * (noise2(vec2(uv.x * 120.0, p * 200.0)) - 0.5) / max(ratio, 0.0001);
    glitchUV = handleUVBounds(glitchUV);

    vec3 splitCol = sampleChromatic(glitchUV, gAmt * 2.6);
    vec3 blurCol = (
        texture2D(tDiffuse, handleUVBounds(glitchUV + vec2(0.003, 0.0))).rgb +
        texture2D(tDiffuse, handleUVBounds(glitchUV + vec2(-0.003, 0.0))).rgb +
        texture2D(tDiffuse, handleUVBounds(glitchUV + vec2(0.0, 0.003 / max(ratio, 0.0001)))).rgb +
        texture2D(tDiffuse, handleUVBounds(glitchUV + vec2(0.0, -0.003 / max(ratio, 0.0001)))).rgb
    ) * 0.25;
    vec3 holoBase = mix(splitCol, blurCol, 0.55);

    vec2 gridUV = uv * vec2(220.0, 220.0 / max(ratio, 0.0001));
    float gx = abs(fract(gridUV.x) - 0.5);
    float gy = abs(fract(gridUV.y) - 0.5);
    float wire = 1.0 - smoothstep(0.05, 0.11, min(gx, gy));
    vec3 wireGlow = mix(vec3(0.1, 1.0, 1.0), laserColor.rgb, 0.7) * wire * (0.7 + 0.3 * noise2(uv * 80.0 + p * 40.0));
    vec3 hologram = mix(holoBase * 0.45, wireGlow + holoBase * 0.35, converted);

    float laserBand = exp(-abs(uv.x - laserX) * 140.0);
    vec3 laser = laserColor.rgb * laserBand * (1.8 + 0.8 * sin((uv.y + p * 8.0) * 90.0));

    float shatterT = clamp((p - shatterStart) / (shatterEnd - shatterStart), 0.0, 1.0);
    float cell = particleDensity;
    vec2 gid = floor(uv * cell);
    vec2 f = fract(uv * cell);
    vec2 rnd = vec2(hash12(gid), hash12(gid + 17.31));
    vec2 c = 0.5 + (rnd - 0.5) * 0.9;
    float d = length((f - c) * vec2(1.0, ratio));
    float particleCore = 1.0 - smoothstep(0.02, 0.11, d);
    float particleHalo = 1.0 - smoothstep(0.04, 0.24, d);
    float strobe = 0.6 + 0.4 * step(0.65, sin((p * 120.0 + hash12(gid) * 20.0)));
    vec3 pCol = mix(vec3(0.2, 0.9, 1.0), laserColor.rgb, rnd.x) * (particleCore * 1.2 + particleHalo * 0.45) * strobe;

    vec3 shatterMix = mix(hologram + laser, pCol, shatterT * converted);

    float suckT = clamp((p - suckStart) / (suckEnd - suckStart), 0.0, 1.0);
    vec2 toCenter = uv - 0.5;
    float r = length(toCenter * vec2(1.0, ratio));
    float vortex = 1.0 - smoothstep(0.0, 1.0, suckT);
    float pull = exp(-6.0 * r) * suckT;
    float survive = (1.0 - suckT) * (1.0 - 0.85 * r) + (1.0 - pull) * 0.25;
    survive = clamp(survive, 0.0, 1.0);

    vec3 col = shatterMix * survive * (1.0 - smoothstep(0.70, 0.75, p) * 1.5);
    col *= vortex + 0.08;

    return vec4(clamp(col, 0.0, 1.0), texel.a * survive);
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