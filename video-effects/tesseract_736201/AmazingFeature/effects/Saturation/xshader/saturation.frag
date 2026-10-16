precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;

uniform float u_intensity;

const vec3 LuminanceFactor = vec3(0.208540, 0.702086, 0.089374);

void main()
{
    vec4 oriColor = texture2D(u_inputTexture, uv0);
    vec4 resColor = oriColor;

    // use a color vector to adjust saturation
    vec3 baseAdjustVec = LuminanceFactor * (1. - u_intensity);
    vec3 adjustVec = baseAdjustVec + vec3(u_intensity, 0., 0.);
    resColor.r = dot(oriColor.rgb, adjustVec);

    adjustVec = baseAdjustVec + vec3(0., u_intensity, 0.);
    resColor.g = dot(oriColor.rgb, adjustVec);

    adjustVec = baseAdjustVec + vec3(0., 0., u_intensity);
    resColor.b = dot(oriColor.rgb, adjustVec);
    gl_FragColor = clamp(resColor, 0., 1.);
}
