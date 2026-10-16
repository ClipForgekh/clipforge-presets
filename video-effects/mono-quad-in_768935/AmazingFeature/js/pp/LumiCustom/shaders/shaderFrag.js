exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float dropHeight; // = 1.25 [0.5, 2.0] // 分块从上方下落的起始高度
uniform float bounceStrength; // = 0.035 [0.0, 0.12] // 落地回弹强度
uniform float flashStrength; // = 0.75 [0.0, 1.5] // 落地白闪强度
uniform float seamGap; // = 0.035 [0.0, 0.12] // 分块之间初始缝隙

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float easeOutCubic(float x) {
    float t = clamp(x, 0.0, 1.0);
    return 1.0 - pow(1.0 - t, 3.0);
}

float landingBounce(float t, float amp) {
    float u = clamp((t - 0.72) / 0.28, 0.0, 1.0);
    float wave = sin(u * 3.14159265 * 2.0) * (1.0 - u);
    return wave * amp;
}

float landingFlash(float t) {
    float a = smoothstep(0.78, 0.95, t);
    float b = 1.0 - smoothstep(0.95, 1.0, t);
    return a * b;
}

vec4 effect(vec4 texel, float p) {
    float p0 = clamp((p - 0.00) / 0.34, 0.0, 1.0); // top-left
    float p1 = clamp((p - 0.20) / 0.34, 0.0, 1.0); // top-right
    float p2 = clamp((p - 0.40) / 0.34, 0.0, 1.0); // bottom-left
    float p3 = clamp((p - 0.60) / 0.34, 0.0, 1.0); // bottom-right

    float e0 = easeOutCubic(p0);
    float e1 = easeOutCubic(p1);
    float e2 = easeOutCubic(p2);
    float e3 = easeOutCubic(p3);

    float colorRestore = smoothstep(0.78, 1.0, p);
    float gap = (1.0 - colorRestore) * seamGap;
    float panelSize = 0.5 - gap;

    vec2 baseCenter[4];
    baseCenter[0] = vec2(0.25, 0.75);
    baseCenter[1] = vec2(0.75, 0.75);
    baseCenter[2] = vec2(0.25, 0.25);
    baseCenter[3] = vec2(0.75, 0.25);

    vec2 srcOrigin[4];
    srcOrigin[0] = vec2(0.0, 0.5);
    srcOrigin[1] = vec2(0.5, 0.5);
    srcOrigin[2] = vec2(0.0, 0.0);
    srcOrigin[3] = vec2(0.5, 0.0);

    float ep[4];
    ep[0] = e0; ep[1] = e1; ep[2] = e2; ep[3] = e3;

    float pp[4];
    pp[0] = p0; pp[1] = p1; pp[2] = p2; pp[3] = p3;

    vec4 outCol = vec4(0.0);

    for (int i = 0; i < 4; i++) {
        float settle = ep[i];
        float yDrop = (1.0 - settle) * dropHeight + landingBounce(pp[i], bounceStrength);
        vec2 center = baseCenter[i] + vec2(0.0, yDrop);

        vec2 local = vUv - center;
        float inside = step(abs(local.x), panelSize * 0.5) * step(abs(local.y), panelSize * 0.5);

        if (inside > 0.5) {
            vec2 local01 = local / panelSize + 0.5;
            vec2 srcUV = srcOrigin[i] + local01 * 0.5;
            srcUV = handleUVBounds(srcUV);

            vec4 c = texture2D(tDiffuse, srcUV);
            float gray = dot(c.rgb, vec3(0.299, 0.587, 0.114));
            vec3 bw = vec3(gray);
            vec3 baseRgb = mix(bw, c.rgb, colorRestore);

            float f = landingFlash(pp[i]) * flashStrength;
            vec3 flashed = clamp(baseRgb + vec3(f), 0.0, 1.0);

            outCol = vec4(flashed, c.a);
        }
    }

    if (p >= 0.9999) return texel;
    return outCol;
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