precision highp float;

uniform sampler2D u_videoTex;

varying vec2 uv;

void main ()
{
    // vec2 uv1=uv;
    // uv1.y=1.-uv1.y;
    // gl_FragColor = texture2D(u_videoTex, uv);
    vec4 color = texture2D(u_videoTex, uv);
    if (color.a < .01) discard;
    gl_FragColor = color;
}

