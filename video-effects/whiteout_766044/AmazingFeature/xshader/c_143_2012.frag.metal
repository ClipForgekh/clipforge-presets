#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_verticalBlur;
    float2 uvScale;
    float2 uvOffset;
    float u_chromatic;
    float u_time;
    float u_scanNoise;
    float u_grayscale;
    float u_brightness;
    float u_opacity;
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
float4 sampleVerticalBlur(thread const float2& uv, constant float& u_verticalBlur, texture2d<float> texture1, sampler texture1Smplr)
{
    float blur = u_verticalBlur * 0.002199999988079071044921875;
    float2 o1 = float2(0.0, blur * 0.5);
    float2 o2 = float2(0.0, blur * 1.2000000476837158203125);
    float4 c0 = texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.3400000035762786865234375;
    float4 c1 = texture1.sample(texture1Smplr, fast::clamp(uv + o1, float2(0.0), float2(1.0))) * 0.2199999988079071044921875;
    float4 c2 = texture1.sample(texture1Smplr, fast::clamp(uv - o1, float2(0.0), float2(1.0))) * 0.2199999988079071044921875;
    float4 c3 = texture1.sample(texture1Smplr, fast::clamp(uv + o2, float2(0.0), float2(1.0))) * 0.10999999940395355224609375;
    float4 c4 = texture1.sample(texture1Smplr, fast::clamp(uv - o2, float2(0.0), float2(1.0))) * 0.10999999940395355224609375;
    return (((c0 + c1) + c2) + c3) + c4;
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.uvScale) + buffer.uvOffset;
    float2 dir = fast::normalize((mappedUv - float2(0.5)) + float2(9.9999997473787516355514526367188e-06));
    float ca = buffer.u_chromatic * 0.0199999995529651641845703125;
    float2 param = mappedUv + (dir * ca);
    float r = sampleVerticalBlur(param, buffer.u_verticalBlur, texture1, texture1Smplr).x;
    float2 param_1 = mappedUv;
    float g = sampleVerticalBlur(param_1, buffer.u_verticalBlur, texture1, texture1Smplr).y;
    float2 param_2 = mappedUv - (dir * ca);
    float b = sampleVerticalBlur(param_2, buffer.u_verticalBlur, texture1, texture1Smplr).z;
    float4 texColor = float4(r, g, b, 1.0);
    float scan = (sin((mappedUv.y * 900.0) + (buffer.u_time * 0.0500000007450580596923828125)) * 0.5) + 0.5;
    float2 param_3 = (mappedUv * float2(320.0, 180.0)) + float2(buffer.u_time * 0.001000000047497451305389404296875, buffer.u_time * 0.00200000009499490261077880859375);
    float grain = hash12(param_3);
    float noiseMix = ((scan * 0.100000001490116119384765625) + ((grain - 0.5) * 0.14000000059604644775390625)) * buffer.u_scanNoise;
    float4 _244 = texColor;
    float3 _246 = _244.xyz + float3(noiseMix * 0.800000011920928955078125, noiseMix * 0.300000011920928955078125, noiseMix * 1.10000002384185791015625);
    texColor.x = _246.x;
    texColor.y = _246.y;
    texColor.z = _246.z;
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _261 = texColor;
    float3 _268 = mix(_261.xyz, float3(gray), float3(buffer.u_grayscale));
    texColor.x = _268.x;
    texColor.y = _268.y;
    texColor.z = _268.z;
    float4 _277 = texColor;
    float3 _279 = _277.xyz * buffer.u_brightness;
    texColor.x = _279.x;
    texColor.y = _279.y;
    texColor.z = _279.z;
    texColor.w = buffer.u_opacity;
    out.gl_FragColor = texColor;
    return out;
}

