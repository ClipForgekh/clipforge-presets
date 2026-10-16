precision highp float;

uniform sampler2D _MainTex;
uniform float u_hue;
uniform float u_saturation;
uniform float u_lightness;

varying vec2 v_uv;


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

vec3 unpremultiply (vec3 color, float alpha) {
    return color / (alpha + 0.0001);
}

vec4 adjustHSL (vec4 color, vec3 adjust) {
    vec3 rgb = unpremultiply(color.rgb, color.a);
    vec3 hsl = rgb2hsl(rgb);
    hsl.x += adjust.x / 360.0;
    hsl.yz = mix( mix(vec2(0.0), hsl.yz, adjust.yz+1.0), mix(hsl.yz, vec2(1.0), adjust.yz), step(vec2(0.0), adjust.yz));
    rgb = hsl2rgb(hsl);
    return vec4(rgb, 1.0) * color.a;
}

void main () {
    vec4 base = texture2D(_MainTex, v_uv);
    base = adjustHSL(base, vec3(u_hue, u_saturation, u_lightness));
    gl_FragColor = base;
}