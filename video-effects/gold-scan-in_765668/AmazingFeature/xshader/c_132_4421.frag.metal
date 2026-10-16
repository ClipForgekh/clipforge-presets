#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float particleScale;
    float particleIntensity;
    float wipeSoftness;
    float blurMax;
    float trailWidth;
    float glowIntensity;
    float4 goldColor;
    float4 highlightColor;
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
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius, constant float& ratio)
{
    float stepBase = radius * 0.00150000001303851604461669921875;
    float2 st = float2(stepBase, stepBase / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.227026998996734619140625);
    float2 param_1 = uv + float2(st.x, 0.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.19459460675716400146484375);
    float2 param_2 = uv - float2(st.x, 0.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.19459460675716400146484375);
    float2 param_3 = uv + float2(0.0, st.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.121621601283550262451171875);
    float2 param_4 = uv - float2(0.0, st.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.121621601283550262451171875);
    float2 param_5 = uv + float2(st.x, st.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.0702702999114990234375);
    float2 param_6 = uv + float2(-st.x, st.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.0702702999114990234375);
    return c;
}

static inline __attribute__((always_inline))
float3 adjustSaturation(thread const float3& c, thread const float& s)
{
    float l = dot(c, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(l), c, float3(s));
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float2 hash22(thread const float2& p)
{
    float2 param = p;
    float n = hash12(param);
    float2 param_1 = (p + float2(n)) + float2(17.1700000762939453125);
    return float2(n, hash12(param_1));
}

static inline __attribute__((always_inline))
float particleField(thread const float2& uv, thread const float& p, thread const float& bandMask, constant float& particleScale, constant float& particleIntensity)
{
    float2 dir = float2(0.707106769084930419921875);
    float2 nor = float2(-dir.y, dir.x);
    float u = dot(uv, dir);
    float v = dot(uv, nor);
    float2 grid = float2(particleScale, particleScale * 0.3400000035762786865234375);
    float2 g = float2(u * grid.x, v * grid.y);
    float2 id = floor(g);
    float2 f = fract(g) - float2(0.5);
    float acc = 0.0;
    float density = 1.0 - p;
    for (int j = -1; j <= 1; j++)
    {
        for (int i = -1; i <= 1; i++)
        {
            float2 o = float2(float(i), float(j));
            float2 cid = id + o;
            float2 param = cid + float2(floor(p * 12.0));
            float2 rnd = hash22(param);
            float2 pos = (o + rnd) - float2(0.5);
            float d = length(f - pos);
            float2 param_1 = cid + float2(3.099999904632568359375);
            float size = mix(0.1599999964237213134765625, 0.0500000007450580596923828125, p) * (0.75 + (0.60000002384185791015625 * hash12(param_1)));
            float dotMask = 1.0 - smoothstep(size * 0.449999988079071044921875, size, d);
            float2 param_2 = (cid * 1.37000000476837158203125) + float2(7.30000019073486328125);
            float alive = step(0.3499999940395355224609375 + (0.550000011920928955078125 * (1.0 - density)), hash12(param_2));
            acc += (dotMask * alive);
        }
    }
    acc = fast::clamp(acc / 2.2000000476837158203125, 0.0, 1.0);
    return ((acc * bandMask) * density) * particleIntensity;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& particleScale, constant float& particleIntensity, thread float2& vUv, constant float& wipeSoftness, constant float& blurMax, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& trailWidth, constant float& glowIntensity, constant float4& goldColor, constant float4& highlightColor)
{
    float diag = (vUv.x + vUv.y) * 0.5;
    float front = mix(-0.20000000298023223876953125, 1.2000000476837158203125, p);
    float reveal = 1.0 - smoothstep(front - wipeSoftness, front + wipeSoftness, diag);
    float blurAmount = (blurMax * (1.0 - p)) * (1.0 - (reveal * 0.89999997615814208984375));
    float2 param = vUv;
    float param_1 = blurAmount;
    float4 base = gaussianBlur9(tDiffuse, tDiffuseSmplr, param, param_1, ratio);
    float brightness = mix(0.300000011920928955078125, 1.0, p);
    float saturation = mix(1.2000000476837158203125, 1.0, p);
    float3 param_2 = base.xyz * brightness;
    float param_3 = saturation;
    float3 baseRgb = adjustSaturation(param_2, param_3);
    float2 dir = float2(0.707106769084930419921875);
    float u = dot(vUv, dir);
    float sweepFront = mix(-0.25, 1.4500000476837158203125, p);
    float band = exp(-pow((u - sweepFront) / fast::max(trailWidth, 9.9999997473787516355514526367188e-05), 2.0));
    float2 param_4 = vUv;
    float param_5 = p;
    float param_6 = band;
    float particles = particleField(param_4, param_5, param_6, particleScale, particleIntensity);
    float glow = (((band * band) * (1.0 - p)) * glowIntensity) * 0.3499999940395355224609375;
    float3 pColor = mix(goldColor.xyz, highlightColor.xyz, float3(fast::clamp(particles * 1.7999999523162841796875, 0.0, 1.0)));
    float3 additive = pColor * (particles + glow);
    float3 rgb = (baseRgb * reveal) + additive;
    float alpha = (texel.w * reveal) + (fast::clamp((particles + glow) * 0.60000002384185791015625, 0.0, 1.0) * (1.0 - p));
    return float4(fast::clamp(rgb, float3(0.0), float3(1.0)), fast::clamp(alpha, 0.0, 1.0));
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.particleScale, buffer.particleIntensity, in.vUv, buffer.wipeSoftness, buffer.blurMax, tDiffuse, tDiffuseSmplr, buffer.trailWidth, buffer.glowIntensity, buffer.goldColor, buffer.highlightColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

