#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float2 uvScale;
    float2 uvOffset;
    float u_blurRadiusPx;
    float u_grayHighlightDampen;
    float u_exposure;
    float u_saturation;
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
float4 gaussian9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusPx, constant float& ratio)
{
    if (radiusPx <= 0.001000000047497451305389404296875)
    {
        return tex.sample(texSmplr, uv);
    }
    float px = radiusPx / 600.0;
    float2 stepUV = float2(px, px / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    c += (tex.sample(texSmplr, (uv + (stepUV * float2(-1.0)))) * 0.07500000298023223876953125);
    c += (tex.sample(texSmplr, (uv + (stepUV * float2(0.0, -1.0)))) * 0.12399999797344207763671875);
    c += (tex.sample(texSmplr, (uv + (stepUV * float2(1.0, -1.0)))) * 0.07500000298023223876953125);
    c += (tex.sample(texSmplr, (uv + (stepUV * float2(-1.0, 0.0)))) * 0.12399999797344207763671875);
    c += (tex.sample(texSmplr, (uv + (stepUV * float2(0.0)))) * 0.203999996185302734375);
    c += (tex.sample(texSmplr, (uv + (stepUV * float2(1.0, 0.0)))) * 0.12399999797344207763671875);
    c += (tex.sample(texSmplr, (uv + (stepUV * float2(-1.0, 1.0)))) * 0.07500000298023223876953125);
    c += (tex.sample(texSmplr, (uv + (stepUV * float2(0.0, 1.0)))) * 0.12399999797344207763671875);
    c += (tex.sample(texSmplr, (uv + (stepUV * float2(1.0)))) * 0.07500000298023223876953125);
    return c;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.uvScale) + buffer.uvOffset;
    float2 param = mappedUv;
    float param_1 = buffer.u_blurRadiusPx;
    float4 col = gaussian9(texture1, texture1Smplr, param, param_1, buffer.ratio);
    float luma = dot(col.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float highMask = smoothstep(0.60000002384185791015625, 1.0, luma);
    float3 gray = float3(luma);
    float4 _182 = col;
    float3 _192 = mix(_182.xyz, gray * 0.920000016689300537109375, float3(buffer.u_grayHighlightDampen * highMask));
    col.x = _192.x;
    col.y = _192.y;
    col.z = _192.z;
    float4 _205 = col;
    float3 _207 = _205.xyz * buffer.u_exposure;
    col.x = _207.x;
    col.y = _207.y;
    col.z = _207.z;
    float g = dot(col.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _220 = col;
    float3 _225 = mix(float3(g), _220.xyz, float3(buffer.u_saturation));
    col.x = _225.x;
    col.y = _225.y;
    col.z = _225.z;
    out.gl_FragColor = float4(col.xyz, 1.0);
    return out;
}

