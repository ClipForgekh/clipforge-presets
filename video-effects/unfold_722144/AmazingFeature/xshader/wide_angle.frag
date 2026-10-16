precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_Albedo;
uniform sampler2D _MainTex;
uniform float u_Strength;
uniform vec4 u_ScreenParams;

float uvProtect(vec2 uv)
{
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

void main()
{

    vec2 uv = uv0;
    vec2 ratio = (u_ScreenParams.xy / max(u_ScreenParams.x, u_ScreenParams.y));
    for (int i = 1; i < 9; ++i)
    {
        uv -= 0.5;
        uv *= ratio;
        float d = length(uv * 2.0);
        uv = uv * pow((d*d) + 1.0, -pow(u_Strength * 0.0049375, 3.0));
        uv /= ratio;

        uv += 0.5;
    }
    gl_FragColor = texture2D(u_Albedo, uv) * uvProtect(uv);

}