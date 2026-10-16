precision highp float;

uniform vec2 u_screen_size;
uniform float u_wavelength;
uniform float u_amplitude;

uniform sampler2D u_tex;

varying vec2 v_xy;

#define PI2 6.28318530718


void main () {
	float source = u_screen_size.y * 0.5;
	float phase = fract((v_xy.y - source) / u_wavelength) * PI2;
	float amplitude = sin(phase) * u_amplitude;
	vec2 uv = vec2(v_xy.x + amplitude, v_xy.y) / u_screen_size;
	gl_FragColor = texture2D(u_tex, uv);
}