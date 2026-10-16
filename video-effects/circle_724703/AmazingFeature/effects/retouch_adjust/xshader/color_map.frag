precision highp float;

uniform sampler2D combineLut;

varying vec2 uv;
uniform lowp float intensityBrightness; 
uniform lowp float intensityContrast;
uniform lowp float intensityShadow;
uniform lowp float intensityHighlight;
uniform lowp float intensityTemperature;
uniform lowp float intensityTone;
uniform lowp float intensitySaturation;
uniform lowp float intensityLightSensation;
uniform lowp float intensityFade;
uniform lowp float intensityExposure;
uniform lowp float intensityVibrance;

const lowp float brightnessInLutRow = 1.0;
const lowp float contrastInLutRow = 2.0;
const lowp float exposureInLutRow = 3.0;
const lowp float fadeInLutRow = 4.0;
const lowp float highlightInLutRow = 5.0;
const lowp float lightSensationInLutRow = 6.0;
const lowp float saturationInLutRow = 7.0;
const lowp float shadowInLutRow = 8.0;
const lowp float temperatureInLutRow = 9.0;
const lowp float toneInLutRow = 10.0;
const lowp float vibranceInLutRow = 11.0;

const float lut_scale_row_y = 1.0 / 22.0;
const float lut_scale_17 = 1.0 / 17.0;

vec4 locationEffectByTextureMap(vec4 baseColor, float intensity, float rowInLut)
{
    float slider_progress = abs(intensity);
    vec4 curColor = baseColor;
    vec4 textureColor = curColor;
    float blueColor = curColor.b * (17.0 - 1.0);
    vec2 standardTableSize = vec2(289.0, 17.0);
    vec2 pixelSize = 1.0 / standardTableSize;
    vec2 quad1 = vec2(0.0);
    quad1.y = floor(floor(blueColor) * lut_scale_17);
    quad1.x = floor(blueColor) - (quad1.y * 1.0);
    vec2 quad2;
    quad2.y = floor(ceil(blueColor) * lut_scale_17);
    quad2.x = ceil(blueColor) - (quad2.y * 1.0);
    vec2 texPos1;
    texPos1.x = (quad1.x * 1.0 * lut_scale_17) + 0.5 / standardTableSize.x + ((1.0 * lut_scale_17 - 1.0 / standardTableSize.x) * textureColor.r);
    texPos1.y = (quad1.y * 1.0 / 1.0) + 0.5 / standardTableSize.y + ((1.0 / 1.0 - 1.0 / standardTableSize.y) * textureColor.g);
    texPos1.y = texPos1.y * lut_scale_row_y + lut_scale_row_y * (rowInLut - 1.0) * 2.0;
    vec2 texPos2;
    texPos2.x = (quad2.x * 1.0 * lut_scale_17) + 0.5 / standardTableSize.x + ((1.0 * lut_scale_17 - 1.0 / standardTableSize.x) * textureColor.r);
    texPos2.y = (quad2.y * 1.0 / 1.0) + 0.5 / standardTableSize.y + ((1.0 / 1.0 - 1.0 / standardTableSize.y) * textureColor.g);
    texPos2.y = texPos2.y * lut_scale_row_y + lut_scale_row_y * (rowInLut - 1.0) * 2.0;

    float alpha = fract(blueColor);
    vec4 newColor = vec4(0.0);
    if (intensity > 0.0) { 
        texPos1.y = texPos1.y + lut_scale_row_y;
        texPos2.y = texPos2.y + lut_scale_row_y;
    }
    vec4 newColor1 = texture2D(combineLut, texPos1);
    vec4 newColor2 = texture2D(combineLut, texPos2);
    newColor = mix(newColor1, newColor2, alpha);
    newColor = mix(curColor,newColor,slider_progress);
    return newColor;
}


void main()
{
    highp vec4 baseColor;
    baseColor.r = (17.0 / 16.0) * uv.y - 0.5 / 16.0;
    baseColor.g = floor(uv.x * 17.0) / 16.0;
    baseColor.b = (uv.x - floor(uv.x * 17.0) * lut_scale_17) * 17.0;
    baseColor.b = 17.0 / 16.0 * baseColor.b - 0.5 / 16.0;
    baseColor.a = 1.0;

    if(abs(intensityBrightness) > 0.01){
        baseColor = locationEffectByTextureMap(baseColor, intensityBrightness, brightnessInLutRow);
    }
    if(abs(intensityContrast) > 0.01){
        baseColor = locationEffectByTextureMap(baseColor, intensityContrast, contrastInLutRow);
    }
    if (abs(intensityShadow) > 0.01) { 
        baseColor = locationEffectByTextureMap(baseColor, intensityShadow, shadowInLutRow);
    }
    if (abs(intensityHighlight) > 0.01) {
        baseColor = locationEffectByTextureMap(baseColor, intensityHighlight, highlightInLutRow);
    }
    if(abs(intensityTemperature) > 0.01){
        baseColor = locationEffectByTextureMap(baseColor, intensityTemperature, temperatureInLutRow);
    }
    if(abs(intensityTone) > 0.01){
        baseColor = locationEffectByTextureMap(baseColor, intensityTone, toneInLutRow);
    }
    if(abs(intensitySaturation) > 0.01){
        baseColor = locationEffectByTextureMap(baseColor, intensitySaturation, saturationInLutRow);
    }
    if (abs(intensityLightSensation) > 0.01) {
        baseColor = locationEffectByTextureMap(baseColor, intensityLightSensation, lightSensationInLutRow);
    }
    if (intensityFade > 0.01) { 
        baseColor = locationEffectByTextureMap(baseColor, intensityFade, fadeInLutRow);
    }
    if (abs(intensityExposure) > 0.01) {
        baseColor = locationEffectByTextureMap(baseColor, intensityExposure, exposureInLutRow);
    }
    if (abs(intensityVibrance) > 0.01) {
        baseColor = locationEffectByTextureMap(baseColor, intensityVibrance, vibranceInLutRow);
    }

    gl_FragColor = baseColor;
}
