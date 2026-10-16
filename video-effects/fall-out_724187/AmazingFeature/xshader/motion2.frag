precision highp float;

uniform sampler2D u_tex;

varying vec2 v_uv;


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    vec2 i = step(vec2(0.5 - 1.11), uv) * step(uv, vec2(0.5 + 1.11));
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv)) * (i.x * i.y);
}

void main () {
    gl_FragColor = texture2Dmirror(u_tex, v_uv);
}

