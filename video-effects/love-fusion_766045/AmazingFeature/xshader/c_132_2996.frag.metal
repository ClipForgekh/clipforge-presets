#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float stagger;
    float popStrength;
    float heartScale;
    float rotateStrength;
    float edgeBlur;
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
float2 hash21(thread const float& p)
{
    return fract(sin(float2(p * 127.09999847412109375, p * 311.70001220703125)) * 43758.546875);
}

static inline __attribute__((always_inline))
float hash11(thread const float& p)
{
    return fract(sin(p * 127.09999847412109375) * 43758.546875);
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
        return sqrt(dot(q, q)) - 0.3535533845424652099609375;
    }
    float a = dot(p - float2(0.0, 1.0), p - float2(0.0, 1.0));
    float b = dot(p - float2(0.5), p - float2(0.5));
    return sqrt(fast::min(a, b)) * sign(p.x - p.y);
}

static inline __attribute__((always_inline))
float heartMaskRot(thread const float2& uv, thread const float2& center, thread const float& size, thread const float& angle, thread const float& blurEdge, constant float& ratio)
{
    float2 param = uv;
    float2 param_1 = center;
    float2 p = getSDFCoordinate(param, param_1, ratio);
    float s = sin(angle);
    float c = cos(angle);
    p = float2x2(float2(c, -s), float2(s, c)) * p;
    p /= float2(fast::max(size, 9.9999997473787516355514526367188e-05));
    p.y += 0.449999988079071044921875;
    float2 param_2 = p;
    float _192 = sdHeart(param_2);
    float d = _192 * size;
    return 1.0 - smoothstep(-blurEdge, blurEdge, d);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& stagger, constant float& popStrength, constant float& heartScale, constant float& rotateStrength, thread float2& vUv, constant float& edgeBlur)
{
    float reveal = 0.0;
    for (int i = 0; i < 8; i++)
    {
        float fi = float(i);
        float param = fi + 3.7000000476837158203125;
        float2 rnd = hash21(param);
        float2 center = float2(0.119999997317790985107421875 + (rnd.x * 0.7599999904632568359375), 0.100000001490116119384765625 + (rnd.y * 0.800000011920928955078125));
        float param_1 = fi + 19.299999237060546875;
        float order = hash11(param_1);
        float delay = order * stagger;
        float lp = fast::clamp((p - delay) / fast::max(1.0 - stagger, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
        float pop = (sin(lp * 3.1415927410125732421875) * (1.0 - lp)) * popStrength;
        float grow = lp + pop;
        float param_2 = fi + 7.099999904632568359375;
        float size = (heartScale * (0.550000011920928955078125 + (hash11(param_2) * 0.89999997615814208984375))) * grow;
        float param_3 = fi + 41.200000762939453125;
        float angle = ((hash11(param_3) - 0.5) * rotateStrength) * (1.0 - lp);
        float2 param_4 = vUv;
        float2 param_5 = center;
        float param_6 = size;
        float param_7 = angle;
        float param_8 = edgeBlur;
        float m = heartMaskRot(param_4, param_5, param_6, param_7, param_8, ratio);
        reveal = fast::max(reveal, m);
    }
    reveal = fast::max(reveal, p);
    reveal = fast::clamp(reveal, 0.0, 1.0);
    float3 col = mix(float3(0.0), texel.xyz, float3(reveal));
    return float4(col, texel.w * reveal);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.stagger, buffer.popStrength, buffer.heartScale, buffer.rotateStrength, in.vUv, buffer.edgeBlur);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

