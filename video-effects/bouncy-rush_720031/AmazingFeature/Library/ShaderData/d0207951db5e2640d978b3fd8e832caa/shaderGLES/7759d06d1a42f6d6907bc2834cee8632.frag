precision highp float;

uniform sampler2D u_src;
uniform vec2 u_screen_size;
uniform vec2 u_center;
uniform float u_radian;

varying vec2 v_uv;

const vec4 F = vec4(1.407333, 3.294215, 5.351806, 7.302940);
const vec4 W = vec4(0.233308, 0.135928, 0.051383, 0.012595);


vec4 texture2Dclamp (sampler2D tex, vec2 uv) {
    vec4 color = texture2D(tex, uv);
    uv = step(vec2(0.0), uv) * step(uv, vec2(1.0));
    return color * uv[0] * uv[1];
}

void main () {
	vec2 rec_screen_size = 1.0 / u_screen_size;
	vec2 o = u_center;
	vec2 p = v_uv * u_screen_size;
	vec2 v = p - o;
	float r = length(v);
	float a0 = atan(v.y, v.x);
	float da = u_radian * 0.5;

	vec4 sum = texture2D(u_src, v_uv) * 0.133571;
	for (int i = 0; i < 4; ++i) {
		float a1 = a0 + da * F[i];
		float a2 = a0 - da * F[i];
		vec2 v1 = vec2(cos(a1), sin(a1)) * r;
		vec2 v2 = vec2(cos(a2), sin(a2)) * r;
		vec2 uv1 = (o + v1) * rec_screen_size;
		vec2 uv2 = (o + v2) * rec_screen_size;
		sum += texture2Dclamp(u_src, uv1) * W[i];
		sum += texture2Dclamp(u_src, uv2) * W[i];
	}
	gl_FragColor = sum;
}