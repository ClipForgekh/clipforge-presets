precision highp float;

uniform sampler2D u_base;
uniform float u_intensity;
uniform float u_offset;
uniform float u_gamma;

varying vec2 v_uv;


vec3 unpremultiply (vec3 color, float alpha) {
    return color / (alpha + 0.0001);
}

vec4 ExposureLighten(vec4 col) {
    vec3 rgb = unpremultiply(col.rgb, col.a);
    rgb *= pow(0.75, -u_intensity);
    rgb += u_offset;
    rgb = pow(rgb, vec3(1.0 / u_gamma));
    return vec4(rgb, 1.0) * col.a;
}

void main()
{
    vec4 base = texture2D(u_base, v_uv);
    base = ExposureLighten(base);
    gl_FragColor = base;
}
