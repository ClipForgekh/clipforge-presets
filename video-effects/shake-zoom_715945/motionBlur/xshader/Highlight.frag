precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;

uniform float threshold1;

void main()
{
    vec4 inputColor = texture2D(u_albedo, uv0);
    //float c = clamp((dot(inputColor.rgb, inputColor.rgb) * 0.333 - threshold1) * 5.0, 0.0, 1.0);
    float c = clamp((dot(inputColor.rgb, vec3(0.333))  - threshold1) * 5.0, 0.0, 1.0);
    gl_FragColor = vec4(c, c, c, inputColor.a);
}