precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;
uniform sampler2D u_godRayTexture;

uniform float u_intensity;
uniform float u_brightness;
uniform vec2 u_center;
uniform int u_blendMode;
uniform int u_colorType;
uniform vec3 u_lightColor;
uniform float u_quality;
uniform float u_grayscaleCorrection;
uniform float u_weightDecay;
uniform float u_dither;
uniform float u_gamma;
uniform int u_inverseGammaCorrection;
uniform int u_displayRayOnly;

// finetuned parameters
uniform float u_normalizationSample;
uniform float u_sampleScale;
uniform float u_sampleBias;

#define TRUE 1
#define BLEND_MODE_ADD 1
#define BLEND_MODE_LIGHTEN 2
#define BLEND_MODE_MULTIPLY 3
#define BLEND_MODE_NORMAL 4
#define COLOR_TYPE_LIGHT_COLOR 1
#define MAX_SAMPLE 4096

const float Eps = 1e-5;


vec4 getColor(sampler2D tex, vec2 uv)
{
    vec4 color = texture2D(tex, uv);
    if (u_inverseGammaCorrection == TRUE) {
        // inverse gamma correction is not applied for alpha channel.
        color.rgb = pow(color.rgb, vec3(u_gamma));
    }
    return color;
}


float adjustSample(float quality, float dist, float scale, float bias)
{
    // use a linear function whose slope is slightly less than 1.0 to map distance (dist).
    // the purpose is to compensate sample for small distance.
    // If dist<0, process abs(dist) and preserve its sign.
    dist = sign(dist) * (0.9 * abs(dist) + 0.1);

    return scale * quality * dist + bias;
}


float adjustWeightDecay(float baseWeightDecay, float normalizationSample, float sampleNum)
{
    // this adjustment is to guarantee `scale invariant` for weight decay.
    // the adjusted weight decay should satisfy: pow(wd0, s0) = pow(wd1, s1).
    return pow(pow(baseWeightDecay, normalizationSample), 1. / sampleNum);
}

float hash(vec2 uv)
{
    // generate a pseudo random number between [0, 1]
    return fract(sin(dot(uv, vec2(41., 289.))) * 45758.5453);
}


vec4 screenBlend(vec4 fgColor, vec4 bgColor)
{
    return 1. - (1. - fgColor) * (1. - bgColor);
}


vec4 addBlend(vec4 fgColor, vec4 bgColor)
{
    vec4 resColor = vec4(0.);
    resColor.rgb = fgColor.rgb + bgColor.rgb;
    resColor.a = fgColor.a + bgColor.a * (1. - fgColor.a);
    return resColor;
}


vec4 lightenBlend(vec4 fgColor, vec4 bgColor)
{
    vec4 resColor = vec4(0.);
    resColor.rgb = max(fgColor.rgb, bgColor.rgb);
    resColor.a = fgColor.a + bgColor.a * (1. - fgColor.a);
    return resColor;
}

vec4 multiplyBlend(vec4 fgColor, vec4 bgColor)
{
    vec4 resColor = vec4(0.);
    resColor.rgb = fgColor.rgb * bgColor.rgb;
    resColor.a = fgColor.a + bgColor.a * (1. - fgColor.a);
    return resColor;
}


vec4 alphaComposite(vec4 fgColor, vec4 bgColor)
{
    vec4 resColor = vec4(0.);
    resColor.a = fgColor.a + bgColor.a * (1. - fgColor.a);
    resColor.rgb = (fgColor.a * fgColor.rgb + (1. - fgColor.a) * bgColor.a * bgColor.rgb) / max(resColor.a, Eps);
    return resColor;
}


void main()
{
    // init sumColor and sumWeight using current pixel.
    vec4 oriColor = texture2D(u_inputTexture, uv0);
    vec4 rayColor = getColor(u_godRayTexture, uv0);
    float weight = 1.;
    float sumWeight = weight;
    vec4 sumColor = weight * rayColor;

    // compute sample, which should be related with distantce(uv0, u_center).
    // Larger distance requires larger sample to avoid `layer effect`, whick is a kind of badcase.
    vec2 baseUV = uv0;
    vec2 dirUV = (baseUV - u_center) * u_intensity; // direction * blurIntensity
    float dist = length(dirUV);
    float sampleNum = adjustSample(u_quality, dist, u_sampleScale, u_sampleBias);
    sampleNum = min(sampleNum, float(MAX_SAMPLE));
    vec2 unitUV = dirUV / sampleNum;

    float weightDecay = adjustWeightDecay(u_weightDecay, u_normalizationSample, sampleNum);

    // dither baseUV
    if (u_dither > Eps) {
        vec2 jitterUV = u_dither * (hash(uv0) * 2. - 1.) * dirUV / u_normalizationSample;
        baseUV += jitterUV;
    }

    for (int i = 1; i <= MAX_SAMPLE; i++) {
        float k = float(i);
        if (k > sampleNum) {
            break;
        }
        weight *= weightDecay;

        // towards the center
        vec2 uv = baseUV - k * unitUV;
        if (uv.x < 0. || uv.y < 0. || uv.x > 1. || uv.y > 1.) {
            // process when uv out of border
            sumWeight += weight;
        } else {
            sumColor += weight * getColor(u_godRayTexture, uv);
            sumWeight += weight;
        }
    }
    sumColor /= sumWeight;
    // a `magic` relationship to adjust brightness. Note that all channels including alpha are adjusted
    sumColor *= (11.67 * u_brightness - 19. * pow(u_brightness, 2.) + 23. * pow(u_brightness, 3.));
//    sumColor.rgb *= sumColor.a; // apply alpha premultiplication to make soft light in and out

    if (u_colorType == COLOR_TYPE_LIGHT_COLOR) {
        sumColor.rgb *= u_lightColor;
    }
    sumColor = clamp(sumColor, 0., 1.);

    if (u_inverseGammaCorrection == TRUE) {
        // re-apply gamma correction for rgb.
        sumColor.rgb = pow(sumColor.rgb, vec3(1. / u_gamma));
    }

    // Note that alpha channel is NOT adjusted for grayscaleCorrection.
    sumColor.rgb = pow(sumColor.rgb, vec3(u_grayscaleCorrection));

    // the following processing is to avoid aliasing badcase when weightDecay is small (especially zero).
    if (u_weightDecay < 0.8) {
        sumColor = mix(vec4(0.), sumColor, 1.25 * u_weightDecay);
    }

    vec4 resColor = vec4(0.);
    if (u_displayRayOnly == TRUE) {
        resColor = sumColor;
    } else {
        if (u_blendMode == BLEND_MODE_ADD) {
            resColor = addBlend(sumColor, oriColor);
        } else if (u_blendMode == BLEND_MODE_LIGHTEN) {
            resColor = lightenBlend(sumColor, oriColor);
        } else if (u_blendMode == BLEND_MODE_MULTIPLY) {
            resColor = multiplyBlend(sumColor, oriColor);
        } else if (u_blendMode == BLEND_MODE_NORMAL) {
            resColor = alphaComposite(sumColor, oriColor);
        } else {
            resColor = screenBlend(sumColor, oriColor);
        }
    }

    gl_FragColor = clamp(resColor, 0., 1.);
}
