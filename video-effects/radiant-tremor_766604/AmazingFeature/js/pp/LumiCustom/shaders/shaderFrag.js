exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform vec3 lightColor; // = vec3(1.0, 0.6, 0.2) // 丁达尔光束颜色
uniform float maxBlur; // = 50.0 [20.0, 80.0] // 最大模糊半径
uniform float parallaxStrength; // = 0.1 [0.01, 0.2] // 视差位移强度
uniform float particleDensity; // = 120.0 [50.0, 200.0] // 微尘粒子密度

varying vec2 vUv;

float tween(float progress) {
    // 正弦缓出曲线，自然平滑适合短动画
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453);
}

vec4 gaussianBlur(sampler2D tex, vec2 uv, float blurStrength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    
    float kernel[25];
    kernel[0] = 1.0; kernel[1] = 4.0; kernel[2] = 6.0; kernel[3] = 4.0; kernel[4] = 1.0;
    kernel[5] = 4.0; kernel[6] = 16.0; kernel[7] = 24.0; kernel[8] = 16.0; kernel[9] = 4.0;
    kernel[10] = 6.0; kernel[11] = 24.0; kernel[12] = 36.0; kernel[13] = 24.0; kernel[14] = 6.0;
    kernel[15] = 4.0; kernel[16] = 16.0; kernel[17] = 24.0; kernel[18] = 16.0; kernel[19] = 4.0;
    kernel[20] = 1.0; kernel[21] = 4.0; kernel[22] = 6.0; kernel[23] = 4.0; kernel[24] = 1.0;
    
    float baseStep = 0.001 * blurStrength;
    vec2 stepSize = vec2(baseStep, baseStep / ratio);
    
    for (int i = -2; i <= 2; i++) {
        for (int j = -2; j <= 2; j++) {
            float weight = kernel[(i + 2) * 5 + (j + 2)];
            vec2 offset = vec2(float(i) * stepSize.x, float(j) * stepSize.y);
            vec2 sampleUV = handleUVBounds(uv + offset);
            color += texture2D(tex, sampleUV) * weight;
            totalWeight += weight;
        }
    }
    
    return color / totalWeight;
}

float calcDustParticles(vec2 uv, float progress) {
    float particles = 0.0;
    vec2 pUV = uv * particleDensity;
    pUV.y += progress * 6.0;
    vec2 cell = floor(pUV);
    vec2 cellUV = fract(pUV);
    
    float r = random(cell);
    if (r < 0.12) {
        float size = 0.15 + r * 0.3;
        particles += smoothstep(size, 0.0, length(cellUV - 0.5)) * r;
    }
    
    return particles * (1.0 - tween(progress));
}

float calcGodRay(vec2 uv, float progress) {
    float ray = 0.0;
    vec2 dirs[4];
    dirs[0] = normalize(vec2(-1.0, -1.0));
    dirs[1] = normalize(vec2(1.0, -1.0));
    dirs[2] = normalize(vec2(-1.0, 1.0));
    dirs[3] = normalize(vec2(1.0, 1.0));
    
    for (int i = 0; i < 4; i++) {
        float proj = dot(uv - 0.5, dirs[i]);
        ray += smoothstep(0.0, 0.8, proj) * 0.25;
    }
    
    return ray * (1.0 - tween(progress)) * 0.8;
}

vec4 effect(vec4 texel, float progress) {
    // 三层错落衰减进度 前景>中景>背景
    float fgProgress = tween(clamp(progress / 0.6, 0.0, 1.0));
    float mgProgress = tween(clamp((progress - 0.15) / 0.7, 0.0, 1.0));
    float bgProgress = tween(clamp((progress - 0.3) / 0.7, 0.0, 1.0));
    
    // 前景层计算
    float fgScale = 1.0 + 0.4 * (1.0 - fgProgress);
    vec2 fgOffset = (vec2(random(vec2(fgProgress, 0.1)) - 0.5, random(vec2(0.2, fgProgress)) - 0.5)) * parallaxStrength * (1.0 - fgProgress);
    vec2 fgUV = 0.5 + (vUv - 0.5 + fgOffset) * fgScale;
    fgUV = handleUVBounds(fgUV);
    float fgBlur = maxBlur * (1.0 - fgProgress);
    vec4 fgColor = gaussianBlur(tDiffuse, fgUV, fgBlur, ratio);
    
    // 中景层计算
    float mgScale = 1.0 + 0.25 * (1.0 - mgProgress);
    vec2 mgOffset = (vec2(random(vec2(mgProgress, 0.3)) - 0.5, random(vec2(0.4, mgProgress)) - 0.5)) * parallaxStrength * 0.6 * (1.0 - mgProgress);
    vec2 mgUV = 0.5 + (vUv - 0.5 + mgOffset) * mgScale;
    mgUV = handleUVBounds(mgUV);
    float mgBlur = 35.0 * (1.0 - mgProgress);
    vec4 mgColor = gaussianBlur(tDiffuse, mgUV, mgBlur, ratio);
    
    // 背景层计算
    float bgScale = 1.0 + 0.1 * (1.0 - bgProgress);
    vec2 bgOffset = (vec2(random(vec2(bgProgress, 0.5)) - 0.5, random(vec2(0.6, bgProgress)) - 0.5)) * parallaxStrength * 0.3 * (1.0 - bgProgress);
    vec2 bgUV = 0.5 + (vUv - 0.5 + bgOffset) * bgScale;
    bgUV = handleUVBounds(bgUV);
    float bgBlur = 20.0 * (1.0 - bgProgress);
    vec4 bgColor = gaussianBlur(tDiffuse, bgUV, bgBlur, ratio);
    
    // 三层Add混合
    vec4 layeredColor = bgColor * 0.3 + mgColor * 0.3 + fgColor * 0.4;
    // 恢复亮度饱和度
    vec3 adjustedColor = layeredColor.rgb * 2.8 * 1.9;
    adjustedColor = mix(adjustedColor, texel.rgb, progress);
    
    // 叠加丁达尔光和微尘
    float godRay = calcGodRay(vUv, progress);
    float dust = calcDustParticles(vUv, progress);
    vec3 finalRGB = adjustedColor + godRay * lightColor + dust * lightColor * 0.6;
    
    // 最终平滑过渡到原图
    return mix(vec4(finalRGB, layeredColor.a), texel, smoothstep(0.9, 1.0, progress));
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