precision highp float;
varying vec2 srcUV;
varying vec2 maskRegionUV;

uniform sampler2D srcTex;
uniform sampler2D maskRegionTex;

uniform vec4 skinColor;     //12 keypoints' mean color

uniform float hl_alpha;     //hsv(hsl)-space threshold
uniform float all_alpha;    //rgb-space threshold

uniform float hl_det1;
uniform float hl_det2;

uniform float intensity;

vec3 rgb2hsv(vec3 c) {
    highp vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    highp vec4 p = mix(vec4(c.bg, K.wz),vec4(c.gb, K.xy), step(c.b, c.g));
    highp vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    highp float d = q.x - min(q.w, q.y);
    highp float e = 1.0e-7;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

float getMask(vec3 inp, vec3 ref_hsv){
    vec3 hsv = rgb2hsv(inp);
    float mask1 = 1.0 - exp(-2.0*max(ref_hsv.y*hl_det1-hsv.y, 0.0)*max(ref_hsv.y*hl_det1-hsv.y, 0.0)/(0.01));
    float mask2 = 1.0 - exp(-2.0*max(hsv.z-ref_hsv.z*hl_det2, 0.0)*max(hsv.z-ref_hsv.z*hl_det2, 0.0)/(0.01));
    float mask = clamp(mask1 * mask2, 0.0, 1.0);
    return mask;
}

vec4 smooth_v3(float smooth_intensity)
{
    vec3 centralColor;
    
    float mul_x = 2.0 / 720.0;
    float mul_y = 2.0 / 1280.0;
    
    vec2 blurCoordinates0 = srcUV + vec2(0.0 * mul_x,-10.0 * mul_y);
    vec2 blurCoordinates1 = srcUV + vec2(5.0 * mul_x,-8.0 * mul_y);
    vec2 blurCoordinates2 = srcUV + vec2(8.0 * mul_x,-5.0 * mul_y);
    vec2 blurCoordinates3 = srcUV + vec2(10.0 * mul_x,0.0 * mul_y);
    vec2 blurCoordinates4 = srcUV + vec2(8.0 * mul_x,5.0 * mul_y);
    vec2 blurCoordinates5 = srcUV + vec2(5.0 * mul_x,8.0 * mul_y);
    vec2 blurCoordinates6 = srcUV + vec2(0.0 * mul_x,10.0 * mul_y);
    vec2 blurCoordinates7 = srcUV + vec2(-5.0 * mul_x,8.0 * mul_y);
    vec2 blurCoordinates8 = srcUV + vec2(-8.0 * mul_x,5.0 * mul_y);
    vec2 blurCoordinates9 = srcUV + vec2(-10.0 * mul_x,0.0 * mul_y);
    vec2 blurCoordinates10 = srcUV + vec2(-8.0 * mul_x,-5.0 * mul_y);
    vec2 blurCoordinates11 = srcUV + vec2(-5.0 * mul_x,-8.0 * mul_y);
    
    mul_x = 1.6 / 720.0;
    mul_y = 1.6 / 1280.0;
    
    vec2 blurCoordinates12 = srcUV + vec2(0.0 * mul_x,-6.0 * mul_y);
    vec2 blurCoordinates13 = srcUV + vec2(-4.0 * mul_x,-4.0 * mul_y);
    vec2 blurCoordinates14 = srcUV + vec2(-6.0 * mul_x,0.0 * mul_y);
    vec2 blurCoordinates15 = srcUV + vec2(-4.0 * mul_x,4.0 * mul_y);
    vec2 blurCoordinates16 = srcUV + vec2(0.0 * mul_x,6.0 * mul_y);
    vec2 blurCoordinates17 = srcUV + vec2(4.0 * mul_x,4.0 * mul_y);
    vec2 blurCoordinates18 = srcUV + vec2(6.0 * mul_x,0.0 * mul_y);
    vec2 blurCoordinates19 = srcUV + vec2(4.0 * mul_x,-4.0 * mul_y);
    
    float central;
    float gaussianWeightTotal;
    float sum;
    float sample1;
    float distanceFromCentralColor;
    float gaussianWeight;
    
    float distanceNormalizationFactor = 3.6;
    
    central = texture2D(srcTex, srcUV).g;
    gaussianWeightTotal = 0.2;
    sum = central * 0.2;
    
    sample1 = texture2D(srcTex, blurCoordinates0).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates1).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates2).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates3).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates4).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates5).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates6).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates7).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates8).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates9).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates10).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates11).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates12).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates13).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates14).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates15).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates16).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates17).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates18).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(srcTex, blurCoordinates19).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sum = sum/gaussianWeightTotal;
    
    centralColor = texture2D(srcTex, srcUV).rgb;
    
    sample1 = centralColor.g - sum + 0.5;
    
    for(int i = 0; i < 5; ++i)
    {
        if(sample1 <= 0.5)
        {
            sample1 = sample1 * sample1 * 2.0;
        }
        else
        {
            sample1 = 1.0 - ((1.0 - sample1)*(1.0 - sample1) * 2.0);
        }
    }
    
    float aa = 1.0 + pow(sum, 0.3) * 0.09;
    vec3 smoothColor = centralColor * aa - vec3(sample1) * (aa - 1.0);          // get smooth color
    smoothColor = clamp(smoothColor, vec3(0.0), vec3(1.0));                 // make smooth color right
    
    smoothColor = mix(centralColor, smoothColor, pow(centralColor.g, 0.33));
    smoothColor = mix(centralColor, smoothColor, pow(centralColor.g, 0.39));
    
    smoothColor = mix(centralColor, smoothColor, smooth_intensity);

    return vec4(pow(smoothColor, vec3(1.0-0.04*smooth_intensity)), 1.0);
}

void main() {
    vec4 src = texture2D(srcTex, srcUV);
    vec4 mask_color = texture2D(maskRegionTex, maskRegionUV);

    vec4 src_smooth = smooth_v3(mask_color.b);

    vec3 skinColor_hsv = rgb2hsv(skinColor.rgb);
    float alpha = getMask(src_smooth.rgb, skinColor_hsv.xyz);

    vec4 result = src_smooth; 
    result.rgb = skinColor.rgb + (result.rgb - skinColor.rgb) * (1.0 - all_alpha);

    vec4 newColor = result;
    newColor.rgb = mix(newColor.rgb, skinColor.rgb, alpha);

    vec4 tmp = mix(result, newColor, hl_alpha * mask_color.r);
 
    gl_FragColor = mix(src, tmp, mask_color.b * intensity);
}

