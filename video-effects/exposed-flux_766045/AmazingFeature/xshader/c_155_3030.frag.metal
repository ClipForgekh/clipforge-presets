#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 resolution;
    float2 blurDirection;
    float blurRadiusPx;
    float2 leakLightDirection;
    float leakProgress;
    float leakWidth;
    float exposureGain;
    float leakLightEnabled;
    float leakIntensity;
    float3 leakLightSecondaryColor;
    float3 leakLightColor;
    float filmGrain;
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
float4 sampleDiagonalRadialBlur(thread const float2& uv, constant float2& resolution, constant float2& blurDirection, constant float& blurRadiusPx, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 px = float2(1.0 / fast::max(resolution.x, 1.0), 1.0 / fast::max(resolution.y, 1.0));
    float2 dir = fast::normalize(blurDirection);
    float2 center = float2(0.5);
    float diag = dot(uv - center, float2(0.707106769084930419921875, -0.707106769084930419921875));
    float gradient = smoothstep(-0.75, 0.75, diag);
    float radial = fast::clamp(length(uv - center) * 1.35000002384185791015625, 0.0, 1.0);
    float directionalWeight = mix(1.0, 0.20000000298023223876953125, gradient);
    float localRadius = blurRadiusPx * fast::max(radial * directionalWeight, 0.001000000047497451305389404296875);
    float4 color = float4(0.0);
    float total = 0.0;
    for (int i = -6; i <= 6; i++)
    {
        float fi = float(i);
        float t = fi / 6.0;
        float w = 1.0 - abs(t);
        float2 offset = ((dir * localRadius) * t) * px;
        float2 sampleUv = fast::clamp(uv + offset, float2(0.0), float2(1.0));
        color += (texture1.sample(texture1Smplr, sampleUv) * w);
        total += w;
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float computeLeakBand(thread const float2& uv, constant float2& leakLightDirection, constant float& leakProgress, constant float& leakWidth)
{
    float2 center = float2(0.5);
    float2 diagDir = fast::normalize(leakLightDirection);
    float axis = dot(uv - center, diagDir);
    float bandCenter = mix(0.85000002384185791015625, -0.85000002384185791015625, leakProgress);
    float dist = abs(axis - bandCenter);
    float core = 1.0 - smoothstep(0.0, leakWidth, dist);
    float halo = 1.0 - smoothstep(leakWidth, leakWidth * 2.400000095367431640625, dist);
    return fast::max(core, halo * 0.4000000059604644775390625);
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float4 texColor = sampleDiagonalRadialBlur(param, buffer.resolution, buffer.blurDirection, buffer.blurRadiusPx, texture1, texture1Smplr);
    float4 _212 = texColor;
    float3 _214 = _212.xyz * buffer.exposureGain;
    texColor.x = _214.x;
    texColor.y = _214.y;
    texColor.z = _214.z;
    if (buffer.leakLightEnabled > 0.5)
    {
        float2 param_1 = in.vUv;
        float leakMask = computeLeakBand(param_1, buffer.leakLightDirection, buffer.leakProgress, buffer.leakWidth) * buffer.leakIntensity;
        float2 center = float2(0.5);
        float2 diagDir = fast::normalize(buffer.leakLightDirection);
        float tintMix = smoothstep(-0.5, 0.5, dot(in.vUv - center, diagDir));
        float3 leakColor = mix(buffer.leakLightSecondaryColor, buffer.leakLightColor, float3(tintMix));
        float4 _261 = texColor;
        float3 _263 = _261.xyz + ((leakColor * leakMask) * 0.949999988079071044921875);
        texColor.x = _263.x;
        texColor.y = _263.y;
        texColor.z = _263.z;
        float4 _270 = texColor;
        float4 _272 = texColor;
        float3 _280 = mix(_270.xyz, _272.xyz * 1.08000004291534423828125, float3(leakMask * 0.3499999940395355224609375));
        texColor.x = _280.x;
        texColor.y = _280.y;
        texColor.z = _280.z;
    }
    if (buffer.filmGrain > 9.9999997473787516355514526367188e-06)
    {
        float2 param_2 = ((in.vUv * buffer.resolution) * 0.3499999940395355224609375) + float2(17.1299991607666015625, 4.78999996185302734375);
        float grain = random(param_2) - 0.5;
        float4 _308 = texColor;
        float3 _311 = _308.xyz + float3(grain * buffer.filmGrain);
        texColor.x = _311.x;
        texColor.y = _311.y;
        texColor.z = _311.z;
    }
    float4 _320 = texColor;
    float3 _322 = _320.xyz * buffer.u_brightness;
    texColor.x = _322.x;
    texColor.y = _322.y;
    texColor.z = _322.z;
    out.gl_FragColor = float4(fast::clamp(texColor.xyz, float3(0.0), float3(1.0)), 1.0);
    return out;
}

