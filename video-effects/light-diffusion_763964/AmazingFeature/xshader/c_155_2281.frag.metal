#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_rippleRadius;
    float u_blurAmount;
    float u_saturation;
    float u_blackMask;
    float u_rippleGlow;
    float3 u_rippleColorInner;
    float3 u_rippleColorOuter;
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
float2 getAspectCorrectCenterSpace(thread const float2& uv, constant float& ratio)
{
    float2 p = uv - float2(0.5);
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
float4 sampleBlurred(thread const float2& uv, thread const float& blurStrength, constant float& ratio, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 stepUV = float2(0.0040000001899898052215576171875 * blurStrength, (0.0040000001899898052215576171875 * blurStrength) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    c += (texture1.sample(texture1Smplr, uv) * 0.2800000011920928955078125);
    c += (texture1.sample(texture1Smplr, (uv + float2(stepUV.x, 0.0))) * 0.14000000059604644775390625);
    c += (texture1.sample(texture1Smplr, (uv - float2(stepUV.x, 0.0))) * 0.14000000059604644775390625);
    c += (texture1.sample(texture1Smplr, (uv + float2(0.0, stepUV.y))) * 0.14000000059604644775390625);
    c += (texture1.sample(texture1Smplr, (uv - float2(0.0, stepUV.y))) * 0.14000000059604644775390625);
    c += (texture1.sample(texture1Smplr, (uv + stepUV)) * 0.07999999821186065673828125);
    c += (texture1.sample(texture1Smplr, (uv - stepUV)) * 0.07999999821186065673828125);
    return c;
}

static inline __attribute__((always_inline))
float3 applySaturation(thread const float3& color, thread const float& sat)
{
    float gray = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(gray), color, float3(sat));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 p = getAspectCorrectCenterSpace(param, buffer.ratio);
    float distToCenter = length(p);
    float passedMask = 1.0 - smoothstep(buffer.u_rippleRadius - 0.02999999932944774627685546875, buffer.u_rippleRadius + 0.02999999932944774627685546875, distToCenter);
    float localBlur = buffer.u_blurAmount * (1.0 - (0.85000002384185791015625 * passedMask));
    float2 param_1 = in.vUv;
    float param_2 = localBlur;
    float4 texel = sampleBlurred(param_1, param_2, buffer.ratio, texture1, texture1Smplr);
    float localSat = mix(buffer.u_saturation, 1.0, passedMask);
    float3 param_3 = texel.xyz;
    float param_4 = localSat;
    float3 _202 = applySaturation(param_3, param_4);
    texel.x = _202.x;
    texel.y = _202.y;
    texel.z = _202.z;
    float revealMask = fast::max(1.0 - buffer.u_blackMask, passedMask);
    float4 _217 = texel;
    float3 _219 = _217.xyz * revealMask;
    texel.x = _219.x;
    texel.y = _219.y;
    texel.z = _219.z;
    float ring = exp(-pow((distToCenter - buffer.u_rippleRadius) * 85.0, 2.0)) * buffer.u_rippleGlow;
    float ringT = fast::clamp(distToCenter / fast::max(buffer.u_rippleRadius, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
    float3 ringColor = mix(buffer.u_rippleColorInner, buffer.u_rippleColorOuter, float3(ringT));
    float4 _259 = texel;
    float3 _261 = _259.xyz + ((ringColor * ring) * 0.75);
    texel.x = _261.x;
    texel.y = _261.y;
    texel.z = _261.z;
    out.gl_FragColor = float4(texel.xyz, 1.0);
    return out;
}

