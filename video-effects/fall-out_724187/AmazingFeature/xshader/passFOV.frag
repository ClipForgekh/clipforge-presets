precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform vec4 u_ScreenParams;
uniform vec2 u_center;
uniform float u_fov;
uniform float u_strength;
uniform float u_scale;
uniform float intensity;

float uvProtect(vec2 uv)
{
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

void main()
{
    vec2 uv = uv0;
    vec2 ratio = (u_ScreenParams.xy / max(u_ScreenParams.x, u_ScreenParams.y));
    float scale = max(u_ScreenParams.x / u_ScreenParams.y, u_ScreenParams.y / u_ScreenParams.x);

    uv -= u_center;
    uv *= ratio;
    for (int i = 1; i < 16; ++i)
    {
        float d = length(uv * 2.0);
        uv = uv * pow((d*d) + 1.0, -pow(u_fov * (scale / (16. / 9.)) * u_strength * intensity * 0.0059375, 3.0));
    }
    uv /= ratio;
    uv += u_center;
    gl_FragColor = texture2D(u_albedo, uv) * uvProtect(uv);
}
