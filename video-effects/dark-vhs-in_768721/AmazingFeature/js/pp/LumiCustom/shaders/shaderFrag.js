exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float tearAmount; // = 0.08 [0.0, 0.2] // VHS横向撕裂强度
uniform float bandCount; // = 90.0 [20.0, 200.0] // 跟踪噪波条带密度
uniform float chromaAmount; // = 0.008 [0.0, 0.02] // 色差强度
uniform float glowAmount; // = 0.12 [0.0, 0.5] // 柔和辉光强度

float getScanline(vec2 uv, float density, float amp) {
    float s = sin((uv.y + uv.x * 0.03) * density);
    return 1.0 - amp * (0.5 + 0.5 * s);
} 

float getVignette(vec2 uv, float strength) {
    vec2 d = uv - 0.5;
    float r = dot(d, d) * 2.2;
    return clamp(1.0 - r * strength, 0.0, 1.0);
} 

vec2 getCRTBendUV(vec2 uv, float amount) {
    vec2 p = uv * 2.0 - 1.0;
    float r2 = dot(p, p);
    p *= 1.0 + r2 * amount;
    return p * 0.5 + 0.5;
}

float getNoise(vec2 uv, float t) {
    return fract(sin(dot(uv + t, vec2(12.9898, 78.233))) * 43758.5453);
} 

varying vec2 vUv;

float tween(float p) {
    return clamp(p, 0.0, 1.0);
}

float easeExpoOut(float t) {
    return (t >= 1.0) ? 1.0 : (1.0 - pow(2.0, -10.0 * t));
}

float easeSineInOut(float t) {
    return 0.5 * (1.0 - cos(3.14159265 * t));
}

float easeQuadOut(float t) {
    return 1.0 - (1.0 - t) * (1.0 - t);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash(float n) {
    return fract(sin(n) * 43758.5453123);
}

vec4 effect(vec4 texel, float p) {
    p = clamp(p, 0.0, 1.0);

    float scaleY = 1.0;
    if (p < 0.16) {
        float t0 = p / 0.16;
        float openT = t0 * t0;
        scaleY = max(0.0001, openT);
    }

    float fxWeight = 1.0 - smoothstep(0.60, 0.82, p);

    float tear = 0.0;
    if (p < 0.22) {
        float t0 = p / 0.22;
        tear = 0.55 + 0.75 * easeExpoOut(t0);
    } else if (p < 0.55) {
        float t1 = (p - 0.22) / 0.33;
        float osc = sin(t1 * 3.14159265 * 1.6);
        tear = 0.35 + 0.95 * osc * easeSineInOut(1.0 - abs(2.0 * t1 - 1.0));
    } else {
        float t2 = (p - 0.55) / 0.45;
        float fade = 1.0 - easeQuadOut(t2);
        tear = 0.32 * fade;
    }
    tear *= fxWeight;

    float halfVisible = 0.5 * max(scaleY, 0.0001);
    float revealMask = 1.0 - step(halfVisible, abs(vUv.y - 0.5));

    vec2 uv = vUv;
    uv.y = (vUv.y - 0.5) / max(scaleY, 0.0001) + 0.5;

    float boot = clamp(p / 0.09, 0.0, 1.0);
    float bootFlash = (1.0 - smoothstep(0.0, 0.65, boot)) * fxWeight;
    float bootBand = exp(-pow((vUv.y - 0.5) / mix(0.005, 0.26, boot), 2.0));

    vec2 crtUV = getCRTBendUV(uv, 0.12 * fxWeight);

    float bandIndex = floor(vUv.y * (bandCount * 1.35) + p * 95.0);
    float bandRnd = hash(bandIndex * 1.37 + 17.0);
    float bandGate = step(0.42, hash(bandIndex * 2.11 + floor(p * 240.0)));
    float lineJitter = sin(vUv.y * 440.0 + p * 320.0) * 0.0034 * tear;
    float trackingShift = (bandRnd * 2.0 - 1.0) * (tearAmount * 1.45) * tear * bandGate;

    crtUV.x += trackingShift + lineJitter;
    vec2 sampleUV = handleUVBounds(crtUV);

    float envWSW = sin(p * 3.14159265);
    float ca = chromaAmount * 1.7 * fxWeight * (0.55 * tear + 0.65 * envWSW + 0.45);

    vec2 caOffset = vec2(ca, 0.0);
    vec4 cR = texture2D(tDiffuse, handleUVBounds(sampleUV + caOffset));
    vec4 cG = texture2D(tDiffuse, sampleUV);
    vec4 cB = texture2D(tDiffuse, handleUVBounds(sampleUV - caOffset));
    vec3 rgb = vec3(cR.r, cG.g, cB.b);

    float g = glowAmount * 1.55 * fxWeight * (0.45 + 0.55 * envWSW) * (0.45 + 0.85 * tear);
    vec2 gx = vec2(0.0032, 0.0);
    vec2 gy = vec2(0.0, 0.0032 / max(ratio, 0.0001));
    vec3 glow = (
        texture2D(tDiffuse, handleUVBounds(sampleUV + gx)).rgb +
        texture2D(tDiffuse, handleUVBounds(sampleUV - gx)).rgb +
        texture2D(tDiffuse, handleUVBounds(sampleUV + gy)).rgb +
        texture2D(tDiffuse, handleUVBounds(sampleUV - gy)).rgb
    ) * 0.25;

    rgb = mix(rgb, glow, g);

    float scanline = getScanline(vUv, 1200.0, (0.13 + 0.10 * (1.0 - p)) * fxWeight);
    float vignette = getVignette(vUv, 0.95 * fxWeight);
    float noise = (getNoise(vUv * vec2(960.0, 540.0), floor(p * 180.0)) - 0.5) * 0.055 * fxWeight;

    rgb = mix(rgb, rgb * scanline, fxWeight);
    rgb = mix(rgb, rgb * vignette, fxWeight);
    rgb += noise;
    rgb += bootFlash * bootBand * vec3(1.05, 1.12, 1.28);

    vec3 cleanRgb = texel.rgb;
    rgb = mix(cleanRgb, rgb, fxWeight);

    float borderMask = mix(1.0, getHardBoundaryMask(crtUV), fxWeight);
    float fxAlpha = cG.a * revealMask * borderMask;
    float alpha = mix(texel.a, fxAlpha, fxWeight);

    return vec4(rgb, alpha);
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