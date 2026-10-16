#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 uvOffset;
    float2 uvScale;
    float blurRadiusPx;
    float exposureWarm;
    float3 warmTint;
    float lightLeakStrength;
    float grainStrength;
    float u_grayscale;
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
float2 clampUv(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 filmBlurSample(thread const float2& mappedUv, thread const float& blurPx, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 texel = float2(0.00166666670702397823333740234375);
    float2 radius = texel * blurPx;
    float4 sum = float4(0.0);
    float2 param = mappedUv + (radius * float2(-1.0));
    sum += (texture1.sample(texture1Smplr, clampUv(param)) * 0.0625);
    float2 param_1 = mappedUv + (radius * float2(0.0, -1.0));
    sum += (texture1.sample(texture1Smplr, clampUv(param_1)) * 0.125);
    float2 param_2 = mappedUv + (radius * float2(1.0, -1.0));
    sum += (texture1.sample(texture1Smplr, clampUv(param_2)) * 0.0625);
    float2 param_3 = mappedUv + (radius * float2(-1.0, 0.0));
    sum += (texture1.sample(texture1Smplr, clampUv(param_3)) * 0.125);
    float2 param_4 = mappedUv + (radius * float2(0.0));
    sum += (texture1.sample(texture1Smplr, clampUv(param_4)) * 0.25);
    float2 param_5 = mappedUv + (radius * float2(1.0, 0.0));
    sum += (texture1.sample(texture1Smplr, clampUv(param_5)) * 0.125);
    float2 param_6 = mappedUv + (radius * float2(-1.0, 1.0));
    sum += (texture1.sample(texture1Smplr, clampUv(param_6)) * 0.0625);
    float2 param_7 = mappedUv + (radius * float2(0.0, 1.0));
    sum += (texture1.sample(texture1Smplr, clampUv(param_7)) * 0.125);
    float2 param_8 = mappedUv + (radius * float2(1.0));
    sum += (texture1.sample(texture1Smplr, clampUv(param_8)) * 0.0625);
    return sum;
}

static inline __attribute__((always_inline))
float randomValue(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = buffer.uvOffset + (in.vUv * buffer.uvScale);
    float2 param = mappedUv;
    float param_1 = buffer.blurRadiusPx;
    float4 texColor = filmBlurSample(param, param_1, texture1, texture1Smplr);
    float warmFactor = fast::max(buffer.exposureWarm - 1.0, 0.0);
    float4 _198 = texColor;
    float3 _200 = _198.xyz * buffer.exposureWarm;
    texColor.x = _200.x;
    texColor.y = _200.y;
    texColor.z = _200.z;
    float4 _218 = texColor;
    float3 _220 = _218.xyz + ((buffer.warmTint * warmFactor) * 0.2800000011920928955078125);
    texColor.x = _220.x;
    texColor.y = _220.y;
    texColor.z = _220.z;
    float edgeX = smoothstep(0.0, 0.07999999821186065673828125, in.vUv.x) * (1.0 - smoothstep(0.920000016689300537109375, 1.0, in.vUv.x));
    float edgeY = smoothstep(0.0, 0.07999999821186065673828125, in.vUv.y) * (1.0 - smoothstep(0.920000016689300537109375, 1.0, in.vUv.y));
    float edgeCenterMask = 1.0 - fast::min(edgeX, edgeY);
    float leakMask = fast::clamp(1.0 - edgeCenterMask, 0.0, 1.0);
    float4 _265 = texColor;
    float3 _267 = _265.xyz + (((buffer.warmTint * buffer.lightLeakStrength) * leakMask) * 0.89999997615814208984375);
    texColor.x = _267.x;
    texColor.y = _267.y;
    texColor.z = _267.z;
    float2 param_2 = (mappedUv * 173.0) + (in.vUv * 47.0);
    float grain = (randomValue(param_2) - 0.5) * buffer.grainStrength;
    float4 _290 = texColor;
    float3 _293 = _290.xyz + float3(grain);
    texColor.x = _293.x;
    texColor.y = _293.y;
    texColor.z = _293.z;
    float4 _300 = texColor;
    float3 _304 = fast::clamp(_300.xyz, float3(0.0), float3(1.0));
    texColor.x = _304.x;
    texColor.y = _304.y;
    texColor.z = _304.z;
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _319 = texColor;
    float3 _326 = mix(_319.xyz, float3(gray), float3(buffer.u_grayscale));
    texColor.x = _326.x;
    texColor.y = _326.y;
    texColor.z = _326.z;
    float4 _335 = texColor;
    float3 _337 = _335.xyz * buffer.u_brightness;
    texColor.x = _337.x;
    texColor.y = _337.y;
    texColor.z = _337.z;
    out.gl_FragColor = texColor;
    return out;
}

