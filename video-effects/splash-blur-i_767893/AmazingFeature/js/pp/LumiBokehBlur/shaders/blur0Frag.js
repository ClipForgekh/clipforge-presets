exports.source=`
precision highp float;

// Receive UV from commonVert
varying vec2 vUv;

// Uniforms
uniform sampler2D u_inputTex;
uniform float u_sample;
uniform float u_baseTexWidth;
uniform float u_baseTexHeight;

// Gaussian weight calculation
float normpdf(in float x, in float sigma) {
    return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

vec4 gaussianBlur(sampler2D i_InputTex, vec2 i_Uv, vec2 i_Dir, vec2 screenSize) {
    float sigma = 4.0;
    float weight = normpdf(0.0, sigma);

    vec4 sum = vec4(0.0);
    vec2 unit_uv = i_Dir / screenSize;
    float gamma = 1.0;
    
    vec4 curColor = texture2D(i_InputTex, i_Uv);
    vec4 centerPixel = pow(curColor, vec4(gamma)) * weight;
    float sum_weight = weight;
    
    float s = max(u_sample, 1.0); // Prevent division by zero exception

    // WebGL1 compatible loop unrolling, maximum sample in Lua is 80
    for (int i = 1; i <= 80; i++) {
        if (float(i) > u_sample) break;
        float fi = float(i);
        
        vec2 curRightCoordinate = i_Uv + fi * unit_uv;
        vec2 curLeftCoordinate = i_Uv - fi * unit_uv;
        
        vec4 rightColor = texture2D(i_InputTex, curRightCoordinate);
        vec4 leftColor = texture2D(i_InputTex, curLeftCoordinate);
        
        float curWeight = normpdf(fi / s * 15.0, sigma);
        
        sum += pow(rightColor, vec4(gamma)) * curWeight;
        sum += pow(leftColor, vec4(gamma)) * curWeight;
        sum_weight += curWeight * 2.0;
    }

    vec4 result = (sum + centerPixel) / sum_weight;
    result = pow(result, vec4(1.0 / gamma));
    return clamp(result, 0.0, 1.0);
}

void main() {
    // Dynamically calculate base size based on 720p
    vec2 screenSize = vec2(u_baseTexWidth, u_baseTexHeight) / min(u_baseTexWidth, u_baseTexHeight) * 720.0;
    
    // blur0 is vertical blur
    vec2 blurDir = vec2(0.0, 1.0);
    
    gl_FragColor = gaussianBlur(u_inputTex, vUv, blurDir, screenSize);
}
`;