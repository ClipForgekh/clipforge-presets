precision highp float;

uniform sampler2D _MainTex;
uniform float u_intensity;

varying vec2 v_xy;

#define SQRT2 1.41421356237


float quadInOut (float t) {
    float t_ = 2.0 * t * t;
    float _t = (4.0 - t - t) * t - 1.0;
    return mix(t_, _t, step(t, 0.5));
}

void main () {
//    float t = length(v_xy);
//    float t = length(v_xy) / SQRT2;

//    t = (t) * (1.0 - t);
//    t = 1.0 - quadInOut(t);

//    vec2 xy = v_xy + normalize(v_xy) * (t * u_intensity);
//    vec2 xy = v_xy * (1.0 + t * u_intensity);


    vec2 t = abs(v_xy);
    t = (t) * (1.0 - t);

    vec2 xy = v_xy + normalize(v_xy) * t * u_intensity;

    gl_FragColor = texture2D(_MainTex, xy * 0.5 + 0.5);
}

