precision highp float;

uniform sampler2D u_tex;
uniform float u_sat;

varying vec2 v_uv;

const vec3 LuminanceFactor = vec3(0.208540, 0.702086, 0.089374);


vec3 rgb2hsl (vec3 RGB) {
    float cmin = min(RGB.r, min(RGB.g, RGB.b));
    float cmax = max(RGB.r, max(RGB.g, RGB.b));
    float C = cmax - cmin;
    float Ceq0 = step(C, 0.0);
    float Cgt0 = 1.0 - Ceq0;

    vec3 H3 = (RGB.gbr - RGB.brg) / (C + Ceq0);
    H3 = (H3 + vec3(0.0, 2.0, 4.0)) / 6.0;

    float L2 = cmax + cmin;
    float L2eq0 = step(L2, 0.0);
    float L2eq2 = step(2.0, L2);

    float H = H3.z;
    float S = mix(C / (L2 + L2eq0), C / (2.0 - L2 + L2eq2), step(1.0, L2));
    float L = L2 * 0.5;

    H = mix(H, H3.y, step(cmax, RGB.g));
    H = mix(H, H3.x, step(cmax, RGB.r));
    H = fract(H);
    H *= Cgt0;
    S *= Cgt0;
    return vec3(H, S, L);
}
vec3 hsl2rgb (vec3 HSL) {
    vec3 P = clamp(abs(mod(HSL.xxx * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    return HSL.zzz + HSL.yyy * (P - 0.5) * (1.0 - abs(HSL.z + HSL.z - 1.0));
}

vec3 unpremultiply (vec4 color) {
    return color.rgb / (color.a + 0.0001);
}

vec4 adjustHSL (vec4 color, vec3 adjust) {
    vec3 rgb = unpremultiply(color);
    vec3 hsl = rgb2hsl(rgb);
    hsl.x += adjust.x / 360.0;
    hsl.yz = mix( mix(vec2(0.0), hsl.yz, adjust.yz+1.0), mix(hsl.yz, vec2(1.0), adjust.yz), step(vec2(0.0), adjust.yz));
    rgb = hsl2rgb(hsl);
    return vec4(rgb, 1.0) * color.a;
}

//void main () {
//    vec4 base = texture2D(u_tex, v_uv);
//    base = adjustHSL(base, vec3(0.0, u_sat, 0.0));
//    gl_FragColor = base;
//}

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