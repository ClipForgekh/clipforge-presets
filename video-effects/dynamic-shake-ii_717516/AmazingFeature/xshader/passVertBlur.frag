precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTexture;
uniform float vertR;
uniform vec4 u_ScreenParams;
uniform vec3 ColorA;
uniform vec3 ColorB;
uniform float sigma;
uniform float intensity;
uniform float threshold;
uniform float flagGlowColor;
uniform float colorRemoval;

float rgb2grey(vec3 rgbColor){
    return (rgbColor.r*0.299 + rgbColor.g*0.587 + rgbColor.b*0.114);
}

vec4 neighborColor(float i){
	float blurSize=1.;
	vec2 unit=vec2(blurSize/u_ScreenParams.x,blurSize/u_ScreenParams.y);
	vec2 uv1 = uv0 + unit * vec2(0., i);
	vec2 uv2 = uv0 - unit * vec2(0., i);
	vec4 result = texture2D(inputTexture, uv1)
				+ texture2D(inputTexture, uv2);
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
	for(float i=1.;i<=8. * (10. / 10.);i++){
		if (i > 8. * (vertR / 10.))
		{
			break;
		}
		w = Gaussian(float(i));
		resultColor+=neighborColor(i) * w;
		weight+= w * 2.;
	}
	resultColor /= weight;
	return resultColor;
}

vec4 adjustColor(vec4 sourceColor) {
	vec4 resultColor = sourceColor;
	float grey = rgb2grey(resultColor.rgb);
	vec4 ABColor = sourceColor;
	ABColor.rgb = sourceColor.rgb * ColorA;
	ABColor.rgb = mix(ABColor.rgb, ColorB, (1. - grey) * .2);//AB x 0.2

	if (sourceColor.r < .5) sourceColor.r = sourceColor.r / .5;
	else sourceColor.r = 1. - (sourceColor.r - .5) / .5;
	if (sourceColor.g < .5) sourceColor.g = sourceColor.g / .5;
	else sourceColor.g = 1. - (sourceColor.g - .5) / .5;
	if (sourceColor.b < .5) sourceColor.b = sourceColor.b / .5;
	else sourceColor.b = 1. - (sourceColor.b - .5) / .5;
	vec4 ABAColor = sourceColor;
	ABAColor.rgb *= ColorA * grey;
	ABAColor.rgb = mix(ABAColor.rgb, ColorB, grey);


	if (flagGlowColor < .5) {
		if (intensity <= 1.) {
			resultColor.rgb = resultColor.rgb * intensity;
		}
		else {
			float range = .035;
			float edge = -.0;
			float edge1 = edge + range * 2.;
			float v = smoothstep(-range, range, 1. - edge - uv0.x) * smoothstep(-range, range, 1. - edge - uv0.y)
					* smoothstep(-range, range, uv0.x - edge) * smoothstep(-range, range, uv0.y - edge);
			vec3 addColor = max(resultColor.rgb, min(vec3(.7), resultColor.rgb * intensity));
			resultColor.rgb = mix(addColor, resultColor.rgb * intensity, v);
			resultColor.rgb = clamp(resultColor.rgb, 0., 1.);
			float v1 = smoothstep(-range, range, 1. - edge1 - uv0.x) * smoothstep(-range, range, 1. - edge1 - uv0.y)
					* smoothstep(-range, range, uv0.x - edge1) * smoothstep(-range, range, uv0.y - edge1);
			resultColor.rgb = mix(addColor, resultColor.rgb, v1);
		}
	}
	else if (flagGlowColor < 1.5) {
		// AB color
		resultColor = ABColor;
		if (intensity <= 1.) {
			resultColor.rgb = resultColor.rgb * intensity;
		}
		else {
			float range = .035;
			float edge = -.0;
			float edge1 = edge + range * 2.;
			float v = smoothstep(-range, range, 1. - edge - uv0.x) * smoothstep(-range, range, 1. - edge - uv0.y)
					* smoothstep(-range, range, uv0.x - edge) * smoothstep(-range, range, uv0.y - edge);
			vec3 addColor = max(resultColor.rgb, min(vec3(.7) * (ColorA + ColorB) / 2., resultColor.rgb * intensity));
			resultColor.rgb = mix(addColor, min(resultColor.rgb * intensity, ColorA), v);
			resultColor.rgb = clamp(resultColor.rgb, 0., 1.);
			float v1 = smoothstep(-range, range, 1. - edge1 - uv0.x) * smoothstep(-range, range, 1. - edge1 - uv0.y)
					* smoothstep(-range, range, uv0.x - edge1) * smoothstep(-range, range, uv0.y - edge1);
			resultColor.rgb = mix(addColor, resultColor.rgb, v1);
		}
	}
	else if (flagGlowColor < 2.5) {
		// ABA color
		resultColor = ABAColor;
		if (intensity <= 1.) {
			resultColor.rgb = resultColor.rgb * intensity;
			// resultColor.rgb = min(ColorB + (ColorA - ColorB) * .7, (resultColor.rgb) * intensity);
		}
		else {
			resultColor.rgb = max(resultColor.rgb, min(ColorB + (ColorA - ColorB) * 4., (resultColor.rgb) * (intensity)));
		}
	}
	return resultColor;
}

void main()
{
	vec4 curColor=texture2D(inputTexture,uv0);
	vec4 resultColor = vertBlurColor(curColor);
	resultColor.rgb *= (1. - colorRemoval);

	gl_FragColor=resultColor;

}
