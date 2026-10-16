precision highp float;
varying highp vec2 textureCoordinate;
uniform sampler2D u_albedo;
uniform float sharpenIntensity;
uniform float lightIntensity;

void main()
{
    vec2 uv0 = textureCoordinate;
    uv0.x = (uv0.x - .5) * 3. + .5;
    uv0.x = clamp(uv0.x, 0., 1.);
    // uv0 = (textureCoordinate + 1.0)*0.50;
    vec2 uv1 = vec2(uv0.x, fract(mod(uv0.y, 1. / 3.) * 3.));
    vec4 resultColor = texture2D(u_albedo, uv1);
    resultColor.rgb *= 1. + lightIntensity;
    resultColor.rgb = (resultColor.rgb - .5) * (1. + sharpenIntensity) + .5;
    resultColor = mix(resultColor, vec4(0,0,0, (1. - (uv0.x - .95) / .05) * .5), step(.95, uv0.x));
    resultColor = mix(resultColor, vec4(0,0,0, (uv0.x / .05) * .5), step(uv0.x, .05));

    gl_FragColor = resultColor;

}
