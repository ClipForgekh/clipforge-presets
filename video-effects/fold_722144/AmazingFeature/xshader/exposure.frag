precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform float u_Intensity;
uniform float u_GrayscaleCorrect;
uniform float u_Offset;
void ExposureLighten(vec4 i_col, float _alpha, out vec4 o_col){

    o_col = i_col * pow(0.75, -u_Intensity);
    o_col += u_Offset;
    o_col = pow(o_col, vec4(1.0 / u_GrayscaleCorrect));
    o_col = mix(i_col, o_col, _alpha);
}
void main()
{
    vec4 color = texture2D(u_InputTex, uv0);
    float a = color.a;
    ExposureLighten(color, 1.0, color);
    color.a = a;
    gl_FragColor = color;
}
