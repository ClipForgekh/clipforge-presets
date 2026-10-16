exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float bladeWidth; // = 0.014 [0.004, 0.05] // 光刃宽度
uniform float blurStrength; // = 0.02 [0.0, 0.08] // 斜向拉伸模糊强度
uniform float maxGlow; // = 2.8 [0.0, 4.0] // 光刃峰值发光强度
uniform float particleDensity; // = 140.0 [40.0, 260.0] // 金箔粒子密度
uniform float particleRise; // = 0.35 [0.0, 1.0] // 金箔上飘速度
uniform vec3 bladeColor; // = vec3(1.0, 0.78, 0.35) // 暖金色光刃颜色

varying vec2 vUv;

float tween(float p) {
    return 0.5 - 0.5 * cos(3.14159265 * p);
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

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec4 diagonalBlur(vec2 uv, float amount) {
    vec2 dir = normalize(vec2(1.0, 1.0 / max(ratio, 0.0001)));
    vec2 stepV = dir * amount;
    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv - stepV * 2.0)) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - stepV * 1.0)) * 0.23;
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 0.30;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepV * 1.0)) * 0.23;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepV * 2.0)) * 0.12;
    return c;
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5, 0.5);
    vec2 q = getSDFCoordinate(vUv, center);
    float maxR = length(getSDFCoordinate(vec2(0.0, 0.0), center));

    float sweepMask = 0.0;
    float bladeAccum = 0.0;

    for (int i = 0; i < 8; i++) {
        float fi = float(i);
        float baseAng = fi * 0.78539816339;
        float spinDir = (mod(fi, 2.0) < 1.0) ? 1.0 : -1.0;
        float spiral = (0.25 + 0.95 * p * (1.0 - p) * 2.0 + 0.25 * p) * spinDir;
        float ang = baseAng + spiral;

        vec2 dir = vec2(cos(ang), sin(ang));
        float along = dot(q, -dir);
        float ortho = abs(dot(q, vec2(-dir.y, dir.x)));

        float headPos = mix(maxR * 1.15, 0.0, p);
        float head = exp(-pow((along - headPos) / 0.045, 2.0));
        float core = exp(-pow(ortho / max(bladeWidth, 0.0001), 2.0));

        float blade = core * head * step(0.0, along);
        sweepMask = max(sweepMask, blade);
        bladeAccum += blade * (0.85 + 0.15 * sin(fi * 1.7 + p * 6.2831853));
    }

    float blurLocal = clamp((sweepMask * 0.9 + p * p) * p, 0.0, 1.0);
    vec4 blurTex = diagonalBlur(vUv, blurStrength * (0.5 + 1.8 * blurLocal));
    vec4 baseTex = mix(texel, blurTex, blurLocal);

    vec2 puv = vUv * particleDensity + vec2(0.0, p * particleRise * particleDensity * 0.35);
    vec2 cell = floor(puv);
    vec2 f = fract(puv) - 0.5;

    float rnd = hash12(cell);
    float spark = step(0.84, rnd);
    float shape = smoothstep(0.26, 0.02, length(f));
    float swept = smoothstep(0.08, 0.8, sweepMask + p * 0.55);
    float particle = spark * shape * swept * p * (1.0 - p);

    float glowRamp = clamp(p * 1.35, 0.0, 1.0) * maxGlow;
    vec3 glow = bladeColor * bladeAccum * glowRamp;
    vec3 foil = bladeColor * (1.2 + rnd * 0.6) * particle;

    float darken = 1.0 - 0.92 * p;
    vec3 rgb = baseTex.rgb * darken + glow + foil;
    rgb = clamp(rgb, 0.0, 1.0);

    float alpha = texel.a * (1.0 - p);
    return vec4(rgb, alpha);
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