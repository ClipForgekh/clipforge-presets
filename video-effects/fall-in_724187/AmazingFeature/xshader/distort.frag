precision highp float;

uniform sampler2D u_tex;
uniform vec3 u_Ki;
uniform vec3 u_Kj;
uniform float u_aspect;
uniform float u_radius;

varying vec2 v_uv;


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}

float distort (vec2 pos, vec3 Ki, vec3 Kj) {
    float r2 = pos.x * pos.x + pos.y * pos.y;
    float r4 = r2 * r2;
    float r6 = r4 * r2;
    vec3 Rs = vec3(r2, r4, r6);
    return (1.0 + dot(Ki, Rs)) / (1.0 + dot(Kj, Rs));
}


void main () {
    vec2 s = vec2(u_aspect, 1.0) / u_radius;
    vec2 p = v_uv * 2.0 - 1.0;
    p *= s;
    p *= distort(p, u_Ki, u_Kj);
    p /= s;
    p = p * 0.5 + 0.5;
    gl_FragColor = texture2D(u_tex, p);
}

