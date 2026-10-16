precision highp float;

uniform sampler2D _MainTex;
uniform float u_opacity;

varying vec2 v_uv;

void main() {
    gl_FragColor = texture2D(_MainTex, v_uv) * u_opacity;
}
