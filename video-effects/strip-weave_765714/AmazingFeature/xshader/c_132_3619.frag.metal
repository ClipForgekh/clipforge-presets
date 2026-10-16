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
    float sliceCount;
    float stagger;
    float stretchAmount;
    float glitchAmount;
    float blurAmount;
    float glowIntensity;
    float3 colorNeonA;
    float3 colorNeonB;
    float startAlpha;
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
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 456.209991455078125));
    p += float2(dot(p, p + float2(45.31999969482421875)));
    return fract(p.x * p.y);
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
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius)
{
    float2 off = float2(0.0, radius);
    float2 param = uv - (off * 2.0);
    float4 c0 = tex.sample(texSmplr, handleUVBounds(param)) * 0.119999997317790985107421875;
    float2 param_1 = uv - off;
    float4 c1 = tex.sample(texSmplr, handleUVBounds(param_1)) * 0.23000000417232513427734375;
    float2 param_2 = uv;
    float4 c2 = tex.sample(texSmplr, handleUVBounds(param_2)) * 0.300000011920928955078125;
    float2 param_3 = uv + off;
    float4 c3 = tex.sample(texSmplr, handleUVBounds(param_3)) * 0.23000000417232513427734375;
    float2 param_4 = uv + (off * 2.0);
    float4 c4 = tex.sample(texSmplr, handleUVBounds(param_4)) * 0.119999997317790985107421875;
    return (((c0 + c1) + c2) + c3) + c4;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& sliceCount, thread float2& vUv, constant float& stagger, constant float& stretchAmount, constant float& glitchAmount, constant float& blurAmount, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& glowIntensity, constant float3& colorNeonA, constant float3& colorNeonB, constant float& startAlpha)
{
    float sc = fast::max(2.0, floor(sliceCount + 0.5));
    float idx = floor(vUv.x * sc);
    float localX = fract(vUv.x * sc);
    float maxDelay = (sc - 1.0) * stagger;
    float denom = fast::max(9.9999997473787516355514526367188e-05, 1.0 - maxDelay);
    float startAt = idx * stagger;
    float lp = fast::clamp((p - startAt) / denom, 0.0, 1.0);
    float param = lp;
    float eased = tween(param);
    float strength = 1.0 - eased;
    float parity = mod(idx, 2.0);
    float dir = mix(-1.0, 1.0, parity);
    float moveDistance = 1.14999997615814208984375 * strength;
    float shiftY = dir * moveDistance;
    float stretch = 1.0 + ((stretchAmount - 1.0) * strength);
    float yStretched = 0.5 + ((vUv.y - 0.5) / stretch);
    float glitchPulse = step(0.939999997615814208984375, (sin((p * 180.0) + (idx * 11.69999980926513671875)) * 0.5) + 0.5);
    float2 param_1 = float2(floor(vUv.y * 140.0), idx + floor(p * 120.0));
    float _270 = hash21(param_1);
    float glitchLine = step(0.75, _270);
    float2 param_2 = float2(idx, floor(p * 200.0));
    float _280 = hash21(param_2);
    float glitchOffset = (((((_280 - 0.5) * 2.0) * glitchAmount) * strength) * glitchPulse) * glitchLine;
    float2 srcUVRaw = float2(vUv.x + glitchOffset, yStretched - shiftY);
    float2 param_3 = srcUVRaw;
    float srcMask = getHardBoundaryMask(param_3);
    float2 param_4 = srcUVRaw;
    float2 srcUV = handleUVBounds(param_4);
    float blurR = blurAmount * strength;
    float2 param_5 = srcUV;
    float param_6 = blurR;
    float4 col = verticalBlur(tDiffuse, tDiffuseSmplr, param_5, param_6);
    col.w *= srcMask;
    float edgeDist = fast::min(localX, 1.0 - localX);
    float edgeGlow = (smoothstep(0.100000001490116119384765625, 0.0, edgeDist) * glowIntensity) * strength;
    float3 neon = mix(colorNeonA, colorNeonB, float3(vUv.y));
    float4 _358 = col;
    float3 _360 = _358.xyz + ((neon * edgeGlow) * 0.550000011920928955078125);
    col.x = _360.x;
    col.y = _360.y;
    col.z = _360.z;
    float alphaMix = mix(startAlpha, 1.0, eased);
    col.w *= alphaMix;
    if (p >= 0.99989998340606689453125)
    {
        return texel;
    }
    return col;
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
    float4 effectColor = effect(param_1, param_2, buffer.sliceCount, in.vUv, buffer.stagger, buffer.stretchAmount, buffer.glitchAmount, buffer.blurAmount, tDiffuse, tDiffuseSmplr, buffer.glowIntensity, buffer.colorNeonA, buffer.colorNeonB, buffer.startAlpha);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

