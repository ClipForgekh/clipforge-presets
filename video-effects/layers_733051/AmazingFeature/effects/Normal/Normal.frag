precision highp float;

varying vec2 uv0;

uniform sampler2D mainTex;

void main()
{
    vec4 mainCol = texture2D(mainTex, uv0);
    vec4 res = mainCol;
    gl_FragColor = res;
}
