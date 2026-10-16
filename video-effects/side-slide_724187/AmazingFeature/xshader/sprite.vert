precision highp float;

uniform mat4 u_VP;
uniform mat4 u_MVP;
uniform mat4 u_CustomModel;
uniform vec2 u_size;
uniform vec2 u_anchor;
uniform vec2 u_mirror;
uniform vec4 u_frame;
uniform float u_image_anchor;

attribute vec2 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uv;

void main() {
    v_uv = mix(u_frame.xy, u_frame.zw, a_texcoord0);

    vec2 size = u_size * (u_frame.zw - u_frame.xy);
    vec2 anchor = mix(u_anchor, (u_anchor - u_frame.xy) / (u_frame.zw - u_frame.xy), u_image_anchor);
    vec2 position = (a_texcoord0 - anchor) * size;
    mat4 mvp = u_VP * u_CustomModel;
    gl_Position = mvp * vec4(position, 0.0, 1.0);

    v_uv = mix(v_uv, 1.0 - v_uv, u_mirror);
}
