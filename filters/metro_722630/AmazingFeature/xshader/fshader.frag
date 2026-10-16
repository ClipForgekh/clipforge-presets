precision highp float;

varying vec2 uv;
varying vec2 uRenderSize;
uniform sampler2D inputImageTexture;
uniform sampler2D oriTexture;
//uniform float uniAlpha;
uniform float uTime;

uniform float slider_value;

// 2D Random
float random (vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))* 43758.5453123);
}

float noise (vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

void main() 
{
    float strengthPower = 1.0 * slider_value;
    float strength = 16.0 * strengthPower;
    //float x = (uv.x + 4.0) * (uv.y + 4.0) * (uTime* 10.0);
    float x = (uv.x + random(uv)) * (uv.y + random(uv)) * ((mod(uTime,100.0)+3.0) * 10.0 * slider_value);
    vec4 grain =vec4(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01) - (0.005 * (1.0 - step(slider_value, 0.0)))) *strength;
//    vec4 grain =vec4(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01) - 0.005) *strength;
    
    vec4 color1 = texture2D(inputImageTexture,uv);
    vec4 ori = texture2D(oriTexture,uv);

    gl_FragColor = vec4((color1 + grain).rgb, ori.a);
}

