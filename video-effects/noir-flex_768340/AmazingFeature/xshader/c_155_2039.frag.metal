#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL radians() function
template<typename T>
inline T radians(T d)
{
    return d * T(0.01745329251);
}

struct buffer_t
{
    float ratio;
    float u_lensRotateZDeg;
    float u_lensDepthZ;
    float u_fisheyeStrength;
    float u_saturation;
    float u_lumaMatteRadius;
    float u_lumaEdgeSoftness;
    float u_edgeDarkness;
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
float2 fitToTextureAspect(thread const float2& uv, constant float& ratio)
{
    float2 p = uv - float2(0.5);
    if (ratio > 1.0)
    {
        p.x *= ratio;
    }
    else
    {
        p.y /= fast::max(ratio, 9.9999997473787516355514526367188e-05);
    }
    return p;
}

static inline __attribute__((always_inline))
float2 rotate2D(thread const float2& p, thread const float& a)
{
    float s = sin(a);
    float c = cos(a);
    return float2x2(float2(c, -s), float2(s, c)) * p;
}

static inline __attribute__((always_inline))
float2 unfitFromTextureAspect(thread float2& p, constant float& ratio)
{
    if (ratio > 1.0)
    {
        p.x /= ratio;
    }
    else
    {
        p.y *= fast::max(ratio, 9.9999997473787516355514526367188e-05);
    }
    return p + float2(0.5);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 p = fitToTextureAspect(param, buffer.ratio);
    float lensRad = radians(buffer.u_lensRotateZDeg);
    float2 param_1 = p;
    float param_2 = lensRad;
    p = rotate2D(param_1, param_2);
    float r = length(p);
    float depthNorm = fast::clamp((-buffer.u_lensDepthZ) / 6.0, 0.0, 1.0);
    float compression = mix(1.0, 0.449999988079071044921875, depthNorm);
    float k = buffer.u_fisheyeStrength * mix(0.800000011920928955078125, 1.14999997615814208984375, depthNorm);
    float2 distorted = p / float2(1.0 + ((k * r) * r));
    distorted *= (compression + ((1.0 - compression) * smoothstep(0.0, 1.0, r)));
    float2 param_3 = distorted;
    float2 _154 = unfitFromTextureAspect(param_3, buffer.ratio);
    float2 mappedUv = _154;
    mappedUv = fast::clamp(mappedUv, float2(0.0), float2(1.0));
    float4 texColor = texture1.sample(texture1Smplr, mappedUv);
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _180 = texColor;
    float3 _186 = mix(float3(gray), _180.xyz, float3(fast::clamp(buffer.u_saturation, 0.0, 1.0)));
    texColor.x = _186.x;
    texColor.y = _186.y;
    texColor.z = _186.z;
    float mask = 1.0 - smoothstep(buffer.u_lumaMatteRadius - buffer.u_lumaEdgeSoftness, buffer.u_lumaMatteRadius + buffer.u_lumaEdgeSoftness, r);
    float edgeFactor = mix(1.0 - buffer.u_edgeDarkness, 1.0, mask);
    float4 _213 = texColor;
    float3 _215 = _213.xyz * edgeFactor;
    texColor.x = _215.x;
    texColor.y = _215.y;
    texColor.z = _215.z;
    out.gl_FragColor = texColor;
    return out;
}

