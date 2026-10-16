exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float laserWidth; // = 0.03 [0.005, 0.12] // 激光扫描线宽度
uniform float glitchStrength; // = 1.1 [0.0, 2.0] // 故障强度
uniform float particleDensity; // = 0.8 [0.1, 1.0] // 粒子密度
uniform float strobeIntensity; // = 1.2 [0.0, 2.0] // 频闪强度
uniform float pullStrength; // = 1.8 [0.5, 3.0] // 吸入深渊强度

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

vec4 effect(vec4 texel, float p) {
    const float holdEnd = 0.125;
    const float scanStart = 0.125;
    const float scanEnd = 0.5;
    const float shatterStart = 0.375;
    const float shatterEnd = 0.625;
    const float suckStart = 0.575;
    const float suckEnd = 0.75;
    const float blackStart = 0.75;

    if (p <= holdEnd) return texel;

    float scanT = clamp((p - scanStart) / (scanEnd - scanStart), 0.0, 1.0);
    float shatterT = clamp((p - shatterStart) / (shatterEnd - shatterStart), 0.0, 1.0);
    float suckT = clamp((p - suckStart) / (suckEnd - suckStart), 0.0, 1.0);
    float blackT = smoothstep(blackStart, 1.0, p);

    float laserPos = mix(-0.15, 1.15, scanT);
    float laserBand = exp(-pow((vUv.x - laserPos) / max(laserWidth, 0.0001), 2.0));
    float passed = smoothstep(-0.01, 0.01, laserPos - vUv.x);

    float lineRnd = hash12(vec2(floor(vUv.y * 320.0), floor(p * 500.0)));
    float blockRnd = hash12(vec2(floor(vUv.y * 96.0), floor(vUv.x * 156.0 + p * 420.0)));
    float glitch = glitchStrength * scanT * (0.35 + 0.65 * step(0.82, lineRnd));
    vec2 jitter = vec2((blockRnd - 0.5) * 0.03 * glitch, (lineRnd - 0.5) * 0.008 * glitch);
    float split = (0.002 + 0.012 * step(0.9, lineRnd)) * glitch;

    vec2 uvR = handleUVBounds(vUv + jitter + vec2(split, 0.0));
    vec2 uvG = handleUVBounds(vUv + jitter);
    vec2 uvB = handleUVBounds(vUv + jitter - vec2(split, 0.0));

    vec3 splitTex = vec3(
        texture2D(tDiffuse, uvR).r,
        texture2D(tDiffuse, uvG).g,
        texture2D(tDiffuse, uvB).b
    );

    vec2 px = vec2(0.0022, 0.0022 / max(ratio, 0.0001));
    float l0 = dot(texture2D(tDiffuse, handleUVBounds(vUv + px)).rgb, vec3(0.299, 0.587, 0.114));
    float l1 = dot(texture2D(tDiffuse, handleUVBounds(vUv - px)).rgb, vec3(0.299, 0.587, 0.114));
    float l2 = dot(texture2D(tDiffuse, handleUVBounds(vUv + vec2(px.x, -px.y))).rgb, vec3(0.299, 0.587, 0.114));
    float l3 = dot(texture2D(tDiffuse, handleUVBounds(vUv + vec2(-px.x, px.y))).rgb, vec3(0.299, 0.587, 0.114));
    float edge = clamp(abs(l0 - l1) + abs(l2 - l3), 0.0, 1.0);

    vec3 holo = mix(splitTex * 0.2, vec3(0.02, 0.85, 1.0) * (edge * 1.7 + laserBand * 1.3), 0.82);
    vec3 scene = mix(texel.rgb, holo, passed);

    float grid = mix(170.0, 320.0, particleDensity);
    vec2 gv = fract(vUv * grid) - 0.5;
    vec2 cell = floor(vUv * grid);

    float rnd = hash12(cell);
    float particleOn = step(rnd, particleDensity * (0.22 + 0.78 * shatterT));

    vec2 dir = vec2(hash12(cell + 11.3), hash12(cell + 37.7)) - 0.5;
    dir = normalize(dir + vec2(0.0001));
    vec2 centerVec = vUv - 0.5;

    vec2 explosion = dir * shatterT * (1.0 - suckT) * 0.62;
    vec2 pull = -centerVec * suckT * pullStrength;

    vec2 particleLocal = gv - explosion + pull * grid * 0.01;
    float size = mix(0.4, 0.07, shatterT) * (1.0 - 0.9 * suckT);
    float d = length(particleLocal);
    float core = smoothstep(size, 0.0, d) * particleOn;
    float glow = exp(-d * d / max(size * size * 0.5, 0.00001)) * particleOn;

    float strobeWindow = smoothstep(shatterStart, shatterStart + 0.03, p) * (1.0 - smoothstep(0.62, 0.76, p));
    float strobe = 1.0 + (0.55 + 0.45 * sin((p - shatterStart) * 300.0)) * strobeIntensity * strobeWindow;
    vec3 particleColor = vec3(0.04, 0.9, 1.0) * (glow * 1.5 + core * 1.9) * strobe;

    scene = mix(scene, particleColor, shatterT);

    float voidFade = smoothstep(suckStart, suckEnd, p);
    scene *= (1.0 - 0.92 * voidFade);

    scene = mix(scene, vec3(0.0), blackT);
    float alpha = mix(texel.a, 1.0, blackT);
    return vec4(clamp(scene, 0.0, 1.0), clamp(alpha, 0.0, 1.0));
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