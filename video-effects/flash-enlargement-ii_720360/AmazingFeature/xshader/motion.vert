precision highp float;

uniform vec2 u_screen_size;

uniform vec2 u_position1;
uniform vec2 u_anchor1;
uniform float u_scale1;
uniform float u_angle1;

uniform vec2 u_position2;
uniform vec2 u_anchor2;
uniform float u_scale2;
uniform float u_angle2;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uv;


vec2 transform (vec2 screen_size, vec2 image_size, vec2 translate, vec2 anchor, vec2 scale, float rotate, vec2 uv) {
    float R = rotate * 0.01745329251;
    float c = cos(R);
    float s = sin(R);

    vec2 rx = vec2(c, s);
    vec2 ry = vec2(-s, c);

    vec2 origin = translate * screen_size;
    vec2 p = uv * screen_size - origin;
    p = vec2(dot(rx, p), dot(ry, p));
    p /= image_size * scale;
    p += anchor;
    return p;
}

void main () {
    v_uv = a_texcoord0;
    v_uv = transform(u_screen_size, u_screen_size, u_position1, u_anchor1, vec2(u_scale1), u_angle1, v_uv);
    v_uv = transform(u_screen_size, u_screen_size, u_position2, u_anchor2, vec2(u_scale2), u_angle2, v_uv);
    gl_Position = a_position;
}
