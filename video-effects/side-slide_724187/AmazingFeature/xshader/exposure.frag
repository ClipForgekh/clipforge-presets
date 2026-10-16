precision highp float;

uniform sampler2D _MainTex;
uniform float u_Intensity;
uniform float u_Offset;
uniform float u_GrayscaleCorrect;

varying vec2 v_uv;


vec4 ExposureLighten(vec4 col){
    col = col * pow(0.75, -u_Intensity);
    col += u_Offset;
    col = pow(col, vec4(1.0 / u_GrayscaleCorrect));
    return col;
}

void main () {
    vec4 base = texture2D(_MainTex, v_uv);
    base = ExposureLighten(base);
    gl_FragColor = base;
}

