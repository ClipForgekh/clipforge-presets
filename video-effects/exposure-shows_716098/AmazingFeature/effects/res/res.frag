precision highp float;

varying vec2 uv0;

uniform sampler2D obTex;

uniform vec2 offset;
uniform float scale;

vec2 Mirror(vec2 x){
    return abs(mod(x-1., 2.)-1.);
}

void main()
{
    vec2 uv1 = uv0;
    uv1 += offset * 0.5;
    uv1 -= 0.5;
    uv1 *= scale;
    uv1 += 0.5;

    vec4 res = texture2D(obTex, Mirror(uv1));
    gl_FragColor = res;
}
