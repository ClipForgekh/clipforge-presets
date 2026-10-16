exports.source=`
//===begin_frag_code===
precision highp float;
#define PI 3.14159265359

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float chromaStrength; // = 0.16 [0.0, 0.5] // 边缘色散强度
uniform float blurStrength; // = 0.22 [0.0, 0.5] // 高光模糊强度
uniform float reuleauxRoundness; // = 0.3 [0.1, 0.8] // 三叶圆角系数
uniform float brightnessWave; // = 0.18 [0.0, 0.3] // 亮度波动幅度

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getAspectCorrectUV(vec2 uv) {
    vec2 aspectUV = uv - 0.5;
    if (ratio > 1.0) aspectUV.y /= ratio;
    else aspectUV.x *= ratio;
    return aspectUV + 0.5;
}

float reuleauxSDF(vec2 uv, vec2 center, float size, float roundness) {
    vec2 p = getAspectCorrectUV(uv) - center;
    p *= 2.0 / size;
    
    float k = sqrt(3.0);
    p.x = abs(p.x);
    if(p.y + p.x * k > 1.0) p = vec2(p.x * k - p.y, -p.x - p.y * k)/2.0;
    p.x -= clamp(p.x, -roundness, roundness);
    
    return length(p) * sign(p.y) * size * 0.5;
}

vec4 gaussianBlur(sampler2D tex, vec2 uv, float strength, float ratio) {
    vec4 color = vec4(0.0);
    float kernel[9];
    kernel[0] = 1.0;
    kernel[1] = 2.0;
    kernel[2] = 1.0;
    kernel[3] = 2.0;
    kernel[4] = 4.0;
    kernel[5] = 2.0;
    kernel[6] = 1.0;
    kernel[7] = 2.0;
    kernel[8] = 1.0;
    
    float totalWeight = 16.0;
    float step = strength * 0.005;
    vec2 stepSize = vec2(step, step / ratio);
    
    for(int i = -1; i <= 1; i++) {
        for(int j = -1; j <= 1; j++) {
            float weight = kernel[(i+1)*3 + (j+1)];
            vec2 offset = vec2(float(i)*stepSize.x, float(j)*stepSize.y);
            color += texture2D(tex, handleUVBounds(uv + offset)) * weight;
        }
    }
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float cycle = progress * 2.0 * PI;
    float effectCycle = 0.5 * (1.0 - cos(2.0 * cycle));
    
    vec2 center = vec2(0.5);
    float rotation = 2.0 * PI * progress;
    float s = sin(rotation);
    float c = cos(rotation);
    vec2 rotatedUV = vec2(dot(vUv - center, vec2(c, -s)), dot(vUv - center, vec2(s, c))) + center;
    
    float dist = reuleauxSDF(rotatedUV, center, 0.8, reuleauxRoundness);
    float edgeMask = smoothstep(0.0, 0.02, abs(dist) - 0.005);
    
    float chromaOffset = chromaStrength * effectCycle * edgeMask;
    float r = texture2D(tDiffuse, handleUVBounds(vUv + vec2(chromaOffset, 0.0))).r;
    float g = texel.g;
    float b = texture2D(tDiffuse, handleUVBounds(vUv + vec2(-chromaOffset, 0.0))).b;
    vec3 chromaColor = vec3(r, g, b);
    
    float currentBlur = blurStrength * effectCycle * (1.0 - edgeMask);
    vec4 blurredColor = gaussianBlur(tDiffuse, vUv, currentBlur, ratio);
    vec3 finalColor = mix(blurredColor.rgb, chromaColor, edgeMask);
    
    float brightness = 1.0 + brightnessWave * sin(cycle + dist * 10.0);
    finalColor *= brightness;
    
    return vec4(finalColor, texel.a);
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