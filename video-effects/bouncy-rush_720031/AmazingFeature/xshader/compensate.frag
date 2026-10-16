precision highp float;

uniform sampler2D _MainTex;
uniform vec2 u_flat;
uniform float u_depth;
uniform float u_intensity;

varying vec2 v_xy;


void main () {
    float r = length(v_xy);
    float s = sin(atan(r, u_depth));
    vec2 xy = v_xy / r;
    xy *= r * (1.0 + s * u_intensity);
    vec2 uv = xy / u_flat * 0.5 + 0.5;
    gl_FragColor = texture2D(_MainTex, uv);
}

