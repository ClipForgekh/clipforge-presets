exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float crtStrength; // = 1.0 [0.0, 2.0] // CRT效果强度
uniform float borderSize; // = 0.05 [0.0, 0.2] // 边框厚度（5%建议）
uniform float cornerRadius; // = 0.12 [0.02, 0.3] // 圆角半径

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float rand(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float backOut(float t) {
    float s = 1.70158;
    t -= 1.0;
    return t * t * ((s + 1.0) * t + s) + 1.0;
}

float sdRoundRect(vec2 p, vec2 b, float r) {
    vec2 q = abs(p) - (b - vec2(r));
    return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - r;
}

vec4 effect(vec4 texel, float p) {
    float t0 = 0.15 / 2.2;
    float t1 = 1.3 / 2.2;
    float t2 = 1.7 / 2.2;

    float scale = 0.35;
    if (p < t0) {
        scale = 0.35;
    } else if (p < t1) {
        float k = (p - t0) / (t1 - t0);
        scale = mix(0.35, 1.06, backOut(k));
    } else if (p < t2) {
        float k = (p - t1) / (t2 - t1);
        scale = mix(1.06, 1.0, smoothstep(0.0, 1.0, k));
    } else {
        float k = (p - t2) / (1.0 - t2);
        scale = mix(1.0, 1.0, k);
    }

    float introStrength = 1.0 - p;

    vec2 localUV = (vUv - 0.5) / max(scale, 0.0001) + 0.5;

    float scan = sin(localUV.y * 900.0) * 0.5 + 0.5;
    float flicker = (rand(vec2(floor(p * 240.0), 13.7)) - 0.5) * 0.08;
    float wobble = sin((localUV.y * 40.0) + p * 24.0) * 0.004 * crtStrength * introStrength;
    vec2 distortedUV = localUV + vec2(wobble, 0.0);
    distortedUV = handleUVBounds(distortedUV);

    vec4 crtTexel = texture2D(tDiffuse, distortedUV);

    float crtMix = crtStrength * introStrength;
    crtTexel.rgb *= 1.0 - 0.12 * crtMix * scan;
    crtTexel.rgb *= 1.0 + flicker * crtMix;

    float grain = (rand(vUv * vec2(640.0, 360.0) + p * 173.0) - 0.5) * 0.10 * crtMix;
    crtTexel.rgb = clamp(crtTexel.rgb + grain, 0.0, 1.0);

    vec2 lp = localUV - 0.5;
    float aa = 0.003;
    float outer = sdRoundRect(lp, vec2(0.5), cornerRadius);
    float inner = sdRoundRect(lp, vec2(0.5 - borderSize), max(cornerRadius - borderSize, 0.001));

    float tvMask = 1.0 - smoothstep(0.0, aa, outer);
    float screenMask = 1.0 - smoothstep(0.0, aa, inner);
    float bezel = clamp(tvMask - screenMask, 0.0, 1.0);

    vec3 borderColor = vec3(0.03);
    vec3 tvColor = mix(borderColor, crtTexel.rgb, screenMask);

    float shapedAlpha = tvMask;
    vec4 shaped = vec4(tvColor, shapedAlpha);

    return mix(texel, shaped, introStrength);
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