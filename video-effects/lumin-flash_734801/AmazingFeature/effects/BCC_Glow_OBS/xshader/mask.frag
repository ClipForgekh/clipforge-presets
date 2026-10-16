precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTexture;
uniform vec2 u_outputSize;
uniform float u_Threshold;
uniform float u_Delta;
uniform int u_Step;
uniform int u_GlowChannels;

#define Channel_RGB        0
#define Channel_Red        1
#define Channel_Green      2
#define Channel_Blue       3
#define Channel_Alpha      4
#define Channel_Luminance  5
#define Channel_Brightness 6

vec4 singleChannelMask(float x, float threshold)
{
    vec4 result = vec4(0.0);
    float t = clamp(threshold, u_Delta, 1.0 - u_Delta);
    float mask0 = smoothstep(t - u_Delta, t, x) - smoothstep(t, t + u_Delta, x);
    // float mask1 = smoothstep(t - u_Delta / 2.0, t - u_Delta, x);

    result.r = mask0;
    if (x < t - u_Delta / 2.0) result.r = 1.0;

    result.g = mask0 * 0.5;
    if (x > t + u_Delta / 2.0) result.g = 1.0;

    // if (x < t) result.b = 1.0;

    // result.a = mask0;

    return result;
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

float getValue(vec2 uv)
{
    vec4 color = texture2D(u_InputTexture, uv);

    if (u_GlowChannels == Channel_Luminance) 
        return getLuminosity(color.rgb);
    else if (u_GlowChannels == Channel_Brightness) 
        return getBrightness(color.rgb);
    else if (u_GlowChannels == Channel_Red) 
        return color.r;
    else if (u_GlowChannels == Channel_Green) 
        return color.g;
    else if (u_GlowChannels == Channel_Blue) 
        return color.b;
    else if (u_GlowChannels == Channel_Alpha) 
        return color.a;
    return color.a;
}

float myEdge(float value)
{
    // return 0.5;
    // return step(value, 0.0) * 2. - 1.;
    if (abs(value) < u_Delta)
    {
        if (value < 0.0) return 1.;
        return -1.;
    }
    return 0.0;
}

float getEdge(float value)
{
    float edge = 0.0;
    vec2 unit = float(u_Step) / u_outputSize.xy;
    if (0.0 > value * (u_Threshold - getValue(uv0 + vec2(-unit.x, unit.y)))) {
        edge = myEdge(value); 
    } else if (0.0 > value * (u_Threshold - getValue(uv0 + vec2(-unit.x, 0)))) { 
        edge = myEdge(value); 
    } else if (0.0 > value * (u_Threshold - getValue(uv0 + vec2(-unit.x, -unit.y)))) {
        edge = myEdge(value);
    } else if (0.0 > value * (u_Threshold - getValue(uv0 + vec2(0, unit.y)))) { 
        edge = myEdge(value);
    } else if (0.0 > value * (u_Threshold - getValue(uv0 + vec2(0, -unit.y)))) { 
        edge = myEdge(value); 
    } else if (0.0 > value * (u_Threshold - getValue(uv0 + vec2(unit.x, unit.y)))) { 
        edge = myEdge(value); 
    } else if (0.0 > value * (u_Threshold - getValue(uv0 + vec2(unit.x, 0)))) {
        edge = myEdge(value); 
    } else if (0.0 > value * (u_Threshold - getValue(uv0 + vec2(unit.x, -unit.y)))) {
        edge = myEdge(value);
    }
    return edge;
}

void main()
{
    vec4 color = vec4(0.0);

    if (u_GlowChannels == Channel_RGB)
    {
        vec4 inputColor = texture2D(u_InputTexture, uv0);
        float r = smoothstep(u_Threshold - u_Delta, u_Threshold + u_Delta, inputColor.r);
        float g = smoothstep(u_Threshold - u_Delta, u_Threshold + u_Delta, inputColor.g);
        float b = smoothstep(u_Threshold - u_Delta, u_Threshold + u_Delta, inputColor.b);
        color.rgb = vec3(r, g, b);
    }
    else
    {
        float value = getValue(uv0);
        color.rgba = singleChannelMask(value, u_Threshold);

        // if (u_Step > 0)
        // {
        //     float edge = getEdge(u_Threshold - value);
        // }
    }

    gl_FragColor = color;
}
