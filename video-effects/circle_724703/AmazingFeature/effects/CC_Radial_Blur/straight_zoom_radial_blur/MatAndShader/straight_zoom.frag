precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform vec2 u_Center;
uniform vec4 u_ScreenParams;
uniform float u_Amount;
uniform float u_Quality;
uniform float u_Alpha;
void main()
{
    float quality = clamp(u_Quality * 0.01, 0.1, 1.0) * 1.8;
    float amount = u_Amount * u_ScreenParams.x / 720.0 * 3.2;
    vec2 uv = uv0;
    vec2 dir = (uv - u_Center);
    float x = length(uv - u_Center);
    dir = dir / u_ScreenParams.x * (amount) * 1.0;
    float weight = 1.0;
    vec4 res = texture2D(u_InputTex, uv) * weight;
    float sumWeight = weight;
    float s = (1.0 + abs(amount) * quality * x);
    vec2 d = dir / s;

    const float maxSamples = 40.;     // Custom Value;

    for (float i = 1.0; i < maxSamples; i += 1.0) 
    {
        weight = 1.0;
        // vec4 tmp = (texture2D(u_InputTex, uv - float(i) * d)) * weight;
        vec4 tmp = (texture2D(u_InputTex, uv - mix(1., s, (i-1.)/maxSamples) * d)) * weight;
        res += tmp;
        sumWeight += weight;
    }
    res = vec4(res / sumWeight);
    gl_FragColor = res;
    
}