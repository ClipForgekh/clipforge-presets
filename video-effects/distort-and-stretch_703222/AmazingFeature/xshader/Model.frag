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

uniform vec2 u_NoisePos;
uniform float u_Frequency;
uniform float u_TwistRotFactor;
uniform float u_TwistFactor;
uniform float u_ScaleFactor;
uniform float u_Distort;
uniform vec2 c1;

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
const float PI = 3.141592653589793;

vec2 rotate(vec2 uv, float angle)
{
    float theta = angle / 180.0 * PI;
    mat2 rotMat2 = mat2(cos(theta), -sin(theta)
                        ,sin(theta), cos(theta));
    return rotMat2 * uv;
}


vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}
const mat2 mtx = mat2( 0.80,  0.60, -0.60,  0.80 );

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}


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

vec4 getScaleBlur(sampler2D tex,vec2 uv0, vec2 uv1)
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

        // vec2 curUV = uv0 + toCenter * percent * scaleBlurStep;
        vec2 curUV1 = uv1 + toCenter * percent * scaleBlurStep;
        vec2 uvT = vec2(1.0 - abs(abs(curUV1.x) - 1.0), 1.0 - abs(abs(curUV1.y) - 1.0));
        color += crossFade(tex, uvT, dissolve) * weight;
        // color += crossFade(uvT + toCenter * percent * blurStep, dissolve) * weight;
        total += weight;
    }
    vec4 retColor = color / total * step(uv0.x, 2.0) * step(uv0.y, 2.0) * step(-1.0, uv0.x) * step(-1.0, uv0.y);
    return retColor;
}

vec2 fishEye(vec2 uv, float strength, vec2 point)
{
    uv.x = 1. - uv.x;
    uv += point;
    float d = length(uv);
    float z = sqrt(1. + d * d * strength);
    float r = d/z;
    float phi = atan(uv.y, uv.x);
    uv = vec2(r * cos(phi), r * sin(phi));
    uv -= point;
    uv.x = 1. - uv.x;
    return uv;
}


void main()
{
    // isotropic scaling, ensuring entire texture fits into the view.
    // float minRes = min (iResolution.x, iResolution.y);

    // do the scaling.
    // After this, you should consider fragCoord = 0..1, usually,
    // aside from overflow for wide-screen.
    vec2 fragCoord = TexCoords;

    fragCoord.x *= u_ScreenParams.x/u_ScreenParams.y;

    fragCoord = (fragCoord - .5) / u_ScaleFactor + .5;
    vec2 st1 = ((fragCoord)) * u_Frequency + u_NoisePos;
    vec2 st2 = ((1. - fragCoord)) * u_Frequency + u_NoisePos;
    vec2 pos1 = vec2(st1);
    vec2 pos2 = vec2(st2);

    float x = noise(pos1);
    float y = noise(pos2);
    vec2 xy = rotate(vec2(x, y), u_TwistRotFactor);
    vec2 uv1= (TexCoords - .5) / u_ScaleFactor + .5;

    vec2 uv2 = uv1 - u_TwistFactor * xy;
    fragCoord = fishEye(uv2, u_Distort * 6.0, c1);


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
        vec4 scaleBlur = getScaleBlur(u_inputTexture, uv1, uv2);
        gl_FragColor = scaleBlur;
    #endif

    gl_FragColor *= step(0., TexCoords.x) * step(TexCoords.x, 1.) * step(0., TexCoords.y) * step(TexCoords.y, 1.);
}
