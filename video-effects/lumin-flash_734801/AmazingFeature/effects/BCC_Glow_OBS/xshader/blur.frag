precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTexture;
uniform vec2 u_outputSize;
uniform float u_Radius;
uniform float u_Sigma;
uniform float u_MaxRadius;
uniform int u_edgeMode;
uniform int u_GlowChannels;

vec2 getS(float a, float b)
{
    vec2 s = vec2(1.0);
    if (u_edgeMode == 0)
    {
        s.x = step(0.0, a) * step(a, 1.0);
        s.y = step(0.0, b) * step(b, 1.0);
    }
    return s;
}

vec4 neighborColor(float i)
{
    vec2 unit = 1.0 / u_outputSize.xy;
#ifdef AE_HORZ
    vec2 uv1 = uv0 + unit * vec2(i, 0.);
    vec2 uv2 = uv0 - unit * vec2(i, 0.);
    vec2 s = getS(uv1.x, uv2.x);
#else
    vec2 uv1 = uv0 + unit * vec2(0., i);
    vec2 uv2 = uv0 - unit * vec2(0., i);
    vec2 s = getS(uv1.y, uv2.y);
#endif
    return texture2D(u_InputTexture, uv1) * s.x + texture2D(u_InputTexture, uv2) * s.y;
}

float Gaussian(float x, float sigmaSquare)
{
    return exp(-(x * x) / sigmaSquare);
}

#define ITERATIONS 1024.0
vec4 blurColor(vec4 color)
{
    vec4 weight = vec4(1.0);
    vec4 w = vec4(0.0);
    bool loopFlag = true;
    float stepI = max(1.0, u_Radius / u_MaxRadius);
    float i = 1.0;
    for (float j = 1.0; j <= ITERATIONS; j += 1.0)
    {
        if (i > ITERATIONS) break;
        loopFlag = i <= u_Radius;
        if (i > u_MaxRadius * stepI || !loopFlag)
        {
            break;
        }
        w.r = step(i, u_Radius) * Gaussian(float(i), u_Sigma);
        w.g = step(i, u_Radius) * Gaussian(float(i), u_Sigma);
        w.b = step(i, u_Radius) * Gaussian(float(i), u_Sigma);
        w.a = step(i, u_Radius) * Gaussian(float(i), u_Sigma);
        color += neighborColor(i) * w;
        weight += w * 2.;

        i += stepI;
    }
    color /= weight;
    return color;
}

void main()
{
    vec4 curColor = texture2D(u_InputTexture, uv0);
    gl_FragColor = blurColor(curColor);
}
