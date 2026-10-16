precision highp float;

uniform sampler2D u_base;
uniform vec2 u_screen_size;
uniform vec2 u_mosaic_size;

varying vec2 v_xy;

void main () {
vec2 half_size = u_mosaic_size *1.;
vec2 center = u_screen_size * 1.;
vec2 indices = floor((v_xy - center) / u_mosaic_size);
vec2 xy = center + indices * u_mosaic_size;
vec2 uv = (xy + half_size) / u_screen_size;
gl_FragColor = texture2D(u_base, uv);
}