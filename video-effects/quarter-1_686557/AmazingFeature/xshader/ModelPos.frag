precision highp float;

uniform sampler2D u_videoTex;

varying vec2 uv;
varying vec4 lastScreenPos;
varying vec4 screenPos;

void main ()
{
    // gl_FragColor = texture2D(u_videoTex, uv);
    vec2 dir = screenPos.xy / screenPos.w - lastScreenPos.xy / lastScreenPos.w;
    gl_FragColor = vec4(dir * .5 + .5, 0, 1);
}

