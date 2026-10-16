precision highp float;

uniform sampler2D u_videoTex;
varying vec2 uv;

void main ()
{
    gl_FragColor = texture2D(u_videoTex, uv);
    //gl_FragColor = vec4(uv1,0,1);
}

