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

uniform sampler2D _MainTex;
uniform sampler2D u_InputTex;
uniform sampler2D flagTex;
// uniform sampler2D _MainTex;
#define inputImageTexture u_InputTex
uniform float swing_index;

const float cols = 1.0 / 4.0;
const float rows = 1.0 / 7.0;

#if defined(BLUR_TYPE) && BLUR_TYPE == BLUR_SCALE
#define num 12
#else
#define num 7
#endif
uniform vec2 inputSize;
/* random number between 0 and 1 */
float random(in vec3 scale, in float seed) {
    /* use the fragment position for randomness */
    return fract(sin(dot(gl_FragCoord.xyz + seed, scale)) * 43758.5453 + seed);
}

void clip(float ratio, float inputRatio, float xRatio, float yRatio, vec2 uv, out float mask) {
    // float edge = max(abs(blurStep) / 4., .001);
    // float xMask = smoothstep((1. - inputRatio / ratio) * .5, (1. - inputRatio / ratio) * .5 + edge, uv.x)
    //     * smoothstep(1. - (1. - inputRatio / ratio) * .5, 1. - (1. - inputRatio / ratio) * .5 - edge, uv.x)
    //     * smoothstep(0., edge, uv.y)
    //     * smoothstep(1., 1. - edge, uv.y);
    // float yMask = smoothstep(0., edge, uv.x)
    //     * smoothstep(1., 1. - edge, uv.x)
    //     * smoothstep((1. - ratio / inputRatio) * .5, (1. - ratio / inputRatio) * .5 + edge, uv.y)
    //     * smoothstep(1. - (1. - ratio / inputRatio) * .5, 1. - (1. - ratio / inputRatio) * .5 - edge, uv.y);
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

    // if (ratio > 1.) { // 4:3 16:9
    //     if (ratio > inputRatio) {
    //         mask = xMask;
    //     } else {
    //         mask = yMask;
    //     }
    // } else if (abs(ratio - 1.) < .1) { // 1:1
    //     if (inputRatio < 1.) {
    //         mask = xMask;
    //     } else {
    //         mask = yMask;
    //     }
    // } else if (ratio < 1.) { // 9:16 3:4
    //     if (abs(inputRatio - 1.) < .1 || ratio < inputRatio) {
    //         mask = yMask;
    //     } else {
    //         mask = xMask;
    //     }
    // }
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

    // if (ratio > 1.) { // 4:3 16:9
    //     if (ratio > inputRatio) {
    //         uv /= vec2(xRatio, 1);
    //     } else {
    //         uv /= vec2(1, yRatio);
    //     }
    // } else if (abs(ratio - 1.) < .1) { // 1:1
    //     if (inputRatio < 1.) {
    //         uv /= vec2(xRatio, 1);
    //     } else {
    //         uv /= vec2(1, yRatio);
    //     }
    // } else if (ratio < 1.) { // 9:16 3:4
    //     if (abs(inputRatio - 1.) < .1 || ratio < inputRatio) {
    //         uv /= vec2(1, yRatio);
    //     } else {
    //         uv /= vec2(xRatio, 1);
    //     }
    // }
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
}

void main() {
    float ratio = inputWidth / inputHeight;
    float xRatio = inputRatio / ratio;
    float yRatio = ratio / inputRatio;

    vec2 uv = uv0;
    transformInvert(uv);

    float scale = mix(1. / leftScale, 1. / rightScale, step(0., uv.x));
    uv -= .5;
    uv *= scale;
    uv += .5;

    float offsetX = mix(leftOffsetX, rightOffsetX, step(.5, uv.x));
    float offsetY = mix(leftOffsetY, rightOffsetY, step(.5, uv.x));
    float middleMask = step(abs(offsetX), abs(uv.x - .5));

    uv.x -= offsetX;
    uv.y -= offsetY;

    // uv -= 0.5;
    // if(inputHeight > inputWidth)
    //     uv.y *= (inputSize.y/inputSize.x) * (inputWidth/inputHeight);
    // else
    //     uv.x *= (inputSize.x/inputSize.y) * (inputHeight/inputWidth);
    // uv += 0.5;

    float mask = 1.;
    clip(ratio, inputRatio, xRatio, yRatio, uv, mask);
    mask *= middleMask;

    #if defined(BLUR_TYPE) && BLUR_TYPE == BLUR_SCALE
    vec4 color = vec4(0.0);
    float total = 0.0;
	vec2 toCenter = vec2(0.5, 0.5) - uv;
    float dissolve = 0.5;
    /* randomize the lookup values to hide the fixed number of samples */
    float offset3 = random(vec3(12.9898, 78.233, 151.7182), 0.0);

    float weight = 1. / float(num);
    for (int t = 0; t <= num; t++) {
        float percent = (float(t) + offset3) / float(num);
        // float weight = 4.0 * (percent - percent * percent);

		vec2 curUV = uv + toCenter * percent * blurStep;
        // vec2 uvT = vec2(1.0 - abs(abs(curUV.x) - 1.0), 1.0 - abs(abs(curUV.y) - 1.0));

        float mask = 1.;
        // clip(ratio, inputRatio, xRatio, yRatio, curUV, mask);
        fit(ratio, inputRatio, xRatio, yRatio, curUV);
        if(swing_index>0.5) curUV.y = 1.-curUV.y;
        color += mix(vec4(0), texture2D(u_InputTex, curUV), mask) * weight;
        // color += crossFade(uvT + toCenter * percent * blurStep, dissolve) * weight;
        total += weight;
    }
   	gl_FragColor = color / total * mask;
    #else
    fit(ratio, inputRatio, xRatio, yRatio, uv);
    if(swing_index>0.5) uv.y = 1.-uv.y;
   	gl_FragColor = texture2D(u_InputTex, uv) * mask;
    #endif
}
