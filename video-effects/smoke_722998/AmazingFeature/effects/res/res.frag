precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex1;
uniform sampler2D inputTex2;

uniform float alpha;
uniform float scale;
uniform vec2 pos;
uniform vec2 pivot;

uniform vec4 u_ScreenParams;

vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }

float cut(vec2 u) {return step(0., u.x)*step(u.x, 1.)*step(0., u.y)*step(u.y, 1.); }

void main()
{
    vec2 uv1 = uv0;
    uv1 += pos;
    uv1 -= pivot;
    uv1 /= scale;
    uv1 += pivot;
    // uv1.y = 1.-uv1.y;
    vec4 col1 = texture2D(inputTex1, Mirror(uv1));

    vec2 uv2 = uv0;
    vec4 col2 = texture2D(inputTex2, Mirror(uv2));

    vec4 res = mix(col2, col1, alpha);
    res = mix(col2, res, res.a);
    res.a = max(col2.a, res.a);

    gl_FragColor = res;
}
