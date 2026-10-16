precision highp float;

uniform sampler2D u_src;
uniform vec2 u_screen_size;
uniform vec2 u_center;
uniform float u_step;
uniform float u_fade0;
uniform float u_fade1;
uniform float u_spos;
uniform float u_sneg;

varying vec2 v_uv;

const vec4 F = vec4(1.407333, 3.294215, 5.351806, 7.302940);
const vec4 W = vec4(0.233308, 0.135928, 0.051383, 0.012595);


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}

void main () {
	vec2 rec_screen_size = 1.0 / u_screen_size;
	vec2 o = u_center;
	vec2 p = v_uv * u_screen_size;
	vec2 v = p - o;
	float l = length(v);
	v /= l;
	float bs = min(u_screen_size.x, u_screen_size.y);
	float ss = smoothstep(bs * u_fade0, bs * u_fade1, l);
	vec2 s = v * rec_screen_size * u_step * ss;

	vec4 sum = texture2D(u_src, v_uv) * 0.133571;
	for (int i = 0; i < 4; ++i) {
		sum += texture2Dmirror(u_src, v_uv + s * F[i]) * W[i] * u_sneg;
		sum += texture2Dmirror(u_src, v_uv - s * F[i]) * W[i] * u_spos;
	}
	gl_FragColor = sum;
}