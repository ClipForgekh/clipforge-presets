#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float flowStrength;
    float particleDensity;
    float3 inkColor;
    float3 glowColor;
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
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float _noise(thread const float2& p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    float2 u = (f * f) * (float2(3.0) - (f * 2.0));
    float2 param = i;
    float a = hash12(param);
    float2 param_1 = i + float2(1.0, 0.0);
    float b = hash12(param_1);
    float2 param_2 = i + float2(0.0, 1.0);
    float c = hash12(param_2);
    float2 param_3 = i + float2(1.0);
    float d = hash12(param_3);
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

static inline __attribute__((always_inline))
float fbm(thread float2& p)
{
    float v = 0.0;
    float a = 0.5;
    float2 param = p;
    v += (a * _noise(param));
    p *= 2.019999980926513671875;
    a *= 0.5;
    float2 param_1 = p;
    v += (a * _noise(param_1));
    p *= 2.0299999713897705078125;
    a *= 0.5;
    float2 param_2 = p;
    v += (a * _noise(param_2));
    p *= 2.0099999904632568359375;
    a *= 0.5;
    float2 param_3 = p;
    v += (a * _noise(param_3));
    return v;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, thread float2& vUv, constant float& ratio, constant float& flowStrength, constant float& particleDensity, constant float3& inkColor, constant float3& glowColor)
{
    float inv = 1.0 - p;
    float2 suv = vUv - float2(0.5);
    if (ratio > 1.0)
    {
        suv.y /= ratio;
    }
    else
    {
        suv.x *= ratio;
    }
    float r = length(suv);
    float dEdge = fast::min(fast::min(vUv.x, 1.0 - vUv.x), fast::min(vUv.y, 1.0 - vUv.y));
    float front = (p * 0.5) * flowStrength;
    float width = mix(0.085000000894069671630859375, 0.0280000008642673492431640625, p);
    float edgeBand = exp((-pow((dEdge - front) / fast::max(width, 9.9999997473787516355514526367188e-05), 2.0)) * 2.599999904632568359375);
    float2 nUv1 = float2(vUv.x * 260.0, vUv.y * (260.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05)));
    float2 nUv2 = float2(vUv.x * 120.0, vUv.y * (120.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05)));
    float2 param = nUv1 + float2(p * 10.0, (-p) * 7.0);
    float _284 = fbm(param);
    float n1 = _284;
    float2 param_1 = nUv2 + float2((-p) * 6.0, p * 5.0);
    float _297 = fbm(param_1);
    float n2 = _297;
    float particles = smoothstep(1.0 - particleDensity, 1.0, n1) * edgeBand;
    float trails = smoothstep(0.3499999940395355224609375, 0.949999988079071044921875, (n2 * edgeBand) + (edgeBand * 0.550000011920928955078125));
    float centerRadius = p * 0.7799999713897705078125;
    float centerInk = smoothstep(centerRadius + 0.119999997317790985107421875, centerRadius - 0.07999999821186065673828125, r);
    float inkCoverage = fast::clamp(((centerInk * 0.949999988079071044921875) + (trails * 0.550000011920928955078125)) + (particles * 0.85000002384185791015625), 0.0, 1.0);
    float dissolve = smoothstep(0.7799999713897705078125, 1.0, p);
    float inkVisible = inkCoverage * (1.0 - dissolve);
    float revealBoost = smoothstep(0.550000011920928955078125, 0.949999988079071044921875, p) * 0.3499999940395355224609375;
    float reveal = fast::clamp(inkCoverage + revealBoost, 0.0, 1.0);
    float2 param_2 = float2(vUv.x * 180.0, vUv.y * (180.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05)));
    float _371 = fbm(param_2);
    float paperN = _371;
    float paperPhase = smoothstep(0.800000011920928955078125, 0.89999997615814208984375, p) * (1.0 - smoothstep(0.930000007152557373046875, 1.0, p));
    float3 paperTex = (float3(0.100000001490116119384765625, 0.0900000035762786865234375, 0.07999999821186065673828125) * (paperN - 0.5)) * paperPhase;
    float3 revealedColor = texel.xyz + paperTex;
    float3 baseColor = mix(float3(0.0), revealedColor, float3(reveal));
    float3 inkTint = mix(inkColor, glowColor, float3(fast::clamp((particles * 0.89999997615814208984375) + (trails * 0.25), 0.0, 1.0)));
    float3 color = baseColor + ((inkTint * inkVisible) * (0.3499999940395355224609375 + (0.64999997615814208984375 * particles)));
    float alpha = fast::max(texel.w * reveal, inkVisible * 0.89999997615814208984375);
    if (p >= 1.0)
    {
        return texel;
    }
    return float4(fast::clamp(color, float3(0.0), float3(1.0)), fast::clamp(alpha, 0.0, 1.0));
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.ratio, buffer.flowStrength, buffer.particleDensity, buffer.inkColor, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

