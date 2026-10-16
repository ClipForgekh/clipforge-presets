precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTexture;
uniform sampler2D inputTexture1;

vec3 OneMinus(vec3 color)
{
    color = vec3(1.0) - color;
    return color;
}

void main()
{
    vec3 outboxColor = texture2D(inputTexture, uv0).rgb;
    vec3 inboxColor = texture2D(inputTexture1, uv0).rgb;
    vec3 finalboxColor = clamp(outboxColor - inboxColor, 0.0, 1.0);
    // vec3 finalboxColor = outboxColor * OneMinus(inboxColor);

    gl_FragColor = vec4(finalboxColor, finalboxColor.r);
}
