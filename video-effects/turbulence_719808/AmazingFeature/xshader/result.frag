precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTex;
uniform sampler2D u_maskTex;
uniform float u_lightIntensity;
uniform float u_Alpha;
uniform vec2 u_inputOffset;


#define PI 3.1415926
uniform float u_maskTextureScale;
uniform vec4 u_ScreenParams;
uniform vec2 u_maskTextureSize;
uniform vec2 u_maskOffsetRange;


void ExposureLighten(vec4 i_col, float _alpha, out vec4 o_col){
    float x = pow((u_lightIntensity) * 0.263, 2.92) + pow((u_lightIntensity) * 0.34, 0.92);
    o_col = i_col * vec4(x+1.) + 0.0;
    o_col = mix(i_col, o_col, _alpha);
}

vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}
void main()
{
    vec2 tempUv = vec2(uv0.x,1.-uv0.y);
    vec2 maksSize = vec2(u_ScreenParams.x * u_maskTextureSize.x/u_maskTextureSize.y,u_ScreenParams.y);
    vec2 maskRatio = maksSize.xy/max(maksSize.x,maksSize.y);
    vec2 maskUv = (tempUv - .5) * maskRatio + 0.5;
    vec2 maskOffset = texture2D(u_maskTex,maskUv).rr-0.5;
    maskOffset =  maskOffset.rg * 2. * u_maskOffsetRange;
    maskOffset.x = -maskOffset.x;

    vec2 uv = uv0+u_inputOffset*1.1;
    uv -= maskOffset;
    uv = flip_uv(uv);
    vec4 resultColor = texture2D(u_inputTex, uv);
    ExposureLighten(resultColor, 1.0, resultColor);
    gl_FragColor = vec4(resultColor);
    // gl_FragColor = vec4(maskOffset,0,1);
}