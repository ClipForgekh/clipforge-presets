precision highp float;
varying vec2 TexCoords;
#define uv0 TexCoords
uniform sampler2D u_inputTexture;

// ---- CODE ----------------------------------------------------------------
uniform float inputHeight;
uniform float inputWidth;
uniform vec2 center;
uniform float blurScale;    // _replacedText_replacedText_replacedText_replacedText_replacedText_replacedText_replacedText_replacedText_replacedText

uniform float blurStep;
uniform mat4 u_InvModel;
uniform vec2 blurDirection;
uniform float mirrorRange;

const float PI = 3.141592653589793;


void main()
{
    float ratio = inputWidth / inputHeight;

    const int rotateNum = 8;
    float rotateAngle = blurStep * PI / 400.0;

    float fRotateNum = float(rotateNum);
    mat2 startRotateMat = mat2(cos(-rotateAngle * fRotateNum), sin(-rotateAngle * fRotateNum), -sin(-rotateAngle * fRotateNum), cos(-rotateAngle * fRotateNum));    
    mat2 stepRotateMat = mat2(cos(rotateAngle), sin(rotateAngle), -sin(rotateAngle), cos(rotateAngle));

    vec2 uv_ori = uv0 * vec2(ratio, 1.0);
    uv_ori = (u_InvModel * vec4(uv_ori.x * 2.0 - ratio, uv_ori.y * 2.0 - 1.0, 0.0, 1.0)).xy;
    uv_ori.x = (uv_ori.x / ratio + 1.0) / 2.0;
    uv_ori.y = (uv_ori.y + 1.0) / 2.0;

    uv_ori = vec2(1.0 - abs(abs(uv_ori.x) - 1.0), 1.0 - abs(abs(uv_ori.y) - 1.0));
    float A = texture2D(u_inputTexture, uv_ori).a;

    vec2 uv = uv0 * vec2(ratio, 1.0);
    vec2 ct = center * vec2(ratio, 1.0);
    vec2 pixelStep = 1.0/vec2(inputWidth,inputHeight) * blurStep;
    vec2 directionOfBlur = uv - ct;
    float dircLength = length(directionOfBlur);
	pixelStep.x = directionOfBlur.x * 1.0 * dircLength * pixelStep.x;
	pixelStep.y = directionOfBlur.y * 1.0 * dircLength * pixelStep.y;
    // uv = startRotateMat * (uv - ct) + ct;

    vec4 color = vec4(0.0);
    float sumA = 0.0;
	for(int i = -rotateNum + 1; i < rotateNum; i++) {
        uv = uv + pixelStep;
        // vec2 uvT = vec2(1.0 - abs(abs(uv.x) - 1.0), 1.0 - abs(abs(uv.y) - 1.0));
        // vec2 uvT = vec2(mod(uv.x ,1.0), mod(uv.y ,1.0));
        vec2 uvT = (u_InvModel * vec4(uv.x * 2.0 - ratio, uv.y * 2.0 - 1.0, 0.0, 1.0)).xy;
        uvT.x = (uvT.x / ratio + 1.0) / 2.0;
        uvT.y = (uvT.y + 1.0) / 2.0;
        vec2 uvTemp = uvT-.5;
        // uvT = vec2(1.0 - abs(abs(uvT.x) - 1.0), 1.0 - abs(abs(uvT.y) - 1.0));
        uvT = mix(fract(uvT), 1. - fract(uvT), mod(floor(uvT), 2.0));

        vec4 clr = texture2D(u_inputTexture, uvT) * step(abs(uvTemp.x),mirrorRange+0.5) * step(abs(uvTemp.y),mirrorRange+0.5);
        color += clr * clr.a;// * step(uvT.x, 1.0) * step(uvT.y, 1.0) * step(0.0, uvT.x) * step(0.0, uvT.y);
        sumA += clr.a;
	}
    color /= sumA;	
    // color /= 2.0 * fRotateNum - 1.0;	
    // color.a = A;

    // if (A != 0.0) {
	//     gl_FragColor = color;
    // }
    // else {
    //     gl_FragColor = vec4(0.0);
    // }
    gl_FragColor = color;// * ceil(A);
    // gl_FragColor = vec4(TexCoords,0,1);
    // gl_FragColor = texture2D(u_inputTexture, uv);
    // gl_FragColor = vec4(0.3804, 0.8667, 0.1882, 1.0);
}
