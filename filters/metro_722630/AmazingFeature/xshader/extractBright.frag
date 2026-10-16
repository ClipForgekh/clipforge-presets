precision highp float;
varying vec2 TexCoords;
uniform sampler2D u_inputTexture;
uniform float threshold;

void main()
{
    vec4 result = texture2D(u_inputTexture, TexCoords);
    // check whether fragment output is higher than threshold, if so output as brightness color
    float brightness = dot(result.rgb, vec3(0.2126, 0.7152, 0.0722));
    if(brightness > threshold)
        gl_FragColor = result;
    else
        gl_FragColor = vec4(0.0, 0.0, 0.0, result.a);
}
