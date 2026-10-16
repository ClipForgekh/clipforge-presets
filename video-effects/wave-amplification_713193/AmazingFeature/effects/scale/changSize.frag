precision highp float;
varying vec2 texCoord;

uniform sampler2D inputTexture;
uniform float size;

void main()
{
    vec2 uv1 = (vec2(texCoord.x, texCoord.y)-0.5)/size+0.5;
    uv1=abs(mod(uv1-1.,2.)-1.);

    vec4 res = vec4(texture2D(inputTexture, uv1));
    gl_FragColor = res;
}