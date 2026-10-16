exports.source=`
precision highp float;

varying vec2 vUv;

// Uniforms
uniform sampler2D u_inputTex;
uniform sampler2D noiseTex;
uniform float u_sample;
uniform sampler2D darkFilterTex;

uniform float u_baseTexWidth;
uniform float u_baseTexHeight;
uniform float u_intensity;
uniform float u_darkIns;

float normpdf(in float x, in float sigma) {
    return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

vec4 gaussianBlur(sampler2D i_InputTex, vec2 i_Uv, vec2 i_Dir, vec2 screenSize) {
    float sigma = 4.0;
    float weight = normpdf(0.0, sigma);

    vec4 sum = vec4(0.0);
    vec4 result = vec4(0.0);
    vec2 unit_uv = i_Dir / screenSize;
    float gamma = 1.0;
    
    vec4 curColor = texture2D(i_InputTex, i_Uv);
    // 加上 max(..., 0.0) 防止 WebGL 下 pow 负数导致黑屏报错
    vec4 centerPixel = pow(max(curColor, 0.0), vec4(gamma)) * weight;
    float sum_weight = weight;

    float s = max(u_sample, 1.0);
    
    // WebGL1 兼容的循环
    for(int i = 1; i <= 80; i++) {
        if (float(i) > u_sample) break;
        float fi = float(i);
        
        vec2 curRightCoordinate = i_Uv + fi * unit_uv;
        vec2 curLeftCoordinate = i_Uv - fi * unit_uv;
        
        vec4 rightColor = texture2D(i_InputTex, curRightCoordinate);
        vec4 leftColor = texture2D(i_InputTex, curLeftCoordinate);
        
        float curWeight = normpdf(fi / s * 15.0, sigma);
        
        sum += pow(max(rightColor, 0.0), vec4(gamma)) * curWeight;
        sum += pow(max(leftColor, 0.0), vec4(gamma)) * curWeight;
        sum_weight += curWeight * 2.0;
    }

    result = (sum + centerPixel) / sum_weight;
    result = pow(max(result, 0.0), vec4(1.0 / gamma));
    return clamp(result, 0.0, 1.0);
}

vec4 takeEffectFilter(vec4 inputColor, float how, sampler2D myfilter) {

    highp float blueColor = inputColor.b * 63.0;

    highp vec2 quad1;
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);

    highp vec2 quad2;
    quad2.y = floor(ceil(blueColor) / 8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);

    highp vec2 texPos1;
    texPos1.x = (quad1.x * 1.0 / 8.0) + 0.5 / 512.0 + ((1.0 / 8.0 - 1.0 / 512.0) * inputColor.r);
    texPos1.y = (quad1.y * 1.0 / 8.0) + 0.5 / 512.0 + ((1.0 / 8.0 - 1.0 / 512.0) * inputColor.g);

    highp vec2 texPos2;
    texPos2.x = (quad2.x * 1.0 / 8.0) + 0.5 / 512.0 + ((1.0 / 8.0 - 1.0 / 512.0) * inputColor.r);
    texPos2.y = (quad2.y * 1.0 / 8.0) + 0.5 / 512.0 + ((1.0 / 8.0 - 1.0 / 512.0) * inputColor.g);

    lowp vec4 newColor1 = texture2D(myfilter, texPos1);
    lowp vec4 newColor2 = texture2D(myfilter, texPos2);
    lowp vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    
    // WebGL中 vector 4 的 alpha 分量通常用 .a (对应原生代码的 .w)
    newColor = mix(inputColor, vec4(newColor.rgb, 1.0), how);
    return newColor;
}

void main() {
    vec2 screenSize = vec2(u_baseTexWidth, u_baseTexHeight) / min(u_baseTexWidth, u_baseTexHeight) * 720.0;
    vec2 blurDir = vec2(1.0, 0.0);
    
    vec4 resultCol = gaussianBlur(u_inputTex, vUv, blurDir, screenSize);
    
    vec2 noiseUV = vUv * screenSize / min(screenSize.x, screenSize.y) * 2.0;
    float noise = texture2D(noiseTex, fract(noiseUV)).r;
    
    float gray = dot(resultCol.rgb, vec3(0.299, 0.587, 0.114));
    
    resultCol = takeEffectFilter(resultCol, 0.5 * u_intensity * u_darkIns, darkFilterTex);
    resultCol.rgb = mix(resultCol.rgb, resultCol.rgb * (noise * 1.0 + 0.0), gray * 0.1 * u_intensity * u_darkIns);
    
    gl_FragColor = resultCol;
}
`;