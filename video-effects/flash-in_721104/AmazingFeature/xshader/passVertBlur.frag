precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTex;
uniform vec4 u_ScreenParams;
uniform float u_strength;
uniform float u_vertR;

vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}

vec4 neighborColor(int i){
    // float horzR = 20.;
	float blurSize= u_vertR;
	float rescale = max(u_ScreenParams.x, u_ScreenParams.y) / 1280.;
	vec2 unit=vec2(blurSize/u_ScreenParams.x,blurSize/u_ScreenParams.y) * rescale;
	vec2 uv1 = uv0 + unit * vec2(0., i);
	vec2 uv2 = uv0 - unit * vec2(0., i);
    // uv1 = flip_uv(uv1);
    // uv2 = flip_uv(uv2);
	vec4 result = texture2D(u_inputTex, uv1)
				+ texture2D(u_inputTex, uv2);
	if (i < 2) {
		result *= .19;
	}
	else if (i < 3) {
		result *= .17;
	}
	else if (i < 4) {
		result *= .15;
	}
	else if (i < 5) {
		result *= .13;
	}
	else if (i < 6) {
		result *= .11;
	}
	else if (i < 7) {
		result *= .08;
	}
	else if (i < 8) {
		result *= .05;
	}
	else if (i < 9) {
		result *= .02;
	}
	return result;
}

float neighborWeight(int i) {
	float result = 0.;
	if (i < 2) {
		result = .19 * 2.;
	}
	else if (i < 3) {
		result = .17 * 2.;
	}
	else if (i < 4) {
		result = .15 * 2.;
	}
	else if (i < 5) {
		result = .13 * 2.;
	}
	else if (i < 6) {
		result = .11 * 2.;
	}
	else if (i < 7) {
		result = .08 * 2.;
	}
	else if (i < 8) {
		result = .05 * 2.;
	}
	else if (i < 9) {
		result = .02 * 2.;
	}
	return result * 10.;
}

void main()
{
    float half_gaussian_weight[9];
	half_gaussian_weight[0]=.2;//0.137401;
	// half_gaussian_weight[1]=.19;//0.125794;
	// half_gaussian_weight[2]=.17;//0.106483;
	// half_gaussian_weight[3]=.15;//0.080657;
	// half_gaussian_weight[4]=.13;//0.054670;
	// half_gaussian_weight[5]=.11;//0.033159;
	// half_gaussian_weight[6]=.08;//0.017997;
	// half_gaussian_weight[7]=.05;//0.008741;
	// half_gaussian_weight[8]=.02;//0.003799;
	vec4 curColor=texture2D(u_inputTex,uv0);
	vec4 resultColor=vec4(0.);
	
	vec4 centerPixel=curColor*half_gaussian_weight[0];
	resultColor += centerPixel;
	float weight=half_gaussian_weight[0] * 10.;
	float i = 1.;
	float blurSize=u_vertR;
	for(int i=1;i<=8;i++){

		resultColor += neighborColor(i);
		weight += neighborWeight(i);
	}
	resultColor /= weight / 10.; 
	gl_FragColor=resultColor;
}