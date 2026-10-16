precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;

uniform float u_sampleX;
uniform float u_stepX;
uniform int u_borderType;

#define FALSE 0
#define TRUE 1
#define BORDER_TYPE_REPLICATE 1
#define BORDER_TYPE_BLACK 2
#define BORDER_TYPE_REFLECT 3
#define MAX_SAMPLE 1024

const float Eps = 1e-5;


void main()
{
    if (u_sampleX < Eps) {
        gl_FragColor = texture2D(u_inputTexture, uv0);
        return;
    }

    // init sumColor and sumWeight using current pixel
    vec4 oriColor = texture2D(u_inputTexture, uv0);
    float sumWeight = 1.;
    vec4 sumColor = sumWeight * oriColor;

    // loop for both direction
    vec2 uv = uv0;
    for (int i = 1; i <= MAX_SAMPLE; i++) {
        float k = float(i);
        if (k > u_sampleX) {
            break;
        }

        float x = k * u_stepX;

        // borderType: Normal, Replicate, Black, Reflect
        // Normal does NOT accumulate weight and color. Black does Not accumulate color

        // left range
        uv.x = uv0.x - x;
        if (uv.x < 0.) {
            // uv out of border, process border conditions
            if (u_borderType == BORDER_TYPE_REPLICATE) {
                uv.x = 0.;
                sumColor += texture2D(u_inputTexture, uv);
                sumWeight += 1.;
            } else if (u_borderType == BORDER_TYPE_BLACK) {
                sumWeight += 1.;
            } else if (u_borderType == BORDER_TYPE_REFLECT) {
                uv.x = -uv.x;
                sumColor += texture2D(u_inputTexture, uv);
                sumWeight += 1.;
            }
        } else {
            sumColor += texture2D(u_inputTexture, uv);
            sumWeight += 1.;
        }

        // right range
        uv.x = uv0.x + x;
        if (uv.x > 1.) {
            // uv out of border, process border conditions
            if (u_borderType == BORDER_TYPE_REPLICATE) {
                uv.x = 1.;
                sumColor += texture2D(u_inputTexture, uv);
                sumWeight += 1.;
            } else if (u_borderType == BORDER_TYPE_BLACK) {
                sumWeight += 1.;
            } else if (u_borderType == BORDER_TYPE_REFLECT) {
                uv.x = 2. - uv.x;
                sumColor += texture2D(u_inputTexture, uv);
                sumWeight += 1.;
            }
        } else {
            sumColor += texture2D(u_inputTexture, uv);
            sumWeight += 1.;
        }
    }
    sumColor /= sumWeight;

    gl_FragColor = sumColor;
}