precision highp float;

uniform sampler2D u_base;
uniform sampler2D u_msk0;
uniform sampler2D u_msk1;
uniform float u_progress;
uniform vec4 u_intensityX;
uniform vec4 u_intensityY;

varying vec2 v_uv;
varying vec2 v_uv1;


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}

void main() {
    vec4 msk0 = texture2Dmirror(u_msk0, v_uv1);
    vec4 msk1 = texture2Dmirror(u_msk1, v_uv1);
    vec4 mask = (mix(msk0, msk1, u_progress) - 0.5) * 1.75;
    vec2 uv = vec2(v_uv.x + dot(mask, u_intensityX), v_uv.y + dot(mask, u_intensityY));
    vec4 base = texture2Dmirror(u_base, uv);

    gl_FragColor = base;
//    gl_FragColor = mask * 0.5 + 0.5;
}
