#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float randFreq;
    float seed;
    float randLumaAmp;
    float randColorAmp;
    float waveFreq;
    float phaseR;
    float phaseG;
    float phaseB;
    float waveAmp;
    float progress;
    float ampR;
    float ampG;
    float ampB;
    float globalAmp;
    float brightness;
    float u_Intensity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUv [[user(vUv)]];
};

static inline __attribute__((always_inline))
float3 generateRandomNoise(thread const float& time, constant float& randFreq, constant float& seed, constant float& randLumaAmp, constant float& randColorAmp)
{
    float t = time * randFreq;
    float seedOffset1 = mod(seed, 0.23000000417232513427734375);
    float seedOffset2 = mod(seed, 0.4699999988079071044921875);
    float seedOffset3 = mod(seed, 0.829999983310699462890625);
    float lumaNoiseR = 0.0;
    lumaNoiseR += (sin((t + seedOffset1) * 6.28299999237060546875) * 0.4000000059604644775390625);
    lumaNoiseR += (sin(((t * 2.0299999713897705078125) + seedOffset2) * 6.28299999237060546875) * 0.300000011920928955078125);
    lumaNoiseR += (cos(((t * 4.0) + seedOffset3) * 6.28299999237060546875) * 0.20000000298023223876953125);
    lumaNoiseR += (sin(((t * 4.909999847412109375) + seedOffset1) * 6.28299999237060546875) * 0.100000001490116119384765625);
    float3 colorNoise = float3(0.0);
    colorNoise.x += (cos((t + seedOffset1) * 6.28299999237060546875) * 0.4000000059604644775390625);
    colorNoise.x += (cos(((t * 1.5299999713897705078125) + seedOffset2) * 6.28299999237060546875) * 0.300000011920928955078125);
    colorNoise.x += (cos(((t * 3.5699999332427978515625) + seedOffset3) * 6.28299999237060546875) * 0.20000000298023223876953125);
    colorNoise.x += (sin(((t * 5.110000133514404296875) + seedOffset1) * 6.28299999237060546875) * 0.100000001490116119384765625);
    colorNoise.y += (cos((t + seedOffset2) * 6.28299999237060546875) * 0.4000000059604644775390625);
    colorNoise.y += (cos(((t * 1.5299999713897705078125) + seedOffset3) * 6.28299999237060546875) * 0.300000011920928955078125);
    colorNoise.y += (cos(((t * 2.1700000762939453125) + seedOffset1) * 6.28299999237060546875) * 0.20000000298023223876953125);
    colorNoise.y += (cos(((t * 3.9100000858306884765625) + seedOffset2) * 6.28299999237060546875) * 0.100000001490116119384765625);
    colorNoise.z += (cos((t + seedOffset3) * 6.28299999237060546875) * 0.4000000059604644775390625);
    colorNoise.z += (cos(((t * 0.9700000286102294921875) + seedOffset1) * 6.28299999237060546875) * 0.300000011920928955078125);
    colorNoise.z += (sin(((t * 2.1700000762939453125) + seedOffset2) * 6.28299999237060546875) * 0.20000000298023223876953125);
    colorNoise.z += (cos(((t * 3.9100000858306884765625) + seedOffset3) * 6.28299999237060546875) * 0.100000001490116119384765625);
    return (float3(lumaNoiseR) * randLumaAmp) + (colorNoise * randColorAmp);
}

static inline __attribute__((always_inline))
float3 generateWaveModulation(thread const float& time, constant float& waveFreq, constant float& phaseR, constant float& phaseG, constant float& phaseB, constant float& waveAmp)
{
    return float3(cos(((time * waveFreq) + phaseR) * 6.28299999237060546875), cos(((time * waveFreq) + phaseG) * 6.28299999237060546875), cos(((time * waveFreq) + phaseB) * 6.28299999237060546875)) * waveAmp;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 originalColor = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float param = buffer.progress;
    float3 randomNoise = generateRandomNoise(param, buffer.randFreq, buffer.seed, buffer.randLumaAmp, buffer.randColorAmp);
    float param_1 = buffer.progress;
    float3 waveModulation = generateWaveModulation(param_1, buffer.waveFreq, buffer.phaseR, buffer.phaseG, buffer.phaseB, buffer.waveAmp);
    float3 flickerModulation = ((waveModulation + randomNoise) * (originalColor.xyz * float3(buffer.ampR, buffer.ampG, buffer.ampB))) * buffer.globalAmp;
    float3 flickerColor = fast::clamp((originalColor.xyz * buffer.brightness) + flickerModulation, float3(0.0), float3(1.0));
    float3 finalColor = mix(originalColor.xyz, flickerColor, float3(buffer.u_Intensity));
    out.gl_FragColor = float4(finalColor, originalColor.w);
    return out;
}

