precision highp float;

uniform float u_aspect_dst;
uniform float u_aspect_src;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uv;


vec2 contains (float src_aspect, float dst_aspect, vec2 uv) {
    vec2 sd = vec2(src_aspect, dst_aspect);
    vec2 ds = sd.yx;
    vec2 s = ds / sd;
    vec2 p = (uv - 0.5) * s + 0.5;
    vec2 a = step(sd, ds);
    return mix(uv, p, a);
}

void main () {
    v_uv = contains(u_aspect_src, u_aspect_dst, a_texcoord0);
    gl_Position = a_position;
}
