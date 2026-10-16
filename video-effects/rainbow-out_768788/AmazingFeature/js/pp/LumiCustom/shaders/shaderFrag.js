exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform int deviceTier; // = 1 [0, 2] // 设备分层：0低端 1中端 2高端
uniform float frameTimeMs; // = 16.0 [0.0, 100.0] // 单帧耗时，>30ms时降级到Tier0
uniform float jitterAmount; // = 1.0 [0.0, 2.0] // 横向抖动强度
uniform float scatterAmount; // = 1.0 [0.0, 2.0] // 扫描线碎裂强度

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

vec3 hsv2rgb(vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

float expIn(float x) {
    return (x <= 0.0) ? 0.0 : pow(2.0, 10.0 * (x - 1.0));
}

float sinOut(float x) {
    return sin(x * 1.57079632679);
}

float ppTimeline(float t) {
    if (t < 0.3 || t > 0.7) return 0.0;
    if (t <= 0.55) return 0.75 * smoothstep(0.3, 0.55, t);
    return 0.75 * (1.0 - smoothstep(0.55, 0.7, t));
}

vec4 effect(vec4 texel, float t) {
    int effectiveTier = (frameTimeMs > 30.0) ? 0 : deviceTier;

    float glitch = 0.0;
    float opacity = 1.0;

    if (t < 0.2) {
        glitch = 0.0;
        opacity = 1.0;
    } else if (t < 0.5) {
        float p = (t - 0.2) / 0.3;
        glitch = 0.6 * expIn(p);
        opacity = 1.0;
    } else if (t < 0.75) {
        float p = (t - 0.5) / 0.25;
        glitch = 0.6 + 0.4 * expIn(p);
        opacity = mix(1.0, 0.3, expIn(p));
    } else {
        float p = (t - 0.75) / 0.25;
        glitch = 0.15 * (1.0 - p);
        opacity = mix(0.3, 0.0, sinOut(p));
    }

    if (effectiveTier == 0) {
        float simpleFade = smoothstep(0.2, 1.0, t);
        vec3 twoA = vec3(0.0, 1.0, 1.0);
        vec3 twoB = vec3(1.0, 0.0, 1.0);
        float b = step(0.5, fract(floor(vUv.x * 18.0) * 0.5 + t * 3.0));
        vec3 tint2 = mix(twoA, twoB, b);
        float tintAmt = 0.15 * smoothstep(0.2, 0.75, t);
        vec3 rgb2 = mix(texel.rgb, texel.rgb * tint2, tintAmt);
        float a2 = texel.a * (1.0 - simpleFade);
        return vec4(rgb2 * a2, a2);
    }

    float density = mix(8.0, 90.0, glitch);
    float bandId = floor(vUv.x * density);
    float lineId = floor(vUv.y * (220.0 + 480.0 * glitch));
    float nBand = hash12(vec2(bandId, 19.7));
    float nLine = hash12(vec2(lineId, bandId + floor(t * 300.0)));

    float j = (nLine * 2.0 - 1.0) * 0.045 * glitch * jitterAmount;
    j += sin(vUv.y * 300.0 + bandId * 0.21) * 0.01 * glitch;

    float scatterGate = step(0.55 - 0.5 * glitch, nLine);
    float scatterShift = (hash12(vec2(lineId, bandId + 77.0)) * 2.0 - 1.0) * 0.06 * glitch * scatterAmount * scatterGate;

    vec2 uv = vUv;
    uv.x += j + scatterShift;
    uv = handleUVBounds(uv);

    vec4 src = texture2D(tDiffuse, uv);

    float sweepSpeed = mix(0.7, 3.2, glitch);
    float hue = fract(bandId * 0.017 + t * sweepSpeed + nBand * 0.35);
    vec3 fullSpectrum = hsv2rgb(vec3(hue, 0.95, 1.0));

    vec3 cCyan = vec3(0.0, 1.0, 1.0);
    vec3 cMagenta = vec3(1.0, 0.0, 1.0);
    vec3 cYellow = vec3(1.0, 1.0, 0.0);
    vec3 cLime = vec3(0.6, 1.0, 0.0);
    float q = fract(bandId * 0.11 + t * 2.0);
    vec3 quad = (q < 0.25) ? cCyan : (q < 0.5) ? cMagenta : (q < 0.75) ? cYellow : cLime;

    vec3 tint = mix(quad, fullSpectrum, 0.65);
    float tintAmt = clamp(0.2 + 0.65 * glitch, 0.0, 0.9);
    vec3 rgb = mix(src.rgb, src.rgb * tint, tintAmt);

    float fragKeep = 1.0 - step(0.78 + 0.18 * (1.0 - glitch), hash12(vec2(lineId + floor(t * 500.0), bandId + 13.0)));
    rgb *= mix(1.0, fragKeep, 0.6 * glitch);

    float pp = ppTimeline(t);
    if (effectiveTier >= 1) {
        vec2 off = vec2(0.0015 * pp, 0.0);
        vec3 ca;
        ca.r = texture2D(tDiffuse, handleUVBounds(uv + off)).r;
        ca.g = src.g;
        ca.b = texture2D(tDiffuse, handleUVBounds(uv - off)).b;
        rgb = mix(rgb, ca, 0.35 * pp);
    }
    if (effectiveTier >= 2) {
        float luma = dot(rgb, vec3(0.299, 0.587, 0.114));
        vec3 glow = tint * smoothstep(0.55, 1.0, luma) * (0.35 * pp);
        rgb += glow;
    }

    float finalAlpha = src.a * opacity;
    if (t >= 0.999) finalAlpha = 0.0;

    return vec4(rgb * finalAlpha, finalAlpha);
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