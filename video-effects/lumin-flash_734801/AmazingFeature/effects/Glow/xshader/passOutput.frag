precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTexture;
uniform sampler2D u_blurTexture;
uniform vec3 u_colorA;
uniform vec3 u_colorB;
uniform float u_intensity;
uniform int u_show;
uniform int u_glowColors;
uniform int u_blendMode;
uniform float u_colorLoops;
uniform float u_colorPhase;
uniform float u_midpoint;

#define blendScreen(s, d) (s + d - s * d)
#define blendMultiply(s, d) (s * d)
#define blendDifference(s, d) (abs(s - d))
#define blendAdd(s, d) (s + d)
#define blendLighten(s, d) max(s, d)
#define blendExclusion(s, d) (d + s - 2.0 * d * s)

const float Pi = 3.1415926;
const float Eps = 0.0001;

// linearly remap value from [srcMin, srcMax] to [dstMin, dstMax]
float remap(float value, float srcMin, float srcMax, float dstMin, float dstMax)
{
    return (value - srcMin) * (dstMax - dstMin) / (srcMax - srcMin) + dstMin;
}

// get mixing factor to mix color a & b for ab mode
float getAB(float x)
{
    // x_ = (x + b) % 1
    // y = ceil(ax_) - ax_
    float x_ = mod(x + u_colorPhase, 1.01);
    x_ *= u_colorLoops;
    float y0 = ceil(x_) - x_;
    if (u_midpoint == 0.5) {
        return y0;
    }
    float midpoint = clamp(u_midpoint, 0.01, 0.99);
    float y1 = (y0 - 1.0) / (2.0 * max(1.0 - midpoint, Eps)) + 1.0;
    y0 /= max(2.0 * midpoint, Eps);
    if (y0 < 0.5) {
        return clamp(y0, 0.0, 0.5);
    }
    return clamp(y1, 0.5, 1.0);
}

// get mixing factor to mix color a & b for aba mode
float getABA(float x)
{
    // x_ = (x + b) % 1
    // y = 0.5 * (1.0 - cos(2πax_))
    // float x_ = mod(x + u_colorPhase, 1.01);
    // return 0.5 * (1.0 - cos(2.0 * Pi * u_colorLoops * x_));

    // y0 = 0.5(1 + cos(π|x|^(2c)))
    // y1 = 1 - 0.5(1 + cos(π(1 - |x|)^(2(1 - c))))
    x = mod(x + u_colorPhase, 1.0);
    x = mod(x, 1.0 / u_colorLoops);
    x = x * u_colorLoops; // remap(x, 0.0, 1.0 / u_colorLoops, 0.0, 1.0);
    x = x * 2.0 - 1.0;
    float y = 0.0;
    float midpoint = remap(u_midpoint, 0.0, 1.0, 0.1, 0.9);
    if (midpoint <= 0.5) {
        y = 0.5 * (1.0 + cos(Pi * pow(abs(x), 2.0 * midpoint)));
    } else {
        y = 1.0 - 0.5 * (1.0 + cos(Pi * pow(1.0 - abs(x), 2.0 * (1.0 - midpoint))));
    }

    return y;
}

vec4 adjustColor(vec4 sourceColor)
{
    if (u_glowColors < 1) {
        return sourceColor;
    }

    if (u_glowColors == 1) {
        vec4 ABColor = sourceColor;

        // float t = 1.0;
        // for (float i = u_colorLoops; i > 0.0; i -= 1.0)
        // {
        //     float t0 = t - t / u_colorLoops * (i - 1.0);
        //     if (gray <= t0)
        //     {
        //         float t1 = t - t / u_colorLoops * i;
        //         ABColor.rgb = sourceColor.rgb * mix(u_colorB, u_colorA, m * 0.4 + rangeMapper(gray, t1, t0,
        //         0.0, 1.0)); break;
        //     }
        // }

        ABColor.rgb = mix(u_colorA, u_colorB, vec3(getAB(sourceColor.r))) * ABColor.a;

        return ABColor;
    } else if (u_glowColors == 2) {
        vec4 ABAColor = sourceColor;
        ABAColor.rgb = mix(u_colorB, u_colorA, vec3(getABA(sourceColor.r))) * ABAColor.a;
        return ABAColor;
    }

    return sourceColor;
}

void main()
{
    vec4 baseColor = texture2D(u_inputTexture, uv0);
    vec4 mask = texture2D(u_blurTexture, uv0);
    if (u_show == 1) {
        gl_FragColor = mask;
        return;
    }
    vec4 blurColor = adjustColor(mask);
    blurColor *= u_intensity;
    if (blurColor.a > 1.0) {
        blurColor /= blurColor.a;
    }
    if (u_show == 2 || u_blendMode == 6) {
        gl_FragColor = blurColor;
        return;
    }

    vec4 resultColor = baseColor;
    if (u_blendMode == 1) {
        blurColor = 1. - mask + blurColor;
        resultColor.rgb = blendMultiply(blurColor.rgb, baseColor.rgb);
    } else if (u_blendMode == 2) {
        resultColor.rgb = blendDifference(blurColor.rgb, baseColor.rgb);
    } else if (u_blendMode == 3) {
        resultColor.rgb = blendLighten(blurColor.rgb, baseColor.rgb);
    } else if (u_blendMode == 4) {
        resultColor.rgb = blendScreen(blurColor.rgb, baseColor.rgb);
    } else if (u_blendMode == 5) {
        resultColor.rgb = blendExclusion(blurColor.rgb, baseColor.rgb);
    } else {
        resultColor.rgb = blendAdd(blurColor.rgb, baseColor.rgb);
    }

    resultColor.a = blurColor.a + (1.0 - blurColor.a) * baseColor.a;

    gl_FragColor = resultColor;
}
