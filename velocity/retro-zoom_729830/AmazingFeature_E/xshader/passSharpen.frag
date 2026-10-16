precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform sampler2D u_albedo;
uniform vec4 u_ScreenParams;
uniform float sharpenIntensity;

void main()
{
    vec2 uv1 = uv0;
    vec4 inputColor = texture2D(u_albedo, uv1);
    vec4 resultColor = texture2D(inputTex, uv1);
    resultColor.rgb = (inputColor.rgb - resultColor.rgb) * 5. * sharpenIntensity + resultColor.rgb;
    gl_FragColor = resultColor;
}
