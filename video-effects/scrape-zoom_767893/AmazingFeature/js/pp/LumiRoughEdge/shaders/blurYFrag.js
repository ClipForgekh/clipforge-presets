exports.source=`
varying vec2 v_uv;
uniform sampler2D inputImageTexture;
uniform vec4 u_ScreenParams;
uniform float blurSize;

#define MAX_ITERATIONS 64.0

float uvProtect(vec2 uvTemp) {
    return step(0.0, uvTemp.x) * step(0.0, uvTemp.y) * step(uvTemp.x, 1.0) * step(uvTemp.y, 1.0);
}

float normpdf(in float x, in float sigma) {
    return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

void main() {
    vec2 mySize = u_ScreenParams.xy / min(u_ScreenParams.x, u_ScreenParams.y) * 540.0;
    float blurSize0 = blurSize;
    if (blurSize < 1.0) {
        blurSize0 = 0.0;
    } else if (blurSize <= 24.0) {
        blurSize0 = 24.0;
        mySize = u_ScreenParams.xy / min(u_ScreenParams.x, u_ScreenParams.y) * 540.0 * (24.0 / blurSize);
    } else if (blurSize <= 64.0) {
        blurSize0 = blurSize;
        mySize = u_ScreenParams.xy / min(u_ScreenParams.x, u_ScreenParams.y) * 540.0;
    } else {
        blurSize0 = 64.0;
        mySize = u_ScreenParams.xy / min(u_ScreenParams.x, u_ScreenParams.y) * 540.0 * (64.0 / blurSize);
    }
    vec2 unit = 1.0 / mySize;

    const float sigma = 4.0;
    float weight = normpdf(0.0, sigma);
    float sum_weight = weight;
    vec4 color = texture2D(inputImageTexture, v_uv) * weight;
    float validIterations = min(blurSize, MAX_ITERATIONS);
    
    for (int i = 1; i <= 64; i++) {
        float fi = float(i);
        if (fi > validIterations) break;
        if (fi > blurSize0) break;
        weight = normpdf(fi / blurSize0 * 15.0, sigma);
        color += weight * texture2D(inputImageTexture, v_uv + vec2(0.0, fi * unit.y)) * uvProtect(v_uv + vec2(0.0, fi * unit.y));
        color += weight * texture2D(inputImageTexture, v_uv - vec2(0.0, fi * unit.y)) * uvProtect(v_uv - vec2(0.0, fi * unit.y));
        sum_weight += 2.0 * weight;
    }
    color /= sum_weight;
    gl_FragColor = color;
}
`;