precision highp float;
varying vec2 TexCoords;
uniform sampler2D u_inputTexture;
uniform float iTime;
uniform float enLarge;
uniform vec2 transform;
uniform vec4 u_ScreenParams;
uniform float dirBlurStep;
uniform float scaleBlurStep;
uniform vec2 blurDirection;
uniform float dirBlurAlpha;
uniform float scaleBlurAlpha;
// Jason Allen Doucette
// http://xona.com/jason/
//
// Quake-style Underwater Distortion
// May 15, 2016

// ---- HOW IT'S DONE ----------------------------------------------------------------

// Click the mouse to see!

// ---- DESCRIPTION ----------------------------------------------------------------

// I always figured Quake's software underwater effect was merely shearing in X and Y --
// very efficient and effective (and noticeably breaks down if you go super high res,
// like 800x600 to 1024x768 or more, since it didn't scale for the resolution!).
// This is also something GPUs of the day couldn't do. These days, they can!
// Much better than Quake's vertex shifting.

// NOTE:
// This scales to show the entire texture on-screen, maintaining aspect ratio, so it doesn't
// break down when you go fullscreen.  Since screen width is typically > height, this means
// we're likely scaling to screen height.  The comments below assume this.

// ---- SETTINGS ----------------------------------------------------------------
uniform float center;

uniform float delta;

uniform float xAddOffset;
uniform float yAddOffset;

uniform float distortSpeed;

// #define speed 2.0

// the amount of shearing (shifting of a single column or row)
// 1.0 = entire screen height offset (to both sides, meaning it's 2.0 in total)
uniform float xDistMag;
uniform float yDistMag;
// #define xDistMag 0.05
// #define yDistMag 0.05

// cycle multiplier for a given screen height
// 2*PI = you see a complete sine wave from top..bottom
uniform float xSineCycles;
uniform float ySineCycles;
// #define xSineCycles 6.28
// #define ySineCycles 6.28
uniform float distortAlpha;

// ---- CODE ----------------------------------------------------------------
vec2 hash22(vec2 p)
{
    p = vec2(dot(p, vec2(127.1, 311.7)),
        dot(p, vec2(269.5, 183.3)));

    return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}
float perlin_noise(vec2 p)
{
    vec2 pi = floor(p);
    vec2 pf = p - pi;

    vec2 w = pf * pf * (3.0 - 2.0 * pf);

    return mix(mix(dot(hash22(pi + vec2(0.0, 0.0)), pf - vec2(0.0, 0.0)),
            dot(hash22(pi + vec2(1.0, 0.0)), pf - vec2(1.0, 0.0)), w.x),
        mix(dot(hash22(pi + vec2(0.0, 1.0)), pf - vec2(0.0, 1.0)),
            dot(hash22(pi + vec2(1.0, 1.0)), pf - vec2(1.0, 1.0)), w.x),
        w.y);
}

const float PI = 3.141592653589793;

/* random number between 0 and 1 */
float random(in vec3 scale, in float seed) {
    /* use the fragment position for randomness */
    return fract(sin(dot(gl_FragCoord.xyz + seed, scale)) * 43758.5453 + seed);
}

vec4 crossFade(sampler2D tex, in vec2 uv, in float dissolve) {
    return texture2D(tex, uv).rgba;
}

vec4 directionBlur(sampler2D tex, vec2 resolution, vec2 uv, vec2 directionOfBlur, float intensity)
{
    vec2 pixelStep = 1.0 / resolution * intensity;
    float dircLength = length(directionOfBlur);
    pixelStep.x = directionOfBlur.x * 1.0 / dircLength * pixelStep.x;
    pixelStep.y = directionOfBlur.y * 1.0 / dircLength * pixelStep.y;

    vec4 color = vec4(0);
    const int num = 25;
    for (int i = -num; i <= num; i++)
    {
        vec2 blurCoord = uv + pixelStep * float(i);
        vec2 uvT = vec2(1.0 - abs(abs(blurCoord.x) - 1.0), 1.0 - abs(abs(blurCoord.y) - 1.0));
        color += texture2D(tex, uvT);
    }
    color /= float(2 * num + 1);
    return color;
}

vec4 getDirectionBlur(sampler2D tex,vec2 uv0,vec2 tmpBlurDirection)
{
    vec2 resolution = vec2(u_ScreenParams.x, u_ScreenParams.y);
    vec4 resultColor = directionBlur(tex, resolution, uv0, tmpBlurDirection, dirBlurStep);
    vec4 retColor = vec4(resultColor.rgb, resultColor.a) * step(uv0.x, 2.0) * step(uv0.y, 2.0) * step(-1.0, uv0.x) * step(-1.0, uv0.y);
    return retColor;
}

vec4 getScaleBlur(sampler2D tex,vec2 uv0)
{
    vec4 color = vec4(0.0);
    float total = 0.0;
    vec2 toCenter = vec2(0.5, 0.5) - uv0;
    float dissolve = 0.5;

    /* randomize the lookup values to hide the fixed number of samples */
    float offset = random(vec3(12.9898, 78.233, 151.7182), 0.0);
    const int num = 25;
    for (int t = 0; t <= num; t++) {
        float percent = (float(t) + offset) / float(num);
        float weight = 4.0 * (percent - percent * percent);

        vec2 curUV = uv0 + toCenter * percent * scaleBlurStep;
        vec2 uvT = vec2(1.0 - abs(abs(curUV.x) - 1.0), 1.0 - abs(abs(curUV.y) - 1.0));
        color += crossFade(tex, uvT, dissolve) * weight;
        // color += crossFade(uvT + toCenter * percent * blurStep, dissolve) * weight;
        total += weight;
    }
    vec4 retColor = color / total * step(uv0.x, 2.0) * step(uv0.y, 2.0) * step(-1.0, uv0.x) * step(-1.0, uv0.y);
    return retColor;
}

void main()
{
    // isotropic scaling, ensuring entire texture fits into the view.
    // float minRes = min (iResolution.x, iResolution.y);

    // do the scaling.
    // After this, you should consider fragCoord = 0..1, usually,
    // aside from overflow for wide-screen.
    vec2 fragCoord = TexCoords;
    fragCoord += vec2(-transform.x,transform.y);
    // fragCoord = (fragCoord - 0.2);
    // fragCoord.x -= iTime;
    // fragCoord.y += iTime;
    float scale = 1.0 / (enLarge);
    fragCoord = (fragCoord - 0.5) * scale + 0.5;

    // vec2 odd = mod(fragCoord, 2.0);
    // fragCoord = mod(fragCoord, 1.0);
    // if (odd.x > 1.0)
    //     fragCoord.x = 1.0 - fragCoord.x;
    // if (odd.y > 1.0)
    //     fragCoord.y = 1.0 - fragCoord.y;

    // the value for the sine has 2 inputs:
    // 1. the time, so that it animates.
    // 2. the y-row, so that ALL scanlines do not distort equally.
    float time = iTime * distortSpeed;
    float xAngle = (time + fragCoord.y) * xSineCycles + xAddOffset;
    float yAngle = (time + fragCoord.x) * ySineCycles + yAddOffset;

    vec2 distortOffset =
        vec2(sin(xAngle), sin(yAngle)) * // amount of shearing
        vec2(xDistMag, yDistMag) ; // magnitude adjustment

    // shear the coordinates
    // distortOffset.y = - distortOffset.y;
    // distortOffset.y += 0.05;
    fragCoord += distortOffset * distortAlpha;

    vec2 odd = mod(fragCoord, 2.0); 
    fragCoord = mod(fragCoord, 1.0);
    vec2 tmpBlurDirection = blurDirection;
    if (odd.x > 1.0)
    {
        fragCoord.x = 1.0 - fragCoord.x;
        tmpBlurDirection.x = -tmpBlurDirection.x;
    }
    if (odd.y > 1.0)
    {
        fragCoord.y = 1.0 - fragCoord.y;
        tmpBlurDirection.y = -tmpBlurDirection.y;
    }

    vec4 result = texture2D(u_inputTexture, fragCoord);
    gl_FragColor = result;

    #ifdef USE_DIR_BLUR
        // motionBlur
        vec4 dirBlur = getDirectionBlur(u_inputTexture,fragCoord,tmpBlurDirection);
        gl_FragColor = dirBlur;
    #endif

    #ifdef USE_SACLE_BLUR
        //scaleBlur
        vec4 scaleBlur = getScaleBlur(u_inputTexture,fragCoord);
        gl_FragColor = scaleBlur;
    #endif

    // vec2 blurCenter = vec2(0.15, -0.2) * center * 0.5 + 0.5;
    // vec2 uv = (fragCoord - blurCenter);
    // vec2 deltaStep = delta * (fragCoord - blurCenter);
    // deltaStep /= 12.0;
    // vec4 color = vec4(0.0);
    // for (int i = 0; i < 16; ++i)
    // {
    //     vec2 xy = uv + deltaStep * float(i);
    //     color += texture2D(u_inputTexture, vec2(xy + blurCenter));
    // }
    // gl_FragColor = color / 16.0;

    gl_FragColor *= step(0., TexCoords.x) * step(TexCoords.x, 1.) * step(0., TexCoords.y) * step(TexCoords.y, 1.);
}
