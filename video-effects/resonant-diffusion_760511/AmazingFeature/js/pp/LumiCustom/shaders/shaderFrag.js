exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform参数
uniform float echoInterval; // = 0.05 [0.01, 0.1] // 共振层生成间隔
uniform float echoDuration; // = 0.3 [0.1, 0.5] // 共振层生命周期，调整为0.3以保证多层叠加
uniform float echoDecay; // = 0.85 [0.5, 0.95] // 共振层透明度衰减系数

varying vec2 vUv;

// 保持线性进度，具体的缓动在effect内部实现，以保证共振层的时间逻辑正确
float tween(float progress) {
    return progress;
}

// 边界处理函数：clamp边界（留黑），避免镜像
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：硬边界裁切，避免边缘拉丝
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float p) {
    // 1. 基础缩放逻辑：0.0-1.0进度对应缩放0.2-1.0
    // 使用smoothstep实现平滑的主体入场缓动
    float baseScale = mix(0.2, 1.0, smoothstep(0.0, 1.0, p));
    
    // 初始化背景颜色为纯黑 (符合描述"四周填充纯黑")
    vec4 finalColor = vec4(0.0, 0.0, 0.0, 1.0);
    
    // 2. 共振层逻辑 (声波扩散动态)
    // 0.0-0.78期间生成新层，之后不再生成
    float spawnLimit = 0.78;
    // 计算当前时刻理论上最新的层级索引
    int currentMaxK = int(min(p, spawnLimit) / echoInterval);
    
    // 循环最近的6个层级 (i=0为最新层，i=5为最老层)
    // 使用倒序循环模拟层叠关系，或者简单的Alpha混合
    for (int i = 5; i >= 0; i--) {
        int k = currentMaxK - i;
        if (k < 0) continue;
        
        float tk = float(k) * echoInterval; // 该层的生成时间
        float age = p - tk; // 该层已存在的时间
        
        // 归一化生命周期 0.0(出生) -> 1.0(消亡)
        // 注意：为了满足"持续存在不少于5个层级"的要求，
        // 这里使用 echoDuration (0.3) 而非间隔 (0.05) 作为生命周期分母
        float lk = clamp(age / echoDuration, 0.0, 1.0);
        
        // 如果层还未出生(age<0)或已完全消亡(lk>=1.0)，跳过
        if (age < 0.0 || lk >= 1.0) continue;
        
        // 层属性计算
        // 缩放：随生命周期变大 (扩散效果)，产生外扩波纹质感
        float scale_k = baseScale * (1.0 + 0.7 * lk);
        
        // 透明度计算：
        // (1) 代际衰减：i越大(越老)越淡，模拟能量递减
        float layerAlpha = 0.8 * pow(echoDecay, float(i));
        // (2) 生命周期衰减：随扩散逐渐消失
        layerAlpha *= (1.0 - smoothstep(0.0, 1.0, lk));
        // (3) 结尾全局消隐：progress > 0.78 后，所有剩余层加速淡出
        if (p > 0.78) {
            layerAlpha *= (1.0 - smoothstep(0.78, 1.0, p));
        }
        
        // 绘制该共振层
        vec2 uv_k = 0.5 + (vUv - 0.5) / scale_k;
        float mask_k = getHardBoundaryMask(uv_k); // 硬裁切
        uv_k = handleUVBounds(uv_k); // 边界处理
        vec4 col_k = texture2D(tDiffuse, uv_k);
        
        // 混合：简单Alpha叠加到背景上
        finalColor = mix(finalColor, col_k, layerAlpha * col_k.a * mask_k);
    }
    
    // 3. 主体绘制
    // 主体始终在最上层，沿Z轴虚拟推近
    vec2 uv_main = 0.5 + (vUv - 0.5) / baseScale;
    float mask_main = getHardBoundaryMask(uv_main);
    uv_main = handleUVBounds(uv_main);
    vec4 col_main = texture2D(tDiffuse, uv_main);
    
    // 主体透明度：从0.8平滑过渡到1.0 (恢复原图)
    float alpha_main = mix(0.8, 1.0, p);
    
    // 混合主体
    finalColor = mix(finalColor, col_main, alpha_main * col_main.a * mask_main);
    
    return finalColor;
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    
    // 视频动画逻辑
    float effectProgress = clamp(progress, 0.0, 1.0);
    effectProgress = tween(effectProgress);
    
    vec4 finalColor = effect(texel, effectProgress);

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;