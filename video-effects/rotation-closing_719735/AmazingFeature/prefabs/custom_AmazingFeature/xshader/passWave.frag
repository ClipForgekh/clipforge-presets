precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform float waveHeight;
uniform float waveWidth;
uniform float progress;
void main()
{
    vec2 uv1 = uv0;
    // float waveWidth = 0.;
    // float waveHeight = 1.;
    float xOffset = sin((1. - uv1.y) * (10.5 - 1.5 * waveWidth) + 1.2 * progress * 6.28) * .07 * waveHeight;
    uv1.x += xOffset;
    gl_FragColor = texture2D(u_albedo, uv1);
}
