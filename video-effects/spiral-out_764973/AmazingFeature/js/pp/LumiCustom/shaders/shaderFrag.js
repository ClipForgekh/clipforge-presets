exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float curlStrength; // = 1.0 [0.2, 2.0] // 卷边强度
uniform float spiralTurns; // = 3.0 [0.5, 8.0] // 螺旋圈数
uniform float glowIntensity; // = 1.0 [0.0, 2.0] // 暖橙光带强度
uniform float scratchIntensity; // = 0.35 [0.0, 1.0] // 胶片划痕强度

varying vec2 vUv;

float tween(float p) {
    return p * p * p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec3 applySaturation(vec3 color, float sat) {
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(luma), color, sat);
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5, mix(0.5, 0.72, p));
    float edge = pow(abs(vUv.x - 0.5) * 2.0, 1.5);
    float curl = curlStrength * edge * p;

    float angle = spiralTurns * 6.2831853 * p * p;
    float s = sin(angle);
    float c = cos(angle);

    float scale = mix(1.0, 0.1, p);
    vec2 q = vUv - center;
    vec2 rq = vec2(c * q.x - s * q.y, s * q.x + c * q.y);

    vec2 rawUV = rq / max(scale, 0.0001) + vec2(0.5);
    rawUV.x -= sign(vUv.x - 0.5) * curl * 0.12;
    rawUV.y += curl * 0.04;

    vec2 uv = handleUVBounds(rawUV);
    float borderMask = getHardBoundaryMask(rawUV);

    vec2 vStep = vec2(0.0, (0.002 + 0.01 * p) / max(ratio, 0.0001));
    vec4 c0 = texture2D(tDiffuse, handleUVBounds(uv - vStep * 2.0));
    vec4 c1 = texture2D(tDiffuse, handleUVBounds(uv - vStep));
    vec4 c2 = texture2D(tDiffuse, uv);
    vec4 c3 = texture2D(tDiffuse, handleUVBounds(uv + vStep));
    vec4 c4 = texture2D(tDiffuse, handleUVBounds(uv + vStep * 2.0));
    vec4 blurCol = (c0 + 2.0 * c1 + 3.0 * c2 + 2.0 * c3 + c4) / 9.0;

    float blurAmt = clamp((curl * 0.8 + p * p * 0.6), 0.0, 1.0);
    vec4 filmCol = mix(c2, blurCol, blurAmt);
    filmCol.a *= borderMask;

    float satUp = smoothstep(0.0, 0.45, p);
    float satDown = smoothstep(0.45, 1.0, p);
    float sat = 1.0 + 0.5 * satUp - 1.1 * satDown;
    filmCol.rgb = applySaturation(filmCol.rgb, clamp(sat, 0.0, 1.5));

    float edgeGlow = glowIntensity * edge * p * (1.0 - 0.45 * p);
    float theta = atan(vUv.y - center.y, vUv.x - center.x);
    float rad = length(vUv - center);
    float spiralWave = sin(theta * 6.0 - angle * 2.0 + rad * 45.0);
    float spiralBand = smoothstep(0.55, 0.98, spiralWave) * p * (1.0 - 0.3 * p);
    vec3 warmGlow = vec3(1.0, 0.48, 0.12) * (edgeGlow * 0.55 + spiralBand * 0.7 * glowIntensity);

    float frame = floor(p * 120.0);
    float lineId = floor(vUv.x * 220.0);
    float scratchRand = hash21(vec2(lineId, frame * 0.73));
    float scratchLine = step(0.987, scratchRand) * (0.4 + 0.6 * hash21(vec2(lineId * 1.7, frame * 1.3)));
    float scratchFlicker = scratchLine * scratchIntensity * p;
    vec3 scratchColor = vec3(1.0, 0.9, 0.8) * scratchFlicker;

    float burst = smoothstep(0.82, 0.92, p) * (1.0 - smoothstep(0.92, 1.0, p));
    vec3 burstColor = vec3(1.0, 0.5, 0.15) * burst * 1.6 * glowIntensity;

    vec3 col = filmCol.rgb + warmGlow + scratchColor + burstColor;
    float fadeToBlack = 1.0 - smoothstep(0.76, 1.0, p);
    col *= fadeToBlack;

    float alphaFade = 1.0 - smoothstep(0.70, 1.0, p);
    float outAlpha = filmCol.a * alphaFade;

    return vec4(clamp(col, 0.0, 1.0), clamp(outAlpha, 0.0, 1.0));
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