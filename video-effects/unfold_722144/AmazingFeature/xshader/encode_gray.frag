precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_MaskTex;
uniform sampler2D _MainTex;
uniform vec4 u_ScreenParams;
vec4 encode(float gray)
{
    vec4 res = vec4(0.0, 0.0, 0.0, 0.0);
    gray *= 255.0;
    res.x = floor(gray) / 255.0;

    gray = fract(gray);
    gray *= 255.0;
    res.y = floor(gray) / 255.0;

    gray = fract(gray);
    gray *= 255.0;
    res.z = floor(gray) / 255.0;

    // gray = fract(gray);
    // gray *= 255.0;
    gray = fract(gray);
    res.w = gray;
    return res;
}
float decode(vec4 g)
{
    float ret = 0.0;
    ret = g.x + g.y / 255.0 + g.z / (65025.0) + g.w / (16581375.0);
    return ret;
}
float uvProtect(vec2 uv)
{
    vec2 _uv = step(uv, vec2(1.0)) * step(vec2(0.0), uv);
    return _uv.x * _uv.y;
}
void main()
{
    vec2 uv = vec2(uv0.x, 1. - uv0.y);
    uv -= .5;
    uv *= u_ScreenParams.xy / max(u_ScreenParams.x, u_ScreenParams.y);
    uv += 0.5;
    vec4 c = texture2D(_MainTex, uv) * uvProtect(uv);
    vec4 g = encode(c.r);
    gl_FragColor = g;
}
