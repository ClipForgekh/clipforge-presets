precision highp float;
varying highp vec2 textureCoordinate;
uniform sampler2D u_albedo;
uniform float sharpenIntensity;
uniform float lightIntensity;

void main()
{
    vec2 uv0 = textureCoordinate;
    // uv0 = (uv0 - .5) * 3. + .5;
    uv0 = clamp(uv0, 0., 1.);
    // uv0 = (textureCoordinate + 1.0)*0.50;
    vec2 uv1 = vec2(fract(mod(uv0, 1. / 3.) * 3.));
    vec4 resultColor = texture2D(u_albedo, uv1);

    gl_FragColor = resultColor;

}
