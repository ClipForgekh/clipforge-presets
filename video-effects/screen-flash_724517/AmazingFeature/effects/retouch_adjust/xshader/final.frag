precision highp float;
uniform sampler2D lut;
uniform sampler2D inputImage;

varying vec2 uv;

uniform float intensitySharp;
uniform float intensityTexture;

uniform vec4 u_ScreenParams;

uniform int baseTexWidth;
uniform int baseTexHeight;
uniform vec2 fullBlendTexSize;

uniform sampler2D oilTexture;
uniform sampler2D grain_texture;

uniform float u_max;
uniform float v_max;

uniform float intensityGrain;

uniform float random_x1; // 0 ~ 1
uniform float random_y1; // 0 ~ 1

uniform lowp sampler2D stereoS;
uniform lowp sampler2D stereoH;
uniform int histWidth;
uniform float intensityStructure;


vec4 sharp(vec4 baseColor, float intensity) {
    float surfaceWidth=u_ScreenParams.x;
    float surfaceHeight=u_ScreenParams.y;

    if (intensity == 0.0) {
        return baseColor;
    }

    vec4 result_color = baseColor;

    float bitmapMaxLength = max(surfaceHeight, surfaceWidth);
    float f = abs(intensity);

    float f2 = (bitmapMaxLength - 1000.0) / 2000.0;
    f2 = max(0.0, min(f2, 1.0));
    f = ((f * 4.0) * (((1.0 - f2) * 0.65) + (f2 * 1.2))) + 1.0;
    float f3 = (1.0 - f) * 0.25;

    vec4 color_left = texture2D(inputImage, uv+vec2(-1.0/surfaceWidth, 0.0));
    color_left.rgb = color_left.rgb/max(color_left.a,0.00001);
    vec4 color_right = texture2D(inputImage, uv+vec2(1.0/surfaceWidth, 0.0));
    color_right.rgb = color_right.rgb/max(color_right.a,0.00001);
    vec4 color_bottom = texture2D(inputImage, uv+vec2(0.0, 1.0/surfaceHeight));
    color_bottom.rgb = color_bottom.rgb/max(color_bottom.a,0.00001);
    vec4 color_top = texture2D(inputImage, uv+vec2(0.0, -1.0/surfaceHeight));
    color_top.rgb = color_top.rgb/max(color_top.a, 0.00001);
    result_color.rgb = f*result_color.rgb + f3*color_left.rgb + f3*color_right.rgb + f3*color_top.rgb + f3*color_bottom.rgb;
    result_color = clamp(result_color, 0.0, 1.0);
    return result_color;
}

vec4 blendFunc(vec4 base, vec4 blend){
    vec4 result = vec4(0., 0., 0., 1.);
    result = clamp(mix(2.*blend*base+base*base*(1.-2.*blend), 2.*base*(1.-blend)+sqrt(base)*(2.*blend-1.), step(0.5, blend)), 0., 1.);
    return result;
}

vec2 sucaiAlign(vec2 videoUV,vec2 videoSize,vec2 sucaiSize,vec2 anchorImageCoord,float sucaiScale)
{
    vec2 videoImageCoord = videoUV * videoSize;
    vec2 sucaiUV= (videoImageCoord - anchorImageCoord)/(sucaiSize*sucaiScale) + vec2(0.5);//scaleSize对素材图也就是mask图按比例缩放
    return sucaiUV;
}

vec4 oilTextureBlendColor(sampler2D sucai, vec4 baseColor,vec2 videoSize,vec2 sucaiSize,vec2 anchorImageCoord,float sucaiScale)
{
    lowp vec4 resultColor = baseColor;

    vec2 sucaiUV = sucaiAlign(uv,videoSize,sucaiSize,anchorImageCoord,sucaiScale);

    lowp vec4 fgColor = baseColor;

     if(sucaiUV.x >= 0.0 && sucaiUV.x <= 1.0 && sucaiUV.y >= 0.0 && sucaiUV.y <= 1.0 ) {
        // sucaiUV.y = 1.0 - sucaiUV.y;
        fgColor = texture2D(sucai,sucaiUV);
    } else {
        return baseColor;
    }
    
    vec4 result = vec4(0.0);
    fgColor.rgb = fgColor.rgb/fgColor.a;
    result = blendFunc(baseColor, fgColor);
    result = mix(baseColor, result, intensityTexture);
    return result;
}

// 以下用于grain效果
vec3 rgb2gray = vec3(0.299, 0.587, 0.114);

float check_value(float value)
{
    float int_part = floor(value);
    value = value - int_part;
    return value;
}

float get_grain_texture(vec2 uv, float random_x, float random_y, float u_max, float v_max)
{
    vec2 res;
    float random_u = check_value(uv.x + random_x);
    float random_v = check_value(uv.y + random_y);

    res.x = check_value(random_u * u_max);
    res.y = check_value(random_v * v_max);
    return texture2D(grain_texture, res).r;;
}

vec4 structureFunc(vec4 baseColor, float intensity) {
    float testFactor = 0.0;
    float sharpenStrength = 0.0;
    float structureS = 0.0;
    if(intensity > 0.00001){
        testFactor = 0.396;
        sharpenStrength = 0.0;
        structureS = 0.76*pow(intensity, 2.0);
    }
    if(intensity < -0.00001){
        testFactor = 0.456;
        sharpenStrength = 0.0;
        structureS = -0.4*pow(abs(intensity), 2.0);
    }
    int modWidth = histWidth/64;
    vec2 realWidthHeight = vec2(float(modWidth), 25.0);

    float destiny = 0.066667;
    vec3 color = baseColor.rgb;
    vec3 textureHsize = vec3(float(histWidth),25.0,0.02);
    float srcLumS = color.r * 0.3333 + color.g * 0.5 + color.b * 0.1667;
    float dstLums = srcLumS - texture2D(stereoS, uv).a;
    color = clamp(color + dstLums * sharpenStrength, 0.0, 1.0);
    
    float lumVal = clamp(srcLumS + clamp(-dstLums, -destiny, destiny), 0.0, 1.0) * testFactor * 2.0;

    vec2 realPosition = uv * realWidthHeight;
    vec2 minVal = floor(realPosition - 0.5);
    vec2 maxVal = minVal + 1.0;
    minVal = max(minVal, 0.0);
    maxVal = min(maxVal, realWidthHeight - 1.0);
    
    vec2 TX = (vec2(minVal.x, maxVal.x) * 64.0 + 0.1 + lumVal * 63.8) / textureHsize.x;
    vec2 TY = vec2(minVal.y, maxVal.y)  / textureHsize.y + textureHsize.z;
    realPosition -= minVal + 0.5;
    
    vec2 resVal = mix(
        vec2(texture2D(stereoH, vec2(TX.x, TY.y)).r, texture2D(stereoH, vec2(TX.x, TY.x)).r),
        vec2(texture2D(stereoH, vec2(TX.y, TY.y)).r, texture2D(stereoH, vec2(TX.y, TY.x)).r),
        realPosition.x
    );
    
    float mixLum = mix(resVal.y, resVal.x, realPosition.y);
    float finalLum = srcLumS + structureS * (srcLumS * 1.4 - mixLum * 1.484 + 0.042) - 0.5;
    float meanVal = srcLumS - 0.5;
    float scale = min((0.275 - finalLum * finalLum) / (0.275 - meanVal * meanVal) * (1.0 + structureS / 5.0), 5.0);
    
    vec4 result = vec4(0.0, 0.0, 0.0, 1.0);
    result.rgb = finalLum + (color - srcLumS) * scale + 0.5;
    result = clamp(result, 0.0, 1.0);
    return result;
}

vec4 caculLut(vec4 inColor){
    highp float g = inColor.g * 16.0;
    highp float v = (0.5 / 17.0) + inColor.r * (1.0 - 1.0 / 17.0);
    highp float b = inColor.b * 16.0 / 17.0 + (0.5 / 17.0);
    highp float u1 = b / 17.0 + floor(g) / 17.0;
    highp float u2 = b / 17.0 + ceil(g) / 17.0;
    lowp vec4 newColor1 = texture2D(lut, vec2(u1, v));
    lowp vec4 newColor2 = texture2D(lut, vec2(u2, v));
    return mix(newColor1, newColor2, fract(g));
}

void main()
{
    highp vec4 textureColor = texture2D(inputImage, uv);
    // if(textureColor.a > 0.0) textureColor.rgb /= textureColor.a;
    float inColorA = textureColor.a;
    // 
    if (abs(intensitySharp) > 0.001)
    {
        textureColor = sharp(textureColor, intensitySharp);
    }
    /// 
    if (abs(intensityStructure) > 0.001)
    {
        // textureColor = structureFunc(textureColor, intensityStructure);
    }
    // 
    vec4 baseColor = caculLut(textureColor);
    // 
    vec4 fullblendColor = baseColor;
    if (abs(intensityTexture) > 0.001)
    {
        vec2 baseTexureSize = vec2(baseTexWidth, baseTexHeight);
        vec2 fullBlendAnchor = baseTexureSize * vec2(0.5, 0.5);
        float scale = 1.0;
        //
        float baseAspectRatio = baseTexureSize.y/baseTexureSize.x;
        float blendAspectRatio = fullBlendTexSize.y/fullBlendTexSize.x;
        if(baseAspectRatio >= blendAspectRatio) {
            scale = baseTexureSize.y / fullBlendTexSize.y;
        } else {
            scale = baseTexureSize.x / fullBlendTexSize.x;
        }
        fullblendColor = oilTextureBlendColor(oilTexture, baseColor, baseTexureSize, fullBlendTexSize, fullBlendAnchor, scale);
    }
    // 
    vec3 new_color = fullblendColor.rgb;
    if (abs(intensityGrain) > 0.001)
    {
        vec3 ori_color = fullblendColor.rgb;
        vec3 grain_color;
        float ori_gray = dot(rgb2gray, ori_color);
        ori_gray = ori_gray * 2.0 - 1.0;
        float abs_ori_gray = abs(ori_gray);
        float abs_ori_gray2 = abs_ori_gray * abs_ori_gray;
        float abs_ori_gray3 = abs_ori_gray2 * abs_ori_gray;
        float grain_gray = get_grain_texture(uv, random_x1, random_y1, u_max, v_max);
        grain_gray = grain_gray * 2.0 - 1.0;
        float mask;
        float strength = 0.49019608;
        if(ori_gray >= 0.)
        {
            mask = (abs_ori_gray3 * 0.5 + abs_ori_gray2 * 0.5) * (strength - 0.03921569);
        }
        else
        {
            mask = (abs_ori_gray2 * 0.4 + abs_ori_gray * 0.6) * strength;
        }
        new_color = clamp(ori_color + grain_gray * (strength - mask), 0., 1.);
        new_color = mix(ori_color.rgb, new_color, intensityGrain);
    }

    // gl_FragColor = vec4(new_color, 1.0) * inColorA;
    gl_FragColor = vec4(new_color, textureColor.a);

    // gl_FragColor = textureColor;
}
