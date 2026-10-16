exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blockSizeStart; // = 52.0 [12.0, 120.0] // 大像素初始网格密度
uniform float blinkRate; // = 96.0 [12.0, 240.0] // 二值闪烁速率
uniform float hueChaos; // = 1.25 [0.0, 2.0] // 色相扰动强度

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -0.3333333, 0.6666667, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec3 p = abs(fract(c.xxx + vec3(0.0, 0.6666667, 0.3333333)) * 6.0 - 3.0);
    vec3 rgb = clamp(p - 1.0, 0.0, 1.0);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

vec3 shiftHue(vec3 color, float shiftAmt) {
    vec3 hsv = rgb2hsv(color);
    hsv.x = fract(hsv.x + shiftAmt);
    return hsv2rgb(hsv);
}

vec4 effect(vec4 texel, float p) {
    float s0 = 1.0 / 12.0;
    float s1 = 2.0 / 3.0;
    float s2 = 5.0 / 6.0;

    if (p < s0) {
        return vec4(0.0, 0.0, 0.0, texel.a);
    }

    if (p < s1) {
        float t = clamp((p - s0) / (s1 - s0), 0.0, 1.0);

        float grid = mix(blockSizeStart, blockSizeStart * 0.58, t);
        vec2 cell = floor(vUv * grid);
        vec2 uvPix = (cell + 0.5) / grid;
        uvPix = handleUVBounds(uvPix);

        vec3 baseColor = texture2D(tDiffuse, uvPix).rgb;

        float blinkFrame = floor(t * blinkRate);
        float blinkRnd = hash21(cell + vec2(blinkFrame, blinkFrame * 1.37));
        float binary = step(0.5, blinkRnd);
        vec3 binaryColor = vec3(binary);

        float cellRnd = hash21(cell * 0.73 + 11.9);
        float violentShift = (1.0 - t) * hueChaos * (cellRnd * 2.0 - 1.0);
        vec3 shifted = shiftHue(baseColor, violentShift);

        vec3 quant = floor(shifted * 7.0) / 7.0;
        float remap = smoothstep(0.12, 0.72, t);
        vec3 remapped = mix(quant, baseColor, remap);

        float fromBinary = smoothstep(0.02, 0.42, t);
        vec3 col = mix(binaryColor, remapped, fromBinary);

        return vec4(clamp(col, 0.0, 1.0), texel.a);
    }

    if (p < s2) {
        float t = clamp((p - s1) / (s2 - s1), 0.0, 1.0);
        float fast = pow(t, 0.55);

        float coarseGrid = blockSizeStart * 0.52;
        float fineGrid = 420.0;
        float grid = mix(coarseGrid, fineGrid, fast);

        vec2 cell = floor(vUv * grid);
        vec2 uvPix = (cell + 0.5) / grid;
        uvPix = handleUVBounds(uvPix);

        vec4 pixelated = texture2D(tDiffuse, uvPix);
        float lockSharp = smoothstep(0.72, 1.0, t);
        return mix(pixelated, texel, lockSharp);
    }

    return texel;
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