precision highp float;
varying vec2 uv0;

#define BLUR_MOTION 0x1
#define BLUR_SCALE  0x2

uniform float inputHeight;
uniform float inputWidth;
uniform float inputRatio;

uniform float leftScale;
uniform float rightScale;
uniform float leftOffsetX;
uniform float leftOffsetY;
uniform float rightOffsetX;
uniform float rightOffsetY;
uniform float blurStep;
uniform mat4 u_Mat;
uniform mat4 u_InvMat;
uniform vec2 blurDirection;
uniform float outputRatio;
uniform float widthIORatio;

uniform sampler2D _MainTex;
uniform sampler2D flagTex;
uniform sampler2D u_InputTex;
#define inputImageTexture u_InputTex

uniform float swing_index;

const float cols = 1.0 / 4.0;
const float rows = 1.0 / 7.0;

uniform float allScale;
uniform float move2X;
uniform float move2Y;
uniform float blur;

// #if defined(BLUR_TYPE) && BLUR_TYPE == BLUR_SCALE
// #define num 12
// #else
// #define num 7
// #endif

/* random number between 0 and 1 */
float random(in vec3 scale, in float seed) {
    /* use the fragment position for randomness */
    return fract(sin(dot(gl_FragCoord.xyz + seed, scale)) * 43758.5453 + seed);
}

void clip(float ratio, float inputRatio, float xRatio, float yRatio, vec2 uv, out float mask) {
    float xMask = step((1. - xRatio) * .5, uv.x) * step(uv.x, 1. - (1. - xRatio) * .5) * step(0., uv.y) * step(uv.y, 1.);
    float yMask = step(0., uv.x) * step(uv.x, 1.) * step((1. - yRatio) * .5, uv.y) * step(uv.y, 1. - (1. - yRatio) * .5);
    mask = mix(
        mix(
            mix(
                1.,
                mix(xMask, yMask, min(step(abs(inputRatio - 1.), .1) + step(ratio, inputRatio), 1.)),
                step(ratio, 1.)
            ),
            mix(xMask, yMask, step(.1, inputRatio)),
            step(abs(ratio - 1.), 1.)
        ),
        mix(xMask, yMask, step(ratio, inputRatio)),
        step(.1, ratio)
    );
}

float needValue(float i){
	float tmp1 = mod(i, 2.);
	float tmp2 = mod(i, 1.);
	float o = 1. * tmp1 - 2. * step(1., tmp1) * tmp2;
	return o;
}

void fit(float ratio, float inputRatio, float xRatio, float yRatio, inout vec2 uv) {
    uv -= .5;
    uv /= mix(
        mix(
            mix(
                vec2(1, 1),
                mix(vec2(xRatio, 1), vec2(1, yRatio), min(step(abs(inputRatio - 1.), .1) + step(ratio, inputRatio), 1.)),
                step(ratio, 1.)
            ),
            mix(vec2(xRatio, 1), vec2(1, yRatio), step(.1, inputRatio)),
            step(abs(ratio - 1.), 1.)
        ),
        mix(vec2(xRatio, 1), vec2(1, yRatio), step(ratio, inputRatio)),
        step(.1, ratio)
    );
    uv += .5;
}

void transform(inout vec2 uv) {
    float ratio = inputWidth / inputHeight;
    uv = (u_Mat * vec4((uv.x * 2.0 - 1.0) * ratio, uv.y * 2.0 - 1.0, 0.0, 1.0)).xy;
    uv.x = (uv.x / ratio + 1.0) / 2.0;
    uv.y = (uv.y + 1.0) / 2.0;
}

void transformInvert(inout vec2 uv) {
    float ratio = inputWidth / inputHeight;
    uv = (u_InvMat * vec4((uv.x * 2.0 - 1.0) * ratio, uv.y * 2.0 - 1.0, 0.0, 1.0)).xy;
    uv.x = (uv.x / ratio + 1.0) / 2.0;
    uv.y = (uv.y + 1.0) / 2.0;

    uv = vec2(uv.x - 0.5, uv.y - 0.5);
    uv *= (1./allScale);
    uv = vec2(uv.x + 0.5, uv.y + 0.5);

}
uniform float time;

vec4 directionBlur(sampler2D tex, vec2 resolution, vec2 uv, vec2 directionOfBlur, float intensity)
{
    // vec2 pixelStep = 1.0/resolution * intensity;
    // float dircLength = length(directionOfBlur);
	// pixelStep.x = directionOfBlur.x * 1.0 / dircLength * pixelStep.x;
	// pixelStep.y = directionOfBlur.y * 1.0 / dircLength * pixelStep.y;

	// vec4 color = vec4(0);
	// for(int i = -7; i <= 7; i++)
	// {
    //    vec2 blurCoord = uv + pixelStep * float(i);
	//    vec2 uvT = vec2(1.0 - abs(abs(blurCoord.x) - 1.0), 1.0 - abs(abs(blurCoord.y) - 1.0));
	//    color += texture2D(tex, uvT);
	// }
	// color /= float(2 * 7 + 1);	
    vec4 color = texture2D(tex, uv);
	return color;
}

void main() {
    float ratio = inputWidth / inputHeight;
    float xRatio = inputRatio / ratio;
    float yRatio = ratio / inputRatio;

    vec2 uv = uv0;

    transformInvert(uv);

    uv = vec2(uv.x - 0.5, uv.y - 0.5);
    uv = vec2(uv.x, uv.y * inputRatio * (1./outputRatio)) * (1./widthIORatio);
    uv = vec2(uv.x + 0.5, uv.y + 0.5);
    uv = vec2(uv.x + move2X, uv.y + move2Y);

    float tt = time;
    float masklu = step(0.0, uv.x) * step(uv.x, 0.5) * step(0.0, uv.y) * step(uv.y, 0.5);
    float maskrd = step(0.5, uv.x) * step(uv.x, 1.0) * step(0.5, uv.y) * step(uv.y, 1.0);
    float maskld = step(0.0, uv.x) * step(uv.x, 0.5) * step(0.5, uv.y) * step(uv.y, 1.0);
    float maskru = step(0.5, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 0.5);
	
    vec2 inputSize = vec2(inputWidth, inputHeight);
    vec2 luuv = vec2(needValue(uv.x + tt), needValue(uv.y));
    vec2 rduv = vec2(needValue(uv.x - tt), needValue(uv.y));
    vec2 lduv = vec2(needValue(uv.x), needValue(uv.y + tt));
    vec2 ruuv = vec2(needValue(uv.x), needValue(uv.y - tt));

    if(swing_index > 0.5){
        luuv.y = 1.-luuv.y;
        rduv.y = 1.-rduv.y;
        lduv.y = 1.-lduv.y;
        ruuv.y = 1.-ruuv.y;
    }

    vec4 luColor = directionBlur(u_InputTex, inputSize, luuv, vec2(-1.,0.), blur);
    vec4 rdColor = directionBlur(u_InputTex, inputSize, rduv, vec2(1.,0.), blur);
    vec4 ldColor = directionBlur(u_InputTex, inputSize, lduv, vec2(0.,1.), blur);
    vec4 ruColor = directionBlur(u_InputTex, inputSize, ruuv, vec2(0.,-1.), blur);

	gl_FragColor = maskld * ldColor + maskru * ruColor + masklu * luColor + maskrd * rdColor;
    // gl_FragColor = texture2D(u_InputTex, uv);
    // gl_FragColor = vec4(ratio,0,0,1);

    // #if defined(BLUR_TYPE) && BLUR_TYPE == BLUR_SCALE
    // vec4 color = vec4(0.0);
    // float total = 0.0;
	// vec2 toCenter = vec2(0.5, 0.5) - uv;
    // float dissolve = 0.5;
    // /* randomize the lookup values to hide the fixed number of samples */
    // float offset3 = random(vec3(12.9898, 78.233, 151.7182), 0.0);

    // float weight = 1. / float(num);
    // for (int t = 0; t <= num; t++) {
    //     float percent = (float(t) + offset3) / float(num);
    //     // float weight = 4.0 * (percent - percent * percent);

	// 	vec2 curUV = uv + toCenter * percent * blurStep;
    //     // vec2 uvT = vec2(1.0 - abs(abs(curUV.x) - 1.0), 1.0 - abs(abs(curUV.y) - 1.0));

    //     float mask = 1.;
    //     // clip(ratio, inputRatio, xRatio, yRatio, curUV, mask);
    //     fit(ratio, inputRatio, xRatio, yRatio, curUV);
    //     color += mix(vec4(0), texture2D(u_InputTex, curUV), mask) * weight;
    //     // color += crossFade(uvT + toCenter * percent * blurStep, dissolve) * weight;
    //     total += weight;
    // }
   	// gl_FragColor = color / total * mask;
    // #else
    // fit(ratio, inputRatio, xRatio, yRatio, uv);
   	// gl_FragColor = texture2D(u_InputTex, uv) * mask;
    // #endif
}
