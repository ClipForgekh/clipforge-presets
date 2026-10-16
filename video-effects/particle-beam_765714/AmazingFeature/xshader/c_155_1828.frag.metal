#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_flickerAmount;
    float u_introAlpha;
    float u_time;
    float u_trailStrength;
    float u_particleDensity;
    float u_glowIntensity;
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
float hash(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 345.45001220703125));
    p += float2(dot(p, p + float2(34.345001220703125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float particleField(thread const float2& uv, thread const float& t, constant float& u_flickerAmount)
{
    float2 flowUv = uv;
    flowUv += float2((-t) * 0.2199999988079071044921875, t * 0.2199999988079071044921875);
    float2 cell = floor(flowUv * 40.0);
    float2 f = fract(flowUv * 40.0) - float2(0.5);
    float2 param = cell;
    float _71 = hash(param);
    float n = _71;
    float2 param_1 = cell + float2(1.7000000476837158203125);
    float _78 = hash(param_1);
    float2 param_2 = cell + float2(9.30000019073486328125);
    float _84 = hash(param_2);
    float2 p = float2(_78, _84) - float2(0.5);
    float d = length(f - (p * 0.75));
    float spark = smoothstep(0.1599999964237213134765625, 0.0, d);
    float blink = 0.85000002384185791015625 + (u_flickerAmount * sin((t * 35.0) + (n * 20.0)));
    return spark * blink;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_texture1 [[texture(0)]], sampler u_texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float4 baseTex = u_texture1.sample(u_texture1Smplr, in.vUv);
    float3 baseColor = baseTex.xyz * buffer.u_introAlpha;
    float t = buffer.u_time * 0.001000000047497451305389404296875;
    float2 dir = float2(0.707106769084930419921875, -0.707106769084930419921875);
    float diag = dot(in.vUv - float2(0.0, 1.0), dir);
    float band = exp((-abs((diag * 3.0) - (t * 2.7999999523162841796875))) * (2.599999904632568359375 - (1.5 * buffer.u_trailStrength)));
    float2 param = in.vUv;
    float param_1 = t;
    float particles = particleField(param, param_1, buffer.u_flickerAmount) * buffer.u_particleDensity;
    float trail = (band * buffer.u_trailStrength) * buffer.u_particleDensity;
    float3 goldCore = float3(0.85000002384185791015625, 0.63999998569488525390625, 0.25);
    float3 goldHot = float3(0.949999988079071044921875, 0.819999992847442626953125, 0.4799999892711639404296875);
    float3 glowColor = mix(goldCore, goldHot, float3(particles));
    float3 glow = (glowColor * ((particles * 1.35000002384185791015625) + (trail * 0.949999988079071044921875))) * buffer.u_glowIntensity;
    float3 finalColor = float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - glow));
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

