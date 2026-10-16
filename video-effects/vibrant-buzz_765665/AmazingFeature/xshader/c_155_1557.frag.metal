#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float u_blurRadiusPx;
    float u_exposureGain;
    float3 u_warmTint;
    float u_noiseAmount;
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
float4 radialBlur(thread const float2& uv, thread const float& radiusPx, constant float2& u_resolution, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 center = float2(0.5);
    float2 dir = uv - center;
    float lenDir = fast::max(length(dir), 9.9999997473787516355514526367188e-05);
    float2 nDir = dir / float2(lenDir);
    float pxToUvX = 1.0 / fast::max(u_resolution.x, 1.0);
    float pxToUvY = 1.0 / fast::max(u_resolution.y, 1.0);
    float2 stepUv = float2((nDir.x * radiusPx) * pxToUvX, (nDir.y * radiusPx) * pxToUvY);
    float4 sum = float4(0.0);
    for (int i = 0; i < 8; i++)
    {
        float t = float(i) / 7.0;
        float2 suv = uv - (stepUv * t);
        suv = fast::clamp(suv, float2(0.0), float2(1.0));
        sum += texture1.sample(texture1Smplr, suv);
    }
    return sum / float4(8.0);
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_blurRadiusPx;
    float4 col = radialBlur(param, param_1, buffer.u_resolution, texture1, texture1Smplr);
    float4 _163 = col;
    float3 _165 = _163.xyz * buffer.u_exposureGain;
    col.x = _165.x;
    col.y = _165.y;
    col.z = _165.z;
    float4 _172 = col;
    float4 _174 = col;
    float3 _182 = mix(_172.xyz, _174.xyz * buffer.u_warmTint, float3(0.3499999940395355224609375));
    col.x = _182.x;
    col.y = _182.y;
    col.z = _182.z;
    float2 param_2 = in.vUv * float2(1024.0);
    float grain = hash12(param_2) - 0.5;
    float4 _203 = col;
    float3 _206 = _203.xyz + float3((grain * buffer.u_noiseAmount) * 0.25);
    col.x = _206.x;
    col.y = _206.y;
    col.z = _206.z;
    float4 _213 = col;
    float3 _217 = fast::clamp(_213.xyz, float3(0.0), float3(1.0));
    col.x = _217.x;
    col.y = _217.y;
    col.z = _217.z;
    out.gl_FragColor = col;
    return out;
}

