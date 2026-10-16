precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform vec2 u_Center;
uniform vec4 u_ScreenParams;
uniform float u_Amount;
uniform float u_Quality;
uniform float u_Alpha;
#define PI 3.1415926
vec2 rotate(vec2 uv, vec2 center, float angle)
{
    float theta = angle * PI / 180.0;
    float sint = sin(theta), cost = cos(theta);
    uv -= center;
    uv = mat2(cost, sint, -sint, cost) * uv;
    return uv + center;

}
void main()
{
    const int SAMPLES = 32;
    float quality = clamp(u_Quality * 0.01, 0.1, 1.0) * 2.6 * u_ScreenParams.x / 720.0;
    float amount = u_Amount * 7.9;
    vec2 uv = uv0;
    float x = length(uv - u_Center);
    float weight = 1.0;
    vec4 res = texture2D(u_InputTex, uv) * weight;
    float sumWeight = weight;
    float s = abs(amount) * x * quality + 1.0;
    float angle = 0.225;
    angle = angle * (amount) / floor(s + 1.0);
    for (float i = 1.0; i < s; i += 1.0)
    {
        vec2 tmpUV = rotate(uv, u_Center, i * angle);
        res += texture2D(u_InputTex, tmpUV) * weight;
        sumWeight += weight;
    }

    res = vec4(res / sumWeight);
    gl_FragColor = res;
}