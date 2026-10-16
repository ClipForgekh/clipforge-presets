precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTexture;
uniform sampler2D u_BlurTexture;
uniform vec3 u_ColorA;
uniform vec3 u_ColorB;
uniform float u_Intensity;
uniform int u_Combine;
uniform float u_Threshold;
uniform int u_GlowChannels;
uniform int u_ShowMode;

#define Channel_RGB        0
#define Channel_Red        1
#define Channel_Green      2
#define Channel_Blue       3
#define Channel_Alpha      4
#define Channel_Luminance  5
#define Channel_Brightness 6

#define BlendOverlayf(s, d)      (d < 0.5 ? (2.0 * d * s) : (1.0 - 2.0 * (1.0 - d) * (1.0 - s))) 
#define BlendOverlay(s, d)       vec3(BlendOverlayf(s.r, d.r), BlendOverlayf(s.g, d.g), BlendOverlayf(s.b, d.b))
#define BlendScreen(s, d)        (s + d - s * d)
#define BlendMultiply(s, d)      (s * d)
#define BlendDifference(s, d)    (abs(s - d))
#define BlendAdd(s, d)           (s + d)
#define BlendSubtract(s, d)      max(vec3(0.0), (d - s))
#define BlendDarken(s, d)        min(s, d)
#define BlendLighten(s, d)       max(s, d)

float softLightf(float s, float d)
{
    return (s < 0.5) ? d - (1.0 - 2.0 * s) * d * (1.0 - d) 
        : (d < 0.25) ? d + (2.0 * s - 1.0) * d * ((16.0 * d - 12.0) * d + 3.0) 
                     : d + (2.0 * s - 1.0) * (sqrt(d) - d);
}

vec3 BlendSoftLight(vec3 s, vec3 d)
{
    return vec3(softLightf(s.r, d.r), softLightf(s.g, d.g), softLightf(s.b, d.b));
}

float hardLightf(float s, float d)
{
    return (s < 0.5) ? 2.0 * s * d : 1.0 - 2.0 * (1.0 - s) * (1.0 - d);
}

vec3 BlendHardLight(vec3 s, vec3 d)
{
    return vec3(hardLightf(s.r, d.r), hardLightf(s.g, d.g), hardLightf(s.b, d.b));
}

// v from rgb2hsv
float getBrightness(vec3 c)
{
    float p = mix(c.b, c.g, step(c.b, c.g));
    return mix(p, c.r, step(p, c.r));
}

float getLuminosity(vec3 color)
{
    return dot(color, vec3(0.299, 0.587, 0.114));
}

vec3 setLuminosity(vec3 c, float lum)
{
    float d = lum - getLuminosity(c);
    c.rgb += vec3(d);

    // clip back into legal range
    lum = getLuminosity(c);
    float cMin = min(c.r, min(c.g, c.b));
    float cMax = max(c.r, max(c.g, c.b));

    if (cMin < 0.0)
        c = mix(vec3(lum,lum,lum), c, lum / (lum - cMin));

    if (cMax > 1.0)
        c = mix(vec3(lum,lum,lum), c, (1. - lum) / (cMax - lum));

    return c;
}

vec3 setSaturationMinMidMax(vec3 cSorted, float s)
{
    if (cSorted.z > cSorted.x)
    {
        cSorted.y = (((cSorted.y - cSorted.x) * s) / (cSorted.z - cSorted.x));
        cSorted.z = s;
    }
    else
    {
        cSorted.y = 0.0;
        cSorted.z = 0.0;
    }

    cSorted.x = 0.0;

    return cSorted;
}

float getSaturation(vec3 c)
{
    return max(c.r, max(c.g, c.b)) - min(c.r, min(c.g, c.b));
}

vec3 setSaturation(vec3 c, float s)
{
    if (c.r <= c.g && c.r <= c.b)
    {
        if (c.g <= c.b)
            c.rgb = setSaturationMinMidMax(c.rgb, s);
        else
            c.rbg = setSaturationMinMidMax(c.rbg, s);
    }
    else if (c.g <= c.r && c.g <= c.b)
    {
        if (c.r <= c.b)
            c.grb = setSaturationMinMidMax(c.grb, s);
        else
            c.gbr = setSaturationMinMidMax(c.gbr, s);
    }
    else
    {
        if (c.r <= c.g)
            c.brg = setSaturationMinMidMax(c.brg, s);
        else
            c.bgr = setSaturationMinMidMax(c.bgr, s);
    }
    
    return c;
}

vec3 BlendHue(vec3 s, vec3 d)
{
    return setLuminosity(setSaturation(s, getSaturation(d)), getLuminosity(d));
}

vec3 BlendSaturation(vec3 s, vec3 d)
{
    return setLuminosity(setSaturation(d, getSaturation(s)), getLuminosity(d));
}

vec3 BlendColor(vec3 s, vec3 d)
{
	return setLuminosity(s, getLuminosity(d));
}

vec3 BlendDarker(vec3 s, vec3 d)
{
	return getLuminosity(d) <= getLuminosity(s) ? d : s;
}

vec3 BlendLighter(vec3 s, vec3 d)
{
	return getLuminosity(d) > getLuminosity(s) ? d : s;
}

void main()
{
    vec4 bgColor = texture2D(u_InputTexture, uv0);
    // gl_FragColor = bgColor; return;

    vec4 blurColor = texture2D(u_BlurTexture, uv0);

    float tqh = blurColor.g * 2.0 - 1.0;
    float mask = (1.0 - abs(tqh)) * blurColor.g;
    float mask1 = step(tqh, 0.0) * (0.5 - mask);

    if (u_ShowMode == 1)
    {
        // gl_FragColor = vec4(vec3(blurColor.r*blurColor.g + clamp(blurColor.b - blurColor.g, 0.0, 1.0)), 1.0);
        // gl_FragColor = vec4(vec3(clamp((1.0-blurColor.g) * u_Intensity, 0.0, 1.0) * u_Intensity * blurColor.g), 1.0);
        // float tqh = smoothstep(0.0, 0.5, clamp((1.0 - blurColor.b) * u_Intensity, 0.0, 1.0)) * blurColor.b;

        gl_FragColor = blurColor * u_Intensity;
        if (u_Combine == 2)
            gl_FragColor = blurColor.rrrr * u_Intensity;
        else if (u_GlowChannels != Channel_RGB)
            gl_FragColor = vec4(vec3(mask) * u_Intensity, 1.0);

        // gl_FragColor = vec4(vec3(factor), 1.0);

        return;
    }

    vec4 fgBlurColor = blurColor;
    if (u_GlowChannels != Channel_RGB)
    {
        if (u_Combine == 2) // Mult Mode
            fgBlurColor = blurColor.rrrr;
        else
            fgBlurColor = vec4(mask);

        fgBlurColor.rgb *= u_ColorB;
    }

    fgBlurColor.rgb *= u_Intensity;
    fgBlurColor.rgb = clamp(fgBlurColor.rgb, 0.0, 1.0);

    float value = 0.0;
    if      (u_GlowChannels == Channel_Red)        value = bgColor.r;
    else if (u_GlowChannels == Channel_Green)      value = bgColor.g;
    else if (u_GlowChannels == Channel_Blue)       value = bgColor.b;
    else if (u_GlowChannels == Channel_Alpha)      value = bgColor.a;
    else if (u_GlowChannels == Channel_Luminance)  value = getLuminosity(bgColor.rgb);
    else if (u_GlowChannels == Channel_Brightness) value = getBrightness(bgColor.rgb);

    vec4 resultColor = bgColor;
    if (u_Combine == 1) resultColor.rgb = BlendAdd(fgBlurColor.rgb, bgColor.rgb);
    else if (u_Combine == 2) resultColor.rgb = BlendMultiply(fgBlurColor.rgb, bgColor.rgb);
    else if (u_Combine == 3) resultColor.rgb = BlendDifference(fgBlurColor.rgb, bgColor.rgb);
    else if (u_Combine == 4)
    {
        if (u_GlowChannels != Channel_RGB) fgBlurColor.rgb += mask1;
        resultColor.rgb = BlendOverlay(fgBlurColor.rgb, bgColor.rgb);
    }
    else if (u_Combine == 5)
    {
        if (u_GlowChannels != Channel_RGB) fgBlurColor.rgb += mask1;
        fgBlurColor.rgb *= 2.0;
        resultColor.rgb = BlendDarken(fgBlurColor.rgb, bgColor.rgb);
    }
    else if (u_Combine == 6) resultColor.rgb = BlendLighten(fgBlurColor.rgb, bgColor.rgb);
    else if (u_Combine == 7)
    {
        if (u_GlowChannels != Channel_RGB) fgBlurColor.rgb += mask1;
        resultColor.rgb = BlendSoftLight(fgBlurColor.rgb, bgColor.rgb);
    }
    else if (u_Combine == 8)
    {
        if (u_GlowChannels != Channel_RGB) fgBlurColor.rgb += mask1;
        resultColor.rgb = BlendHardLight(fgBlurColor.rgb, bgColor.rgb);
    }
    else if (u_Combine == 9)
    {
        if (u_GlowChannels == Channel_RGB)
        {
            resultColor.rgb = fgBlurColor.rgb;
        }
        else
        {
            vec3 result = BlendScreen(fgBlurColor.rgb, bgColor.rgb);
            result = mix(fgBlurColor.rgb, result, clamp(fgBlurColor.r, 0.0, 1.0));
            resultColor.rgb = mix(result, bgColor.rgb, clamp(mask1 * 2.0, 0.0, 1.0));
        }
    }
    else if (u_Combine == 10)
    {
        if (u_GlowChannels == Channel_RGB)
        {
            resultColor.rgb = BlendHue(fgBlurColor.rgb, bgColor.rgb);
        }
        else
        {
            fgBlurColor.rgb += mask1;
            resultColor.rgb = mix(BlendHue(fgBlurColor.rgb, bgColor.rgb), bgColor.rgb, clamp(fgBlurColor.r * 2.0, 0.0, 1.0));
        }
    }
    else if (u_Combine == 11)
    {
        if (u_GlowChannels == Channel_RGB)
        {
            resultColor.rgb = BlendSaturation(fgBlurColor.rgb, bgColor.rgb);
        }
        else
        {
            fgBlurColor.rgb += mask1;
            resultColor.rgb = mix(BlendSaturation(fgBlurColor.rgb, bgColor.rgb), bgColor.rgb, clamp(fgBlurColor.r * 2.0, 0.0, 1.0));
        }
    }
    else if (u_Combine == 12)
    {
        if (u_GlowChannels == Channel_RGB)
        {
            resultColor.rgb = BlendColor(fgBlurColor.rgb, bgColor.rgb);
        }
        else
        {
            fgBlurColor.rgb += mask1;
            resultColor.rgb = mix(BlendColor(fgBlurColor.rgb, bgColor.rgb), bgColor.rgb, clamp(fgBlurColor.r * 2.0, 0.0, 1.0));
        }
    }
    else resultColor.rgb = BlendScreen(fgBlurColor.rgb, bgColor.rgb);

    if (u_GlowChannels != Channel_RGB)
    {
        if (value > u_Threshold) resultColor.rgb += (value * u_ColorA);
        if (u_Combine == 2 ||
            u_Combine == 4 ||
            u_Combine == 5 ||
            u_Combine == 7 ||
            u_Combine == 8 ||
            u_Combine == 9 ||
            u_Combine == 10 ||
            u_Combine == 11 ||
            u_Combine == 12)
        {
            resultColor = mix(bgColor, resultColor, clamp(u_Intensity, 0.0, 1.0));
        }
    }
    resultColor.rgb = clamp(resultColor.rgb, 0.0, resultColor.a);
    gl_FragColor = resultColor;
}
