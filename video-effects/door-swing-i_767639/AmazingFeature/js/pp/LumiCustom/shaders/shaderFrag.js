exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float foldAxis; // = 0.0 [0.0, 1.0] // 折叠轴：0=垂直（左右展开），1=水平（上下展开）
uniform float perspectiveStrength; // = 0.4 [0.1, 0.8] // 透视强度，控制3D深度感
uniform float foldEdge; // = 0.0 [0.0, 1.0] // 折叠起始边：0=从左/上，1=从右/下

varying vec2 vUv;

float tween(float progress) {
    // 中度缓出曲线，适合入场动画
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec4 effect(vec4 texel, float progress) {
    // progress已经经过tween处理，直接使用
    // 确保有最小角度避免除零
    float theta = progress * 1.57079632679 + 0.001;
    float sinT = sin(theta);
    float cosT = cos(theta);
    float persp = perspectiveStrength;
    
    vec2 uv = vUv;
    float sx, sy;
    float u, v;
    
    // 根据折叠方向设置坐标
    if (foldAxis < 0.5) {
        // 垂直轴折叠（左右展开）
        sx = foldEdge < 0.5 ? uv.x : 1.0 - uv.x;
        sy = uv.y;
        
        // 3D透视投影逆运算
        // 屏幕x = u * sin(theta) / (1 + u * cos(theta) * persp)
        // 解方程求u
        float denom = sinT - sx * cosT * persp;
        if (abs(denom) < 0.0001) return vec4(0.0, 0.0, 0.0, 0.0);
        
        u = sx / denom;
        
        // 计算深度并调整Y坐标
        float z3d = u * cosT;
        v = (sy - 0.5) * (1.0 + z3d * persp) + 0.5;
        
        // 边界检查
        if (u < 0.0 || u > 1.0 || v < 0.0 || v > 1.0) {
            return vec4(0.0, 0.0, 0.0, 0.0);
        }
        
        // 如果从右向左展开，需要翻转u坐标
        if (foldEdge >= 0.5) u = 1.0 - u;
        
        return texture2D(tDiffuse, vec2(u, v));
    } else {
        // 水平轴折叠（上下展开）
        sx = foldEdge < 0.5 ? uv.y : 1.0 - uv.y;
        sy = uv.x;
        
        float denom = sinT - sx * cosT * persp;
        if (abs(denom) < 0.0001) return vec4(0.0, 0.0, 0.0, 0.0);
        
        u = sx / denom;
        
        float z3d = u * cosT;
        v = (sy - 0.5) * (1.0 + z3d * persp) + 0.5;
        
        if (u < 0.0 || u > 1.0 || v < 0.0 || v > 1.0) {
            return vec4(0.0, 0.0, 0.0, 0.0);
        }
        
        if (foldEdge >= 0.5) u = 1.0 - u;
        
        // 交换回x,y坐标
        return texture2D(tDiffuse, vec2(v, u));
    }
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