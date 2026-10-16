exports.source=`
precision highp float;

uniform sampler2D tDiffuse; // u_inputTexture
uniform sampler2D u_noiseTexture;
uniform float u_intensity;
uniform float u_intensityR;
uniform float u_intensityG;
uniform float u_intensityB;
uniform float u_combine;

varying vec2 vUv;

#define BlendOverlayf(base, blend)      (base < 0.5 ? (2.0 * base * blend) : (1.0 - 2.0 * (1.0 - base) * (1.0 - blend))) 
#define BlendOverlay(base, blend)       vec3(BlendOverlayf(base.r, blend.r), BlendOverlayf(base.g, blend.g), BlendOverlayf(base.b, blend.b))
#define BlendColorBurnf(base, blend)    ((blend == 0.0) ? blend : max((1.0 - ((1.0 - base) / blend)), 0.0))
#define BlendColorBurn(base, blend)     vec3(BlendColorBurnf(base.r, blend.r), BlendColorBurnf(base.g, blend.g), BlendColorBurnf(base.b, blend.b))
#define BlendScreen(base, blend)        (1.0 - (1.0 - base) * (1.0 - blend))
#define BlendMultiply(base, blend)      (base * blend)
#define BlendDifference(base, blend)    (abs(blend - base))
#define BlendAdd(base, blend)           (blend + base)

void main()
{
    vec4 noiseColor = texture2D(u_noiseTexture, vUv);
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