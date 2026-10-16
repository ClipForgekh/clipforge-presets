precision highp float;

uniform sampler2D u_src;

varying vec2 v_uv[9];

const vec4 c_weights = vec4(0.233308, 0.135928, 0.051383, 0.012595);


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}
vec4 texture2Dclamp (sampler2D tex, vec2 uv) {
    vec4 color = texture2D(tex, uv);
    uv = step(vec2(0.0), uv) * step(uv, vec2(1.0));
    return color * uv[0] * uv[1];
}

void main () {
    vec4 sum = texture2D(u_src, v_uv[0]) * 0.133571;
	for (int i = 0; i < 4; ++i) {
		sum += texture2Dmirror(u_src, v_uv[i * 2 + 1]) * c_weights[i];
		sum += texture2Dmirror(u_src, v_uv[i * 2 + 2]) * c_weights[i];
	}
	gl_FragColor = sum;
}