precision highp float;

uniform sampler2D u_baseTex;
uniform sampler2D u_baseMaskTex;
uniform sampler2D u_haloTex;
uniform sampler2D u_shadowTex;
uniform sampler2D u_maskTex;
uniform float u_saturation;
uniform float u_exposure;
uniform float u_opacity;

varying vec2 v_uvBase;
varying vec2 v_uvBaseMask;
varying vec2 v_uvHalo;
varying vec2 v_uvShadow;
varying vec2 v_uvMask;

const vec3 C0 = vec3(0.0);
const vec3 C1 = vec3(1.0);
const vec3 C_2 = vec3(0.5);


float rgb2lum (vec3 RGB) {
    const vec3 W = vec3(0.299, 0.587, 0.114);
    return dot(RGB, W);
}
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


// [Add]
vec3 blend_1001 (vec3 dst, vec3 src) {
    return min(src + dst, C1);
}
// [Average]
vec3 blend_1002 (vec3 dst, vec3 src) {
    return (src + dst) * 0.5;
}
// [Color Burn]
vec3 blend_1003 (vec3 dst, vec3 src) {
    vec3 eq0 = step(C0, -src);
    vec3 res = max(C1 - (C1 - dst) / (src + eq0), C0);
    return mix(res, C0, eq0);
}
// [Color Dodge]
vec3 blend_1004 (vec3 dst, vec3 src) {
    vec3 eq1 = step(C1, src);
    vec3 res = min(dst / (C1 - src + eq1), C1);
    return mix(res, C1, eq1);
}
// [Darken]
vec3 blend_1005 (vec3 dst, vec3 src) {
    return min(src, dst);
}
// [Difference]
vec3 blend_1006 (vec3 dst, vec3 src) {
    return abs(dst - src);
}
// [Exclusion]
vec3 blend_1007 (vec3 dst, vec3 src) {
    vec3 mul = dst * src;
    return dst + src - (mul + mul);
}
// [Glow]
vec3 blend_1008 (vec3 dst, vec3 src) {
    vec3 eq1 = step(C1, dst);
    vec3 res = min(src * src / (C1 - dst + eq1), C1);
    return mix(res, C1, eq1);
}
// [Hard Light]
vec3 blend_1009 (vec3 dst, vec3 src) {
    vec3 ge_2 = step(C_2, dst);
    vec3 res0 = dst * src;
    res0 += res0;
    vec3 res1 = (C1 - dst) * (C1 - src);
    res1 = C1 - res1 - res1;
    return mix(res0, res1, ge_2);
}
// [Hard Mix]
vec3 blend_1010 (vec3 dst, vec3 src) {
    vec3 ge_2 = step(C_2, src);
    vec3 res0 = blend_1003(dst, (src + src));
    res0 = mix(C0, C1, step(C_2, res0));
    vec3 res1 = blend_1004(dst, (src + src) - C1);
    res1 = mix(C0, C1, step(C_2, res1));
    return mix(res0, res1, ge_2);
}
// [Lighten]
vec3 blend_1011 (vec3 dst, vec3 src) {
    return max(dst, src);
}
// [Linear Burn]
vec3 blend_1012 (vec3 dst, vec3 src) {
    return max(dst + src - C1, C0);
}
// [Linear Dodge]
vec3 blend_1013 (vec3 dst, vec3 src) {
    return min(dst + src, C1);
}
// [Linear Light]
vec3 blend_1014 (vec3 dst, vec3 src) {
    vec3 ge_2 = step(C_2, src);
    vec3 res0 = blend_1012(dst, (src + src));
    vec3 res1 = blend_1013(dst, (src + src) - C1);
    return mix(res0, res1, ge_2);
}
// [Multiply]
vec3 blend_1015 (vec3 dst, vec3 src) {
    return dst * src;
}
// [Negation]
vec3 blend_1016 (vec3 dst, vec3 src) {
    return C1 - abs(C1 - dst - src);
}
// [Overlay]
vec3 blend_1017 (vec3 dst, vec3 src) {
    vec3 ge_2 = step(C_2, dst);
    vec3 res0 = dst * src;
    res0 += res0;
    vec3 res1 = (C1 - dst) * (C1 - src);
    res1 = C1 - res1 - res1;
    return mix(res0, res1, ge_2);
}
// [Phoenix]
vec3 blend_1018 (vec3 dst, vec3 src) {
    return C1 + min(dst, src) - max(dst, src);
}
// [Pin Light]
vec3 blend_1019 (vec3 dst, vec3 src) {
    vec3 ge_2 = step(C_2, src);
    vec3 res0 = blend_1005(dst, (src + src));
    vec3 res1 = blend_1011(dst, (src + src) - C1);
    return mix(res0, res1, ge_2);
}
// [Reflect]
vec3 blend_1020 (vec3 dst, vec3 src) {
    return blend_1008(src, dst);
}
// [Screen]
vec3 blend_1021 (vec3 dst, vec3 src) {
    return C1 - (C1 - dst) * (C1 - src);
}
// [Soft Light]
vec3 blend_1022 (vec3 dst, vec3 src) {
    vec3 ge_2 = step(C_2, src);
    vec3 dst2 = dst + dst;
    vec3 src2 = src + src;
    vec3 res0 = dst2 * src + dst * dst * (C1 - src2);
    vec3 res1 = sqrt(dst) * (src2 - C1) + dst2 * (C1 - src);
    return mix(res0, res1, ge_2);
}
// [Subtract]
vec3 blend_1023 (vec3 dst, vec3 src) {
    return max(dst + src - C1, C0);
}
// [Vivid Light]
vec3 blend_1024 (vec3 dst, vec3 src) {
    vec3 ge_2 = step(C_2, src);
    vec3 res0 = blend_1003(dst, (src + src));
    vec3 res1 = blend_1004(dst, (src + src) - C1);
    return mix(res0, res1, ge_2);
}
// [Hue]
vec3 blend_1025 (vec3 dst, vec3 src) {
    dst = rgb2hsl(dst);
    src = rgb2hsl(src);
    vec3 res = vec3(src.x, dst.y, dst.z);
    return hsl2rgb(res);
}
// [Saturation]
vec3 blend_1026 (vec3 dst, vec3 src) {
    dst = rgb2hsl(dst);
    src = rgb2hsl(src);
    vec3 res = vec3(dst.x, src.y, dst.z);
    return hsl2rgb(res);
}
// [Lightness]
vec3 blend_1027 (vec3 dst, vec3 src) {
    dst = rgb2hsl(dst);
    src = rgb2hsl(src);
    vec3 res = vec3(dst.x, dst.y, src.z);
    return hsl2rgb(res);
}
// [Hue-Saturation]
vec3 blend_1028 (vec3 dst, vec3 src) {
    dst = rgb2hsl(dst);
    src = rgb2hsl(src);
    vec3 res = vec3(src.x, src.y, dst.z);
    return hsl2rgb(res);
}
// [Lighter Color]
vec3 blend_1101 (vec3 dst, vec3 src) {
    float dstLum = rgb2lum(dst);
    float srcLum = rgb2lum(src);
    float select = step(dstLum, srcLum);
    return mix(dst, src, select);
}

vec3 unpremultiply (vec3 color, float alpha) {
    return color / (alpha + 0.0001);
}

vec4 blend (int mode, vec4 dst, vec4 src, float opacity) {
    if (mode == 0) {
        src *= opacity;
        return src + dst * (1.0 - src.a);
    }
    vec3 d = unpremultiply(dst.rgb, dst.a);
    vec3 s = unpremultiply(src.rgb, src.a);
    if (mode == 1001)
        s = blend_1001(d, s);
    else if (mode == 1002)
        s = blend_1002(d, s);
    else if (mode == 1003)
        s = blend_1003(d, s);
    else if (mode == 1004)
        s = blend_1004(d, s);
    else if (mode == 1005)
        s = blend_1005(d, s);
    else if (mode == 1006)
        s = blend_1006(d, s);
    else if (mode == 1007)
        s = blend_1007(d, s);
    else if (mode == 1008)
        s = blend_1008(d, s);
    else if (mode == 1009)
        s = blend_1009(d, s);
    else if (mode == 1010)
        s = blend_1010(d, s);
    else if (mode == 1011)
        s = blend_1011(d, s);
    else if (mode == 1012)
        s = blend_1012(d, s);
    else if (mode == 1013)
        s = blend_1013(d, s);
    else if (mode == 1014)
        s = blend_1014(d, s);
    else if (mode == 1015)
        s = blend_1015(d, s);
    else if (mode == 1016)
        s = blend_1016(d, s);
    else if (mode == 1017)
        s = blend_1017(d, s);
    else if (mode == 1018)
        s = blend_1018(d, s);
    else if (mode == 1019)
        s = blend_1019(d, s);
    else if (mode == 1020)
        s = blend_1020(d, s);
    else if (mode == 1021)
        s = blend_1021(d, s);
    else if (mode == 1022)
        s = blend_1022(d, s);
    else if (mode == 1023)
        s = blend_1023(d, s);
    else if (mode == 1024)
        s = blend_1024(d, s);
    else if (mode == 1025)
        s = blend_1025(d, s);
    else if (mode == 1026)
        s = blend_1026(d, s);
    else if (mode == 1101)
        s = blend_1101(d, s);
    else
        s = d;
    return mix(dst, vec4(s, 1.0) * dst.a, src.a * opacity);
}

vec4 adjustHSL (vec4 color, vec3 adjust) {
    vec3 rgb = unpremultiply(color.rgb, color.a);
    vec3 hsl = rgb2hsl(rgb);
    hsl.x += adjust.x / 360.0;
    hsl.yz = mix( mix(vec2(0.0), hsl.yz, adjust.yz+1.0), mix(hsl.yz, vec2(1.0), adjust.yz), step(vec2(0.0), adjust.yz));
    rgb = hsl2rgb(hsl);
    return vec4(rgb, 1.0) * color.a;
}

vec4 Exposure (vec4 col, float intensity) {
    vec3 rgb = unpremultiply(col.rgb, col.a);
    rgb *= pow(2.0, intensity);
    rgb = clamp(rgb, 0.0, 1.0);
    return vec4(rgb, 1.0) * col.a;
}

void main () {
    vec4 base = texture2D(u_baseTex, v_uvBase);
    vec4 baseMask = texture2D(u_baseMaskTex, v_uvBaseMask);
    base = adjustHSL(base, vec3(0.0, u_saturation, 0.0));
    base *= baseMask.r;

    vec4 halo = texture2D(u_haloTex, v_uvHalo);
    base = blend(0000, base, halo, 1.0);

    vec4 shadow = texture2D(u_shadowTex, v_uvShadow);
    base = blend(1015, base, shadow, 1.0);

    base = Exposure(base, u_exposure);
    base *= u_opacity;

    vec4 mask = texture2D(u_maskTex, v_uvMask);
    base *= mask.a;

    gl_FragColor = base;
}