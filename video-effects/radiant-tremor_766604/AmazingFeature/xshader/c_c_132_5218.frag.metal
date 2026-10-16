#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    float particleDensity;
    float parallaxStrength;
    float maxBlur;
    float ratio;
    float3 lightColor;
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
float tween(thread const float& progress)
{
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.1415927410125732421875));
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, thread const float& ratio)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    spvUnsafeArray<float, 25> kernel0;
    kernel0[0] = 1.0;
    kernel0[1] = 4.0;
    kernel0[2] = 6.0;
    kernel0[3] = 4.0;
    kernel0[4] = 1.0;
    kernel0[5] = 4.0;
    kernel0[6] = 16.0;
    kernel0[7] = 24.0;
    kernel0[8] = 16.0;
    kernel0[9] = 4.0;
    kernel0[10] = 6.0;
    kernel0[11] = 24.0;
    kernel0[12] = 36.0;
    kernel0[13] = 24.0;
    kernel0[14] = 6.0;
    kernel0[15] = 4.0;
    kernel0[16] = 16.0;
    kernel0[17] = 24.0;
    kernel0[18] = 16.0;
    kernel0[19] = 4.0;
    kernel0[20] = 1.0;
    kernel0[21] = 4.0;
    kernel0[22] = 6.0;
    kernel0[23] = 4.0;
    kernel0[24] = 1.0;
    float baseStep = 0.001000000047497451305389404296875 * blurStrength;
    float2 stepSize = float2(baseStep, baseStep / ratio);
    for (int i = -2; i <= 2; i++)
    {
        for (int j = -2; j <= 2; j++)
        {
            float weight = kernel0[((i + 2) * 5) + (j + 2)];
            float2 offset = float2(float(i) * stepSize.x, float(j) * stepSize.y);
            float2 param = uv + offset;
            float2 sampleUV = handleUVBounds(param);
            color += (tex.sample(texSmplr, sampleUV) * weight);
            totalWeight += weight;
        }
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float calcGodRay(thread const float2& uv, thread const float& progress)
{
    float ray = 0.0;
    spvUnsafeArray<float2, 4> dirs;
    dirs[0] = float2(-0.707106769084930419921875);
    dirs[1] = float2(0.707106769084930419921875, -0.707106769084930419921875);
    dirs[2] = float2(-0.707106769084930419921875, 0.707106769084930419921875);
    dirs[3] = float2(0.707106769084930419921875);
    for (int i = 0; i < 4; i++)
    {
        float proj = dot(uv - float2(0.5), dirs[i]);
        ray += (smoothstep(0.0, 0.800000011920928955078125, proj) * 0.25);
    }
    float param = progress;
    return (ray * (1.0 - tween(param))) * 0.800000011920928955078125;
}

static inline __attribute__((always_inline))
float calcDustParticles(thread const float2& uv, thread const float& progress, constant float& particleDensity)
{
    float particles = 0.0;
    float2 pUV = uv * particleDensity;
    pUV.y += (progress * 6.0);
    float2 cell = floor(pUV);
    float2 cellUV = fract(pUV);
    float2 param = cell;
    float r = random(param);
    if (r < 0.119999997317790985107421875)
    {
        float size = 0.1500000059604644775390625 + (r * 0.300000011920928955078125);
        particles += (smoothstep(size, 0.0, length(cellUV - float2(0.5))) * r);
    }
    float param_1 = progress;
    return particles * (1.0 - tween(param_1));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& particleDensity, constant float& parallaxStrength, thread float2& vUv, constant float& maxBlur, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& ratio, constant float3& lightColor)
{
    float param = fast::clamp(progress / 0.60000002384185791015625, 0.0, 1.0);
    float fgProgress = tween(param);
    float param_1 = fast::clamp((progress - 0.1500000059604644775390625) / 0.699999988079071044921875, 0.0, 1.0);
    float mgProgress = tween(param_1);
    float param_2 = fast::clamp((progress - 0.300000011920928955078125) / 0.699999988079071044921875, 0.0, 1.0);
    float bgProgress = tween(param_2);
    float fgScale = 1.0 + (0.4000000059604644775390625 * (1.0 - fgProgress));
    float2 param_3 = float2(fgProgress, 0.100000001490116119384765625);
    float2 param_4 = float2(0.20000000298023223876953125, fgProgress);
    float2 fgOffset = (float2(random(param_3) - 0.5, random(param_4) - 0.5) * parallaxStrength) * (1.0 - fgProgress);
    float2 fgUV = float2(0.5) + (((vUv - float2(0.5)) + fgOffset) * fgScale);
    float2 param_5 = fgUV;
    fgUV = handleUVBounds(param_5);
    float fgBlur = maxBlur * (1.0 - fgProgress);
    float2 param_6 = fgUV;
    float param_7 = fgBlur;
    float param_8 = ratio;
    float4 fgColor = gaussianBlur(tDiffuse, tDiffuseSmplr, param_6, param_7, param_8);
    float mgScale = 1.0 + (0.25 * (1.0 - mgProgress));
    float2 param_9 = float2(mgProgress, 0.300000011920928955078125);
    float2 param_10 = float2(0.4000000059604644775390625, mgProgress);
    float2 mgOffset = ((float2(random(param_9) - 0.5, random(param_10) - 0.5) * parallaxStrength) * 0.60000002384185791015625) * (1.0 - mgProgress);
    float2 mgUV = float2(0.5) + (((vUv - float2(0.5)) + mgOffset) * mgScale);
    float2 param_11 = mgUV;
    mgUV = handleUVBounds(param_11);
    float mgBlur = 35.0 * (1.0 - mgProgress);
    float2 param_12 = mgUV;
    float param_13 = mgBlur;
    float param_14 = ratio;
    float4 mgColor = gaussianBlur(tDiffuse, tDiffuseSmplr, param_12, param_13, param_14);
    float bgScale = 1.0 + (0.100000001490116119384765625 * (1.0 - bgProgress));
    float2 param_15 = float2(bgProgress, 0.5);
    float2 param_16 = float2(0.60000002384185791015625, bgProgress);
    float2 bgOffset = ((float2(random(param_15) - 0.5, random(param_16) - 0.5) * parallaxStrength) * 0.300000011920928955078125) * (1.0 - bgProgress);
    float2 bgUV = float2(0.5) + (((vUv - float2(0.5)) + bgOffset) * bgScale);
    float2 param_17 = bgUV;
    bgUV = handleUVBounds(param_17);
    float bgBlur = 20.0 * (1.0 - bgProgress);
    float2 param_18 = bgUV;
    float param_19 = bgBlur;
    float param_20 = ratio;
    float4 bgColor = gaussianBlur(tDiffuse, tDiffuseSmplr, param_18, param_19, param_20);
    float4 layeredColor = ((bgColor * 0.300000011920928955078125) + (mgColor * 0.300000011920928955078125)) + (fgColor * 0.4000000059604644775390625);
    float3 adjustedColor = (layeredColor.xyz * 2.7999999523162841796875) * 1.89999997615814208984375;
    adjustedColor = mix(adjustedColor, texel.xyz, float3(progress));
    float2 param_21 = vUv;
    float param_22 = progress;
    float godRay = calcGodRay(param_21, param_22);
    float2 param_23 = vUv;
    float param_24 = progress;
    float dust = calcDustParticles(param_23, param_24, particleDensity);
    float3 finalRGB = (adjustedColor + (lightColor * godRay)) + ((lightColor * dust) * 0.60000002384185791015625);
    return mix(float4(finalRGB, layeredColor.w), texel, float4(smoothstep(0.89999997615814208984375, 1.0, progress)));
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
    float4 effectColor = effect(param_1, param_2, buffer.particleDensity, buffer.parallaxStrength, in.vUv, buffer.maxBlur, tDiffuse, tDiffuseSmplr, buffer.ratio, buffer.lightColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

