precision highp float;

uniform sampler2D u_tex;
uniform float u_sat;

varying vec2 v_uv;

const vec3 LuminanceFactor = vec3(0.208540, 0.702086, 0.089374);


void main()
{
//    float u_intensity = u_sat * 0.5 + 0.5;
    float u_intensity = u_sat + 1.0;
    vec4 oriColor = texture2D(u_tex, v_uv);
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