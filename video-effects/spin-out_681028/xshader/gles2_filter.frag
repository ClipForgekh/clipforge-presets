precision highp float;
varying vec2 uv0;
#define texCoord uv0

#define BLUR_MOTION 0x1
#define BLUR_SCALE  0x2

uniform float time;
// uniform float aspect;

uniform float inputHeight;
uniform float inputWidth;

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

void main() {

    float ratio = inputWidth / inputHeight;

    vec2 uv = (u_InvModel * vec4((uv0.x * 2.0 - 1.0) * ratio, uv0.y * 2.0 - 1.0, 0.0, 1.0)).xy;

    uv.x = (uv.x / ratio + 1.0) / 2.0;
    uv.y = (uv.y + 1.0) / 2.0;

    //  ------------------------------
    // vec2 uv1 = uv * vec2(2.0, 2.0) - vec2(1.0, 1.0);
    // float r = 0.3 * time;
    // vec2 st = normalize(uv1) * r;
    // vec2 uv2 = st + uv1 * vec2(0.1, 0.2);
    // vec2 uv3 = uv2;

    vec2 uv1 = uv * vec2(2.0, 2.0) - vec2(1.0, 1.0);

    float k = 0.0;
    vec2 st = vec2(0.0, 0.0);
    float eps = 0.0001;
    if (uv1.x != 0.0) {
        k = uv1.y / uv1.x;
        float st_x = time * sqrt(1.0/(0.25+k*k)) * sign(uv1.x);     //  椭圆方程x²/(2t)² + y²/t² = 1，代入y=kx，注意解的符号
        st = vec2(st_x, k * st_x);
    }
    else {
        st = vec2(0, time) * sign(uv1.y);
    }
    
    // float abs_ex = abs(e.x);
    // float abs_ey = abs(e.y);

    vec2 e = normalize(uv1);
    float eScale = 1.0 / max(abs(e.x), abs(e.y));
    vec2 ed0 = e * eScale;
    vec2 ed = ed0 + vec2(2.0, 1.5) * e * time;

    float s = 0.0;
    if (ed0.x != 0.0) s = uv1.x / ed0.x;
    else s = uv1.y / ed0.y;

    vec2 uv2 = st + (ed - st) * s;
    vec2 uv3 = uv2;

    if (uv2.x < -3.0) uv3.x = -1.0;
    else if (uv2.x > 3.0) uv3.x = 1.0;
    else if (uv2.x < -1.0) uv3.x = -2.0 - uv2.x;
    else if (uv2.x > 1.0) uv3.x = 2.0 - uv2.x;

    if (uv2.y < -3.0) uv3.y = -1.0;
    else if (uv2.y > 3.0) uv3.y = 1.0;
    else if (uv2.y < -1.0) uv3.y = -2.0 - uv2.y;
    else if (uv2.y > 1.0) uv3.y = 2.0 - uv2.y;

    uv = (uv3 + vec2(1.0, 1.0)) * vec2(0.5, 0.5);
    //  ------------------------------

#if defined(BLUR_TYPE) && BLUR_TYPE == BLUR_MOTION
	vec2 resolution = vec2(inputWidth,inputHeight);
	//vec2 resolution = vec2(720.0,1280.0);
	vec4 resultColor = directionBlur(inputImageTexture,resolution,uv,blurDirection, blurStep);
	gl_FragColor = vec4(resultColor.rgb, resultColor.a) * step(uv.x, 2.0) * step(uv.y, 2.0) * step(-1.0, uv.x) * step(-1.0, uv.y);

#elif defined(BLUR_TYPE) && BLUR_TYPE == BLUR_SCALE
	vec4 color = vec4(0.0);
    float total = 0.0;
	vec2 toCenter = vec2(0.5, 0.5) - uv;
    float dissolve = 0.5;

    /* randomize the lookup values to hide the fixed number of samples */
    float offset = random(vec3(12.9898, 78.233, 151.7182), 0.0);

    for (int t = 0; t <= num; t++) {
        float percent = (float(t) + offset) / float(num);
        float weight = 4.0 * (percent - percent * percent);

		vec2 curUV = uv + toCenter * percent * blurStep;
        vec2 uvT = vec2(1.0 - abs(abs(curUV.x) - 1.0), 1.0 - abs(abs(curUV.y) - 1.0));
        color += crossFade(uvT, dissolve) * weight;
        // color += crossFade(uvT + toCenter * percent * blurStep, dissolve) * weight;
        total += weight;
    }
    gl_FragColor = color / total * step(uv.x, 2.0) * step(uv.y, 2.0) * step(-1.0, uv.x) * step(-1.0, uv.y);
#else

	gl_FragColor = texture2D(inputImageTexture, uv) * step(uv.x, 2.0) * step(uv.y, 2.0) * step(-1.0, uv.x) * step(-1.0, uv.y);
#endif

}
