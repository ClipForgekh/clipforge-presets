precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;
uniform vec2 u_outputSize;
uniform float u_vertR;
uniform float u_sigma;

vec4 neighborColor(float i)
{
    const float blurSize = 1.;
    const float standardResolutionWidth = 800.;
    vec2 uvUnit = vec2(u_outputSize.xy) / min(u_outputSize.x, u_outputSize.y) * standardResolutionWidth;
    vec2 unit = blurSize / uvUnit;
    vec2 uv1 = uv0 + unit * vec2(0., i);
    vec2 uv2 = uv0 - unit * vec2(0., i);
    vec4 result = texture2D(u_inputTexture, uv1) * step(uv1.y, 1.) * step(0., uv1.y) +
                  texture2D(u_inputTexture, uv2) * step(uv2.y, 1.) * step(0., uv2.y);
    return result;
}

float gaussianWeight(float x)
{
    return exp(-(x * x) / (2.0 * u_sigma * u_sigma * u_vertR * u_vertR / 100.)) * 10.;
}

vec4 vertBlurColor(vec4 curColor)
{
    vec4 resultColor = vec4(0.);
    vec4 centerPixel = curColor * 10.;
    resultColor += centerPixel;
    float weight = 10.;
    float w = 0.;
    for (float i = 1.; i <= 100.; i += 1.0) {
        if (i > 8. * (u_vertR / 10.)) {
            break;
        }
        w = gaussianWeight(float(i));
        resultColor += neighborColor(i) * w;
        weight += w * 2.;
    }
    resultColor /= weight;
    return resultColor;
}

void main()
{
    vec4 curColor = texture2D(u_inputTexture, uv0);
    gl_FragColor = vertBlurColor(curColor);
}
