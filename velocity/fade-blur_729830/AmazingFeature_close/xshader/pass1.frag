precision highp float;

varying vec2 uv;
varying vec4 textureShift_1; 
varying vec4 textureShift_2; 
varying vec4 textureShift_3; 
varying vec4 textureShift_4; 
uniform sampler2D inputImageTexture;
uniform float centerGaussianWeight;
uniform vec4 neighbourGaussianWeight;

void main() 
{
    vec4 sum = texture2D(inputImageTexture, uv) * centerGaussianWeight;
    sum += texture2D(inputImageTexture, textureShift_1.xy) * neighbourGaussianWeight.x;
    sum += texture2D(inputImageTexture, textureShift_1.zw) * neighbourGaussianWeight.x;
    sum += texture2D(inputImageTexture, textureShift_2.xy) * neighbourGaussianWeight.y;
    sum += texture2D(inputImageTexture, textureShift_2.zw) * neighbourGaussianWeight.y;
    sum += texture2D(inputImageTexture, textureShift_3.xy) * neighbourGaussianWeight.z;
    sum += texture2D(inputImageTexture, textureShift_3.zw) * neighbourGaussianWeight.z;
    sum += texture2D(inputImageTexture, textureShift_4.xy) * neighbourGaussianWeight.w;
    sum += texture2D(inputImageTexture, textureShift_4.zw) * neighbourGaussianWeight.w;
    
    gl_FragColor = sum;

}

