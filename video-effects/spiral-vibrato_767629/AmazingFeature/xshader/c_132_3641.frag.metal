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
    float ratio;
    int uSectionCount;
    float uSpiralTightness;
    float uTwirlMax;
    float uRingStart;
    float uBokehMax;
    float uBrightness;
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
    return p;
}

static inline __attribute__((always_inline))
float2 getSDFCoordinate(thread const float2& uv, thread const float2& center, constant float& ratio)
{
    float2 q = uv - center;
    if (ratio > 1.0)
    {
        q.x *= ratio;
    }
    else
    {
        q.y /= ratio;
    }
    return q;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 sampleHexBlur(thread const float2& uv, thread const float& amount, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 d0 = float2(1.0, 0.0) * amount;
    float2 d1 = float2(0.5, 0.866025388240814208984375) * amount;
    float2 d2 = float2(-0.5, 0.866025388240814208984375) * amount;
    float2 d3 = float2(-1.0, 0.0) * amount;
    float2 d4 = float2(-0.5, -0.866025388240814208984375) * amount;
    float2 d5 = float2(0.5, -0.866025388240814208984375) * amount;
    float2 param = uv;
    float4 c = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * 0.4000000059604644775390625;
    float2 param_1 = uv + d0;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.100000001490116119384765625);
    float2 param_2 = uv + d1;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.100000001490116119384765625);
    float2 param_3 = uv + d2;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.100000001490116119384765625);
    float2 param_4 = uv + d3;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.100000001490116119384765625);
    float2 param_5 = uv + d4;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * 0.100000001490116119384765625);
    float2 param_6 = uv + d5;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * 0.100000001490116119384765625);
    return c;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant int& uSectionCount, constant float& uSpiralTightness, constant float& uTwirlMax, constant float& uRingStart, constant float& uBokehMax, constant float& uBrightness)
{
    float2 center = float2(0.5);
    float2 param = vUv;
    float2 param_1 = center;
    float2 q = getSDFCoordinate(param, param_1, ratio);
    float r = length(q);
    float a = precise::atan2(q.y, q.x);
    float cyc = sin(3.1415927410125732421875 * p);
    float envelope = cyc * cyc;
    float sections = float(uSectionCount);
    float spiral = (a + (log(fast::max(r, 0.001000000047497451305389404296875)) * uSpiralTightness)) / 6.283185482025146484375;
    float phase = (spiral * sections) - (p * sections);
    float band = fract(phase);
    float bandMask = smoothstep(0.07999999821186065673828125, 0.25, band) * (1.0 - smoothstep(0.75, 0.920000016689300537109375, band));
    float curl = (0.180000007152557373046875 * sin((6.283185482025146484375 * p) + a)) * bandMask;
    float2 _261;
    if (r > 9.9999997473787516355514526367188e-05)
    {
        _261 = q / float2(r);
    }
    else
    {
        _261 = float2(1.0, 0.0);
    }
    float2 dir = _261;
    float twirl = ((uTwirlMax * envelope) * bandMask) * (1.0 - smoothstep(0.0, 0.949999988079071044921875, r));
    float ang = twirl * (0.60000002384185791015625 + (0.4000000059604644775390625 * sin((6.283185482025146484375 * p) + (a * 2.0))));
    float s = sin(ang);
    float c = cos(ang);
    float2 uq = q;
    uq += ((dir * curl) * 0.02999999932944774627685546875);
    uq = float2((c * uq.x) - (s * uq.y), (s * uq.x) + (c * uq.y));
    float2 uv2 = center;
    if (ratio > 1.0)
    {
        uv2 += float2(uq.x / ratio, uq.y);
    }
    else
    {
        uv2 += float2(uq.x, uq.y * ratio);
    }
    float2 param_2 = uv2;
    uv2 = handleUVBounds(param_2);
    float4 baseCol = tDiffuse.sample(tDiffuseSmplr, uv2);
    float outer = smoothstep(uRingStart, uRingStart + 0.119999997317790985107421875, r);
    float bokehAmt = (((uBokehMax * envelope) * outer) * bandMask) * 0.02999999932944774627685546875;
    float2 param_3 = uv2;
    float param_4 = bokehAmt;
    float4 blurCol = sampleHexBlur(param_3, param_4, tDiffuse, tDiffuseSmplr);
    float4 col = mix(baseCol, blurCol, float4(fast::clamp(outer * envelope, 0.0, 1.0)));
    float sid = floor(mod(floor(phase) + sections, sections));
    float secBright = 0.699999988079071044921875 + (0.0199999995529651641845703125 * (sid + 1.0));
    float localBright = mix(1.0, secBright, bandMask * smoothstep(0.1500000059604644775390625, 1.2000000476837158203125, r));
    float4 _423 = col;
    float3 _425 = _423.xyz * (localBright * uBrightness);
    col.x = _425.x;
    col.y = _425.y;
    col.z = _425.z;
    float4 _433 = col;
    float3 _437 = fast::clamp(_433.xyz, float3(0.0), float3(1.0));
    col.x = _437.x;
    col.y = _437.y;
    col.z = _437.z;
    return float4(col.xyz, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, in.vUv, buffer.uSectionCount, buffer.uSpiralTightness, buffer.uTwirlMax, buffer.uRingStart, buffer.uBokehMax, buffer.uBrightness);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

