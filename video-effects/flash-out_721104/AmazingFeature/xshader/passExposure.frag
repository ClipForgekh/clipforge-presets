precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTex;
uniform vec4 u_ScreenParams;
uniform float u_Intensity;
uniform float u_Offset;
uniform float u_scale;

// u_Alpha: 1
// u_Intensity: 1
// u_Offset: 0

void ExposureLighten(vec4 i_col, float _alpha, out vec4 o_col){
    float x = pow((u_Intensity) * 0.263, 2.92) + pow((u_Intensity) * 0.34, 0.92);
    o_col = i_col * vec4(x+1.) + u_Offset;
    o_col = mix(i_col, o_col, _alpha);
}

void main()
{
    vec2 uv1 = (uv0 - .5) / u_scale + .5;

    vec4 resultColor = texture2D(u_inputTex, uv1);
    if (u_Intensity > 0.)
        ExposureLighten(resultColor, 1., resultColor);
    else
        resultColor.rgb *= 1. + u_Intensity * .2;
    gl_FragColor = resultColor;
}