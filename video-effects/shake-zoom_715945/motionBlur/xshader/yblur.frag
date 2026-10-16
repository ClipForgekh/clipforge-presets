precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform sampler2D inputtex;
uniform float sport_iTime;
uniform vec2 uv_yy;
uniform float blurSize;
uniform float u_Strength;
uniform int inputWidth;
uniform int inputHeight;
#define num 14
#define PI 3.14159265
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

vec2 mirror(vec2 x){
    return abs(mod(x-1.,2.)-1.);
}
void main()
{

float ratio = 100. / 100.;

	vec2 uv = (vec4((uv0.x * 2.0 - 1.0) * ratio, uv0.y * 2.0 - 1.0, 0.0, 1.0)).xy;
	vec2 uv_yy = vec2(uv_yy.x, uv_yy.y);

	uv.x = (uv.x / ratio + 1.0) / 2.0; 

uv.y =( uv.y+0.5)/2.0 +uv_yy.y;
 
	vec2 resolution = vec2(100.,100.);
	// vec2 realCoord = uvT * resolution;

	vec4 resultColor = directionBlur(inputtex,resolution,mirror(uv),vec2(0.,200.),blurSize*u_Strength);

	gl_FragColor = vec4(resultColor.rgb, resultColor.a) * step(uv.x, 2.0) * step(uv.y, 2.0) * step(-1.0, uv.x) * step(-1.0, uv.y);



    // gl_FragColor = inputColor;
}
