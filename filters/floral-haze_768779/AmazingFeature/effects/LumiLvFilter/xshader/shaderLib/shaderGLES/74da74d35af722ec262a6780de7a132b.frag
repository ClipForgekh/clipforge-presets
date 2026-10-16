precision highp float;
precision highp int;

uniform float uniAlpha;
uniform mediump sampler2D inputImageTexture;
uniform mediump sampler2D inputImageTexture2;

varying vec2 v_uv;

float hash21(vec2 p)
{
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float valueNoise(vec2 p)
{
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    return mix(mix(hash21(i), hash21(i + vec2(1.0, 0.0)), f.x),
               mix(hash21(i + vec2(0.0, 1.0)), hash21(i + vec2(1.0, 1.0)), f.x), f.y);
}

vec4 applyLut(vec4 source, float amount)
{
    float blue = source.b * 63.0;
    float slice0 = floor(blue);
    float slice1 = ceil(blue);
    vec2 tile0 = vec2(slice0 - floor(slice0 / 8.0) * 8.0, floor(slice0 / 8.0));
    vec2 tile1 = vec2(slice1 - floor(slice1 / 8.0) * 8.0, floor(slice1 / 8.0));
    vec2 uv0 = tile0 / 8.0 + vec2(0.0009765625) + 0.123046875 * source.rg;
    vec2 uv1 = tile1 / 8.0 + vec2(0.0009765625) + 0.123046875 * source.rg;
    uv0.y = 1.0 - uv0.y;
    uv1.y = 1.0 - uv1.y;
    vec3 mapped = mix(texture2D(inputImageTexture2, uv0).rgb,
                      texture2D(inputImageTexture2, uv1).rgb, fract(blue));
    return vec4(mix(source.rgb, mapped, clamp(amount, 0.0, 1.0)), source.a);
}

void main()
{
    vec4 original = texture2D(inputImageTexture, v_uv);
    if (uniAlpha < 0.00001)
    {
        gl_FragData[0] = original;
        return;
    }

    float strength = clamp(uniAlpha / 0.88, 0.0, 1.0);
    vec2 sampleUV = clamp(v_uv, 0.003, 0.997);
    vec2 softStep = vec2(0.0020);
    vec4 sharpSample = texture2D(inputImageTexture, sampleUV);
    vec2 chromaShift = (sampleUV - vec2(0.5)) * 0.0060 * strength;
    sharpSample.r = texture2D(inputImageTexture, clamp(sampleUV + chromaShift, 0.003, 0.997)).r;
    sharpSample.b = texture2D(inputImageTexture, clamp(sampleUV - chromaShift, 0.003, 0.997)).b;
    vec4 softSample = sharpSample * 4.0;
    softSample += texture2D(inputImageTexture, sampleUV + vec2(softStep.x, 0.0)) * 2.0;
    softSample += texture2D(inputImageTexture, sampleUV - vec2(softStep.x, 0.0)) * 2.0;
    softSample += texture2D(inputImageTexture, sampleUV + vec2(0.0, softStep.y)) * 2.0;
    softSample += texture2D(inputImageTexture, sampleUV - vec2(0.0, softStep.y)) * 2.0;
    softSample += texture2D(inputImageTexture, sampleUV + softStep);
    softSample += texture2D(inputImageTexture, sampleUV - softStep);
    softSample += texture2D(inputImageTexture, sampleUV + vec2(softStep.x, -softStep.y));
    softSample += texture2D(inputImageTexture, sampleUV + vec2(-softStep.x, softStep.y));
    softSample /= 16.0;
    vec4 refracted = mix(sharpSample, softSample, 0.22 * strength);
    vec4 graded = applyLut(refracted, uniAlpha);

    float coarse = valueNoise(v_uv * vec2(5.3, 7.1) + vec2(2.7, 9.4));
    float fineNoise = valueNoise(v_uv * vec2(31.0, 37.0));
    vec2 peachP = (v_uv - vec2(0.63, 0.58)) / vec2(0.55, 0.38);
    vec2 goldP = (v_uv - vec2(0.52, 0.15)) / vec2(0.62, 0.34);
    vec2 cyanP = (v_uv - vec2(0.18, 0.24)) / vec2(0.42, 0.38);
    vec2 greenP = (v_uv - vec2(0.28, 0.80)) / vec2(0.52, 0.32);
    float peachLeak = exp(-dot(peachP, peachP) * 1.45) * 0.250;
    float goldVeil = exp(-dot(goldP, goldP) * 1.20) * 0.135;
    float cyanVeil = exp(-dot(cyanP, cyanP) * 1.35) * 0.090;
    float greenVeil = exp(-dot(greenP, greenP) * 1.40) * 0.075;
    float milk = 0.052 + 0.086 * (0.70 * coarse + 0.30 * fineNoise);

    vec3 optical = vec3(milk * 1.08, milk, milk * 0.78);
    optical += peachLeak * vec3(1.00, 0.47, 0.48);
    optical += goldVeil * vec3(1.00, 0.76, 0.33);
    optical += cyanVeil * vec3(0.28, 0.76, 1.00);
    optical += greenVeil * vec3(0.42, 1.00, 0.60);
    vec3 color = 1.0 - (1.0 - graded.rgb) * (1.0 - clamp(optical * strength, 0.0, 0.32));

    float grain = hash21(v_uv * vec2(1280.0, 960.0) + vec2(13.0, 71.0)) - 0.5;
    color += grain * 0.010 * strength;
    gl_FragData[0] = vec4(clamp(color, 0.0, 1.0), original.a);
}
