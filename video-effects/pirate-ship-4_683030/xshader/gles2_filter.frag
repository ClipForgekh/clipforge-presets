precision highp float;
varying vec2 uv0;
#define texCoord uv0

#define BLUR_MOTION 0x1
#define BLUR_SCALE  0x2

uniform float inputHeight;
uniform float inputWidth;
uniform vec2 center;
uniform float blurScale;    // 控制径向模糊的强度

uniform float blurStep;
uniform mat4 u_InvModel;
uniform vec2 blurDirection;

uniform sampler2D _MainTex;
#define inputImageTexture _MainTex

#if defined(BLUR_TYPE) && BLUR_TYPE == BLUR_SCALE
#define num 25
#else
#define num 7
#endif

const float PI = 3.141592653589793;

/* random number between 0 and 1 */
float random(in vec3 scale, in float seed) {
    /* use the fragment position for randomness */
    return fract(sin(dot(gl_FragCoord.xyz + seed, scale)) * 43758.5453 + seed);
}

vec4 crossFade(in vec2 uv, in float dissolve) {
    return texture2D(inputImageTexture, uv).rgba;
}

vec4 directionBlur(sampler2D tex, vec2 resolution, vec2 uv, vec2 directionOfBlur, float intensity)
{
    vec2 pixelStep = 1.0/resolution * intensity;
    float dircLength = length(directionOfBlur);
	pixelStep.x = directionOfBlur.x * 1.0 / dircLength * pixelStep.x;
	pixelStep.y = directionOfBlur.y * 1.0 / dircLength * pixelStep.y;

	vec4 color = vec4(0);
	for(int i = -num; i <= num; i++)
	{
       vec2 blurCoord = uv + pixelStep * float(i);
	   vec2 uvT = vec2(1.0 - abs(abs(blurCoord.x) - 1.0), 1.0 - abs(abs(blurCoord.y) - 1.0));
	   color += texture2D(tex, uvT);
	}
	color /= float(2 * num + 1);	
	return color;
}

vec3 refract0(vec3 i, vec3 n, float eta) {
    float cosi = dot(-i, n);
    float cost2 = 1.0 - eta * eta * (1.0 - cosi * cosi);
    vec3 t = eta * i + ((eta * cosi - sqrt(abs(cost2))) * n);
    return t;
}

// vec4 circleBlur(sampler2D inputImageTexture, vec2 center, vec2 uv0, float intensity) {
//     const float rotateNum = 27.0;
//     const float rotateAngle = PI / 800.0;

//     vec2 inv_ratio = vec2(inputHeight / inputWidth, 1.0);

//     mat2 startRotateMat = mat2(cos(-rotateAngle * rotateNum), sin(-rotateAngle * rotateNum), -sin(-rotateAngle * rotateNum), cos(-rotateAngle * rotateNum));    
//     mat2 stepRotateMat = mat2(cos(rotateAngle), sin(rotateAngle), -sin(rotateAngle), cos(rotateAngle));
//     vec2 uv = startRotateMat * (uv0 - center) + center;

// 	vec4 color = vec4(0.0);
// 	for(int i = -int(rotateNum) + 1; i < int(rotateNum); i++)
// 	{
//        uv = stepRotateMat * (uv - center) + center;
// 	   vec2 uvT = vec2(1.0 - abs(abs(uv.x) - 1.0), 1.0 - abs(abs(uv.y) - 1.0));
// 	   color += texture2D(inputImageTexture, uvT);
// 	}
// 	color /= 2.0 * rotateNum - 1.0;	
//     color.a = 1.0;
    
// 	return color;
// }

void main() {

    float ratio = inputWidth / inputHeight;

    const int rotateNum = 10;
    float rotateAngle = blurScale * PI / 400.0;

    float fRotateNum = float(rotateNum);
    mat2 startRotateMat = mat2(cos(-rotateAngle * fRotateNum), sin(-rotateAngle * fRotateNum), -sin(-rotateAngle * fRotateNum), cos(-rotateAngle * fRotateNum));    
    mat2 stepRotateMat = mat2(cos(rotateAngle), sin(rotateAngle), -sin(rotateAngle), cos(rotateAngle));

    vec2 uv_ori = uv0 * vec2(ratio, 1.0);
    uv_ori = (u_InvModel * vec4(uv_ori.x * 2.0 - ratio, uv_ori.y * 2.0 - 1.0, 0.0, 1.0)).xy;
    uv_ori.x = (uv_ori.x / ratio + 1.0) / 2.0;
    uv_ori.y = (uv_ori.y + 1.0) / 2.0;
    uv_ori = vec2(1.0 - abs(abs(uv_ori.x) - 1.0), 1.0 - abs(abs(uv_ori.y) - 1.0));
    float A = texture2D(inputImageTexture, uv_ori).a;

    vec2 uv = uv0 * vec2(ratio, 1.0);
    vec2 ct = center * vec2(ratio, 1.0);
    uv = startRotateMat * (uv - ct) + ct;

    vec4 color = vec4(0.0);
    float sumA = 0.0;
	for(int i = -rotateNum + 1; i < rotateNum; i++) {
        uv = stepRotateMat * (uv - ct) + ct;
        // vec2 uvT = vec2(1.0 - abs(abs(uv.x) - 1.0), 1.0 - abs(abs(uv.y) - 1.0));
        // vec2 uvT = vec2(mod(uv.x ,1.0), mod(uv.y ,1.0));
        vec2 uvT = (u_InvModel * vec4(uv.x * 2.0 - ratio, uv.y * 2.0 - 1.0, 0.0, 1.0)).xy;
        uvT.x = (uvT.x / ratio + 1.0) / 2.0;
        uvT.y = (uvT.y + 1.0) / 2.0;
        uvT = vec2(1.0 - abs(abs(uvT.x) - 1.0), 1.0 - abs(abs(uvT.y) - 1.0));
        vec4 clr = texture2D(inputImageTexture, uvT);
        color += clr * clr.a * step(uvT.x, 1.0) * step(uvT.y, 1.0) * step(0.0, uvT.x) * step(0.0, uvT.y);
        sumA += clr.a;
	}
    color /= sumA;	
    // color /= 2.0 * fRotateNum - 1.0;	
    color.a = A;

    // if (A != 0.0) {
	//     gl_FragColor = color;
    // }
    // else {
    //     gl_FragColor = vec4(0.0);
    // }
    gl_FragColor = color * ceil(A);
}
