#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float gapSize;
    float ratio;
    float blurPeak;
    float neonStrength;
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
    return (p * p) * p;
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 456.209991455078125));
    p += float2(dot(p, p + float2(34.450000762939453125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 directionalBlur(thread const float2& uv, thread const float2& dir, thread const float& radius, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float4 acc = float4(0.0);
    float wsum = 0.0;
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        float w = 1.0 - (abs(fi) / 4.0);
        float2 param = uv + ((dir * radius) * fi);
        float2 suv = handleUVBounds(param);
        acc += (tDiffuse.sample(tDiffuseSmplr, suv) * w);
        wsum += w;
    }
    return acc / float4(fast::max(wsum, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& gapSize, constant float& ratio, constant float& blurPeak, constant float& neonStrength)
{
    float sliceIdx = floor(vUv.y * 12.0);
    float localY = fract(vUv.y * 12.0);
    float gapAppear = smoothstep(0.0199999995529651641845703125, 0.119999997317790985107421875, p);
    float halfGap = (gapSize * 0.5) * gapAppear;
    float gapMask = step(halfGap, localY) * step(localY, 1.0 - halfGap);
    float odd = mod(sliceIdx, 2.0);
    float2 dir = mix(float2(0.0, ratio), float2(1.0, 0.0), float2(odd));
    float blurRise = smoothstep(0.02999999932944774627685546875, 0.449999988079071044921875, p);
    float2 param = float2(sliceIdx, 7.13000011444091796875);
    float _200 = hash21(param);
    float blurRadius = (blurPeak * blurRise) * (0.800000011920928955078125 + (0.20000000298023223876953125 * _200));
    float2 param_1 = vUv;
    float2 param_2 = dir;
    float param_3 = blurRadius;
    float4 sliced = directionalBlur(param_1, param_2, param_3, tDiffuse, tDiffuseSmplr);
    float detailFade = smoothstep(0.449999988079071044921875, 1.0, p);
    float3 sceneColor = mix(sliced.xyz, float3(dot(sliced.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), float3(detailFade * 0.3499999940395355224609375));
    float moveP = smoothstep(0.0, 0.64999997615814208984375, p);
    float xL = mix(-0.1500000059604644775390625, 0.5, moveP);
    float xR = mix(1.14999997615814208984375, 0.5, moveP);
    float bandWidth = mix(0.0599999986588954925537109375, 0.014999999664723873138427734375, moveP);
    float leftBand = exp((-abs(vUv.x - xL)) / fast::max(bandWidth, 9.9999997473787516355514526367188e-05));
    float rightBand = exp((-abs(vUv.x - xR)) / fast::max(bandWidth, 9.9999997473787516355514526367188e-05));
    float collision = exp(-pow((p - 0.62000000476837158203125) / 0.10999999940395355224609375, 2.0));
    float centerGlow = exp((-abs(vUv.x - 0.5)) / 0.10999999940395355224609375) * (0.60000002384185791015625 + (0.4000000059604644775390625 * exp((-abs(vUv.y - 0.5)) / 0.3499999940395355224609375)));
    float flash = (collision * centerGlow) * 3.2000000476837158203125;
    float collapse = smoothstep(0.62000000476837158203125, 0.949999988079071044921875, p);
    float topRemnant = exp((-abs(vUv.y - mix(0.5, 0.920000016689300537109375, collapse))) / 0.02999999932944774627685546875) * (1.0 - collapse);
    float bottomRemnant = exp((-abs(vUv.y - mix(0.5, 0.07999999821186065673828125, collapse))) / 0.02999999932944774627685546875) * (1.0 - collapse);
    float remnant = (topRemnant + bottomRemnant) * 0.699999988079071044921875;
    float3 magenta = float3(1.0, 0.1500000059604644775390625, 0.85000002384185791015625);
    float3 cyan = float3(0.100000001490116119384765625, 0.949999988079071044921875, 1.0);
    float3 neon = ((magenta * leftBand) + (cyan * rightBand)) * neonStrength;
    neon += ((float3(1.0, 0.949999988079071044921875, 1.0) * (flash + (remnant * collision))) * neonStrength);
    float edgeZone = exp((-abs(abs(vUv.x - 0.5) - 0.0900000035762786865234375)) / 0.02999999932944774627685546875) * collision;
    float2 param_4 = floor(vUv * float2(220.0));
    float _394 = hash21(param_4);
    float grain = _394;
    float particles = (step(0.964999973773956298828125, grain) * edgeZone) * (1.0 - smoothstep(0.680000007152557373046875, 0.949999988079071044921875, p));
    neon += ((float3(0.89999997615814208984375, 1.0, 1.0) * particles) * 1.7999999523162841796875);
    float3 composed = sceneColor + neon;
    float blackout = smoothstep(0.550000011920928955078125, 1.0, p);
    composed *= (1.0 - blackout);
    float alpha = (texel.w * gapMask) * (1.0 - smoothstep(0.5, 1.0, p));
    return float4(composed, alpha);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, in.vUv, buffer.gapSize, buffer.ratio, buffer.blurPeak, buffer.neonStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

