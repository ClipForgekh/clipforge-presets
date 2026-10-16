precision highp float;

uniform sampler2D _MainTex;
uniform float u_exposure;
uniform float u_offset;
uniform float u_gamma;

varying vec2 v_uv;


vec3 unpremultiply (vec3 color, float alpha) {
    return color / (alpha + 0.0001);
}

vec4 exposure (vec4 src, float exposure, float offset, float gamma) {
    vec3 rgb = unpremultiply(src.rgb, src.a);
    rgb = rgb * pow(0.75, -exposure);
    rgb += offset;
    rgb = pow(rgb, vec3(1.0 / gamma));
    vec4 res = vec4(rgb, 1.0) * src.a;
    return clamp(res, 0.0, 1.0);
}

void main () {
    vec4 base = texture2D(_MainTex, v_uv);
    base = exposure(base, u_exposure, u_offset, u_gamma);
    gl_FragColor = base;
}

