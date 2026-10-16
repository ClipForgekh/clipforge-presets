exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float sliceCount; // = 12.0 [4.0, 24.0] // 竖向切片数量
uniform float sliceDepth; // = 2.0 [0.0, 4.0] // 切片前后层次强度
uniform float flareStrength; // = 1.0 [0.0, 2.0] // 金色棱镜光强
uniform float rollStrength; // = -2.0 [-10.0, 10.0] // 相机滚转角度(度)
uniform vec3 glowColor; // = vec3(1.0, 0.82, 0.55) // 金色辉光颜色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float expoOut(float t) {
    return (t >= 1.0) ? 1.0 : (1.0 - pow(2.0, -10.0 * t));
}

float quadOut(float t) {
    return 1.0 - (1.0 - t) * (1.0 - t);
}

float backOut(float t) {
    float s = 1.70158;
    float x = t - 1.0;
    return 1.0 + x * x * ((s + 1.0) * x + s);
}

vec4 effect(vec4 texel, float p) {
    float t0 = clamp(p / 0.25, 0.0, 1.0);
    float t1 = clamp((p - 0.25) / 0.40, 0.0, 1.0);
    float t2 = clamp((p - 0.65) / 0.35, 0.0, 1.0);

    float blackOpacity = 1.0 - expoOut(t0);

    float camRoll = radians(rollStrength) * (1.0 - p);
    float cs = cos(camRoll);
    float sn = sin(camRoll);
    float zoom = 1.04 - 0.04 * p;

    vec2 centered = vUv - 0.5;
    vec2 camUV = vec2(
        dot(centered, vec2(cs, -sn)),
        dot(centered, vec2(sn,  cs))
    );
    camUV = 0.5 + camUV * zoom;

    float sc = max(sliceCount, 1.0);
    float idx = floor(vUv.x * sc);
    float idNorm = idx / max(sc - 1.0, 1.0);
    float dir = mod(idx, 2.0) * 2.0 - 1.0;

    float delay = idNorm * 0.22;
    float localT = clamp((t1 - delay) / max(1.0 - delay, 0.0001), 0.0, 1.0);
    float lockT = backOut(localT);

    float xOffset = (1.0 - lockT) * dir * sliceDepth * 0.12;
    vec2 rawUV = camUV + vec2(xOffset, 0.0);
    vec2 sampleUV = handleUVBounds(rawUV);

    float borderMask = getHardBoundaryMask(rawUV);
    vec4 img = texture2D(tDiffuse, sampleUV);

    float planeAlpha = backOut(t1) * lockT;
    float imageAlpha = img.a * planeAlpha * borderMask;

    float lightEarly = expoOut(t0);
    float lightMid = mix(1.0, 0.8, t1);
    float lightLate = 1.0 - quadOut(t2);
    float lm1 = step(p, 0.25);
    float lm2 = step(0.25, p) * step(p, 0.65);
    float lm3 = step(0.65, p);
    float lightAlpha = (lm1 * lightEarly + lm2 * lightMid + lm3 * lightLate) * flareStrength;

    float sweep = p * 2.8;
    float streakA = pow(max(0.0, sin((vUv.x * ratio * 18.0 - sweep * 8.0))), 6.0);
    float streakB = pow(max(0.0, sin((vUv.x * ratio * 11.0 + sweep * 5.5))), 8.0) * 0.7;
    float leak = smoothstep(1.05, 0.0, length(vUv - vec2(0.5, 0.56)) * 1.7);

    vec3 prism = mix(glowColor, vec3(0.75, 0.85, 1.0), 0.25 + 0.25 * sin((vUv.x + vUv.y) * 14.0));
    vec3 overlay = prism * (streakA + streakB + leak * 0.6) * lightAlpha * 0.55;

    vec3 sceneRgb = img.rgb * imageAlpha + overlay;
    float sceneA = clamp(imageAlpha + lightAlpha * 0.25, 0.0, 1.0);

    float visible = 1.0 - blackOpacity;
    vec4 outCol = vec4(sceneRgb * visible, sceneA * visible);

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