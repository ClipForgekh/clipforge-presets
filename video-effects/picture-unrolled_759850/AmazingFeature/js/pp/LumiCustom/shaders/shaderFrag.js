exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float rollRadius; // = 0.1 [0.05, 0.3] // 卷轴半径
uniform float shadowStrength; // = 0.6 [0.0, 1.0] // 阴影强度
uniform float ambientLight; // = 0.4 [0.0, 1.0] // 环境光强度

varying vec2 vUv; // 纹理坐标

// 推荐用于入场动画的缓出曲线：正弦缓出，变化均匀自然
float tween(float progress) {
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    // 卷轴入场逻辑：从顶部向下展开
    // progress = 0: currentY = 1.0 (全卷起在顶端)
    // progress = 1: currentY = 0.0 (全展开，卷轴消失在底端)
    float currentY = 1.0 - progress;
    
    // 基础参数
    float r = rollRadius;
    float PI = 3.14159265;
    
    // 屏幕空间坐标与卷轴位置的相对距离
    float dist = currentY - vUv.y;
    
    // 1. 已展开部分 (vUv.y > currentY)
    if (vUv.y >= currentY) {
        return texel;
    }
    
    // 2. 卷轴物理模拟 (RayMarching/SDF 简化思想)
    // 我们模拟一个圆柱体，其横截面在 Y-Z 平面
    // 如果 dist 在 [0, PI * r] 范围内，说明处于卷起的纸张上
    if (dist > 0.0 && dist < PI * r) {
        // 计算在圆柱上的旋转角度
        float angle = dist / r;
        
        // 计算映射后的纹理坐标 (沿圆柱弧长映射)
        // 展开长度为 progress，未展开的部分贴在圆柱上
        vec2 uv = vec2(vUv.x, currentY); 
        // 实际上，卷起的纸张采样的是 currentY 以下的纹理内容，
        // 但为了入场动画的视觉逻辑（从无到有），此处采样卷轴边缘的像素并加上阴影
        
        // 计算模拟法线用于光照
        vec3 normal = vec3(0.0, sin(angle), cos(angle));
        vec3 lightDir = normalize(vec3(0.0, 0.707, 0.707));
        vec3 viewDir = vec3(0.0, 0.0, 1.0);
        
        // Lambert 漫反射
        float diff = max(dot(normal, lightDir), 0.0);
        
        // Blinn-Phong 高光
        vec3 halfDir = normalize(lightDir + viewDir);
        float spec = pow(max(dot(normal, halfDir), 0.0), 16.0);
        
        // 模拟卷轴边缘的阴影（靠近平铺部分的底部最暗）
        float edgeShadow = smoothstep(0.0, 0.3, angle);
        
        // 采样纹理：为了视觉连续性，卷轴部分采样当前卷动边缘的像素
        vec4 rollTexel = texture2D(tDiffuse, handleUVBounds(vec2(vUv.x, currentY + dist * 0.1)));
        
        vec3 finalRGB = rollTexel.rgb * (diff * shadowStrength + ambientLight) + spec * 0.3;
        finalRGB *= edgeShadow;
        
        return vec4(finalRGB, texel.a);
    }
    
    // 3. 未到达部分 (vUv.y < currentY - PI * r)
    // 入场动画开始前，画面应该是不可见的
    return vec4(0.0, 0.0, 0.0, 0.0);
}

void main() {
    // 获取纹理像素颜色
    vec4 texel = texture2D(tDiffuse, vUv);

    // --- 特效配置 ---
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;

    // 1. 计算特效自身的进度
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    
    // 2. 应用卷轴效果
    vec4 effectColor = effect(texel, effectProgress);

    // 3. 输出最终颜色
    gl_FragColor = effectColor;
}
//===end_frag_code===
`;