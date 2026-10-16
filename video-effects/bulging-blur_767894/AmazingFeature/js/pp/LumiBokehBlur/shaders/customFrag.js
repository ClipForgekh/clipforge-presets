exports.source=`
precision highp float;

varying vec2 vUv;

uniform sampler2D u_inputTex;
// 接收自定义形状贴图
uniform sampler2D u_customTex;

uniform float u_baseTexWidth;
uniform float u_baseTexHeight;
uniform float u_blurSize;
uniform float u_lightIns;
uniform float u_intensity;
uniform float u_regionIns;
uniform float u_quality;
uniform float u_scaleX;
uniform float u_scaleY;
uniform float u_angle;

mat2 rotate2d(in float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c, -s, s, c);
}

vec4 blur(sampler2D inputTexture, vec2 textureCoordinate, float blurSize, vec2 screenSize) {
    if(u_intensity < 0.01) {
        return texture2D(inputTexture, textureCoordinate);
    }
    
    float amount = 539.45;
    vec4 oriCol = vec4(0.0);
    vec4 maxCol = oriCol;
    vec4 bokeh = vec4(0.0001);
    vec4 sumCol = vec4(0.0);
    vec4 sumWeight = bokeh;
    mat2 rotMat = rotate2d(u_angle);
    
    // 基础缩放系数
    vec2 unitUV = vec2(2.0, 2.0) * vec2(u_scaleX, u_scaleY) * vec2(blurSize);
    vec2 screenOffset = 1.0 / screenSize;
    
    float blurStep = mix(2.0, 0.5, u_intensity) * mix(2.0, 1.0, u_quality);
    float blurRadius = floor(10.0 / blurStep * mix(0.7, 1.0, u_quality));
    blurRadius = max(5.0, blurRadius);
    float maxRegionIns = mix(0.7, 1.0, u_regionIns);
    
    // 我们将模糊半径映射到自定义贴图的 UV [0, 1] 空间
    // 假设自定义贴图的中心是 (0.5, 0.5)
    
    for(int i = 0; i < 30; i++) {
        float fi = float(i);
        if (fi > blurRadius || u_intensity < 0.3) break;
        
        for(int j = 0; j < 30; j++) {
            float fj = float(j);
            if (fj > blurRadius) break;
            
            // 生成在正方形网格内的偏移 (-blurRadius 到 blurRadius)
            float offsetX = mix(-blurRadius, blurRadius, fi / blurRadius);
            float offsetY = mix(-blurRadius, blurRadius, fj / blurRadius);
            vec2 offsetVec = vec2(offsetX, offsetY);
            
            // 计算在 Custom 贴图上的对应 UV
            // offsetVec 归一化到 [-1, 1]
            vec2 customUV = (offsetVec / blurRadius) * 0.5 + 0.5;
            
            // 【核心修复】：将 Y 轴反转，解决由于 WebGL 与图片坐标系相反导致的图案上下颠倒问题
            customUV.y = 1.0 - customUV.y;
            
            // 采样自定义形状贴图
            // 假设白色/不透明区域是光斑形状，黑色/透明区域是需要剔除的
            vec4 shapeSample = texture2D(u_customTex, customUV);
            // 使用亮度(Luminance)或 Alpha 作为形状的权重
            float shapeWeight = shapeSample.a * dot(shapeSample.rgb, vec3(0.299, 0.587, 0.114));
            
            // 如果这个像素不在自定义形状内，跳过采样
            if (shapeWeight < 0.05) continue;
            
            vec2 tempUV = textureCoordinate - 0.5 * offsetVec * unitUV * rotMat * screenOffset;
            vec4 tempCol = texture2D(inputTexture, tempUV);
            
            // 应用形状权重的衰减 (边缘可以有柔和过渡)
            maxCol = max(maxCol, tempCol * maxRegionIns * shapeWeight);
            bokeh = pow(max(tempCol, 0.0), vec4(9.0)) * amount + 0.4;
            bokeh *= u_regionIns * shapeWeight;
            sumCol += bokeh * tempCol;
            sumWeight += bokeh;
        }
    }

    vec4 resultCol = clamp(sumCol / sumWeight, 0.0, 1.0);
    return vec4(mix(resultCol, maxCol, clamp(resultCol * u_lightIns, 0.0, 1.0)));
}

void main() {
    vec2 screenSize = vec2(u_baseTexWidth, u_baseTexHeight) / min(u_baseTexWidth, u_baseTexHeight) * 720.0;
    gl_FragColor = blur(u_inputTex, vUv, u_blurSize, screenSize);
}
`;