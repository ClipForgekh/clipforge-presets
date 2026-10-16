precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform sampler2D input1;
uniform float width;
uniform float height;
uniform float progress;
uniform float intensity;
uniform float sigma;
uniform float vertR;
uniform float blurSize;

vec4 neighborColor(float i){
	// float blurSize=1.;
	vec2 unit=vec2(blurSize/width,blurSize/height);
	vec2 uv1 = uv0 + unit * vec2(0., i);
	vec2 uv2 = uv0 - unit * vec2(0., i);
	vec4 result = texture2D(inputTex, uv1)
				+ texture2D(inputTex, uv2);
	return result;
}

float Gaussian (float x)
{
    return exp(-(x*x) / (2.0 * sigma*sigma * vertR * vertR / 100.)) * 10.;
}

vec4 vertBlurColor(vec4 curColor){
	vec4 resultColor=vec4(0.);
	vec4 centerPixel=curColor*10.;
	resultColor += centerPixel;
	float weight=10.;
	float w = 0.;
	//vertR=20.
	for(float i=1.;i<=16.6;i++){
		if(i>8. * (vertR / 10.)) break;
		w = Gaussian(float(i));
		resultColor+=neighborColor(i) * w;
		weight+= w * 2.;
	}
	resultColor /= weight;
	return resultColor;
}

void main()
{
    vec2 uv1 = vec2(uv0.x, uv0.y);
    vec4 curColor = texture2D(inputTex, uv1);
    

    vec4 resultColor = vertBlurColor(curColor);
    gl_FragColor = resultColor;
}
