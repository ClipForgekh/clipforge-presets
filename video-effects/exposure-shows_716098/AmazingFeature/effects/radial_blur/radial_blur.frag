precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;
uniform vec2 u_ScreenParams;
uniform float target_scale;
uniform float progress;

vec2 mirror(vec2 x){
    return abs(mod(x-1.,2.)-1.);
}

vec4 radial_blur(vec2 _u)
{
	const int samples = 15;    
    vec4 col = vec4(0);
    vec2 uv = _u;
    for (int i = 0; i < samples; i++)
    {
        col += texture2D(inputTex, mirror((uv-0.5)*mix(1., mix(1., target_scale*4., progress), pow(float(i)/float(samples), 0.2))+0.5));
    }
    return col/(float(samples));
}

float cut(vec2 _u){
    return step(0., _u.x) * step(_u.x, 1.) * step(0., _u.y) * step(_u.y, 1.);
}

void main()
{
    vec2 uv1 = uv0;
    vec4 res = radial_blur(uv1);

    gl_FragColor = res;
}
