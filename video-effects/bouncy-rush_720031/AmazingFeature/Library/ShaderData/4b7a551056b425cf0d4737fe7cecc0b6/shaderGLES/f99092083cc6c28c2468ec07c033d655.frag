precision highp float;

uniform sampler2D u_src;
uniform float u_step_x;
uniform float u_step_y;
uniform float u_intensity;

varying vec2 v_uv;


void main () {
    vec2 ds = vec2(u_step_x, u_step_y) * u_intensity;
	vec4 sum = texture2D(u_src, v_uv) * 0.133571;
	sum += texture2D(u_src, v_uv - ds * 1.407333) * 0.233308;
	sum += texture2D(u_src, v_uv + ds * 1.407333) * 0.233308;
	sum += texture2D(u_src, v_uv - ds * 3.294215) * 0.135928;
	sum += texture2D(u_src, v_uv + ds * 3.294215) * 0.135928;
	sum += texture2D(u_src, v_uv - ds * 5.351806) * 0.051383;
	sum += texture2D(u_src, v_uv + ds * 5.351806) * 0.051383;
	sum += texture2D(u_src, v_uv - ds * 7.302940) * 0.012595;
	sum += texture2D(u_src, v_uv + ds * 7.302940) * 0.012595;
	gl_FragColor = sum;
}