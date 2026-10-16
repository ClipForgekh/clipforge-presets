precision highp float;

uniform sampler2D u_src;
uniform float u_opacity;

varying vec2 v_uv;


void main () {
	gl_FragColor = texture2D(u_src, v_uv) * u_opacity;
}