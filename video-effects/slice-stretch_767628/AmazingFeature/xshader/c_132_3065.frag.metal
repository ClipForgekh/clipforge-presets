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
    float stripWidth;
    float weaveStrength;
    float slideAmount;
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
    return smoothstep(0.0, 1.0, p);
}

static inline __attribute__((always_inline))
float stripeMask(thread const float& coord, thread const float& width)
{
    float f = abs(fract(coord) - 0.5);
    return 1.0 - smoothstep(width, width + 0.02999999932944774627685546875, f);
}

static inline __attribute__((always_inline))
float outInCubic(thread const float& p)
{
    if (p < 0.5)
    {
        float x = p * 2.0;
        return 0.5 * (1.0 - pow(1.0 - x, 3.0));
    }
    else
    {
        float x_1 = (p - 0.5) * 2.0;
        return 0.5 + (((0.5 * x_1) * x_1) * x_1);
    }
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
float4 effect(thread const float4& texel, thread const float& p, thread float2& vUv, constant float& ratio, constant float& stripWidth, constant float& weaveStrength, constant float& slideAmount, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 uv = vUv;
    float2 centered = uv - float2(0.5);
    if (ratio > 1.0)
    {
        centered.y /= ratio;
    }
    else
    {
        centered.x *= ratio;
    }
    float env = sin(3.1415927410125732421875 * p);
    float envSoft = env * env;
    float cA = ((centered.x + centered.y) * 7.0) + 3.5;
    float cB = ((centered.x - centered.y) * 7.0) + 3.5;
    float param = cA;
    float param_1 = stripWidth;
    float maskA = stripeMask(param, param_1);
    float param_2 = cB;
    float param_3 = stripWidth;
    float maskB = stripeMask(param_2, param_3);
    float idxA = floor(fast::clamp(cA, 0.0, 6.0));
    float idxB = floor(fast::clamp(cB, 0.0, 6.0));
    float parityA = (mod(idxA, 2.0) < 0.5) ? (-1.0) : 1.0;
    float sideB = (mod(idxB, 2.0) < 0.5) ? 1.0 : (-1.0);
    float stagger = idxB * 0.04500000178813934326171875;
    float localP = fast::clamp((p - stagger) / fast::max(9.9999997473787516355514526367188e-05, 1.0 - stagger), 0.0, 1.0);
    float param_4 = localP;
    float slideP = outInCubic(param_4);
    float spring = (sin(localP * 3.1415927410125732421875) * (1.0 - localP)) * 0.449999988079071044921875;
    float2 uvA = uv;
    uvA.x += ((parityA * (((0.04500000178813934326171875 * weaveStrength) * envSoft) + ((0.02999999932944774627685546875 * spring) * env))) * maskA);
    uvA.y += (((0.017999999225139617919921875 * weaveStrength) * envSoft) * maskA);
    float2 uvB = uv;
    uvB.x += ((((sideB * (1.0 - slideP)) * slideAmount) * env) * maskB);
    uvB.y -= ((0.01200000010430812835693359375 * envSoft) * maskB);
    float2 param_5 = uvA;
    uvA = handleUVBounds(param_5);
    float2 param_6 = uvB;
    uvB = handleUVBounds(param_6);
    float4 colA = tDiffuse.sample(tDiffuseSmplr, uvA);
    float4 colB = tDiffuse.sample(tDiffuseSmplr, uvB);
    float weaveMix = fast::clamp(maskB * (0.3499999940395355224609375 + (0.64999997615814208984375 * envSoft)), 0.0, 1.0);
    float4 woven = mix(colA, colB, float4(weaveMix));
    float depthPulse = (1.0 - (0.07999999821186065673828125 * envSoft)) + ((0.0599999986588954925537109375 * envSoft) * maskB);
    float4 _329 = woven;
    float3 _331 = _329.xyz * depthPulse;
    woven.x = _331.x;
    woven.y = _331.y;
    woven.z = _331.z;
    float2 param_7 = vUv;
    float boundary = getHardBoundaryMask(param_7);
    float4 outCol = float4(fast::clamp(woven.xyz, float3(0.0), float3(1.0)), woven.w * boundary);
    return mix(texel, outCol, float4(env));
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.ratio, buffer.stripWidth, buffer.weaveStrength, buffer.slideAmount, tDiffuse, tDiffuseSmplr);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

