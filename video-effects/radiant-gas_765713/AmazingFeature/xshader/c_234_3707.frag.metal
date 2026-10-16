#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blurRadius;
    float u_noiseScale;
    float u_noiseThreshold;
    float3 u_glowColorB;
    float3 u_glowColorA;
    float u_glowStrength;
    float u_blobAlpha;
    float u_brightness;
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
float4 sampleBlurred(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius)
{
    float2 r = float2(radius);
    float4 color = float4(0.0);
    color += (tex.sample(texSmplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.20000000298023223876953125);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(r.x, 0.0), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(-r.x, 0.0), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, r.y), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, -r.y), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(r.x, r.y), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(-r.x, r.y), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(r.x, -r.y), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(-r.x, -r.y), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    return color;
}

static inline __attribute__((always_inline))
float hash(thread const float2& p)
{
    return fract(sin(dot(p, float2(127.09999847412109375, 311.70001220703125))) * 43758.546875);
}

static inline __attribute__((always_inline))
float _noise(thread const float2& p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    float2 param = i;
    float a = hash(param);
    float2 param_1 = i + float2(1.0, 0.0);
    float b = hash(param_1);
    float2 param_2 = i + float2(0.0, 1.0);
    float c = hash(param_2);
    float2 param_3 = i + float2(1.0);
    float d = hash(param_3);
    float2 u = (f * f) * (float2(3.0) - (f * 2.0));
    return (mix(a, b, u.x) + (((c - a) * u.y) * (1.0 - u.x))) + (((d - b) * u.x) * u.y);
}

static inline __attribute__((always_inline))
float fbm(thread const float2& p)
{
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    for (int i = 0; i < 5; i++)
    {
        float2 param = p * frequency;
        value += (amplitude * _noise(param));
        frequency *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& base, thread const float3& blend)
{
    return float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - blend));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = fast::clamp(in.vUv, float2(0.0), float2(1.0));
    float4 clearTex = texture1.sample(texture1Smplr, uv);
    float2 param = uv;
    float param_1 = buffer.u_blurRadius;
    float4 blurredTex = sampleBlurred(texture1, texture1Smplr, param, param_1);
    float2 noiseUv = (uv - float2(0.5)) * buffer.u_noiseScale;
    noiseUv.x *= 1.14999997615814208984375;
    float2 param_2 = noiseUv + float2(0.0);
    float n1 = fbm(param_2);
    float2 param_3 = (noiseUv * 1.89999997615814208984375) + float2(2.7000000476837158203125, -1.2999999523162841796875);
    float n2 = fbm(param_3);
    float2 param_4 = (noiseUv * 0.699999988079071044921875) + float2(-3.099999904632568359375, 1.7999999523162841796875);
    float n3 = fbm(param_4);
    float combinedNoise = ((n1 * 0.550000011920928955078125) + (n2 * 0.300000011920928955078125)) + (n3 * 0.1500000059604644775390625);
    float radial = 1.0 - smoothstep(0.100000001490116119384765625, 0.920000016689300537109375, distance(uv, float2(0.5, 0.540000021457672119140625)));
    float blobField = (combinedNoise * 0.819999992847442626953125) + (radial * 0.550000011920928955078125);
    float coreMask = smoothstep(buffer.u_noiseThreshold, 1.0, blobField);
    float glowMask = smoothstep(buffer.u_noiseThreshold - 0.20000000298023223876953125, 1.0, blobField) - coreMask;
    float3 warmColor = mix(buffer.u_glowColorB, buffer.u_glowColorA, float3(fast::clamp(blobField * 1.10000002384185791015625, 0.0, 1.0)));
    float3 bloomLayer = warmColor * ((coreMask * (0.89999997615814208984375 + (buffer.u_glowStrength * 1.39999997615814208984375))) + (glowMask * (0.60000002384185791015625 + (buffer.u_glowStrength * 2.0))));
    float3 overExpose = ((warmColor * coreMask) * buffer.u_glowStrength) * 0.85000002384185791015625;
    float3 baseColor = mix(clearTex.xyz, blurredTex.xyz, float3(fast::clamp((buffer.u_blobAlpha * 0.85000002384185791015625) + (buffer.u_blurRadius * 2.2000000476837158203125), 0.0, 1.0)));
    float3 param_5 = baseColor;
    float3 param_6 = bloomLayer * buffer.u_blobAlpha;
    float3 screened = screenBlend(param_5, param_6);
    float3 added = screened + (overExpose * buffer.u_blobAlpha);
    float3 finalColor = mix(clearTex.xyz, added, float3(fast::clamp(buffer.u_blobAlpha + (buffer.u_glowStrength * 0.25), 0.0, 1.0)));
    finalColor *= buffer.u_brightness;
    out.gl_FragColor = float4(fast::clamp(finalColor, float3(0.0), float3(1.0)), 1.0);
    return out;
}

