precision highp float;

uniform sampler2D blurTexture;
uniform sampler2D inputImageTexture;

varying vec2 uv;

uniform float blurScale;

#define num 16

float random(in vec3 scale, in float seed) {
    /* use the fragment position for randomness */
    return fract(sin(dot(gl_FragCoord.xyz + seed, scale)) * 43758.5453 + seed);
}

vec4 directionBlur(sampler2D tex, vec2 resolution, vec2 uv, vec2 directionOfBlur, float intensity)
{
	vec4 color = texture2D(tex, uv);
    float dircLength = length(directionOfBlur);
	if (dircLength < .01) return color;

    vec2 pixelStep = 1.0 / resolution * intensity;
	// pixelStep.x = directionOfBlur.x * 1.0 / dircLength * pixelStep.x;
	// pixelStep.y = directionOfBlur.y * 1.0 / dircLength * pixelStep.y;

	pixelStep.x = directionOfBlur.x * pixelStep.x;
	pixelStep.y = directionOfBlur.y * pixelStep.y;

	// pixelStep = normalize(directionOfBlur) * .1;

	for(int i = 1; i < num; i++)
	{
       vec2 blurCoord = uv + pixelStep * float(i);
	//    vec2 uvT = vec2(1.0 - abs(abs(blurCoord.x) - 1.0), 1.0 - abs(abs(blurCoord.y) - 1.0));
	   color += texture2D(tex, blurCoord);
	}
	color /= float(num);	
	return color;
}

void main ()
{
    vec4 tex = texture2D(blurTexture, uv);
	// vec2 dir = mix(vec2(.5), tex.xy, tex.a) * 2. - 1.;
    // gl_FragColor = directionBlur(inputImageTexture, vec2(720, 720), uv, -dir, 8.);
    gl_FragColor = texture2D(inputImageTexture, uv);
}

