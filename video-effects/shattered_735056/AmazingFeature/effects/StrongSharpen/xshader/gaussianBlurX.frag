precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;

uniform float u_sampleX;
uniform float u_sigmaX;
uniform float u_dx;
uniform int u_borderType;

#define TRUE 1
#define BORDER_TYPE_REPLICATE 1
#define BORDER_TYPE_BLACK 2
#define BORDER_TYPE_REFLECT 3
#define MAX_SAMPLE 1024

const float Eps = 1e-5;


float getGaussianWeight(float x, float sigma)
{
    return exp(-0.5 * x * x / (sigma * sigma));
}


void main()
{
    if (u_sampleX < Eps) {
        gl_FragColor = texture2D(u_inputTexture, uv0);
        return;
    }

    // init sumColor and sumWeight using current pixel
    vec4 oriColor = texture2D(u_inputTexture, uv0);
    float sumWeight = getGaussianWeight(0., u_sigmaX);
    vec4 sumColor = sumWeight * oriColor;

    // loop for both direction
    vec2 uv = uv0;
    for (int i = 1; i <= MAX_SAMPLE; i++) {
        float k = float(i);
        if (k > u_sampleX) {
            break;
        }

        float x = k * u_dx;
        float weight = getGaussianWeight(x, u_sigmaX);

        // borderType: Normal=0, Replicate=1, Black=2, Reflect=3
        // Normal does NOT accumulate weight and color

        // left range
        uv.x = uv0.x - x;
        if (uv.x < 0.) {
            // uv out of border, process border conditions
            if (u_borderType == BORDER_TYPE_REPLICATE) {
                uv.x = 0.;
                sumColor += weight * texture2D(u_inputTexture, uv);
                sumWeight += weight;
            } else if (u_borderType == BORDER_TYPE_BLACK) {
                sumColor += weight * vec4(0., 0., 0., 1.);
                sumWeight += weight;
            } else if (u_borderType == BORDER_TYPE_REFLECT) {
                uv.x = -uv.x;
                sumColor += weight * texture2D(u_inputTexture, uv);
                sumWeight += weight;
            }
        } else {
            sumColor += weight * texture2D(u_inputTexture, uv);
            sumWeight += weight;
        }

        // right range
        uv.x = uv0.x + x;
        if (uv.x > 1.) {
            // uv out of border, process border conditions
            if (u_borderType == BORDER_TYPE_REPLICATE) {
                uv.x = 1.;
                sumColor += weight * texture2D(u_inputTexture, uv);
                sumWeight += weight;
            } else if (u_borderType == BORDER_TYPE_BLACK) {
                sumColor += weight * vec4(0., 0., 0., 1.);
                sumWeight += weight;
            } else if (u_borderType == BORDER_TYPE_REFLECT) {
                uv.x = 2. - uv.x;
                sumColor += weight * texture2D(u_inputTexture, uv);
                sumWeight += weight;
            }
        } else {
            sumColor += weight * texture2D(u_inputTexture, uv);
            sumWeight += weight;
        }
    }
    sumColor /= sumWeight;

    gl_FragColor = sumColor;
}
