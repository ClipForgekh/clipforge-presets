exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float displacementAmount; // = 0.18 [0.0, 0.4] // 最大水平切片位移（约0.18≈1920宽下120px）
uniform float rgbSplitAmount; // = 0.00625 [0.0, 0.03] // 初始RGB分离（约0.00625≈1920宽下12px）
uniform float noiseAmount; // = 0.16 [0.0, 0.5] // 数字噪声强度
uniform float scanlineAmount; // = 0.2 [0.0, 0.6] // 扫描线强度

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float rand(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

vec4 sampleSplit(vec2 baseUV, float splitUV) {
    vec2 uvR = baseUV + vec2(-splitUV, 0.0);
    vec2 uvG = baseUV;
    vec2 uvB = baseUV + vec2(splitUV, 0.0);

    vec2 cuvR = handleUVBounds(uvR);
    vec2 cuvG = handleUVBounds(uvG);
    vec2 cuvB = handleUVBounds(uvB);

    float mR = getHardBoundaryMask(uvR);
    float mG = getHardBoundaryMask(uvG);
    float mB = getHardBoundaryMask(uvB);

    float r = texture2D(tDiffuse, cuvR).r * mR;
    float g = texture2D(tDiffuse, cuvG).g * mG;
    float b = texture2D(tDiffuse, cuvB).b * mB;

    float a = texture2D(tDiffuse, cuvG).a * mG;
    return vec4(r, g, b, a);
}

vec4 effect(vec4 texel, float p) {
    float t = clamp(p, 0.0, 1.0);

    if (t < 0.05) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    if (t >= 0.75) {
        return texel;
    }

    float split = 0.0;
    float disp = 0.0;
    float nAmt = 0.0;
    float sAmt = 0.0;
    float mosaicAmt = 0.0;
    float visibility = 1.0;
    vec2 uv = vUv;

    float slices = 10.0;
    float sliceId = floor(vUv.y * slices);

    if (t < 0.25) {
        float lt = (t - 0.05) / 0.20;
        float flicker = step(0.5, sin(lt * 8.0 * 3.14159265) * 0.5 + 0.5);

        float dir = sign(rand(vec2(sliceId, floor(lt * 32.0) + 3.1)) - 0.5);
        float ampJitter = 0.5 + 0.5 * rand(vec2(sliceId * 1.7, floor(lt * 40.0) + 9.3));
        disp = displacementAmount * dir * ampJitter;
        split = rgbSplitAmount;
        nAmt = noiseAmount;
        sAmt = scanlineAmount;
        visibility = flicker;
    } else if (t < 0.45) {
        float lt = (t - 0.25) / 0.20;
        float stepLt = floor(lt * 6.0) / 6.0;

        float dir = sign(rand(vec2(sliceId, floor(stepLt * 24.0) + 5.7)) - 0.5);
        disp = displacementAmount * (1.0 - stepLt) * 0.7 * dir;
        split = mix(rgbSplitAmount, rgbSplitAmount * (4.0 / 12.0), stepLt);
        nAmt = noiseAmount * 0.7;
        sAmt = scanlineAmount * 0.8;
        mosaicAmt = 1.0;
    } else if (t < 0.60) {
        float lt = (t - 0.45) / 0.15;
        float burst = exp(-pow((lt - 0.35) * 6.0, 2.0));
        float shakeUV = (6.0 / 1920.0) * burst;
        float shakeDir = sign(sin(lt * 90.0));
        disp = shakeUV * shakeDir;
        split = mix(rgbSplitAmount * (4.0 / 12.0), rgbSplitAmount * 0.5, lt) * burst;
        nAmt = noiseAmount * burst;
        sAmt = scanlineAmount * burst;
    } else {
        float lt = (t - 0.60) / 0.15;
        disp = 0.0;
        split = mix(rgbSplitAmount * (4.0 / 12.0), 0.0, lt);
        nAmt = noiseAmount * (1.0 - lt);
        sAmt = scanlineAmount * (1.0 - lt);
    }

    uv.x += disp;
    vec4 col = sampleSplit(uv, split);

    if (mosaicAmt > 0.0) {
        vec2 patchCell = floor(vUv * vec2(48.0, 27.0));
        float patch = step(0.94, rand(patchCell + vec2(floor(t * 120.0), 13.0)));
        vec2 blockUV = floor(vUv * vec2(96.0, 54.0)) / vec2(96.0, 54.0);
        vec4 blockCol = sampleSplit(blockUV + vec2(disp, 0.0), split);
        col = mix(col, blockCol, patch * 0.85);
    }

    float scan = sin((vUv.y * 1080.0 / max(ratio, 0.0001)) * 3.14159265);
    float scanMask = 0.5 + 0.5 * scan;
    col.rgb *= (1.0 - sAmt * 0.35 * scanMask);

    float n = rand(vUv * vec2(1920.0, 1080.0) + vec2(floor(t * 240.0), 17.0)) - 0.5;
    col.rgb += n * nAmt;

    col.rgb = clamp(col.rgb, 0.0, 1.0);
    col.a *= visibility;

    return col;
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