precision highp float;

uniform sampler2D inputTex;

// uniform float w;
// uniform float h;
// uniform vec2 wh;
uniform vec2 tile_centr;


varying vec2 uv;

vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}

void main ()
{
    vec2 uv1 = uv;
    // uv1 -= vec2(0.5, 0.5);
    // uv1 /= 1.2;
    uv1 -= tile_centr;
    // uv1 += vec2(0.5, 0.5);


    gl_FragColor = texture2D(inputTex, flip_uv(uv1));
}

