precision highp float;

uniform sampler2D u_base;
uniform sampler2D u_mask;
uniform vec4 u_skin;     //12 keypoints' mean color

uniform float u_screenW;
uniform float u_screenH;

uniform float hl_alpha;     //hsv(hsl)-space threshold
uniform float all_alpha;    //rgb-space threshold

uniform float hl_det1;
uniform float hl_det2;

uniform sampler2D u_lut0;
uniform sampler2D u_lut1;

uniform float intensity;

varying vec2 v_uv;


vec3 rgb2hsv(vec3 c) {
    highp vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    highp vec4 p = mix(vec4(c.bg, K.wz),vec4(c.gb, K.xy), step(c.b, c.g));
    highp vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    highp float d = q.x - min(q.w, q.y);
    highp float e = 1.0e-7;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

float getMask(vec3 inp, vec3 ref){
    vec3 hsv0 = rgb2hsv(inp);
    vec3 hsv1 = rgb2hsv(ref);
    float mask1 = 1.0 - exp(-2.0 * max(hsv1.y * hl_det1 - hsv0.y, 0.0) * max(hsv1.y * hl_det1 - hsv0.y, 0.0) / (0.01));
    float mask2 = 1.0 - exp(-2.0 * max(hsv0.z - hsv1.z * hl_det2, 0.0) * max(hsv0.z - hsv1.z * hl_det2, 0.0) / (0.01));
    float mask = clamp(mask1 * mask2, 0.0, 1.0);
    return mask;
}

vec4 smooth_v3(float smooth_intensity)
{
    vec3 centralColor;
    
    float mul_x = 2.0 / u_screenW;
    float mul_y = 2.0 / u_screenH;
    
    vec2 blurCoordinates0 = v_uv + vec2(0.0 * mul_x,-10.0 * mul_y);
    vec2 blurCoordinates1 = v_uv + vec2(5.0 * mul_x,-8.0 * mul_y);
    vec2 blurCoordinates2 = v_uv + vec2(8.0 * mul_x,-5.0 * mul_y);
    vec2 blurCoordinates3 = v_uv + vec2(10.0 * mul_x,0.0 * mul_y);
    vec2 blurCoordinates4 = v_uv + vec2(8.0 * mul_x,5.0 * mul_y);
    vec2 blurCoordinates5 = v_uv + vec2(5.0 * mul_x,8.0 * mul_y);
    vec2 blurCoordinates6 = v_uv + vec2(0.0 * mul_x,10.0 * mul_y);
    vec2 blurCoordinates7 = v_uv + vec2(-5.0 * mul_x,8.0 * mul_y);
    vec2 blurCoordinates8 = v_uv + vec2(-8.0 * mul_x,5.0 * mul_y);
    vec2 blurCoordinates9 = v_uv + vec2(-10.0 * mul_x,0.0 * mul_y);
    vec2 blurCoordinates10 = v_uv + vec2(-8.0 * mul_x,-5.0 * mul_y);
    vec2 blurCoordinates11 = v_uv + vec2(-5.0 * mul_x,-8.0 * mul_y);
    
    mul_x = 1.6 / u_screenW;
    mul_y = 1.6 / u_screenH;
    
    vec2 blurCoordinates12 = v_uv + vec2(0.0 * mul_x,-6.0 * mul_y);
    vec2 blurCoordinates13 = v_uv + vec2(-4.0 * mul_x,-4.0 * mul_y);
    vec2 blurCoordinates14 = v_uv + vec2(-6.0 * mul_x,0.0 * mul_y);
    vec2 blurCoordinates15 = v_uv + vec2(-4.0 * mul_x,4.0 * mul_y);
    vec2 blurCoordinates16 = v_uv + vec2(0.0 * mul_x,6.0 * mul_y);
    vec2 blurCoordinates17 = v_uv + vec2(4.0 * mul_x,4.0 * mul_y);
    vec2 blurCoordinates18 = v_uv + vec2(6.0 * mul_x,0.0 * mul_y);
    vec2 blurCoordinates19 = v_uv + vec2(4.0 * mul_x,-4.0 * mul_y);
    
    float central;
    float gaussianWeightTotal;
    float sum;
    float sample1;
    float distanceFromCentralColor;
    float gaussianWeight;
    
    float distanceNormalizationFactor = 3.6;
    
    central = texture2D(u_base, v_uv).g;
    gaussianWeightTotal = 0.2;
    sum = central * 0.2;
    
    sample1 = texture2D(u_base, blurCoordinates0).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates1).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates2).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates3).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates4).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates5).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates6).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates7).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates8).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates9).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates10).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates11).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.08 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates12).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates13).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates14).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates15).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates16).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates17).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates18).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sample1 = texture2D(u_base, blurCoordinates19).g;
    distanceFromCentralColor = min(abs(central - sample1) * distanceNormalizationFactor, 1.0);
    gaussianWeight = 0.1 * (1.0 - distanceFromCentralColor);
    gaussianWeightTotal += gaussianWeight;
    sum += sample1 * gaussianWeight;
    
    sum = sum/gaussianWeightTotal;
    
    centralColor = texture2D(u_base, v_uv).rgb;
    
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

vec3 unpremultiply (vec3 color, float alpha) {
    return color / (alpha + 0.0001);
}

vec3 lut8x8 (sampler2D lut, vec3 src) {
    src *= 63.0;
    float b = src.b;

    vec2 i01 = vec2(floor(b), ceil(b));
    vec2 r01 = floor(i01 * 0.125);
    vec2 c01 = i01 - r01 * 8.0;

    vec4 uv0 = vec4(c01, r01).xzyw * 0.125;
    vec2 uv1 = (src.rg + 0.5) * 0.001953125;
    uv0 += vec4(uv1, uv1);

    vec3 c0 = texture2D(lut, uv0.xy).rgb;
    vec3 c1 = texture2D(lut, uv0.zw).rgb;
    return mix(c0, c1, b - i01.x);
}

vec4 mapping (vec4 color, sampler2D lut, float intensity) {
    vec3 dst = unpremultiply(color.rgb, color.a);
    vec3 src = lut8x8(lut, dst);
    dst = mix(dst, src, intensity);
    return vec4(dst, 1.0) * color.a;
}

void main() {
    vec4 base = texture2D(u_base, v_uv);
    vec4 mask = texture2D(u_mask, vec2(v_uv.x, 1.0 - v_uv.y));

    // vec4 base_smooth = smooth_v3(mask.a);

    // float alpha = getMask(base_smooth.rgb, u_skin.rgb);

    // vec4 result = base_smooth;
    // result.rgb = mix(result.rgb, u_skin.rgb, all_alpha);

    // vec4 newColor = result;
    // newColor.rgb = mix(newColor.rgb, u_skin.rgb, alpha);

    // vec4 temp = mix(result, newColor, hl_alpha * mask.a);

    // base = mix(base, temp, mask.a * intensity);

    vec4 lut0 = mapping(base, u_lut0, intensity);
    vec4 lut1 = mapping(base, u_lut1, intensity);
    base = mix(lut0, lut1, mask.a);
    gl_FragColor = base;
}

