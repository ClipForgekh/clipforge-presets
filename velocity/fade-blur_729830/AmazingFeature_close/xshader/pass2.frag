precision highp float;

varying vec2 uv;
uniform sampler2D inputImageTexture;

uniform float elapsedTime;
uniform float duration;

#define PI 3.14159265

void main() 
{
    // vec2 resolution = vec2(imageWidth,imageHeight);
    vec4 bgColor = texture2D(inputImageTexture,uv) * elapsedTime;

    gl_FragColor = bgColor;


}

