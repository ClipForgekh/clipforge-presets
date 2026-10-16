precision highp float;

uniform sampler2D u_bgTex;

varying vec2 uv;

void main ()
{
    gl_FragColor = texture2D(u_bgTex, uv);
    //gl_FragColor = vec4(uv.xy, 0.0, 1.0);
    //gl_FragColor = vec4(1,0,0,1);
}

