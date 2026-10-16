exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform vec3 starColor; // = vec3(0.45, 0.82, 1.0) // 冰蓝星芒颜色
uniform float starIntensity; // = 1.0 [0.2, 2.0] // 星芒整体强度
uniform float blurMax; // = 10.0 [0.0, 20.0] // 初始最大模糊半径

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

vec3 adjustSaturation(vec3 color, float sat) {
    float l = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(l), color, sat);
}

vec4 blur9(sampler2D tex, vec2 uv, float radius) {
    if (radius <= 0.001) return texture2D(tex, uv);
    vec2 stepSize = vec2(radius * 0.0015, radius * 0.0015 / max(ratio, 0.0001));
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + vec2(-stepSize.x, -stepSize.y))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -stepSize.y))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + vec2(stepSize.x, -stepSize.y))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + vec2(-stepSize.x, 0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv)) * 4.0;
    c += texture2D(tex, handleUVBounds(uv + vec2(stepSize.x, 0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + vec2(-stepSize.x, stepSize.y))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, stepSize.y))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + vec2(stepSize.x, stepSize.y))) * 1.0;
    return c / 16.0;
}

vec2 getStartPos(float i) {
    float edge = mod(i, 4.0);
    float t = fract(i * 0.173 + 0.13);
    if (edge < 0.5) return vec2(t, -0.14);      // 下外侧
    if (edge < 1.5) return vec2(1.14, t);       // 右外侧
    if (edge < 2.5) return vec2(t, 1.14);       // 上外侧
    return vec2(-0.14, t);                      // 左外侧
}

vec2 bezier2(vec2 a, vec2 b, vec2 c, float t) {
    float u = 1.0 - t;
    return u * u * a + 2.0 * u * t * b + t * t * c;
}

float starShape(vec2 p, float size) {
    float r = length(p) / max(size, 0.0001);
    float core = exp(-r * 7.0);
    float rays = exp(-abs(p.x) / max(size * 0.22, 0.0001)) + exp(-abs(p.y) / max(size * 0.22, 0.0001));
    float diag = exp(-abs(p.x + p.y) / max(size * 0.35, 0.0001)) + exp(-abs(p.x - p.y) / max(size * 0.35, 0.0001));
    return core + 0.35 * rays + 0.18 * diag;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 1.0) return texel;

    float blurR = (1.0 - p) * blurMax;
    float baseBrightness = mix(0.15, 1.0, p);
    float baseSaturation = mix(0.7, 1.0, p);
    float baseScale = mix(0.9, 1.0, p);
    float baseAlpha = mix(0.3, 1.0, p);

    vec2 uvScaled = 0.5 + (vUv - 0.5) * baseScale;
    uvScaled = handleUVBounds(uvScaled);

    vec4 base = blur9(tDiffuse, uvScaled, blurR);
    base.rgb = adjustSaturation(base.rgb, baseSaturation) * baseBrightness;
    base.a *= baseAlpha * getHardBoundaryMask(vUv);

    const float phaseGatherEnd = 0.55;
    const float phaseExplodeEnd = 0.85;

    vec2 center = vec2(0.5);
    vec3 glowAccum = vec3(0.0);
    float glowAlpha = 0.0;

    for (int k = 0; k < 12; k++) {
        float fi = float(k);
        vec2 start = getStartPos(fi);

        vec2 mid = (start + center) * 0.5;
        vec2 dir = normalize(center - start);
        vec2 n = vec2(-dir.y, dir.x);
        float arcAmp = (0.08 + 0.08 * fract(fi * 0.37)) * (mod(fi, 2.0) < 1.0 ? 1.0 : -1.0);
        vec2 ctrl = mid + n * arcAmp;

        float tGather = clamp(p / phaseGatherEnd, 0.0, 1.0);
        vec2 posGather = bezier2(start, ctrl, center, tGather);

        vec2 explodeDir = normalize(vec2(cos(fi * 0.73 + 0.4), sin(fi * 1.11 + 1.3)));
        float tExplode = clamp((p - phaseGatherEnd) / (phaseExplodeEnd - phaseGatherEnd), 0.0, 1.0);
        vec2 posExplode = center + explodeDir * (0.5 * tExplode);

        vec2 pos = mix(posGather, posExplode, step(phaseGatherEnd, p));

        float sGather = mix(0.1, 0.8, tGather);
        float sFade = 1.0 - clamp((p - phaseGatherEnd) / (1.0 - phaseGatherEnd), 0.0, 1.0);
        float starSizeVal = 0.035 * sGather * sFade;

        float gGather = mix(2.8, 4.0, tGather);
        float gFade = 1.0 - clamp((p - phaseExplodeEnd) / (1.0 - phaseExplodeEnd), 0.0, 1.0);
        float glowStrength = gGather * gFade * starIntensity;

        vec2 dp = vUv - pos;
        if (ratio > 1.0) dp.y /= ratio; else dp.x *= ratio;

        float st = starShape(dp, starSizeVal);
        float trail = exp(-length(dp - dir * 0.03) / max(starSizeVal * 1.8, 0.0001)) * 0.25;
        float a = (st + trail) * glowStrength * 0.14;

        glowAccum += starColor * a;
        glowAlpha += a;
    }

    float burst = exp(-pow((p - phaseGatherEnd) / 0.09, 2.0));
    vec2 dc = vUv - center;
    if (ratio > 1.0) dc.y /= ratio; else dc.x *= ratio;
    float radial = exp(-length(dc) * 4.0);
    vec3 collisionGlow = starColor * burst * radial * 1.2 * starIntensity;

    vec3 finalRgb = base.rgb + glowAccum + collisionGlow;
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    float starFadeOut = 1.0 - smoothstep(0.82, 1.0, p);
    float finalA = clamp(base.a + glowAlpha * 0.08 * starFadeOut + burst * radial * 0.25 * starFadeOut, 0.0, 1.0);

    return vec4(finalRgb, finalA);
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