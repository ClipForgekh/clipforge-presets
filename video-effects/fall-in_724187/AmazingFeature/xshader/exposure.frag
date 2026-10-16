precision highp float;

uniform sampler2D _MainTex;
uniform float u_Intensity;
uniform float u_Offset;
uniform float u_GrayscaleCorrect;

varying vec2 v_uv;


vec3 ExposureLighten(vec3 col){
    col = col * pow(0.75, -u_Intensity);
    col += u_Offset;
    col = pow(col, vec3(1.0 / u_GrayscaleCorrect));
    return col;
}

void main () {
    vec4 base = texture2D(_MainTex, v_uv);
    base.rgb = ExposureLighten(base.rgb);
    gl_FragColor = base;
}

