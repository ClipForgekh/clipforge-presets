exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float bandCount; // = 24.0 [8.0, 64.0] // 水平信号带数量
uniform float glitchAmount; // = 1.0 [0.0, 2.0] // 故障强度
uniform float rgbSplitStrength; // = 1.0 [0.0, 2.0] // RGB分离强度

varying vec2 vUv;

float easeCubicIn(float p) {
    return p * p * p;
}

float easeQuartOut(float p) {
    float q = 1.0 - p;
    return 1.0 - q * q * q * q;
}

float easeCubicInOut(float p) {
    return p < 0.5
        ? 4.0 * p * p * p
        : 1.0 - pow(-2.0 * p + 2.0, 3.0) * 0.5;
}

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    if (p < 0.33) {
        float t = p / 0.33;
        return 0.33 * easeCubicIn(t);
    } else if (p < 0.72) {
        float t = (p - 0.33) / 0.39;
        return 0.33 + 0.39 * easeQuartOut(t);
    } else {
        float t = (p - 0.72) / 0.28;
        return 0.72 + 0.28 * easeCubicInOut(t);
    }
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash21(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

vec4 effect(vec4 texel, float p) {
    float t1 = 0.153846; // 0.20s
    float t2 = 0.307692; // 0.40s
    float t3 = 0.500000; // 0.65s
    float t4 = 0.653846; // 0.85s
    float t5 = 0.807692; // 1.05s

    float bands = max(2.0, floor(bandCount));
    float bandIndex = floor(vUv.y * bands);
    float bandRnd = hash21(vec2(bandIndex, 17.13));

    float scaleY = 1.0;
    if (p < t1) {
        float k = easeCubicIn(p / t1);
        scaleY = mix(0.02, 0.35, k);
    } else if (p < t2) {
        float k = easeQuartOut((p - t1) / (t2 - t1));
        scaleY = mix(0.35, 1.03, k);
    } else if (p < t3) {
        float k = easeCubicInOut((p - t2) / (t3 - t2));
        scaleY = mix(1.03, 1.0, k);
    } else if (p < t4) {
        float k = easeCubicInOut((p - t3) / (t4 - t3));
        scaleY = mix(1.0, 0.96, k);
    } else if (p < t5) {
        float k = easeQuartOut((p - t4) / (t5 - t4));
        scaleY = mix(0.96, 1.0, k);
    } else {
        scaleY = 1.0;
    }

    float overshootPulse = exp(-pow((p - t2) / 0.045, 2.0));
    float hasOvershoot = step(0.62, bandRnd);
    float bandOvershoot = (bandRnd - 0.5) * 0.12 * overshootPulse * hasOvershoot * glitchAmount;

    float dispAmp = 0.0;
    if (p < t1) {
        dispAmp = mix(0.00, 0.06, easeCubicIn(p / t1));
    } else if (p < t2) {
        dispAmp = mix(0.06, 0.12, easeQuartOut((p - t1) / (t2 - t1)));
    } else if (p < t3) {
        dispAmp = mix(0.12, 0.015, easeCubicInOut((p - t2) / (t3 - t2)));
    } else {
        dispAmp = mix(0.015, 0.0, easeCubicInOut(clamp((p - t3) / (1.0 - t3), 0.0, 1.0)));
    }
    dispAmp *= glitchAmount;

    float frameJitter = floor(p * 180.0);
    float jitter = (hash21(vec2(bandIndex, frameJitter + 3.7)) * 2.0 - 1.0) * dispAmp;

    float scanPhase = clamp((p - t4) / (t5 - t4), 0.0, 1.0);
    float lineY = 1.0 - scanPhase;
    float lineMask = exp(-pow((vUv.y - lineY) / 0.008, 2.0));
    float scanJitter = lineMask * 0.02 * sin(vUv.y * 900.0 + p * 130.0) * glitchAmount;

    vec2 uv = vUv;
    uv.y = 0.5 + (uv.y - 0.5) * scaleY + bandOvershoot;
    uv.x += jitter + scanJitter;

    float splitAmp = 0.012 * rgbSplitStrength * glitchAmount;
    if (p < t3) {
        splitAmp *= (1.0 - easeCubicInOut(clamp((p - t2) / (t3 - t2), 0.0, 1.0)) * 0.75);
    } else {
        splitAmp *= (1.0 - easeQuartOut(clamp((p - t3) / (1.0 - t3), 0.0, 1.0)));
    }

    vec2 uvR = handleUVBounds(uv + vec2(splitAmp, 0.0));
    vec2 uvG = handleUVBounds(uv);
    vec2 uvB = handleUVBounds(uv - vec2(splitAmp, 0.0));

    vec4 rCol = texture2D(tDiffuse, uvR);
    vec4 gCol = texture2D(tDiffuse, uvG);
    vec4 bCol = texture2D(tDiffuse, uvB);

    vec4 col = vec4(rCol.r, gCol.g, bCol.b, gCol.a);

    float alpha;
    if (p < t1) {
        alpha = mix(0.0, 0.2, easeCubicIn(p / t1));
    } else if (p < t3) {
        alpha = mix(0.2, 0.82, easeQuartOut((p - t1) / (t3 - t1)));
    } else {
        alpha = mix(0.82, 1.0, easeCubicInOut(clamp((p - t3) / (1.0 - t3), 0.0, 1.0)));
    }

    float borderMask = getHardBoundaryMask(uv);
    col.a *= alpha * borderMask;

    if (p >= 0.9999) return texel;
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