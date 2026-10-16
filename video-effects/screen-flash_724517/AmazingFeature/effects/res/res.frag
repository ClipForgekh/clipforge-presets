precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex1;
uniform sampler2D inputTex2;

uniform float alpha;
uniform float scale;
uniform vec2 pos;
uniform vec2 pivot;
uniform float exposure;

uniform vec4 u_ScreenParams;

vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }

float cut(vec2 u) {return step(0., u.x)*step(u.x, 1.)*step(0., u.y)*step(u.y, 1.); }


void ExposureLighten(inout vec3 col, float _intensity, float _offset, float _gray_scale_correct, float _linear){

    if(_linear>0.5) col = pow(col, vec3(2.2));
    col *= pow(0.75, -_intensity);
    col += _offset;
    col = pow(col, vec3(1.0 / _gray_scale_correct));

    if (_linear>0.5) col = pow(col, vec3(1.0/2.2));
}

void main()
{
    vec2 uv1 = uv0;
    // uv1 += pos;
    // uv1 -= pivot;
    // uv1 /= scale;
    // uv1 += pivot;
    // uv1.y = 1.-uv1.y;
    vec4 col1 = texture2D(inputTex1, Mirror(uv1));

    vec2 uv2 = uv0;
    vec4 col2 = texture2D(inputTex2, Mirror(uv2));

    vec4 res = mix(col2, col1, alpha);
    res = mix(col2, res, res.a);
    res.a = max(col2.a, res.a);

    res = col2;
    // res = vec4(col2.a,0,0,1);
    // res = col1;
    // res = vec4(1,0,0,1);
    ExposureLighten(res.rgb, exposure, 0., 1., 0.);
    res *= alpha;

    gl_FragColor = res;
}
