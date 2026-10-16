precision highp float;

uniform sampler2D _MainTex;

varying vec2 v_uv;


vec4 texture2Dclamp (sampler2D tex, vec2 uv) {
    vec4 color = texture2D(tex, uv);
    uv = step(vec2(0.0), uv) * step(uv, vec2(1.0));
    return color * uv[0] * uv[1];
}

void main () {
    vec4 base = vec4(0.0, 0.0, 0.0, 0.0);
    vec4 src0 = texture2Dclamp(_MainTex, v_uv);

    base = src0 + base * (1.0 - src0.a);
    gl_FragColor = base;
}

