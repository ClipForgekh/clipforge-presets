precision highp float;
varying vec2 uv0;
varying vec2 uv1;
uniform float uniAlpha;
uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 lm_take_effect_filter(sampler2D filterTex, vec4 inputColor)
{
    highp vec4 textureColor = inputColor;
    highp float blueColor = textureColor.b * 63.0;
    highp vec2 quad1;
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);
    highp vec2 quad2;
    quad2.y = floor(ceil(blueColor) / 8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);
    highp vec2 texPos1;
    texPos1.x = (quad1.x * 0.125) + 0.5 / 512.0 + ((0.125 - 1.0 / 512.0) * textureColor.r);
    texPos1.y = (quad1.y * 0.125) + 0.5 / 512.0 + ((0.125 - 1.0 / 512.0) * textureColor.g);
    highp vec2 texPos2;
    texPos2.x = (quad2.x * 0.125) + 0.5 / 512.0 + ((0.125 - 1.0 / 512.0) * textureColor.r);
    texPos2.y = (quad2.y * 0.125) + 0.5 / 512.0 + ((0.125 - 1.0 / 512.0) * textureColor.g);
    vec4 newColor1 = texture2D(filterTex, texPos1);
    vec4 newColor2 = texture2D(filterTex, texPos2);
    vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    return vec4(newColor.rgb, textureColor.a);
}

float filmNoise(vec2 co)
{
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453123) - 0.5;
}

vec3 screenBlend(vec3 baseColor, vec3 blendColor)
{
    return 1.0 - (1.0 - baseColor) * (1.0 - blendColor);
}

void main()
{
    vec4 curColor = texture2D(inputImageTexture, uv0);
    vec4 filtered = lm_take_effect_filter(inputImageTexture2, curColor);

    vec2 px = vec2(1.0 / 720.0, 1.0 / 1280.0);
    vec3 blur = texture2D(inputImageTexture, uv0).rgb * 0.16;
    blur += texture2D(inputImageTexture, uv0 + vec2(px.x * 5.0, 0.0)).rgb * 0.10;
    blur += texture2D(inputImageTexture, uv0 - vec2(px.x * 5.0, 0.0)).rgb * 0.10;
    blur += texture2D(inputImageTexture, uv0 + vec2(0.0, px.y * 5.0)).rgb * 0.10;
    blur += texture2D(inputImageTexture, uv0 - vec2(0.0, px.y * 5.0)).rgb * 0.10;
    blur += texture2D(inputImageTexture, uv0 + vec2(px.x * 10.0, px.y * 8.0)).rgb * 0.08;
    blur += texture2D(inputImageTexture, uv0 + vec2(-px.x * 10.0, px.y * 8.0)).rgb * 0.08;
    blur += texture2D(inputImageTexture, uv0 + vec2(px.x * 10.0, -px.y * 8.0)).rgb * 0.08;
    blur += texture2D(inputImageTexture, uv0 + vec2(-px.x * 10.0, -px.y * 8.0)).rgb * 0.08;
    blur += texture2D(inputImageTexture, uv0 + vec2(px.x * 18.0, -px.y * 4.0)).rgb * 0.06;
    blur += texture2D(inputImageTexture, uv0 + vec2(-px.x * 18.0, px.y * 4.0)).rgb * 0.06;
    blur = clamp(blur, 0.0, 1.0);

    vec3 blurFiltered = lm_take_effect_filter(inputImageTexture2, vec4(blur, curColor.a)).rgb;
    float blurLuma = dot(blurFiltered, vec3(0.299, 0.587, 0.114));
    float high = smoothstep(0.56, 0.96, blurLuma);

    vec3 softColor = mix(filtered.rgb, blurFiltered, 0.055);
    vec3 flashGlow = screenBlend(softColor, clamp(blurFiltered * vec3(1.03, 1.01, 1.04) + vec3(0.020, 0.014, 0.022), 0.0, 1.0));
    vec3 finalColor = mix(softColor, flashGlow, 0.050 + high * 0.095);

    float topLeak = (1.0 - smoothstep(0.18, 0.72, uv0.y)) * (0.76 + 0.24 * sin(uv0.x * 9.0 + uv0.y * 4.0));
    float bottomMint = smoothstep(0.42, 1.0, uv0.y) * (0.78 + 0.22 * cos(uv0.x * 7.0 + 1.7));
    float rightFlare = smoothstep(0.55, 1.0, uv0.x) * (1.0 - smoothstep(0.08, 0.58, uv0.y));

    finalColor = mix(finalColor, screenBlend(finalColor, vec3(1.0, 0.40, 0.56)), clamp(topLeak * 0.150 + rightFlare * 0.040, 0.0, 0.20));
    finalColor = mix(finalColor, screenBlend(finalColor, vec3(0.48, 1.0, 0.76)), clamp(bottomMint * 0.055, 0.0, 0.10));

    float lumaNow = dot(finalColor, vec3(0.299, 0.587, 0.114));
    float grain = filmNoise(uv0 * vec2(1260.0, 840.0)) * (0.018 + 0.014 * (1.0 - lumaNow));
    float fineGrain = filmNoise(uv0 * vec2(2320.0, 1510.0) + 19.0) * 0.006;
    finalColor = clamp(finalColor + vec3(grain + fineGrain, grain * 0.92 + fineGrain, grain * 0.86 + fineGrain), 0.0, 1.0);

    vec3 mixedColor = mix(curColor.rgb, finalColor, uniAlpha);
    gl_FragColor = vec4(mixedColor, curColor.a);
}