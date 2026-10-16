precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;

uniform float u_threshold;
uniform int u_colorType;

#define COLOR_TYPE_LIGHT_COLOR 1


float rgb2gray(vec3 rgb)
{
    // get Y channel from BT.709
    return dot(rgb, vec3(0.2126, 0.7152, 0.0722));
}


void main()
{
    vec4 color = texture2D(u_inputTexture, uv0);
    float gray = rgb2gray(color.rgb);

    if (u_colorType == COLOR_TYPE_LIGHT_COLOR) {
        color.rgb = vec3(gray);
    }
    if (gray < u_threshold) {
        // threshold = 1. - range, range is user parameter
        color = vec4(0.);
    }
    gl_FragColor = color;
}
