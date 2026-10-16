precision highp float;
varying vec2 TexCoords;

uniform sampler2D u_vertBlurTexture;
uniform sampler2D u_inputTexture;
uniform float exposure;
uniform vec3 color;
uniform float enableGammaCorrect;
uniform float hue;
uniform float u_edge;

vec3 ChangeHue(vec3 col, float h){
    float shift = 2.0*h*3.1415926535;
    vec3 m = vec3(cos(shift), -sin(shift) * .57735, 0);
    m = vec3(m.xy, -m.y) + (1. - m.x) * .3333;
    return clamp(mat3(m, m.zxy, m.yzx) * col, vec3(0.), vec3(1.));
}


void main()
{
    const float gamma = 2.2;
    vec4 diffuse = texture2D(u_inputTexture, TexCoords);
    vec3 hdrColor = diffuse.rgb;
    vec3 bloomColor = texture2D(u_vertBlurTexture, TexCoords).rgb;
    vec3 col = color * u_edge;
    bloomColor *= col;
    vec3 result = hdrColor + bloomColor; // additive blending

    if(enableGammaCorrect > 0.5)
    {
        // tone mapping
        result = vec3(1.0) - exp(-result * exposure);
        // also gamma correct while we're at it
        result = pow(result, vec3(1.0 / gamma));
    }
    gl_FragColor = vec4(result, diffuse.a);
}
