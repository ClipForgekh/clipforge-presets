#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float flyStrength;
    float glowIntensity;
    float3 goldColor;
    float progress;
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
float tween(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 2.0);
}

static inline __attribute__((always_inline))
float2 hash2(thread const float& n)
{
    return fract(sin(float2(n, n + 17.1299991607666015625)) * float2(43758.546875, 22578.146484375));
}

static inline __attribute__((always_inline))
float2 getSDFCoordinate(thread const float2& uv, thread const float2& center, constant float& ratio)
{
    float2 p = uv - center;
    if (ratio > 1.0)
    {
        p.y /= ratio;
    }
    else
    {
        p.x *= ratio;
    }
    return p;
}

static inline __attribute__((always_inline))
float sdHeart(thread float2& p)
{
    p.x = abs(p.x);
    if ((p.y + p.x) > 1.0)
    {
        float2 q = p - float2(0.25, 0.75);
        return length(q) - 0.3535533845424652099609375;
    }
    float a = dot(p - float2(0.0, 1.0), p - float2(0.0, 1.0));
    float b = dot(p - float2(0.5), p - float2(0.5));
    return sqrt(fast::min(a, b)) * sign(p.x - p.y);
}

static inline __attribute__((always_inline))
float heartDist3D(thread const float2& uv, thread const float2& center, thread const float& size, thread const float& yAngle, constant float& ratio)
{
    float2 param = uv;
    float2 param_1 = center;
    float2 p = getSDFCoordinate(param, param_1, ratio);
    float projScale = 0.2199999988079071044921875 + (0.7799999713897705078125 * abs(cos(yAngle)));
    p.x /= projScale;
    p /= float2(fast::max(size, 9.9999997473787516355514526367188e-05));
    p.y += 0.449999988079071044921875;
    float2 param_2 = p;
    float _161 = sdHeart(param_2);
    return _161 * size;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& flyStrength, thread float2& vUv, constant float& glowIntensity, constant float3& goldColor)
{
    float t = fast::clamp(p, 0.0, 1.0);
    float holeUnion = 0.0;
    float ringUnion = 0.0;
    float glowUnion = 0.0;
    for (int i = 0; i < 9; i++)
    {
        float fi = float(i);
        float layer = floor(fi / 3.0);
        float layerN = layer / 2.0;
        float param = (fi * 13.36999988555908203125) + 2.71000003814697265625;
        float2 rnd = hash2(param);
        float2 startPos = mix(float2(0.07999999821186065673828125), float2(0.920000016689300537109375), rnd);
        float speed = mix(0.85000002384185791015625, 1.5499999523162841796875, layerN) * flyStrength;
        float localT = fast::clamp(t * speed, 0.0, 1.25);
        float2 driftDir = fast::normalize((startPos - float2(0.5)) + float2(0.001000000047497451305389404296875));
        float2 center = startPos + ((driftDir * localT) * (0.07999999821186065673828125 + (0.0599999986588954925537109375 * layerN)));
        float baseSize = mix(0.0500000007450580596923828125, 0.10999999940395355224609375, layerN);
        float size = baseSize * (1.0 + ((localT * localT) * (6.0 + (3.0 * layerN))));
        float angle = (localT * 6.283185482025146484375) + (fi * 0.89999997615814208984375);
        float2 param_1 = vUv;
        float2 param_2 = center;
        float param_3 = size;
        float param_4 = angle;
        float d = heartDist3D(param_1, param_2, param_3, param_4, ratio);
        float hole = 1.0 - smoothstep(-0.0030000000260770320892333984375, 0.0030000000260770320892333984375, d);
        float thickness = 0.0024999999441206455230712890625;
        float ring = 1.0 - smoothstep(thickness, thickness + 0.00449999980628490447998046875, abs(d));
        float glow = exp((-fast::max(d, 0.0)) * 90.0) * (0.3499999940395355224609375 + (0.25 * layerN));
        holeUnion = fast::max(holeUnion, hole);
        ringUnion = fast::max(ringUnion, ring);
        glowUnion = fast::max(glowUnion, glow);
    }
    float globalReveal = smoothstep(0.699999988079071044921875, 1.0, t);
    float revealMask = fast::clamp(fast::max(holeUnion, globalReveal), 0.0, 1.0);
    float3 color = mix(float3(0.0), texel.xyz, float3(revealMask));
    float metalFade = 1.0 - smoothstep(0.7200000286102294921875, 1.0, t);
    float metalLight = (((ringUnion * 1.14999997615814208984375) + (glowUnion * 0.85000002384185791015625)) * glowIntensity) * metalFade;
    color += ((goldColor * metalLight) * (1.0 - (revealMask * 0.85000002384185791015625)));
    color = fast::clamp(color, float3(0.0), float3(1.0));
    float endRestore = smoothstep(0.980000019073486328125, 1.0, t);
    color = mix(color, texel.xyz, float3(endRestore));
    return float4(color, texel.w);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float param = effectProgress;
    effectProgress = tween(param);
    float4 param_1 = texel;
    float param_2 = effectProgress;
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.flyStrength, in.vUv, buffer.glowIntensity, buffer.goldColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

