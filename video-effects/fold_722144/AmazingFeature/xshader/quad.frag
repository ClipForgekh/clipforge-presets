precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform sampler2D u_MaskTex;
uniform vec4 u_Time;
uniform float u_WaveHeight;
uniform float u_WaterDepth;
uniform float u_Eta;
uniform vec4 u_ScreenParams;
uniform float u_Scale;
uniform float u_Alpha;
#define PI 3.1415926
float decode(vec4 g)
{
    float ret = 0.0;
    ret = g.x + g.y / 255.0 + g.z / (65025.0) + g.w / (16581375.0);
    return ret;
}

vec2 flip_uv(vec2 uv)
{
    vec2 z = abs(mod(uv + 1., 2.) - 1.0);
    return mod(z, 1.0);
}

vec2 scale_uv(vec2 uv, float scale)
{
    uv -= .5;
    uv *= 1.0 / scale;
    uv += .5;
    return uv;
}
void main()
{
    vec2 uvx = vec2(1.0 / u_ScreenParams.x, 0.0);
    vec2 uvy = vec2(0.0, 1.0 / u_ScreenParams.y);
    vec2 uv = vec2(uv0.x, uv0.y);
    vec4 c = texture2D(u_MaskTex, uv);
    float gray = decode(c);
    vec4 c1 = texture2D(u_MaskTex, uv + uvx);
    float gray1 = decode(c1);
    vec4 c2 = texture2D(u_MaskTex, uv - uvx);
    float gray2 = decode(c2);
    vec4 c3 = texture2D(u_MaskTex, uv + uvy);
    float gray3 = decode(c3);
    vec4 c4 = texture2D(u_MaskTex, uv - uvy);
    float gray4 = decode(c4);
    float dx = (gray1 - gray2) / (2.);
    float dy = (gray3 - gray4) / (2.);
    vec2 n = (vec2(dx, dy));
    n *= 255. / min(u_ScreenParams.x, u_ScreenParams.y) * 191.0;
    vec2 uvt = uv0;
    uvt = uvt - n * (gray + u_WaterDepth) * pow(u_WaveHeight, 1.0) * pow(u_Eta - 1.0, 0.75);
    uvt = flip_uv(uvt);
    gl_FragColor = texture2D(u_albedo, uvt);
}
