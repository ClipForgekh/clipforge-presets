precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform sampler2D kira2Texture;
uniform vec4 u_ScreenParams;

void main()
{
    vec4 inputColor = texture2D(u_albedo, uv0);
    vec4 kira2Color = texture2D(kira2Texture, (uv0 - .5) / 1. + .5);
    vec4 resultColor = mix(inputColor, kira2Color, kira2Color.a);

    // resultColor.a = inputColor.a;
    gl_FragColor = resultColor;
    // gl_FragColor = resultColor;

    gl_FragColor.a = max(inputColor.a, kira2Color.a);    
}
