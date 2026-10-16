#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_time;
    float u_fireIntensity;
    float u_brightness;
    float u_grayscale;
    float u_chromatic;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUv [[user(vUv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], texture2d<float> texture2 [[texture(1)]], sampler texture1Smplr [[sampler(0)]], sampler texture2Smplr [[sampler(1)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float4 baseTex = texture1.sample(texture1Smplr, uv);
    float2 flowUvA = uv + float2(0.0, (-buffer.u_time) * 0.180000007152557373046875);
    float2 flowUvB = (uv * 1.35000002384185791015625) + float2(buffer.u_time * 0.070000000298023223876953125, (-buffer.u_time) * 0.119999997317790985107421875);
    float noiseA = texture2.sample(texture2Smplr, flowUvA).x;
    float noiseB = texture2.sample(texture2Smplr, flowUvB).y;
    float fireNoise = mix(noiseA, noiseB, 0.5);
    float2 centered = uv - float2(0.5);
    float r = length(centered);
    float ring = smoothstep(0.180000007152557373046875, 0.4600000083446502685546875, r) * (1.0 - smoothstep(0.4600000083446502685546875, 0.62000000476837158203125, r));
    float flicker = 0.75 + (0.25 * sin((buffer.u_time * 12.0) + (fireNoise * 8.0)));
    float auraMask = ((ring * fireNoise) * buffer.u_fireIntensity) * flicker;
    float3 fireColorA = float3(1.0, 0.4199999868869781494140625, 0.0);
    float3 fireColorB = float3(1.0, 0.180000007152557373046875, 0.0);
    float3 fireColorC = float3(1.0, 0.75, 0.300000011920928955078125);
    float3 auraColor = mix(fireColorA, fireColorB, float3(fast::clamp(fireNoise * 1.2000000476837158203125, 0.0, 1.0)));
    auraColor = mix(auraColor, fireColorC, float3(fast::clamp(ring, 0.0, 1.0) * 0.3499999940395355224609375));
    float3 color = baseTex.xyz + (auraColor * auraMask);
    color *= buffer.u_brightness;
    if (buffer.u_grayscale > 0.0)
    {
        float gray = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
        color = mix(color, float3(gray), float3(fast::clamp(buffer.u_grayscale, 0.0, 1.0)));
    }
    if (buffer.u_chromatic > 0.0)
    {
        float2 dir = uv - float2(0.5);
        float offset = buffer.u_chromatic * 0.0199999995529651641845703125;
        float rCh = texture1.sample(texture1Smplr, (uv + (dir * offset))).x;
        float gCh = texture1.sample(texture1Smplr, uv).y;
        float bCh = texture1.sample(texture1Smplr, (uv - (dir * offset))).z;
        float3 chromaColor = float3(rCh, gCh, bCh) + (auraColor * auraMask);
        color = mix(color, chromaColor, float3(fast::clamp(buffer.u_chromatic, 0.0, 1.0)));
    }
    float alpha = fast::clamp(baseTex.w + (auraMask * 0.89999997615814208984375), 0.0, 1.0);
    out.gl_FragColor = float4(color, alpha);
    return out;
}

