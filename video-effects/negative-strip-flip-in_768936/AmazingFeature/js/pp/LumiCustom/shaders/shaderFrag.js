exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float stripCount; // = 5.0 [3.0, 10.0] // 竖向条带数量
uniform float flipDuration; // = 0.38 [0.15, 0.8] // 单条翻转持续占比
uniform float seamWidth; // = 0.006 [0.001, 0.02] // 白色缝隙宽度
uniform float flashStrength; // = 0.55 [0.0, 1.5] // 翻转闪白强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float count = max(1.0, floor(stripCount + 0.5));
    float idx = floor(vUv.x * count);
    idx = min(idx, count - 1.0);

    float uLocal = fract(vUv.x * count);

    float travel = max(0.0001, 1.0 - flipDuration);
    float start = (count <= 1.0) ? 0.0 : (idx / (count - 1.0)) * travel;
    float lp = clamp((p - start) / max(0.0001, flipDuration), 0.0, 1.0);
    float le = 1.0 - pow(1.0 - lp, 3.0);

    float angle = (1.0 - le) * 3.14159265;
    float c = cos(angle);

    float projectedLocal = 0.5 + (uLocal - 0.5) * c;
    float xMapped = (idx + projectedLocal) / count;

    vec2 uv = vec2(xMapped, vUv.y);
    uv = handleUVBounds(uv);

    vec4 src = texture2D(tDiffuse, uv);

    vec3 neg = 1.0 - src.rgb;
    vec3 baseColor = mix(neg, src.rgb, le);

    float flash = exp(-pow((lp - 0.5) / 0.12, 2.0)) * flashStrength * (1.0 - smoothstep(0.92, 1.0, lp));
    vec3 flashed = mix(baseColor, vec3(1.0), clamp(flash, 0.0, 1.0));

    float xm = fract(vUv.x * count);
    float edgeDist = min(xm, 1.0 - xm);
    float seamCore = 1.0 - smoothstep(0.0, seamWidth, edgeDist);
    float seamVisible = 1.0 - smoothstep(0.82, 1.0, p);
    float seamMask = seamCore * seamVisible;

    vec3 finalRgb = mix(flashed, vec3(1.0), seamMask);

    return vec4(finalRgb, src.a);
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