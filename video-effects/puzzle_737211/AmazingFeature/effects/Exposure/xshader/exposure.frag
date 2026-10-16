precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;

uniform float u_redExposure;
uniform float u_redOffset;
uniform float u_redGrayscaleCorrection;
uniform float u_greenExposure;
uniform float u_greenOffset;
uniform float u_greenGrayscaleCorrection;
uniform float u_blueExposure;
uniform float u_blueOffset;
uniform float u_blueGrayscaleCorrection;
uniform float u_gamma;
uniform int u_noUseLinearLight;

#define FALSE 0

float adjustExposure(float color, float exposure, float offset, float grayscaleCorrection)
{
    if (u_noUseLinearLight == FALSE) {
        color = pow(color, u_gamma);
    }

    color *= pow(2., exposure);
    color += offset;
    color = pow(color, 1. / grayscaleCorrection) * sign(color);

    if (u_noUseLinearLight == FALSE) {
        color = pow(color, 1. / u_gamma) * sign(color);
    }
    return color;
}

void main()
{
    vec4 color = texture2D(u_inputTexture, uv0);
    color.r = adjustExposure(color.r, u_redExposure, u_redOffset, u_redGrayscaleCorrection);
    color.g = adjustExposure(color.g, u_greenExposure, u_greenOffset, u_greenGrayscaleCorrection);
    color.b = adjustExposure(color.b, u_blueExposure, u_blueOffset, u_blueGrayscaleCorrection);
    gl_FragColor = clamp(color, 0., 1.);
}
