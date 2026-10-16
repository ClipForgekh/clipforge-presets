precision highp float;

uniform sampler2D _MainTex;

varying vec2 v_uv;


vec4 texture2Dmirror (sampler2D tex, vec2 uv) {
    uv = abs(mod(uv + 1.0, 2.0) - 1.0);
    return texture2D(tex, uv);
}

void main () {
    gl_FragColor = texture2Dmirror(_MainTex, v_uv);
    //gl_FragColor = texture2D(_MainTex, v_uv);
}