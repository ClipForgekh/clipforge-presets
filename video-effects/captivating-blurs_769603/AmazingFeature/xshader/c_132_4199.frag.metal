#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float3 darkColor;
    float3 lightColor;
    float scanlineDensity;
    float flashPoint;
    float flashWidth;
    float flyDistance;
    float gapSize;
    float3 flashColor;
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
    return ((p * p) * p) * p;
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    return fract(sin(dot(p, float2(127.09999847412109375, 311.70001220703125))) * 43758.546875);
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float3 toGameBoy(thread const float3& color, thread const float2& uv, constant float3& darkColor, constant float3& lightColor, constant float& scanlineDensity)
{
    float luma = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float2 param = floor(uv * float2(14.0, 15.0));
    float d = (hash12(param) - 0.5) * 0.100000001490116119384765625;
    float tone = step(0.5, luma + d);
    float3 duo = mix(darkColor, lightColor, float3(tone));
    float sl = 0.87999999523162841796875 + (0.119999997317790985107421875 * step(0.5, fract(uv.y * scanlineDensity)));
    return duo * sl;
}

static inline __attribute__((always_inline))
float2x2 rot2(thread const float& a)
{
    float s = sin(a);
    float c = cos(a);
    return float2x2(float2(c, -s), float2(s, c));
}

static inline __attribute__((always_inline))
float heartSDFLocal(thread float2& p)
{
    p.x = abs(p.x);
    if ((p.y + p.x) > 1.0)
    {
        float2 q = p - float2(0.25, 0.75);
        return length(q) - 0.3535533845424652099609375;
    }
    float d1 = dot(p - float2(0.0, 1.0), p - float2(0.0, 1.0));
    float d2 = dot(p - float2(0.5), p - float2(0.5));
    return sqrt(fast::min(d1, d2)) * sign(p.x - p.y);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float3& darkColor, constant float3& lightColor, constant float& scanlineDensity, constant float& flashPoint, constant float& flashWidth, thread float2& vUv, constant float& flyDistance, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& gapSize, constant float3& flashColor)
{
    if (p <= 9.9999997473787516355514526367188e-06)
    {
        return texel;
    }
    float t = fast::clamp(p, 0.0, 1.0);
    if (t >= (flashPoint + flashWidth))
    {
        return float4(0.0, 0.0, 0.0, 1.0);
    }
    float2 grid = float2(14.0, 15.0);
    float2 cellId = floor(vUv * grid);
    float2 cellUV = fract(vUv * grid);
    float2 param = cellId + float2(1.37000000476837158203125);
    float r = hash12(param);
    float2 dir;
    if (r < 0.25)
    {
        dir = float2(-0.707106769084930419921875, 0.707106769084930419921875);
    }
    else
    {
        if (r < 0.5)
        {
            dir = float2(0.707106769084930419921875);
        }
        else
        {
            if (r < 0.75)
            {
                dir = float2(-0.707106769084930419921875);
            }
            else
            {
                dir = float2(0.707106769084930419921875, -0.707106769084930419921875);
            }
        }
    }
    float2 sourceUV = vUv - (dir * (flyDistance * t));
    float2 param_1 = sourceUV;
    float srcMask = getHardBoundaryMask(param_1);
    float2 param_2 = sourceUV;
    float2 safeUV = handleUVBounds(param_2);
    float2 srcCell = floor(safeUV * grid);
    float2 srcCenter = (srcCell + float2(0.5)) / grid;
    float4 srcTexel = tDiffuse.sample(tDiffuseSmplr, srcCenter);
    float3 param_3 = srcTexel.xyz;
    float2 param_4 = vUv;
    float3 gb = toGameBoy(param_3, param_4, darkColor, lightColor, scanlineDensity);
    float2 superGrid = float2(8.0, 4.0);
    float2 superId = floor(vUv * superGrid);
    float2 superUV = (fract(vUv * superGrid) * 2.0) - float2(1.0);
    float2 param_5 = superId + float2(4.21000003814697265625);
    float ang = hash12(param_5) * 6.283185482025146484375;
    float2 param_6 = superId + float2(8.729999542236328125);
    float hs = mix(0.550000011920928955078125, 0.949999988079071044921875, hash12(param_6));
    float param_7 = ang;
    float2 hp = rot2(param_7) * (superUV / float2(hs));
    hp.y += 0.2800000011920928955078125;
    float2 param_8 = hp;
    float _376 = heartSDFLocal(param_8);
    float h = 1.0 - smoothstep(-0.02999999932944774627685546875, 0.02999999932944774627685546875, _376);
    float2 param_9 = superId + float2(2.1099998950958251953125);
    float heartEnabled = step(hash12(param_9), 1.0);
    float heartMask = h * heartEnabled;
    float debrisMask = ((step(gapSize, cellUV.x) * step(gapSize, cellUV.y)) * step(cellUV.x, 1.0 - gapSize)) * step(cellUV.y, 1.0 - gapSize);
    float elementMask = mix(debrisMask, 1.0, step(0.00999999977648258209228515625, heartMask));
    float brightnessFade = 1.0 - t;
    float3 outRgb = gb * brightnessFade;
    float alphaFade = 1.0 - t;
    float outA = ((srcTexel.w * srcMask) * elementMask) * alphaFade;
    float flashPulse = step(flashPoint, t) * (1.0 - step(flashPoint + flashWidth, t));
    outRgb = mix(outRgb, flashColor, float3(flashPulse));
    outA = mix(outA, 1.0, flashPulse);
    return float4(outRgb, outA);
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
    float4 effectColor = effect(param_1, param_2, buffer.darkColor, buffer.lightColor, buffer.scanlineDensity, buffer.flashPoint, buffer.flashWidth, in.vUv, buffer.flyDistance, tDiffuse, tDiffuseSmplr, buffer.gapSize, buffer.flashColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

