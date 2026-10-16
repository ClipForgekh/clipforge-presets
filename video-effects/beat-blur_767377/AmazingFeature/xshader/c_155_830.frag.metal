#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uSeed;
    float2 uvScale;
    float2 uvOffset;
    float filmGrainDensity;
    float filmGrainIntensity;
    float uOpacity;
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
float rand(thread const float2& co, constant float& uSeed)
{
    return fract(sin(dot(co + float2(uSeed, uSeed * 1.37000000476837158203125), float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.uvScale) + buffer.uvOffset;
    float4 texel = texture1.sample(texture1Smplr, mappedUv);
    float2 param = mappedUv * 231.6999969482421875;
    float grainMask = step(1.0 - buffer.filmGrainDensity, rand(param, buffer.uSeed));
    float2 param_1 = (mappedUv * 733.0999755859375) + float2(0.37000000476837158203125);
    float grain = (rand(param_1, buffer.uSeed) - 0.5) * 2.0;
    float4 _87 = texel;
    float3 _90 = _87.xyz + float3(((grain * buffer.filmGrainIntensity) * grainMask) * 0.20000000298023223876953125);
    texel.x = _90.x;
    texel.y = _90.y;
    texel.z = _90.z;
    out.gl_FragColor = float4(texel.xyz, texel.w * buffer.uOpacity);
    return out;
}

