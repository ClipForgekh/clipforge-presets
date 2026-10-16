#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_time;
    float u_noiseAmount;
    float u_particleIntensity;
    float u_maskProgress;
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
float _noise(thread const float2& p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    float2 param = i;
    float _60 = hash(param);
    float a = _60;
    float2 param_1 = i + float2(1.0, 0.0);
    float _68 = hash(param_1);
    float b = _68;
    float2 param_2 = i + float2(0.0, 1.0);
    float _74 = hash(param_2);
    float c = _74;
    float2 param_3 = i + float2(1.0);
    float _80 = hash(param_3);
    float d = _80;
    float2 u = (f * f) * (float2(3.0) - (f * 2.0));
    return (mix(a, b, u.x) + (((c - a) * u.y) * (1.0 - u.x))) + (((d - b) * u.x) * u.y);
}

static inline __attribute__((always_inline))
float fbm(thread float2& p)
{
    float v = 0.0;
    float amp = 0.5;
    for (int i = 0; i < 4; i++)
    {
        float2 param = p;
        v += (amp * _noise(param));
        p *= 2.0;
        amp *= 0.5;
    }
    return v;
}

static inline __attribute__((always_inline))
float particleField(thread const float2& uv, thread const float& t)
{
    float2 p = uv;
    p.x -= (t * 0.2199999988079071044921875);
    p.y += (sin((uv.x + (t * 0.3499999940395355224609375)) * 8.0) * 0.0599999986588954925537109375);
    p.y += (sin((uv.x + (t * 0.180000007152557373046875)) * 17.0) * 0.02999999932944774627685546875);
    float2 param = (p * 12.0) + float2(0.0, t * 0.89999997615814208984375);
    float _202 = fbm(param);
    float n1 = _202;
    float2 param_1 = (p * 22.0) - float2(t * 1.2000000476837158203125, 0.0);
    float _213 = fbm(param_1);
    float n2 = _213;
    float n = mix(n1, n2, 0.5);
    float cluster = smoothstep(0.7200000286102294921875, 0.980000019073486328125, n);
    float glow = smoothstep(0.449999988079071044921875, 1.0, n) * 0.60000002384185791015625;
    return cluster + glow;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texA = texture1.sample(texture1Smplr, in.vUv);
    float3 baseColor = texA.xyz;
    float leftSpawn = 1.0 - smoothstep(0.0, 0.449999988079071044921875, in.vUv.x);
    float2 param = (in.vUv * 9.0) + float2(buffer.u_time * 0.800000011920928955078125, (-buffer.u_time) * 0.449999988079071044921875);
    float _272 = fbm(param);
    float driftNoise = (_272 - 0.5) * 2.0;
    float2 uvWarp = in.vUv + float2((driftNoise * 0.0199999995529651641845703125) * buffer.u_noiseAmount, (driftNoise * 0.02999999932944774627685546875) * buffer.u_noiseAmount);
    float2 param_1 = uvWarp;
    float param_2 = buffer.u_time;
    float particles = particleField(param_1, param_2) * leftSpawn;
    particles *= buffer.u_particleIntensity;
    float3 warmWhite = float3(0.939999997615814208984375, 0.920000016689300537109375, 0.839999973773956298828125);
    float3 particleColor = (warmWhite * particles) * 1.39999997615814208984375;
    float3 screenMixed = float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - particleColor));
    float maskCover = smoothstep(in.vUv.x - 0.0199999995529651641845703125, in.vUv.x + 0.0199999995529651641845703125, buffer.u_maskProgress);
    if (buffer.u_maskProgress >= 0.999000012874603271484375)
    {
        maskCover = 1.0;
    }
    float3 finalColor = mix(screenMixed, float3(0.0), float3(maskCover));
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

