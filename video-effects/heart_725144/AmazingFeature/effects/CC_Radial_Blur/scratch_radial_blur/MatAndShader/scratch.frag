precision lowp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform vec2 u_Center;
uniform vec4 u_ScreenParams;
uniform float u_Amount;
uniform float u_Quality;
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
    float weight = 0.0;
    vec4 res = texture2D(u_InputTex, uv) * weight;
    float sumWeight = weight;
    float s = abs(amount) * x * quality * 0.5 + 1.0;
    float angle = 0.225;
    float a = 0.0;

    const float maxSamples = 40.;     // Custom Value;
    
    // for (float i = -s + 1.0; i < s; i += 1.0)   
    //     a += 1.0;
    // angle = angle * (amount) / (a);

    angle = angle * (amount) / maxSamples;

    

    for (float i = 0.0; i < maxSamples; i += 1.0)
    {
        weight = 1.0;
        vec2 tmpUV = rotate(uv, u_Center, -(amount) * 0.225 * 0.5 + mix(0., maxSamples, i/maxSamples) * angle);
        res += texture2D(u_InputTex, tmpUV) * weight;
        sumWeight += weight;
    }

    gl_FragColor = vec4(res / sumWeight);
}