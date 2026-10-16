#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_chromatic;
    float u_noiseTick;
    float edgeGlitchIntensity;
    float u_brightness;
    float trailOpacity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUvMapped [[user(vUvMapped)]];
    float2 vLocalUv [[user(vLocalUv)]];
};

static inline __attribute__((always_inline))
float hash(thread const float2& p)
{
    return fract(sin(dot(p, float2(127.09999847412109375, 311.70001220703125))) * 43758.546875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_texture [[texture(0)]], sampler u_textureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 dir = in.vUvMapped - float2(0.5);
    float ca = buffer.u_chromatic * 0.0199999995529651641845703125;
    float r = u_texture.sample(u_textureSmplr, ((in.vUvMapped + float2(ca, 0.0)) + ((dir * ca) * 0.4000000059604644775390625))).x;
    float g = u_texture.sample(u_textureSmplr, in.vUvMapped).y;
    float b = u_texture.sample(u_textureSmplr, ((in.vUvMapped - float2(ca, 0.0)) - ((dir * ca) * 0.4000000059604644775390625))).z;
    float3 base = float3(r, g, b);
    float edgeDist = fast::min(in.vLocalUv.x, 1.0 - in.vLocalUv.x);
    float edgeMask = 1.0 - smoothstep(0.0199999995529651641845703125, 0.1599999964237213134765625, edgeDist);
    float2 px = floor((in.vLocalUv * float2(28.0, 220.0)) + float2(buffer.u_noiseTick * 240.0, buffer.u_noiseTick * 137.0));
    float2 param = px;
    float n = hash(param);
    float glitch = (step(0.7200000286102294921875, n) * edgeMask) * buffer.edgeGlitchIntensity;
    float3 neonPink = float3(1.0, 0.310000002384185791015625, 0.85000002384185791015625);
    float3 neonBlue = float3(0.20000000298023223876953125, 0.769999980926513671875, 1.0);
    float3 neon = mix(neonBlue, neonPink, float3(in.vLocalUv.y));
    float3 lit = base * buffer.u_brightness;
    float3 screenBlend = float3(1.0) - ((float3(1.0) - lit) * (float3(1.0) - ((neon * buffer.trailOpacity) * 0.949999988079071044921875)));
    float3 glitchColor = mix(screenBlend, neon, float3(glitch));
    float3 finalColor = fast::max(glitchColor, float3(0.0));
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

