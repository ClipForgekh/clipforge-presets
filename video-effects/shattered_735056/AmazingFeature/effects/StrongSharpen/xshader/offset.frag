precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;

uniform float u_offsetX;
uniform float u_offsetY;


void main()
{
    // apply offset for red and blue channel (chromatic aberration)
    vec4 color = texture2D(u_inputTexture, uv0);
    vec2 offsetUV = vec2(u_offsetX, u_offsetY) * (1. - uv0) * uv0;

    vec2 redUV = uv0 + offsetUV;
    vec4 redOffsetColor = texture2D(u_inputTexture, redUV);
    color.r = redOffsetColor.r;

    vec2 blueUV = uv0 - offsetUV;
    vec4 blueOffsetColor = texture2D(u_inputTexture, blueUV);
    color.b = blueOffsetColor.b;

    color.a = (redOffsetColor.a + color.a + blueOffsetColor.a) / 3.;
    gl_FragColor = color;
}
