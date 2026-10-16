exports.source=`
precision highp float;

uniform vec3 factor1;
uniform vec4 u_ScreenParams;
uniform float u_intensity;
uniform float u_intensityR;
uniform float u_intensityG;
uniform float u_intensityB;
uniform float u_scale;
uniform float u_scaleR;
uniform float u_scaleG;
uniform float u_scaleB;
uniform int u_monochrome;
uniform float u_Brightness;
uniform float u_Contrast;
uniform float u_Saturation;
uniform sampler2D tDiffuse; // Changed from u_InputTexture

uniform int u_onlyNoise;
uniform float u_combine;
uniform float u_radius;
uniform float u_smoothing;
uniform float u_seed;

varying vec2 vUv;

#define BlendOverlayf(base, blend)      (base < 0.5 ? (2.0 * base * blend) : (1.0 - 2.0 * (1.0 - base) * (1.0 - blend))) 
#define BlendOverlay(base, blend)       vec3(BlendOverlayf(base.r, blend.r), BlendOverlayf(base.g, blend.g), BlendOverlayf(base.b, blend.b))
#define BlendColorBurnf(base, blend)    ((blend == 0.0) ? blend : max((1.0 - ((1.0 - base) / blend)), 0.0))
#define BlendColorBurn(base, blend)     vec3(BlendColorBurnf(base.r, blend.r), BlendColorBurnf(base.g, blend.g), BlendColorBurnf(base.b, blend.b))
#define BlendScreen(base, blend)        (1.0 - (1.0 - base) * (1.0 - blend))
#define BlendMultiply(base, blend)      (base * blend)
#define BlendDifference(base, blend)    (abs(blend - base))
#define BlendAdd(base, blend)           (blend + base)

vec4 saturation(vec4 color, float sat)
{
    vec3 temp1_1;
    lowp vec4 res_2;
    vec3 tmpvar_3;
    tmpvar_3 = (factor1 / (((factor1.x + factor1.y) + factor1.z) / 0.02));
    float tmpvar_4;
    tmpvar_4 = (50.0 - sat * 100.0);
    lowp vec4 tmpvar_5 = color;
    res_2.w = tmpvar_5.w;
    vec3 tmpvar_6;
    tmpvar_6.x = 0.0;
    tmpvar_6.y = (tmpvar_3.x * tmpvar_4);
    tmpvar_6.z = (tmpvar_3.y * tmpvar_4);
    temp1_1.yz = tmpvar_6.yz;
    temp1_1.x = ((1.0 - tmpvar_6.z) - tmpvar_6.y);
    res_2.x = dot(tmpvar_5.xyz, temp1_1);
    vec3 tmpvar_7;
    tmpvar_7.y = 0.0;
    tmpvar_7.x = (tmpvar_3.z * tmpvar_4);
    tmpvar_7.z = (tmpvar_3.y * tmpvar_4);
    temp1_1.xz = tmpvar_7.xz;
    temp1_1.y = ((1.0 - tmpvar_7.x) - tmpvar_7.z);
    res_2.y = dot(tmpvar_5.xyz, temp1_1);
    vec3 tmpvar_8;
    tmpvar_8.z = 0.0;
    tmpvar_8.x = (tmpvar_3.z * tmpvar_4);
    tmpvar_8.y = (tmpvar_3.x * tmpvar_4);
    temp1_1.xy = tmpvar_8.xy;
    temp1_1.z = ((1.0 - tmpvar_8.x) - tmpvar_8.y);
    res_2.z = dot(tmpvar_5.xyz, temp1_1);
    return res_2;
}

vec2 hash(vec2 p, float seed)
{
    // Fix precision loss issue by bounding BOTH seed and the coordinates before they get multiplied.
    float safeSeed = fract(seed * 0.1) * 100.0;
    vec2 safeP = mod(p, 1000.0);
    
    vec3 p3 = fract(vec3(safeP.xyx) * vec3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yzx + 33.33 + safeSeed);
    return fract((p3.xx + p3.yz) * p3.zy) * 2.0 - 1.0;
}

float noise(in vec2 p, float i_step, float seed, float scale)
{
    vec2 i = vec2(floor(p / i_step));
    vec2 f = fract(p / (i_step));

    vec2 u = f * f * (f * (6.0 * f - 15.0) + 10.0); // feel free to replace by a quintic smoothstep instead
    u = mix(f * u, u, smoothstep(0.3, 0.25, scale));

    return mix(mix(dot(hash((i + vec2(0.0, 0.0)) * i_step, seed), f - vec2(0.0, 0.0)),
                   dot(hash((i + vec2(1.0, 0.0)) * i_step, seed), f - vec2(1.0, 0.0)), u.x),
               mix(dot(hash((i + vec2(0.0, 1.0)) * i_step, seed), f - vec2(0.0, 1.0)),
                   dot(hash((i + vec2(1.0, 1.0)) * i_step, seed), f - vec2(1.0, 1.0)), u.x),
               u.y);
}

float grain(vec2 uv, float scale, float seed)
{
    float k = 2.0 / max(0.1, scale);
    float n = noise(uv * 500.0, 500.0 / pow(2.0, floor(k)), seed, scale) * 0.5 + 0.5;
    float n2 = noise(uv * 300.0, 300.0 / pow(2.0, floor(k)), seed, scale) * 0.5 + 0.5;
    n = 0.6 * n + 0.4 * n2;
    float n1 = noise(uv * 500.0, 500.0 / pow(2.0, floor(k) + 1.0), seed, scale) * 0.5 + 0.5;
    float n3 = noise(uv * 300.0, 300.0 / pow(2.0, floor(k) + 1.0), seed, scale) * 0.5 + 0.5;
    n1 = 0.6 * n1 + 0.4 * n3;
    n = mix(n, n1, fract(k));
    return n;
}

float colorAdjust(float c, float brightness, float contrast)
{
    c += brightness * 0.3;
    if (contrast > 0.0) {
        c = (c - 0.5) * (contrast * 10.0 + 1.0) + 0.5;
    } else {
        c = (c - 0.5) * (contrast + 1.0) + 0.5;
    }
    return c;
}

void main()
{
    vec2 st_0 = vUv;
    // 确保噪声坐标保持 1:1 比例，以最小边为基准
    float aspectRatio = u_ScreenParams.x / u_ScreenParams.y;
    if (aspectRatio > 1.0) {
        st_0.x *= aspectRatio;
    } else {
        st_0.y /= aspectRatio;
    }

    float n_r = grain(st_0, u_scale * u_scaleR, u_seed);
    float n_g = n_r;
    float n_b = n_r;
    if (u_monochrome == 0) {
        n_g = grain(st_0, u_scale * u_scaleG, u_seed + 2.0);
        n_b = grain(st_0, u_scale * u_scaleB, u_seed + 4.0);
    }

    n_r = colorAdjust(n_r, u_Brightness, u_Contrast);
    n_g = colorAdjust(n_g, u_Brightness, u_Contrast);
    n_b = colorAdjust(n_b, u_Brightness, u_Contrast);

    if (u_combine > 0.5 && u_combine < 2.5) {
        n_r = (n_r - 0.5) * 2.0;
        n_g = (n_g - 0.5) * 2.0;
        n_b = (n_b - 0.5) * 2.0;
    } else if (u_combine < 0.5) {
        n_r = abs(n_r - 0.5) * 2.0;
        n_g = abs(n_g - 0.5) * 2.0;
        n_b = abs(n_b - 0.5) * 2.0;
    }
    vec3 noiseColor = vec3(n_r, n_g, n_b);
    noiseColor.rgb = saturation(vec4(noiseColor, 1.0), u_Saturation).rgb;
    noiseColor = clamp(noiseColor, 0.0, 1.0);

    if (u_onlyNoise == 1) {
        gl_FragColor = vec4(noiseColor, 1.0);
        return;
    }

    vec4 inputColor = texture2D(tDiffuse, vUv);

    vec4 fgColor;
    if (u_combine < 0.5) {
        fgColor = vec4(BlendScreen(inputColor.rgb, noiseColor.rgb), inputColor.a);
    } else if (u_combine < 1.5) {
        fgColor = vec4(BlendAdd(inputColor.rgb, noiseColor.rgb), inputColor.a);
    } else if (u_combine < 2.5) {
        fgColor = vec4(BlendMultiply(inputColor.rgb, noiseColor.rgb), inputColor.a);
    } else if (u_combine < 3.5) {
        fgColor = vec4(BlendOverlay(inputColor.rgb, noiseColor.rgb), inputColor.a);
    } else if (u_combine < 4.5) {
        vec3 darkNoise = BlendColorBurn(noiseColor.rgb, vec3(0.5));
        vec3 noiseBlendCol = BlendOverlay(inputColor.rgb, noiseColor.rgb);
        float gray = dot(inputColor.rgb, vec3(0.299, 0.587, 0.114));
        noiseBlendCol = mix(noiseBlendCol, BlendScreen(noiseBlendCol, darkNoise), 0.5 * smoothstep(150. / 255., 130. / 255., gray));
        fgColor = vec4(noiseBlendCol, inputColor.a);
    } else {
        fgColor = vec4(BlendDifference(inputColor.rgb, noiseColor.rgb), inputColor.a);
    }

    if (u_combine > 1.5 && u_combine < 2.5) {
        fgColor.r = inputColor.r + fgColor.r * u_intensity * u_intensityR;
        fgColor.g = inputColor.g + fgColor.g * u_intensity * u_intensityG;
        fgColor.b = inputColor.b + fgColor.b * u_intensity * u_intensityB;
    } else {
        fgColor.r = mix(inputColor.r, fgColor.r, u_intensity * u_intensityR);
        fgColor.g = mix(inputColor.g, fgColor.g, u_intensity * u_intensityG);
        fgColor.b = mix(inputColor.b, fgColor.b, u_intensity * u_intensityB);
    }

    gl_FragColor = fgColor;
}
`;