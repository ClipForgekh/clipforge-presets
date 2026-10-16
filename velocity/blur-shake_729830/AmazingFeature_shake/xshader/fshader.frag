precision highp float;
varying vec2 uv;
varying vec2 uRenderSize;
uniform sampler2D inputImageTexture;
uniform vec2 direction;
#define PI 3.141592653
uniform float runtime;

void main()
{
	vec2 tempUV = uv;
	tempUV -= 0.5;	
	tempUV *= uRenderSize;	
	float radian = runtime * PI / 180.0;	
	float x = cos(radian) * tempUV.x - sin(radian) * tempUV.y;
	float y = sin(radian) * tempUV.x + cos(radian) * tempUV.y;

	tempUV = vec2(x, y)/uRenderSize + 0.5;	

	vec4 resColor = texture2D(inputImageTexture,tempUV + direction);

	gl_FragColor = resColor;
}
