precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;

uniform float u_sampleY;
uniform float u_sigmaY;
uniform float u_stepY;
uniform int u_borderType;
uniform int u_blurAlpha;
uniform int u_inverseGammaCorrection;
uniform float u_gamma;

#define FALSE 0
#define TRUE 1
#define BORDER_TYPE_REPLICATE 1
#define BORDER_TYPE_BLACK 2
#define BORDER_TYPE_REFLECT 3
#define MAX_SAMPLE 1024

const float Eps = 1e-5;

vec4 encode(float gray) {
    vec4 res = vec4(0.0, 0.0, 0.0, 0.0);
    gray *= 255.0;
    res.x = floor(gray) / 255.0;
    gray = fract(gray);
    gray *= 255.0;
    res.y = floor(gray) / 255.0;
    gray = fract(gray);
    gray *= 255.0;
    res.z = floor(gray) / 255.0;
    gray = fract(gray);
    res.w = gray;
    return res;
}

float decode41(vec4 g) {
    float ret = 0.0;
    ret = g.x + g.y / 255.0 + g.z / (65025.0) + g.w / (16581375.0);
    return ret;
}

float getGaussianWeight(float x, float sigma)
{

    return exp(-0.5 * x * x / (sigma * sigma));
}


vec4 getColor(sampler2D tex, vec2 uv)
{
    vec4 color = texture2D(tex, uv);
    color = vec4(decode41(color));
    if (u_inverseGammaCorrection == 1) {
        // inverse gamma correction is not applied for alpha channel
        color.rgb = pow(color.rgb, vec3(u_gamma));
    }
    return color;
}


void main()
{
    if (u_sampleY < Eps) {
        gl_FragColor = texture2D(u_inputTexture, uv0);
        return;
    }

    // init sumColor and sumWeight using current pixel
    vec4 oriColor = getColor(u_inputTexture, uv0);
    oriColor = vec4(decode41(oriColor));
    float sumWeight = getGaussianWeight(0., u_sigmaY);
    vec4 sumColor = sumWeight * oriColor;

    // loop for both direction
    vec2 uv = uv0;
    for (int i = 1; i <= MAX_SAMPLE; i++) {
        float k = float(i);
        if (k > u_sampleY) {
            break;
        }

        float y = k * u_stepY;
        float weight = getGaussianWeight(y, u_sigmaY);

        // borderType: Normal=0, Replicate=1, Black=2, Reflect=3
        // Normal does NOT accumulate weight and color. Black does Not accumulate color

        // left range
        uv.y = uv0.y - y;
        if (uv.y < 0.) {
            // uv out of border, process border conditions
            if (u_borderType == BORDER_TYPE_REPLICATE) {
                uv.y = 0.;
                sumColor += weight * getColor(u_inputTexture, uv);
                sumWeight += weight;
            } else if (u_borderType == BORDER_TYPE_BLACK) {
                sumWeight += weight;
            } else if (u_borderType == BORDER_TYPE_REFLECT) {
                uv.y = -uv.y;
                sumColor += weight * getColor(u_inputTexture, uv);
                sumWeight += weight;
            }
        } else {
            sumColor += weight * getColor(u_inputTexture, uv);
            sumWeight += weight;
        }

        // right range
        uv.y = uv0.y + y;
        if (uv.y > 1.) {
            // uv out of border, process border conditions
            if (u_borderType == BORDER_TYPE_REPLICATE) {
                uv.y = 1.;
                sumColor += weight * getColor(u_inputTexture, uv);
                sumWeight += weight;
            } else if (u_borderType == BORDER_TYPE_BLACK) {
                sumWeight += weight;
            } else if (u_borderType == BORDER_TYPE_REFLECT) {
                uv.y = 2. - uv.y;
                sumColor += weight * getColor(u_inputTexture, uv);
                sumWeight += weight;
            }
        } else {
            sumColor += weight * getColor(u_inputTexture, uv);
            sumWeight += weight;
        }
    }
    sumColor /= sumWeight;

    if (u_inverseGammaCorrection == TRUE) {
        // re-apply gamma correction for rgb
        sumColor.rgb = pow(sumColor.rgb, vec3(1. / u_gamma));
    }

    if (u_blurAlpha == FALSE) {
        sumColor.a = oriColor.a;
    }
    sumColor = encode(sumColor.r);
    gl_FragColor = sumColor;
}
