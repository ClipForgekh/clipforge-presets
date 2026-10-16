precision highp float;
varying highp vec2 uv0;

uniform sampler2D inputImageTexture;
uniform vec4 u_ScreenParams;
uniform float expandRight;
uniform float expandLeft;
uniform float expandUp;
uniform float expandDown;
uniform float expandMode;
uniform float blendBorders;
uniform float runningMode;

vec2 cvtUV1(vec2 uv)
{
    float s_x = 1.0 + expandLeft + expandRight;
    float s_y = 1.0 + expandUp + expandDown;
    uv.x = (uv.x) * s_x - expandLeft;
    uv.y = (uv.y) * s_y - expandDown;
    return uv;
}

vec2 cvtUV2(vec2 uv)
{
    float s_x = 1.0 + expandLeft + expandRight;
    float s_y = 1.0 + expandUp + expandDown;
    uv.x = (uv.x + expandLeft)/s_x;
    uv.y = (uv.y + expandDown)/s_y;
    return uv;
}

float mirrorTexCoord(float coord) {
    float t = mod(coord, 2.0);
    t += (1.0-step(0., t))*2.0;
    t = (1.0-step(t, 1.))*(2.0 - t) + step(t, 1.)*t;
    return t;
}

float repeatTexCoord(float coord) {
    float t = mod(coord, 1.0);
    t += (1.0-step(0., t));
    return t;
}

void main() 
{
    if (runningMode > 1.5 )
    {
        vec2 uv1 = cvtUV2(uv0);
        gl_FragColor = texture2D(inputImageTexture, uv1);
        return;
    }
    if (expandMode < 0.5)
    {
        vec2 uv1 = cvtUV1(uv0);
        if (runningMode < 0.5 )
        {
            uv1 = cvtUV2(uv1);
        }
        gl_FragColor = texture2D(inputImageTexture, uv1);
        return;
    }
    else if (expandMode < 1.5)
    {
        vec2 uv1 = cvtUV1(uv0);
        vec2 uv2 = uv1;
        uv2.x = mirrorTexCoord(uv2.x);
        uv2.y = mirrorTexCoord(uv2.y);
        if (runningMode < 0.5 )
        {
            uv2 = cvtUV2(uv2);
        }
        gl_FragColor = texture2D(inputImageTexture, uv2);
        return;
    }
    else if (expandMode < 2.5)
    {
        vec2 uv1 = cvtUV1(uv0);
        vec2 uv2 = uv1;
        uv2.x = repeatTexCoord(uv2.x);
        uv2.y = repeatTexCoord(uv2.y);
        vec2 uv3 = uv2;
        uv3.x = 1.0 -uv3.x;
        vec2 uv4 = uv2;
        uv4.y = 1.0 -uv4.y;
        vec2 uv5 = uv2;
        uv5.x = 1.0 -uv5.x;
        uv5.y = 1.0 -uv5.y;
        if (runningMode < 0.5 )
        {
            uv2 = cvtUV2(uv2);
            uv3 = cvtUV2(uv3);
            uv4 = cvtUV2(uv4);
            uv5 = cvtUV2(uv5);
        }

        vec4 color2 = texture2D(inputImageTexture, uv2);
        vec4 color3 = texture2D(inputImageTexture, uv3);
        vec4 color4 = texture2D(inputImageTexture, uv4);
        vec4 color5 = texture2D(inputImageTexture, uv5);
        float w1 = smoothstep((1.0-blendBorders*0.4), (1.1-blendBorders*0.4), abs(0.5-mirrorTexCoord(uv1.x))*2.);
        color2 = mix(color2, color3, w1*0.5);
        color4 = mix(color4, color5, w1*0.5);
        float w2 = smoothstep((1.0-blendBorders*0.4), (1.1-blendBorders*0.4), abs(0.5-mirrorTexCoord(uv1.y))*2.);
        color2 = mix(color2, color4, w2*0.5);

        gl_FragColor = color2;

        return;
    }
    gl_FragColor = texture2D(inputImageTexture, uv0);
}