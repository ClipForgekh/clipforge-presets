precision highp float;
uniform sampler2D inputImageTexture;
varying vec2 texCoordinate;

uniform int inputWidth;
uniform int inputHeight;
// uniform float texelWidthOffset;
// uniform float texelHeightOffset;


float M_PI  = 3.14159265;
#define radius  2
float standardGaussianWeights[radius+1];
void initGaussianWeight(float sigma)
{
	float sumOfWeights = 0.0;
	for(int i = 0;i <= 2;i++)
	{
        if(i==0){
            standardGaussianWeights[0] = (1.0 / sqrt(2.0 * M_PI * pow(sigma, 2.0))) 
                        * exp(-pow(float(i), 2.0) / (2.0 * pow(sigma, 2.0)));
        }else if(i==1){
            standardGaussianWeights[1] = (1.0 / sqrt(2.0 * M_PI * pow(sigma, 2.0))) 
                        * exp(-pow(float(i), 2.0) / (2.0 * pow(sigma, 2.0)));
        }else if(i==2){
            standardGaussianWeights[2] = (1.0 / sqrt(2.0 * M_PI * pow(sigma, 2.0))) 
                        * exp(-pow(float(i), 2.0) / (2.0 * pow(sigma, 2.0)));
        }

	    if (i == 0)
	    {
	        sumOfWeights += standardGaussianWeights[0];
	    }
	    else if (i == 1){
	        sumOfWeights += 2.0 * standardGaussianWeights[1];
        }else if(i==2){
	        sumOfWeights += 2.0 * standardGaussianWeights[2];
        }
	}

	for(int i = 0;i <= 2;i++)
	{
        if(i==0){
            standardGaussianWeights[0] = standardGaussianWeights[0] / sumOfWeights;      	
        }else if(i==1){
            standardGaussianWeights[1] = standardGaussianWeights[1] / sumOfWeights;      	
        }else if(i==2){
            standardGaussianWeights[2] = standardGaussianWeights[2] / sumOfWeights;      	
        }
	}	
}


void main() 
{
    float texelWidthOffset = 1.0/float(inputWidth);
    float texelHeightOffset = 1.0/float(inputHeight);
    initGaussianWeight(2.0);
    float blur_kernel[5];  

    for(int i=0;i<4+1;i++)
    {
        int idx = int( abs(float(radius)-float(i)) );

        if(i==0){
            blur_kernel[0] = standardGaussianWeights[2];
        }else if(i==1){
            blur_kernel[1] = standardGaussianWeights[1];
        }else if(i==2){
            blur_kernel[2] = standardGaussianWeights[0];
        }else if(i==3){
            blur_kernel[3] = standardGaussianWeights[1];
        }else if(i==4){
            blur_kernel[4] = standardGaussianWeights[2];
        }
    }  

    // gauss blur
    vec4 result_color = vec4(vec3(0.0), 1.0);

    vec4 t_color;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-2.*texelWidthOffset, -2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[0] * blur_kernel[0] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-2.*texelWidthOffset, -1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[0] * blur_kernel[1] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-2.*texelWidthOffset, 0.*texelHeightOffset) );
    result_color.rgb += blur_kernel[0] * blur_kernel[2] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-2.*texelWidthOffset, 1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[0] * blur_kernel[3] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-2.*texelWidthOffset, 2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[0] * blur_kernel[4] * t_color.rgb;



    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-1.*texelWidthOffset, -2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[1] * blur_kernel[0] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-1.*texelWidthOffset, -1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[1] * blur_kernel[1] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-1.*texelWidthOffset, 0.*texelHeightOffset) );
    result_color.rgb += blur_kernel[1] * blur_kernel[2] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-1.*texelWidthOffset, 1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[1] * blur_kernel[3] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(-1.*texelWidthOffset, 2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[1] * blur_kernel[4] * t_color.rgb;



    t_color = texture2D(inputImageTexture, texCoordinate+vec2(0.*texelWidthOffset, -2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[2] * blur_kernel[0] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(0.*texelWidthOffset, -1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[2] * blur_kernel[1] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(0.*texelWidthOffset, 0.*texelHeightOffset) );
    result_color.rgb += blur_kernel[2] * blur_kernel[2] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(0.*texelWidthOffset, 1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[2] * blur_kernel[3] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(0.*texelWidthOffset, 2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[2] * blur_kernel[4] * t_color.rgb;


    t_color = texture2D(inputImageTexture, texCoordinate+vec2(1.*texelWidthOffset, -2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[3] * blur_kernel[0] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(1.*texelWidthOffset, -1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[3] * blur_kernel[1] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(1.*texelWidthOffset, 0.*texelHeightOffset) );
    result_color.rgb += blur_kernel[3] * blur_kernel[2] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(1.*texelWidthOffset, 1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[3] * blur_kernel[3] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(1.*texelWidthOffset, 2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[3] * blur_kernel[4] * t_color.rgb;

    t_color = texture2D(inputImageTexture, texCoordinate+vec2(2.*texelWidthOffset, -2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[4] * blur_kernel[0] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(2.*texelWidthOffset, -1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[4] * blur_kernel[1] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(2.*texelWidthOffset, 0.*texelHeightOffset) );
    result_color.rgb += blur_kernel[4] * blur_kernel[2] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(2.*texelWidthOffset, 1.*texelHeightOffset) );
    result_color.rgb += blur_kernel[4] * blur_kernel[3] * t_color.rgb;
    t_color = texture2D(inputImageTexture, texCoordinate+vec2(2.*texelWidthOffset, 2.*texelHeightOffset) );
    result_color.rgb += blur_kernel[4] * blur_kernel[4] * t_color.rgb;

    gl_FragColor = result_color;
}