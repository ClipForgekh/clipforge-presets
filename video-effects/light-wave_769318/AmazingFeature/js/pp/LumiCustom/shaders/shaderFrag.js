exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float beamWidth; // = 0.07 [0.01, 0.25] // 光束宽度
uniform float waveAmount; // = 0.035 [0.0, 0.15] // 光束波动强度
uniform float rainbowStrength; // = 0.22 [0.0, 0.8] // 彩虹辉光强度
uniform float particleStrength; // = 0.18 [0.0, 0.6] // 镜头光斑粒子强度
uniform float darkness; // = 0.85 [0.0, 1.0] // 初始暗度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 rainbow(float t) {
    return 0.5 + 0.5 * cos(6.2831853 * (t + vec3(0.0, 0.33, 0.67)));
}

vec4 effect(vec4 texel, float p) {
    vec2 uv = vUv;
    vec2 dir = normalize(vec2(-1.0, 1.0));      // bottom-right -> top-left
    vec2 ortho = vec2(-dir.y, dir.x);

    float move = mix(-1.1, 1.1, p);
    float wave = sin(dot(uv, ortho) * 24.0 + p * 10.0) * waveAmount;
    float proj = dot(uv - 0.5, dir);
    float distToBeam = abs((proj - move) - wave);

    float beamCore = exp(-distToBeam * distToBeam / max(beamWidth * beamWidth, 0.0001));
    float beamSoft = exp(-distToBeam * distToBeam / max((beamWidth * 2.6) * (beamWidth * 2.6), 0.0001));

    vec2 d = vec2(0.002, 0.002 / max(ratio, 0.001));
    vec3 c0 = texture2D(tDiffuse, handleUVBounds(uv)).rgb;
    vec3 cx = texture2D(tDiffuse, handleUVBounds(uv + vec2(d.x, 0.0))).rgb;
    vec3 cy = texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, d.y))).rgb;
    float detail = clamp(length(c0 - 0.5 * (cx + cy)) * 4.0, 0.0, 1.0);

    float bgEarlyBias = (1.0 - detail) * 0.08 - detail * 0.02;
    float reveal = smoothstep(-0.08, 0.08, (move - proj) + bgEarlyBias);
    reveal = max(reveal, p);

    float gray = dot(texel.rgb, vec3(0.299, 0.587, 0.114));
    float sat = mix(0.25, 1.0, reveal);
    vec3 lowSat = mix(vec3(gray), texel.rgb, sat);
    vec3 lowContrast = mix(vec3(0.5), lowSat, mix(0.6, 1.0, reveal));
    vec3 darkBase = lowContrast * (1.0 - darkness * (1.0 - reveal));

    float bright = smoothstep(0.55, 1.0, dot(texel.rgb, vec3(0.2126, 0.7152, 0.0722)));
    float halo = beamSoft * bright * (1.0 - p);

    float r1 = exp(-pow(distToBeam - beamWidth * 0.6, 2.0) / max(beamWidth * beamWidth * 2.0, 0.0001));
    float r2 = exp(-pow(distToBeam - beamWidth * 1.1, 2.0) / max(beamWidth * beamWidth * 3.5, 0.0001));
    vec3 rainbowGlow = (rainbow(uv.x * 0.8 + uv.y * 0.6 + p * 0.35) * r1 + rainbow(uv.y * 0.7 - p * 0.2) * r2) * rainbowStrength * halo;

    float particles = 0.0;
    for (int i = 0; i < 6; i++) {
        float fi = float(i);
        float rnd = hash12(vec2(fi, 7.13));
        float t = fi / 5.0;
        vec2 pPos = 0.5 + dir * (move + (t - 0.5) * 0.6) + ortho * ((rnd - 0.5) * 0.25);
        float size = mix(0.01, 0.03, rnd);
        float pd = length(uv - pPos);
        float pulse = 0.65 + 0.35 * sin((p + rnd) * 18.0);
        particles += exp(-pd * pd / (size * size)) * pulse;
    }
    particles *= particleStrength * beamSoft * (1.0 - p);

    vec3 lit = darkBase + beamCore * 0.55 + rainbowGlow + vec3(particles * 0.45);
    lit = mix(darkBase, lit, reveal);
    lit = clamp(lit, 0.0, 1.0);

    vec3 finalRgb = mix(lit, texel.rgb, p);
    return vec4(finalRgb, texel.a);
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