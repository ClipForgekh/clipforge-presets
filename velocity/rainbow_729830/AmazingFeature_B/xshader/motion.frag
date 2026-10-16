precision highp float;

uniform sampler2D u_base;
uniform float u_exposure;

varying vec2 v_uv;
varying vec2 v_uv1;


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}

vec3 unpremultiply (vec3 color, float alpha) {
    return color / (alpha + 0.0001);
}

void main () {
    vec4 base = texture2Dmirror(u_base, v_uv1);
    vec3 rgb = unpremultiply(base.rgb, base.a);
    rgb *= 1.0 + u_exposure;

    base = vec4(rgb, 1.0) * base.a;
    gl_FragColor = base;
}

