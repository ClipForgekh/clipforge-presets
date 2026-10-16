exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float flyDistance; // = 1.6 [0.5, 3.0] // 对角飞离距离
uniform float scanlineDensity; // = 720.0 [120.0, 2000.0] // 扫描线密度
uniform float gapSize; // = 0.08 [0.0, 0.25] // 像素单元间隔
uniform float flashPoint; // = 0.83 [0.6, 0.98] // 闪屏触发点
uniform float flashWidth; // = 0.015 [0.003, 0.08] // 闪屏持续宽度
uniform vec3 darkColor; // = vec3(0.18, 0.26, 0.14) // GameBoy深色
uniform vec3 lightColor; // = vec3(0.76, 0.86, 0.52) // GameBoy浅色
uniform vec3 flashColor; // = vec3(0.62, 1.00, 0.45) // 怀旧亮绿闪屏

varying vec2 vUv;

float tween(float p) {
    return p * p * p * p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash12(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

mat2 rot2(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}

float heartSDFLocal(vec2 p) {
    p.x = abs(p.x);
    if (p.y + p.x > 1.0) {
        vec2 q = p - vec2(0.25, 0.75);
        return length(q) - 0.35355339;
    }
    float d1 = dot(p - vec2(0.0, 1.0), p - vec2(0.0, 1.0));
    float d2 = dot(p - vec2(0.5, 0.5), p - vec2(0.5, 0.5));
    return sqrt(min(d1, d2)) * sign(p.x - p.y);
}

vec3 toGameBoy(vec3 color, vec2 uv) {
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    float d = (hash12(floor(uv * vec2(14.0, 15.0))) - 0.5) * 0.10;
    float tone = step(0.5, luma + d);
    vec3 duo = mix(darkColor, lightColor, tone);

    float sl = 0.88 + 0.12 * step(0.5, fract(uv.y * scanlineDensity));
    return duo * sl;
}

vec4 effect(vec4 texel, float p) {
    if (p <= 0.00001) return texel;

    float t = clamp(p, 0.0, 1.0);

    if (t >= flashPoint + flashWidth) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    vec2 grid = vec2(14.0, 15.0);
    vec2 cellId = floor(vUv * grid);
    vec2 cellUV = fract(vUv * grid);

    float r = hash12(cellId + 1.37);
    vec2 dir;
    if (r < 0.25) dir = normalize(vec2(-1.0,  1.0));
    else if (r < 0.5) dir = normalize(vec2( 1.0,  1.0));
    else if (r < 0.75) dir = normalize(vec2(-1.0, -1.0));
    else dir = normalize(vec2(1.0, -1.0));

    vec2 sourceUV = vUv - dir * (flyDistance * t);
    float srcMask = getHardBoundaryMask(sourceUV);
    vec2 safeUV = handleUVBounds(sourceUV);

    vec2 srcCell = floor(safeUV * grid);
    vec2 srcCenter = (srcCell + 0.5) / grid;
    vec4 srcTexel = texture2D(tDiffuse, srcCenter);

    vec3 gb = toGameBoy(srcTexel.rgb, vUv);

    vec2 superGrid = vec2(8.0, 4.0);
    vec2 superId = floor(vUv * superGrid);
    vec2 superUV = fract(vUv * superGrid) * 2.0 - 1.0;

    float ang = hash12(superId + 4.21) * 6.2831853;
    float hs = mix(0.55, 0.95, hash12(superId + 8.73));
    vec2 hp = rot2(ang) * (superUV / hs);
    hp.y += 0.28;
    float h = 1.0 - smoothstep(-0.03, 0.03, heartSDFLocal(hp));
    float heartEnabled = step(hash12(superId + 2.11), 1.0);
    float heartMask = h * heartEnabled;

    float debrisMask = step(gapSize, cellUV.x) * step(gapSize, cellUV.y) *
                       step(cellUV.x, 1.0 - gapSize) * step(cellUV.y, 1.0 - gapSize);

    float elementMask = mix(debrisMask, 1.0, step(0.01, heartMask));

    float brightnessFade = 1.0 - t;
    vec3 outRgb = gb * brightnessFade;

    float alphaFade = 1.0 - t;
    float outA = srcTexel.a * srcMask * elementMask * alphaFade;

    float flashPulse = step(flashPoint, t) * (1.0 - step(flashPoint + flashWidth, t));
    outRgb = mix(outRgb, flashColor, flashPulse);
    outA = mix(outA, 1.0, flashPulse);

    return vec4(outRgb, outA);
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