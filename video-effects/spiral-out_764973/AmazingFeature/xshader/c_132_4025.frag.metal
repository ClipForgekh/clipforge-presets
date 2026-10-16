#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float curlStrength;
    float spiralTurns;
    float ratio;
    float glowIntensity;
    float scratchIntensity;
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
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float3 applySaturation(thread const float3& color, thread const float& sat)
{
    float luma = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(luma), color, float3(sat));
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 345.45001220703125));
    p += float2(dot(p, p + float2(34.345001220703125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, thread float2& vUv, constant float& curlStrength, constant float& spiralTurns, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& glowIntensity, constant float& scratchIntensity)
{
    float2 center = float2(0.5, mix(0.5, 0.7200000286102294921875, p));
    float edge = pow(abs(vUv.x - 0.5) * 2.0, 1.5);
    float curl = (curlStrength * edge) * p;
    float angle = ((spiralTurns * 6.283185482025146484375) * p) * p;
    float s = sin(angle);
    float c = cos(angle);
    float scale = mix(1.0, 0.100000001490116119384765625, p);
    float2 q = vUv - center;
    float2 rq = float2((c * q.x) - (s * q.y), (s * q.x) + (c * q.y));
    float2 rawUV = (rq / float2(fast::max(scale, 9.9999997473787516355514526367188e-05))) + float2(0.5);
    rawUV.x -= ((sign(vUv.x - 0.5) * curl) * 0.119999997317790985107421875);
    rawUV.y += (curl * 0.039999999105930328369140625);
    float2 param = rawUV;
    float2 uv = handleUVBounds(param);
    float2 param_1 = rawUV;
    float borderMask = getHardBoundaryMask(param_1);
    float2 vStep = float2(0.0, (0.00200000009499490261077880859375 + (0.00999999977648258209228515625 * p)) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float2 param_2 = uv - (vStep * 2.0);
    float4 c0 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2));
    float2 param_3 = uv - vStep;
    float4 c1 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3));
    float4 c2 = tDiffuse.sample(tDiffuseSmplr, uv);
    float2 param_4 = uv + vStep;
    float4 c3 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4));
    float2 param_5 = uv + (vStep * 2.0);
    float4 c4 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5));
    float4 blurCol = ((((c0 + (c1 * 2.0)) + (c2 * 3.0)) + (c3 * 2.0)) + c4) / float4(9.0);
    float blurAmt = fast::clamp((curl * 0.800000011920928955078125) + ((p * p) * 0.60000002384185791015625), 0.0, 1.0);
    float4 filmCol = mix(c2, blurCol, float4(blurAmt));
    filmCol.w *= borderMask;
    float satUp = smoothstep(0.0, 0.449999988079071044921875, p);
    float satDown = smoothstep(0.449999988079071044921875, 1.0, p);
    float sat = (1.0 + (0.5 * satUp)) - (1.10000002384185791015625 * satDown);
    float3 param_6 = filmCol.xyz;
    float param_7 = fast::clamp(sat, 0.0, 1.5);
    float3 _331 = applySaturation(param_6, param_7);
    filmCol.x = _331.x;
    filmCol.y = _331.y;
    filmCol.z = _331.z;
    float edgeGlow = ((glowIntensity * edge) * p) * (1.0 - (0.449999988079071044921875 * p));
    float theta = precise::atan2(vUv.y - center.y, vUv.x - center.x);
    float rad = length(vUv - center);
    float spiralWave = sin(((theta * 6.0) - (angle * 2.0)) + (rad * 45.0));
    float spiralBand = (smoothstep(0.550000011920928955078125, 0.980000019073486328125, spiralWave) * p) * (1.0 - (0.300000011920928955078125 * p));
    float3 warmGlow = float3(1.0, 0.4799999892711639404296875, 0.119999997317790985107421875) * ((edgeGlow * 0.550000011920928955078125) + ((spiralBand * 0.699999988079071044921875) * glowIntensity));
    float frame = floor(p * 120.0);
    float lineId = floor(vUv.x * 220.0);
    float2 param_8 = float2(lineId, frame * 0.730000019073486328125);
    float _421 = hash21(param_8);
    float scratchRand = _421;
    float2 param_9 = float2(lineId * 1.7000000476837158203125, frame * 1.2999999523162841796875);
    float _435 = hash21(param_9);
    float scratchLine = step(0.986999988555908203125, scratchRand) * (0.4000000059604644775390625 + (0.60000002384185791015625 * _435));
    float scratchFlicker = (scratchLine * scratchIntensity) * p;
    float3 scratchColor = float3(1.0, 0.89999997615814208984375, 0.800000011920928955078125) * scratchFlicker;
    float burst = smoothstep(0.819999992847442626953125, 0.920000016689300537109375, p) * (1.0 - smoothstep(0.920000016689300537109375, 1.0, p));
    float3 burstColor = ((float3(1.0, 0.5, 0.1500000059604644775390625) * burst) * 1.60000002384185791015625) * glowIntensity;
    float3 col = ((filmCol.xyz + warmGlow) + scratchColor) + burstColor;
    float fadeToBlack = 1.0 - smoothstep(0.7599999904632568359375, 1.0, p);
    col *= fadeToBlack;
    float alphaFade = 1.0 - smoothstep(0.699999988079071044921875, 1.0, p);
    float outAlpha = filmCol.w * alphaFade;
    return float4(fast::clamp(col, float3(0.0), float3(1.0)), fast::clamp(outAlpha, 0.0, 1.0));
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.curlStrength, buffer.spiralTurns, buffer.ratio, tDiffuse, tDiffuseSmplr, buffer.glowIntensity, buffer.scratchIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

