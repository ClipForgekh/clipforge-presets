precision highp float;

uniform sampler2D u_tex;
uniform vec4 u_rect;
uniform float u_grey;
uniform float u_exposure;
uniform float u_opacity;

varying vec2 v_uv0;
varying vec2 v_uv1;


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}
vec3 unpremultiply (vec4 color) {
    return color.rgb / (color.a + 0.0001);
}
float rgb2lum (vec3 RGB) {
    const vec3 W = vec3(0.299, 0.587, 0.114);
    return dot(RGB, W);
}
vec4 Exposure (vec4 col, float intensity) {
    vec3 rgb = unpremultiply(col);
    rgb *= pow(2.0, intensity);
    return vec4(rgb, 1.0) * col.a;
}
float cut () {
    vec2 a = step(u_rect.xy, v_uv0) * step(v_uv0, u_rect.zw);
    return a.x * a.y;
}

void main () {
    vec4 base = texture2Dmirror(u_tex, v_uv1);
    vec4 grey = vec4(vec3(rgb2lum(unpremultiply(base))), 1.0) * base.a;
    base = mix(base, grey, u_grey);
    base = Exposure(base, u_exposure);
    gl_FragColor = base * (cut() * u_opacity);
}