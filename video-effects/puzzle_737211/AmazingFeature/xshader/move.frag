precision highp float;

uniform sampler2D _MainTex;

varying vec2 v_uv;

void main () {
    gl_FragColor = texture2D(_MainTex, v_uv);
    //gl_FragColor = vec4(1.0,1.0,1.0,1.0);
}