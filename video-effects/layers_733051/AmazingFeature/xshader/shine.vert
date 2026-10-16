precision highp float;

uniform float u_srcAspect;
uniform float u_dstAspect;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uv;
varying vec2 v_uv1;


vec2 cover (float src_aspect, float dst_aspect, vec2 uv) {
    vec2 sd = vec2(src_aspect, dst_aspect);
    vec2 ds = sd.yx;
    vec2 s = ds / sd;
    vec2 p = (uv - 0.5) * s + 0.5;
    vec2 a = step(ds, sd);
    return mix(uv, p, a);
}

void main () {
    v_uv = a_texcoord0;
    v_uv1 = cover(u_srcAspect, u_dstAspect, a_texcoord0);
    v_uv1.y = 1.0 - v_uv1.y;
    gl_Position = a_position;
}
