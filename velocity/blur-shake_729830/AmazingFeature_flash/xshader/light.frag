precision highp float;

uniform sampler2D u_src;
uniform float u_intensity;

varying vec2 v_uv;


vec3 unpremultiply (vec3 color, float alpha) {
    return color / (alpha + 0.0001);
}

void main () {
    vec4 base = texture2D(u_src, v_uv);
    vec3 rgb = unpremultiply(base.rgb, base.a);
    rgb *= u_intensity;
    gl_FragColor = vec4(rgb, 1.0) * base.a;
}