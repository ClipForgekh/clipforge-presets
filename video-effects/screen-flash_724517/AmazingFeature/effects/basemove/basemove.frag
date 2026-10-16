precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;

uniform float scale;
uniform vec2 pos;

uniform vec4 u_ScreenParams;

uniform float u_fov;
const float u_strength = 0.7;
const float intensity = 1.0;

vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }

float cut(vec2 u) {return step(0., u.x)*step(u.x, 1.)*step(0., u.y)*step(u.y, 1.); }

float dynamic_collage(vec2 u) {return step(-0.05, u.x)*step(u.x, 1.05)*step(-0.05, u.y)*step(u.y, 1.05); }

vec2 optical_compensate(vec2 _u){
    vec2 uv = _u;
    vec2 ratio = (u_ScreenParams.xy / max(u_ScreenParams.x, u_ScreenParams.y));
    float scale = max(u_ScreenParams.x / u_ScreenParams.y, u_ScreenParams.y / u_ScreenParams.x);
    for (int i = 1; i < 16; ++i)
    {
        uv -= 0.5;
        uv *= ratio;
        float d = length(uv * 2.0);
        uv = uv * pow((d*d) + 1.0, -pow(u_fov * (scale / (16. / 9.)) * u_strength * intensity * 0.0059375, 3.0));
        uv /= ratio;

        uv += 0.5;
    }
    return uv;
}

void main()
{
    vec2 uv1 = uv0;
    uv1 += pos;
    uv1 -= 0.5;
    uv1 /= scale;
    uv1 += 0.5;
    // uv1.y = 1.-uv1.y;

    uv1 = optical_compensate(uv1);

    vec4 res = texture2D(inputTex, Mirror(uv1)) * dynamic_collage(uv1);

    gl_FragColor = res;
}
