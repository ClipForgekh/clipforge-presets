#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_seed;
    float2 u_repeat;
    float2 u_offset;
    float u_time;
    float u_glitchStrength;
    float u_chromatic;
    float u_glowStrength;
    float3 u_glowColorA;
    float3 u_glowColorB;
    float u_tileParity;
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
float rand(thread const float2& co, constant float& u_seed)
{
    return fract(sin(dot(co, float2(12.98980045318603515625, 78.233001708984375)) + u_seed) * 43758.546875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.u_repeat) + buffer.u_offset;
    float2 blockUv = floor(mappedUv * float2(42.0)) / float2(42.0);
    float2 param = float2(floor(buffer.u_time * 90.0), (blockUv.y * 97.0) + (blockUv.x * 31.0));
    float n = rand(param, buffer.u_seed);
    float shift = ((n - 0.5) * 0.02999999932944774627685546875) * buffer.u_glitchStrength;
    float2 glitchUv = float2(fast::clamp(mappedUv.x + shift, 0.0, 1.0), mappedUv.y);
    float2 dir = glitchUv - float2(0.5);
    float offset = buffer.u_chromatic * 0.0199999995529651641845703125;
    float rCh = texture1.sample(texture1Smplr, fast::clamp(glitchUv + (dir * offset), float2(0.0), float2(1.0))).x;
    float gCh = texture1.sample(texture1Smplr, fast::clamp(glitchUv, float2(0.0), float2(1.0))).y;
    float bCh = texture1.sample(texture1Smplr, fast::clamp(glitchUv - (dir * offset), float2(0.0), float2(1.0))).z;
    float3 texRgb = float3(rCh, gCh, bCh);
    float edgeDist = fast::min(fast::min(in.vUv.x, 1.0 - in.vUv.x), fast::min(in.vUv.y, 1.0 - in.vUv.y));
    float glowMask = smoothstep(0.20000000298023223876953125, 0.0, edgeDist) * buffer.u_glowStrength;
    float3 glowColor = mix(buffer.u_glowColorA, buffer.u_glowColorB, float3(buffer.u_tileParity));
    float3 finalRgb = (texRgb * buffer.u_brightness) + (glowColor * glowMask);
    out.gl_FragColor = float4(finalRgb, buffer.u_opacity);
    return out;
}

