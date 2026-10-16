precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;
uniform float u_threshold;
uniform int u_glowColors;

float rgb2gray(vec3 rgbColor)
{
    // get Y channel by BT.470 or BT.601
    return dot(rgbColor, vec3(0.299, 0.587, 0.114));
}

// get mask color for origin mode
vec3 selfGlowColor(vec4 curColor)
{
    vec4 resultColor = curColor;
    float t = clamp(u_threshold, .01, 1.);
    resultColor.rgb = smoothstep(t - .075 * u_threshold, t + .115, resultColor.rgb);
    float gamma = 2.2;
    return pow(resultColor.rgb, vec3(1. / gamma));
}

// get mask color for ab mode
vec3 abGlowColor(vec4 curColor)
{
    // float t = clamp(u_threshold, .01, 1.);
    float gray = rgb2gray(curColor.rgb);
    vec3 resultColor = smoothstep(u_threshold - .12 * u_threshold, u_threshold + .07, vec3(gray));
    return resultColor;
}

// get mask color for aba mode
vec3 abaGlowColor(vec4 curColor)
{
    float t = clamp(u_threshold, .01, 1.);
    float gray = rgb2gray(curColor.rgb);
    vec3 resultColor = smoothstep(t - .12 * u_threshold, t + .09, vec3(gray));
    return resultColor;
}

// get mask color
vec4 highlightColor(vec4 curColor)
{
    if (u_glowColors == 1) {
        vec4 abColor = curColor;
        abColor.rgb = abGlowColor(curColor);
        abColor.a = abColor.r;
        return abColor;
    } else if (u_glowColors == 2) {
        vec4 abaColor = curColor;
        abaColor.rgb = abaGlowColor(curColor);
        abaColor.a = abaColor.r;
        return abaColor;
    }

    curColor.rgb = selfGlowColor(curColor);
    return curColor;
}

void main()
{
    vec4 curColor = texture2D(u_inputTexture, uv0);
    gl_FragColor = highlightColor(curColor);
}
