precision highp float;

uniform sampler2D _MainTex;
uniform vec2 u_screenSize;
uniform float u_width;
uniform float u_angle;

varying vec2 v_uv;

void main () {
    float a = radians(u_angle);
    vec2 iSize = 1.0 / u_screenSize;
    vec2 p = v_uv * u_screenSize;
    vec2 v = vec2(cos(a), sin(a)) * u_width;
    float a1 = texture2D(_MainTex, (p - v) * iSize).a;
    float a0 = texture2D(_MainTex, (p + v) * iSize).a;
    gl_FragColor = vec4((a1 - a0) * 0.5 + 0.5);
}