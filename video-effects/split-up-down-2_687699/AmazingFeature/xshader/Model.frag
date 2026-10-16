precision highp float;

uniform sampler2D u_InputTex;

varying vec2 v_UV0;

#define BLUR_MOTION 0x1
#define BLUR_SCALE  0x2

uniform float u_InputWidth;
uniform float u_InputHeight;
uniform highp float u_OutputWidth;
uniform highp float u_OutputHeight;
uniform vec2 u_UVScale;
uniform float topRotation;
uniform float bottomRotation;
uniform float topScale;
uniform float bottomScale;
uniform float blurStep;
uniform vec2 blurDirection;

#if defined(BLUR_TYPE) && BLUR_TYPE == BLUR_SCALE
#define num 12
#else
#define num 7
#endif

/* random number between 0 and 1 */
float random(in vec3 scale, in float seed) {
    /* use the fragment position for randomness */
    return fract(sin(dot(gl_FragCoord.xyz + seed, scale)) * 43758.5453 + seed);
}

void clip(vec2 uv, out float mask) {
    mask = step(0., uv.x) * step(uv.x, 1.) * step(0., uv.y) * step(uv.y, 1.);
}

void clipByScale(vec2 uv, vec2 scale, out float mask) {
    mask = step(1. - 1. / scale.x, uv.x) * step(uv.x, 1. / scale.x) * step(1. - 1. / scale.y, uv.y) * step(uv.y, 1. / scale.y);
}

void clipByID(int id, vec2 uv, out float mask) {
    if (id == 0) {
        mask = step(0., uv.x) * step(uv.x, 1.) * step(.5, uv.y) * step(uv.y, 1.);
    } else if (id == 1) {
        mask = step(0., uv.x) * step(uv.x, 1.) * step(0., uv.y) * step(uv.y, .5);
    }
}

void transformUV(vec2 tilling, vec2 offset, float angle, vec2 scale, vec4 tillingOffset, inout vec2 uv, inout float mask) {
    float inputRatio = u_InputWidth / u_InputHeight;
    uv -= .5;
    uv -= offset;
    uv.x *= inputRatio;
    uv = mat2(cos(angle), -sin(angle), sin(angle), cos(angle)) * uv;
    uv *= 1. / scale;
    uv *= tilling;
    uv.x /= inputRatio;
    uv += .5;
    mask = step(0., uv.x) * step(uv.x, 1.) * step(0., uv.y) * step(uv.y, 1.);
    uv = uv * tillingOffset.xy + tillingOffset.zw;
}

void transformUVByID(int id, inout vec2 uv, inout float mask) {
    if (id == 0) {
        transformUV(vec2(1, 2), vec2(0, .25), topRotation, vec2(topScale), vec4(1, .5, 0, .5), uv, mask);
    } else if (id == 1) {
        transformUV(vec2(1, 2), vec2(0, -.25), bottomRotation, vec2(bottomScale), vec4(1, .5, 0, 0), uv, mask);
    } 
}

vec4 directionBlur(sampler2D tex, vec2 resolution, vec2 uv, vec2 directionOfBlur, float intensity, int id)
{
    vec2 pixelStep = 1.0/resolution * intensity;
    float dircLength = max(length(directionOfBlur), .000001);
	pixelStep.x = directionOfBlur.x * 1.0 / dircLength * pixelStep.x;
	pixelStep.y = directionOfBlur.y * 1.0 / dircLength * pixelStep.y;

	vec4 color = vec4(0);
	for(int i = -7; i <= 7; i++)
	{
        vec2 blurCoord = uv + pixelStep * float(i);
        // vec2 uvT = vec2(1.0 - abs(abs(blurCoord.x) - 1.0), 1.0 - abs(abs(blurCoord.y) - 1.0));
        float mask = 1.;
        clipByID(id, blurCoord, mask);
        color += texture2D(tex, blurCoord) * mask;
	}
	color /= float(2 * 7 + 1);	
	return color;
}

vec4 scaleBlur(vec2 uv, int id) {
    vec4 color = vec4(0.0);
    float total = 0.0;
	vec2 toCenter = vec2(0.5, 0.5) - uv;
    float dissolve = 0.5;
    /* randomize the lookup values to hide the fixed number of samples */
    float offset3 = random(vec3(12.9898, 78.233, 151.7182), 0.0);

    for (int t = 0; t <= 12; t++) {
        float percent = (float(t) + offset3 - .5) / float(12);
        float weight = 4.0 * (percent - percent * percent);

		vec2 curUV = uv + toCenter * percent * blurStep;
        // vec2 uvT = vec2(1.0 - abs(abs(curUV.x) - 1.0), 1.0 - abs(abs(curUV.y) - 1.0));

        float mask = 1.;
        clipByID(id, curUV, mask);
        if (id == 1) {
            // mask = step(.32, curUV.x) * step(curUV.x, .68) * step(0., curUV.y) * step(curUV.y, 1.);
        }
        color += texture2D(u_InputTex, curUV) * mask * weight;
        // color += crossFade(uvT + toCenter * percent * blurStep, dissolve) * weight;
        total += weight;
    }
    return color / total;
}

vec4 blend(vec4 srcColor, vec4 dstColor) {
    return dstColor * (1. - srcColor.a) + srcColor;
}

void main ()
{
    vec4 color0 = vec4(0);
    vec4 color1 = vec4(0);
    vec2 uv0 = v_UV0;
    float mask0 = 1.;
    vec2 uv1 = v_UV0;
    float mask1 = 1.;
 
    transformUVByID(0, uv0, mask0);
    transformUVByID(1, uv1, mask1);

#if defined(BLUR_TYPE) && BLUR_TYPE == BLUR_MOTION
	vec2 resolution = vec2(u_OutputWidth,u_OutputHeight);
    color0 = directionBlur(u_InputTex, resolution, uv0, blurDirection, blurStep, 0);
    color1 = directionBlur(u_InputTex, resolution, uv1, blurDirection, blurStep, 1);
#elif defined(BLUR_TYPE) && BLUR_TYPE == BLUR_SCALE
    color0 = scaleBlur(uv0, 0);
    color1 = scaleBlur(uv1, 1);
#else
    color0 = texture2D(u_InputTex, uv0) * mask0;
    color1 = texture2D(u_InputTex, uv1) * mask1;
#endif
    gl_FragColor = blend(color0, color1);
}
