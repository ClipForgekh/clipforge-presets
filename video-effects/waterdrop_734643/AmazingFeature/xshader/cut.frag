precision highp float;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;
varying vec2 uv;
uniform vec4 u_ScreenParams;
uniform float strength;
uniform float sm;
uniform float scale;
uniform float sdfSize;
uniform vec2 offset;
uniform sampler2D shadowTexture;
uniform float u_shadow;


void main()
{
    vec2 uv0 = uv;
    uv0 += offset*0.5;

    uv0 -= 0.5;
    uv0 = uv0 / (scale);
    uv0 += 0.5;


    vec4 resultcolor = texture2D(inputImageTexture,vec2(uv0));
    float alpha3 = resultcolor.a;
    uv0 = uv;
    uv0 -= 0.5;
    uv0 = uv0 *0.99;
    uv0 += 0.5;

    vec4 mask = texture2D(inputImageTexture2,vec2(uv0));
    float alpha = smoothstep(0.0,0.20,mask.r);
    float alpha1 = smoothstep(0.2,1.0,mask.r);
    float alpha2 = pow(mask.r,5.0);
    resultcolor = vec4(resultcolor.rgb*(0.8+0.2*alpha1)*(alpha1) + vec3(1.0,1.10,2.0)*vec3(u_shadow)*alpha*(1.0-alpha1) ,alpha2),
    gl_FragColor =vec4(resultcolor.rgb,resultcolor.a*alpha3);
}
