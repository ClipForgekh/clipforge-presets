precision highp float;
varying vec2 uv0;

uniform sampler2D inputImageTexture;

uniform int baseTexWidth;
uniform int baseTexHeight;
uniform float timer;
uniform float period;
uniform float max_zoom_in_intensity;
uniform vec2 zoom_in_center;

void main(void) 
{
    vec2 screenSize = vec2(baseTexWidth,baseTexHeight);
    vec4 curColor = texture2D(inputImageTexture,uv0);
    vec4 resultColor = curColor;
    float zoom_in_intensity = 1.0;
    float progress = (mod(timer,period)-period*0.5)*2.0/period;
    // if(progress<=0.0)
    //     zoom_in_intensity = max_zoom_in_intensity-progress*(1.0-max_zoom_in_intensity);
    // else 
    //     zoom_in_intensity = max_zoom_in_intensity+progress*(1.0-max_zoom_in_intensity);
    zoom_in_intensity = max_zoom_in_intensity+abs(progress)*(1.0-max_zoom_in_intensity);
    vec2 uv1 = zoom_in_center+(uv0-zoom_in_center)*zoom_in_intensity;
    resultColor = texture2D(inputImageTexture,uv1);

    gl_FragColor = resultColor;
}

