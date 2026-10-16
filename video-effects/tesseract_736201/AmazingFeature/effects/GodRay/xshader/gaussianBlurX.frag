precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;

uniform float u_sampleX;
uniform float u_sigmaX;
uniform float u_dx;
uniform float u_gamma;
uniform int u_inverseGammaCorrection;

#define TRUE 1
#define MAX_SAMPLE 1024

const float Eps = 1e-5;


float gaussianWeight(float x, float sigma)
{
    return exp(-0.5 * x * x / (sigma * sigma));
}


vec4 getColor(sampler2D tex, vec2 uv)
{
    vec4 color = texture2D(tex, uv);
    if (u_inverseGammaCorrection == TRUE) {
        // inverse gamma correction is not applied for alpha channel
        color.rgb = pow(color.rgb, vec3(u_gamma));
    }
    return color;
}


void main()
{
    if (u_sampleX < Eps) {
        gl_FragColor = texture2D(u_inputTexture, uv0);
        return;
    }

    // init sumColor and sumWeight using current pixel
    vec4 oriColor = getColor(u_inputTexture, uv0);
    float sumWeight = gaussianWeight(0., u_sigmaX);
    vec4 sumColor = sumWeight * oriColor;

    // loop for both direction
    vec2 uv = uv0;
    for (int i = 1; i <= MAX_SAMPLE; i++) {
        float k = float(i);
        if (k > u_sampleX) {
            break;
        }

        float x = k * u_dx;
        float weight = gaussianWeight(x, u_sigmaX);

        // borderType: Transparent, which does NOT accumulate weight and color if uv out of border
        // left range
        uv.x = uv0.x - x;
        if (uv.x >= 0.) {
            sumColor += weight * getColor(u_inputTexture, uv);
            sumWeight += weight;
        }

        // right range
        uv.x = uv0.x + x;
        if (uv.x <= 1.) {
            sumColor += weight * getColor(u_inputTexture, uv);
            sumWeight += weight;
        }
    }
    sumColor /= sumWeight;

    if (u_inverseGammaCorrection == TRUE) {
        // re-apply gamma correction for rgb
        sumColor.rgb = pow(sumColor.rgb, vec3(1. / u_gamma));
    }

    gl_FragColor = sumColor;
}
