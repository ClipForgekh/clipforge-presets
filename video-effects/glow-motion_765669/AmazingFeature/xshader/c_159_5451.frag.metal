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
    float ratio;
    float u_bokehStarStrength;
    float u_depthLayerMask;
    float u_bgBlurRadius;
    float u_mgBlurRadius;
    float u_fgBlurRadius;
    float u_bgExposure;
    float u_mgExposure;
    float u_fgExposure;
    float u_brightness;
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
float2 getAspectCorrectUV(thread const float2& uv, constant float& ratio)
{
    float2 aspectUV = uv;
    if (ratio > 1.0)
    {
        aspectUV.y /= ratio;
        aspectUV.y += ((1.0 - (1.0 / ratio)) * 0.5);
    }
    else
    {
        aspectUV.x *= ratio;
        aspectUV.x += ((1.0 - ratio) * 0.5);
    }
    return aspectUV;
}

static inline __attribute__((always_inline))
float estimateDepthMask(thread const float2& uv, constant float& ratio)
{
    float2 param = uv;
    float2 aspectUV = getAspectCorrectUV(param, ratio);
    float2 centered = aspectUV - float2(0.5);
    float radial = fast::clamp(length(centered) * 1.60000002384185791015625, 0.0, 1.0);
    float vertical = smoothstep(-0.20000000298023223876953125, 0.800000011920928955078125, 1.0 - uv.y);
    float depth = fast::clamp(mix(radial, vertical, 0.3499999940395355224609375), 0.0, 1.0);
    return depth;
}

static inline __attribute__((always_inline))
float4 layeredBlurSample(thread const float2& uv, thread const float& radiusPx, constant float& ratio, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 texel = float2(0.00166666670702397823333740234375);
    texel.y /= fast::max(ratio, 9.9999997473787516355514526367188e-05);
    float2 blur = texel * radiusPx;
    float4 color = float4(0.0);
    float total = 0.0;
    spvUnsafeArray<float2, 9> offsets;
    offsets[0] = float2(0.0);
    offsets[1] = float2(1.0, 0.0);
    offsets[2] = float2(-1.0, 0.0);
    offsets[3] = float2(0.0, 1.0);
    offsets[4] = float2(0.0, -1.0);
    offsets[5] = float2(0.699999988079071044921875);
    offsets[6] = float2(-0.699999988079071044921875, 0.699999988079071044921875);
    offsets[7] = float2(0.699999988079071044921875, -0.699999988079071044921875);
    offsets[8] = float2(-0.699999988079071044921875);
    spvUnsafeArray<float, 9> weights;
    weights[0] = 0.23999999463558197021484375;
    weights[1] = 0.10999999940395355224609375;
    weights[2] = 0.10999999940395355224609375;
    weights[3] = 0.10999999940395355224609375;
    weights[4] = 0.10999999940395355224609375;
    weights[5] = 0.07999999821186065673828125;
    weights[6] = 0.07999999821186065673828125;
    weights[7] = 0.07999999821186065673828125;
    weights[8] = 0.07999999821186065673828125;
    for (int i = 0; i < 9; i++)
    {
        float2 sampleUV = fast::clamp(uv + (offsets[i] * blur), float2(0.0), float2(1.0));
        float4 texelColor = texture1.sample(texture1Smplr, sampleUV);
        color += (texelColor * weights[i]);
        total += weights[i];
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float getLuma(thread const float3& c)
{
    return dot(c, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 456.209991455078125));
    p += float2(dot(p, p + float2(45.31999969482421875)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float starShape(thread float2& p)
{
    p = abs(p);
    float a = fast::max(p.x, p.y);
    float b = fast::min(p.x, p.y);
    float _cross = smoothstep(0.0599999986588954925537109375, 0.0, b) * smoothstep(0.4199999868869781494140625, 0.0, a);
    float diag = smoothstep(0.0500000007450580596923828125, 0.0, abs(p.x - p.y)) * smoothstep(0.4799999892711639404296875, 0.0, a);
    return fast::clamp(_cross + (diag * 0.800000011920928955078125), 0.0, 1.0);
}

static inline __attribute__((always_inline))
float generateStarBokeh(thread const float2& uv, thread const float& exposureAmount, thread const float& depthMask, constant float& ratio, constant float& u_bokehStarStrength)
{
    float2 param = uv;
    float2 aspectUV = getAspectCorrectUV(param, ratio);
    float2 gridUV = aspectUV * 10.0;
    float2 cell = floor(gridUV);
    float2 local = fract(gridUV) - float2(0.5);
    float sparkle = 0.0;
    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            float2 neighbor = cell + float2(float(x), float(y));
            float2 param_1 = neighbor;
            float _352 = hash21(param_1);
            float rnd = _352;
            float2 param_2 = neighbor + float2(1.309999942779541015625);
            float _359 = hash21(param_2);
            float2 param_3 = neighbor + float2(2.730000019073486328125);
            float _365 = hash21(param_3);
            float2 jitter = float2(_359, _365) - float2(0.5);
            float2 p = (local - float2(float(x), float(y))) - (jitter * 0.550000011920928955078125);
            float size = mix(0.07999999821186065673828125, 0.2199999988079071044921875, rnd);
            float2 param_4 = p / float2(fast::max(size, 9.9999997473787516355514526367188e-05));
            float _392 = starShape(param_4);
            float star = _392;
            float intensity = smoothstep(0.550000011920928955078125, 1.0, rnd);
            sparkle += (star * intensity);
        }
    }
    float depthWeighted = smoothstep(0.20000000298023223876953125, 1.0, depthMask);
    return (((sparkle * exposureAmount) * u_bokehStarStrength) * depthWeighted) * 0.3499999940395355224609375;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float4 originalTexel = texture1.sample(texture1Smplr, uv);
    float2 param = uv;
    float depthMask = estimateDepthMask(param, buffer.ratio) * buffer.u_depthLayerMask;
    float bgWeight = smoothstep(0.550000011920928955078125, 1.0, depthMask);
    float fgWeight = 1.0 - smoothstep(0.20000000298023223876953125, 0.449999988079071044921875, depthMask);
    float mgWeight = fast::clamp((1.0 - bgWeight) - fgWeight, 0.0, 1.0);
    float blurRadius = ((bgWeight * buffer.u_bgBlurRadius) + (mgWeight * buffer.u_mgBlurRadius)) + (fgWeight * buffer.u_fgBlurRadius);
    float exposure = ((bgWeight * buffer.u_bgExposure) + (mgWeight * buffer.u_mgExposure)) + (fgWeight * buffer.u_fgExposure);
    float2 param_1 = uv;
    float param_2 = blurRadius;
    float4 blurredTexel = layeredBlurSample(param_1, param_2, buffer.ratio, texture1, texture1Smplr);
    float4 texColor = mix(originalTexel, blurredTexel, float4(fast::clamp(blurRadius / 60.0, 0.0, 1.0)));
    float4 _495 = texColor;
    float3 _497 = _495.xyz * exposure;
    texColor.x = _497.x;
    texColor.y = _497.y;
    texColor.z = _497.z;
    float3 param_3 = texColor.xyz;
    float luma = getLuma(param_3);
    float bloomGate = smoothstep(0.550000011920928955078125, 0.949999988079071044921875, luma);
    float2 param_4 = uv;
    float param_5 = (exposure - 1.0) * bloomGate;
    float param_6 = depthMask;
    float starBokeh = generateStarBokeh(param_4, param_5, param_6, buffer.ratio, buffer.u_bokehStarStrength);
    float4 _527 = texColor;
    float3 _529 = _527.xyz + float3(starBokeh);
    texColor.x = _529.x;
    texColor.y = _529.y;
    texColor.z = _529.z;
    float4 _536 = texColor;
    float3 _541 = mix(_536.xyz, originalTexel.xyz, float3(0.0));
    texColor.x = _541.x;
    texColor.y = _541.y;
    texColor.z = _541.z;
    float4 _550 = texColor;
    float3 _552 = _550.xyz * buffer.u_brightness;
    texColor.x = _552.x;
    texColor.y = _552.y;
    texColor.z = _552.z;
    out.gl_FragColor = float4(fast::clamp(texColor.xyz, float3(0.0), float3(1.0)), originalTexel.w);
    return out;
}

