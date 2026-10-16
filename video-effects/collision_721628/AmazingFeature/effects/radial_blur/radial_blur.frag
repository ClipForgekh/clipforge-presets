precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;
uniform vec2 u_ScreenParams;
uniform float rotate;
uniform vec2 center;

vec2 mirror(vec2 x){ return abs(mod(x-1.,2.)-1.); }

const float PI = 3.1415926;
vec2 Rotate(vec2 _u, float angle)
{
    float radius = angle/180.*PI;
    vec2 ru = _u-center;
    // ru.x *= u_ScreenParams.x/u_ScreenParams.y;
    // ru.y *= u_ScreenParams.y/u_ScreenParams.x;
    ru *= mat2(cos(radius), -sin(radius), sin(radius), cos(radius));
    // ru.x /= u_ScreenParams.x/u_ScreenParams.y;
    // ru.y /= u_ScreenParams.y/u_ScreenParams.x;
    return ru + center;
}

vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }
float cut(vec2 u) {return step(0., u.x)*step(u.x, 1.)*step(0., u.y)*step(u.y, 1.); }

vec4 radial_rotate_blur(vec2 _u)
{
	const int samples = 15;    
    vec4 col = vec4(0);
    vec2 uv = _u;
    for (int i = 0; i < samples; i++)
    {
        vec2 u1 = Rotate(_u, mix(0., rotate, float(i)/float(samples)));
        vec2 u2 = Rotate(_u, mix(0., -rotate, float(i)/float(samples)));
        col += texture2D(inputTex, u1);
        col += texture2D(inputTex, u2);
    }
    return col/(float(samples*2));
}

void main()
{
    vec2 uv1 = uv0;
    vec4 res = radial_rotate_blur(uv1);

    // res = texture2D(inputTex, uv1);
    // res = vec4(uv1,0,1);
    gl_FragColor = res;
}
