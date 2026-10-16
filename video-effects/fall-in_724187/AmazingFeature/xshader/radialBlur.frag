precision highp float;

uniform sampler2D u_tex;
uniform vec2 u_center;
uniform float u_amount;

varying vec2 v_uv;


vec4 texture2Dnormal (sampler2D tex, vec2 uv) {
	return texture2D(tex, uv);
}
vec4 texture2Dclamp (sampler2D tex, vec2 uv) {
	vec4 color = texture2D(tex, uv);
	uv = step(vec2(0.0), uv) * step(uv, vec2(1.0));
	return color * uv[0] * uv[1];
}
vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}
//#ifndef SAMPLES
//#define SAMPLES 20
//#endif

vec4 RadialBlur (sampler2D tex, vec2 center, vec2 uv, float amount) {
	float aW = 1.0;
	vec4 aC = texture2D(tex, uv);
#ifdef SAMPLES
	vec2 vec = uv - center;
	vec2 dUV = vec * (amount / float(SAMPLES));
	vec2 aUV = dUV;
	for (int i = 0; i < SAMPLES; ++i) {
		aC += texture2Dmirror(tex, uv - aUV);
		aC += texture2Dmirror(tex, uv + aUV);
		aW += 2.0;
		aUV += dUV;
	}
#endif
	return aC / aW;
}

void main () {
	gl_FragColor = RadialBlur(u_tex, u_center, v_uv, u_amount);
}