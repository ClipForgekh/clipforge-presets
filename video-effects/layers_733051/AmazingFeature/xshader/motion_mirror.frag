precision highp float;

uniform sampler2D _MainTex;
uniform float u_opacity;

varying vec2 v_uv;
varying vec2 v_uv0;


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}


void main () {
    gl_FragColor = texture2Dmirror(_MainTex, v_uv0) * u_opacity;
}