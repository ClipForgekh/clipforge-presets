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
    float bladeWidth;
    float blurStrength;
    float particleDensity;
    float particleRise;
    float maxGlow;
    float3 bladeColor;
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
    return 0.5 - (0.5 * cos(3.1415927410125732421875 * p));
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
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 diagonalBlur(thread const float2& uv, thread const float& amount, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 dir = fast::normalize(float2(1.0, 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05)));
    float2 stepV = dir * amount;
    float4 c = float4(0.0);
    float2 param = uv - (stepV * 2.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * 0.119999997317790985107421875);
    float2 param_1 = uv - (stepV * 1.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.23000000417232513427734375);
    float2 param_2 = uv;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.300000011920928955078125);
    float2 param_3 = uv + (stepV * 1.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.23000000417232513427734375);
    float2 param_4 = uv + (stepV * 2.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.119999997317790985107421875);
    return c;
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& bladeWidth, constant float& blurStrength, constant float& particleDensity, constant float& particleRise, constant float& maxGlow, constant float3& bladeColor)
{
    float2 center = float2(0.5);
    float2 param = vUv;
    float2 param_1 = center;
    float2 q = getSDFCoordinate(param, param_1, ratio);
    float2 param_2 = float2(0.0);
    float2 param_3 = center;
    float maxR = length(getSDFCoordinate(param_2, param_3, ratio));
    float sweepMask = 0.0;
    float bladeAccum = 0.0;
    for (int i = 0; i < 8; i++)
    {
        float fi = float(i);
        float baseAng = fi * 0.785398185253143310546875;
        float spinDir = (mod(fi, 2.0) < 1.0) ? 1.0 : (-1.0);
        float spiral = ((0.25 + (((0.949999988079071044921875 * p) * (1.0 - p)) * 2.0)) + (0.25 * p)) * spinDir;
        float ang = baseAng + spiral;
        float2 dir = float2(cos(ang), sin(ang));
        float along = dot(q, -dir);
        float ortho = abs(dot(q, float2(-dir.y, dir.x)));
        float headPos = mix(maxR * 1.14999997615814208984375, 0.0, p);
        float head = exp(-pow((along - headPos) / 0.04500000178813934326171875, 2.0));
        float core = exp(-pow(ortho / fast::max(bladeWidth, 9.9999997473787516355514526367188e-05), 2.0));
        float blade = (core * head) * step(0.0, along);
        sweepMask = fast::max(sweepMask, blade);
        bladeAccum += (blade * (0.85000002384185791015625 + (0.1500000059604644775390625 * sin((fi * 1.7000000476837158203125) + (p * 6.283185482025146484375)))));
    }
    float blurLocal = fast::clamp(((sweepMask * 0.89999997615814208984375) + (p * p)) * p, 0.0, 1.0);
    float2 param_4 = vUv;
    float param_5 = blurStrength * (0.5 + (1.7999999523162841796875 * blurLocal));
    float4 blurTex = diagonalBlur(param_4, param_5, ratio, tDiffuse, tDiffuseSmplr);
    float4 baseTex = mix(texel, blurTex, float4(blurLocal));
    float2 puv = (vUv * particleDensity) + float2(0.0, ((p * particleRise) * particleDensity) * 0.3499999940395355224609375);
    float2 cell = floor(puv);
    float2 f = fract(puv) - float2(0.5);
    float2 param_6 = cell;
    float rnd = hash12(param_6);
    float spark = step(0.839999973773956298828125, rnd);
    float shape = smoothstep(0.2599999904632568359375, 0.0199999995529651641845703125, length(f));
    float swept = smoothstep(0.07999999821186065673828125, 0.800000011920928955078125, sweepMask + (p * 0.550000011920928955078125));
    float particle = (((spark * shape) * swept) * p) * (1.0 - p);
    float glowRamp = fast::clamp(p * 1.35000002384185791015625, 0.0, 1.0) * maxGlow;
    float3 glow = (bladeColor * bladeAccum) * glowRamp;
    float3 foil = (bladeColor * (1.2000000476837158203125 + (rnd * 0.60000002384185791015625))) * particle;
    float darken = 1.0 - (0.920000016689300537109375 * p);
    float3 rgb = ((baseTex.xyz * darken) + glow) + foil;
    rgb = fast::clamp(rgb, float3(0.0), float3(1.0));
    float alpha = texel.w * (1.0 - p);
    return float4(rgb, alpha);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, in.vUv, buffer.bladeWidth, buffer.blurStrength, buffer.particleDensity, buffer.particleRise, buffer.maxGlow, buffer.bladeColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

