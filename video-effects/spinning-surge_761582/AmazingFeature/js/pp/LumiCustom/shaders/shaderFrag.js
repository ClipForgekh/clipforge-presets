exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float rotationStrength; // = 3.0 [0.0, 8.0] // 旋转强度系数
uniform float depthIntensity; // = 0.6 [0.0, 1.0] // 深度透明度差异
uniform float spiralCount; // = 3.0 [0.5, 8.0] // 螺旋圈数

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    vec4 accumColor = vec4(0.0);
    float totalWeight = 0.0;
    const int layerCount = 40;
    
    for(int i = 0; i < layerCount; i++) {
        float fi = float(i);
        float n = fi / 40.0;
        
        // 深层（n大）延迟启动，形成从深处涌出的波浪感
        float layerDelay = n * 0.7;
        float layerProgress = clamp((p - layerDelay) / 0.3, 0.0, 1.0);
        layerProgress = 1.0 - pow(1.0 - layerProgress, 2.0);
        
        if(layerProgress < 0.001) continue;
        
        // 从深处（小尺寸）到表面（正常尺寸）
        float scale = mix(0.05, 1.0, layerProgress);
        
        // 从旋转状态到正常状态，深层旋转更多
        float angle = (1.0 - layerProgress) * rotationStrength * 3.14159265 * 2.0 * (1.0 + n);
        
        vec2 center = vec2(0.5);
        vec2 uv = vUv - center;
        
        // 应用旋转变换
        float s = sin(angle);
        float c = cos(angle);
        uv = vec2(uv.x * c - uv.y * s, uv.x * s + uv.y * c);
        
        // 应用缩放（从中心向外扩展）
        uv = uv / max(scale, 0.001);
        
        // 螺旋位置偏移，创造隧道扭曲感
        float spiralPhase = n * spiralCount * 3.14159265 * 2.0;
        float spiralOffset = (1.0 - layerProgress) * 0.15 * n;
        uv += vec2(cos(spiralPhase), sin(spiralPhase)) * spiralOffset;
        
        uv += center;
        uv = handleUVBounds(uv);
        
        vec4 sampleColor = texture2D(tDiffuse, uv);
        
        // 透明度计算：进度越完整越不透明，深层在过程中更透明
        float alpha = layerProgress * (1.0 - depthIntensity * n * (1.0 - layerProgress));
        
        accumColor.rgb += sampleColor.rgb * alpha;
        totalWeight += alpha;
    }
    
    vec4 result;
    if(totalWeight > 0.0) {
        result = vec4(accumColor.rgb / totalWeight, texel.a);
    } else {
        result = vec4(0.0, 0.0, 0.0, 0.0);
    }
    
    // 确保progress=1.0时完全恢复原始图像
    return mix(result, texel, step(0.999, p));
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