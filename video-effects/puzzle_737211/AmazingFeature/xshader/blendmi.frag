precision highp float;

uniform sampler2D u_mask;
uniform sampler2D u_image;
uniform float u_opacity;

varying vec2 v_uv;

void main () {
    vec4 mask = texture2D(u_mask, v_uv);
    vec4 base = texture2D(u_image, v_uv) * mask.a;
    gl_FragColor = base * u_opacity;
}