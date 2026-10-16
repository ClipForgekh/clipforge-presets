precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_Albedo;
uniform vec2 u_ScreenSize;
uniform float u_Size;
uniform float u_Angle;
uniform float u_Bright;
uniform float u_SizeScale;
#define PI 3.1415926
#define GOLDEN_ANGLE 2.39996323
mat2 rotMatrix(float angle)
{
    return mat2(cos(angle), sin(angle),
                    -sin(angle), cos(angle));
}

float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}
vec4 dirBlur(sampler2D inputTexture, vec2 uv, vec2 dir)
{
    float sigma = 7.0;
    float weight = 1.0;
    vec4 resColor = texture2D(inputTexture, uv) * weight;
    float sumWeight = weight;
    vec4 maxColor = resColor;
    float curWeight = 1.0;
    float delay = 0.9;
    float delayWight = curWeight;
    for (int i = 1; i <= 16; ++i)
    {
        weight = 1.0;
        delayWight = delay * delayWight;
        vec2 tmpUV = uv + dir * float(i) * u_Size * u_SizeScale;
        vec4 a = texture2D(inputTexture, tmpUV) * weight;
        tmpUV = uv - dir * float(i) * u_Size * u_SizeScale;
        vec4 b = texture2D(inputTexture, tmpUV);
        resColor += a + b;
        vec4 c = max(a, b);
        // if (dot(c.rgb, vec3(0.33333)) > dot(maxColor.rgb, vec3(0.33333)))
        // {
        //     curWeight = delayWight;
        //     maxColor = c;
        // }
        maxColor = max(c, maxColor);

        sumWeight += 2.0 * weight;
    }
    resColor /= sumWeight;
    // for (int i = 1; i <= 10; ++i)
    // {
    //     vec2 d = vec2(cos(theta), sin(theta));
        
    //     float r1 = (floor(theta / PI * 0.5 + 0.001) + 1.0);
    //     vec2 tmpUV = uv + d * r1 / u_ScreenParams.xy * u_Size;
    //     vec4 a = texture2D(inputTexture, tmpUV);
    //     resColor += a;
    //     maxColor = max(a, maxColor);
    //     theta += PI * 0.2 / r1;
    // }
    // resColor /= 11.0;

    vec4 color = mix(resColor, maxColor, clamp(resColor * u_Bright, 0.0, 1.0));
    resColor.rgb = color.rgb;
    return resColor;
}





void main()
{
    float theta = u_Angle * PI / 180.0;
    vec2 rect = vec2(min(720.0, 720.0 * u_ScreenSize.x / u_ScreenSize.y), min(720.0, 720.0 * u_ScreenSize.y / u_ScreenSize.x));
    vec2 dir = vec2(cos(theta), sin(theta)) / rect.xy;
    vec4 color = dirBlur(u_Albedo, uv0, dir);
    gl_FragColor = color;
}
