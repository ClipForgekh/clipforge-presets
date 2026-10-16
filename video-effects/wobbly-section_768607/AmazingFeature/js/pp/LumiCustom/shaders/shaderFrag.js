exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float uBrightness; // = 0.78 [0.0, 2.0] // 基础亮度
uniform float u_chromatic; // = 0.010 [0.0, 0.03] // 色差峰值强度
uniform float uBrightnessWave; // = 0.20 [0.0, 0.5] // 亮度潮汐振幅
uniform float uWarpStrength; // = 0.035 [0.0, 0.12] // 鞍面扭曲强度

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    const float PI = 3.14159265;
    const float TAU = 6.28318530;

    vec2 grid = vec2(4.0, 3.0);
    vec2 cell = floor(vUv * grid);
    float k = cell.x + cell.y * grid.x;

    float wave = sin(TAU * p + 0.52 * k);
    float brightnessWave = sin(TAU * p + 0.35 * k);

    vec2 centered = vUv - 0.5;
    float saddle = centered.x * centered.x - centered.y * centered.y;

    float odd = mod(k, 2.0);
    float dir = mix(-1.0, 1.0, step(0.5, odd));

    vec2 uv = vUv;
    uv.x += dir * 0.008 * wave;
    uv.y += (0.012 + uWarpStrength * 0.25) * wave * (0.6 + 1.4 * saddle);
    uv.y += centered.y * 0.020 * wave;
    uv = handleUVBounds(uv);

    float chromaStart = 0.55 / 3.0;
    float chromaEnd = 2.45 / 3.0;
    float local = clamp((p - chromaStart) / max(chromaEnd - chromaStart, 0.0001), 0.0, 1.0);
    float chromaAmt = u_chromatic * sin(PI * local);

    vec2 chromaOffset = vec2(chromaAmt * (1.0 + 0.4 * abs(saddle)), 0.0);

    vec3 col;
    col.r = texture2D(tDiffuse, handleUVBounds(uv + chromaOffset)).r;
    col.g = texture2D(tDiffuse, uv).g;
    col.b = texture2D(tDiffuse, handleUVBounds(uv - chromaOffset)).b;

    float b = uBrightness + uBrightnessWave * brightnessWave;
    col *= b;
    col = clamp(col, 0.0, 1.0);

    return vec4(col, texel.a);
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