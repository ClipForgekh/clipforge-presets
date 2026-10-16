precision highp float;

uniform sampler2D u_tex;
uniform float u_step_x;
uniform float u_step_y;
uniform float u_radius;

varying vec2 v_uv;


void main () {
    vec2 ds = vec2(u_step_x, u_step_y) * u_radius;
	vec4 sum = texture2D(u_tex, v_uv) * 0.153170327618346;
	sum += texture2D(u_tex, v_uv - ds * 0.25) * 0.14489292176612587;
	sum += texture2D(u_tex, v_uv + ds * 0.25) * 0.14489292176612587;
	sum += texture2D(u_tex, v_uv - ds * 0.50) * 0.12264921034103102;
	sum += texture2D(u_tex, v_uv + ds * 0.50) * 0.12264921034103102;
	sum += texture2D(u_tex, v_uv - ds * 0.75) * 0.09290249985875561;
	sum += texture2D(u_tex, v_uv + ds * 0.75) * 0.09290249985875561;
	sum += texture2D(u_tex, v_uv - ds * 1.00) * 0.06297020422491453;
	sum += texture2D(u_tex, v_uv + ds * 1.00) * 0.06297020422491453;
	gl_FragColor = sum;
}