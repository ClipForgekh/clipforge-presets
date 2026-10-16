#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float2 u_center;
    float u_radialStrength;
    float u_chromaticShift;
    float u_centerBoost;
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
float2 getAspectDir(thread const float2& uv, thread const float2& center, constant float& ratio)
{
    float2 d = uv - center;
    d.y /= fast::max(ratio, 9.9999997473787516355514526367188e-05);
    float len = length(d);
    if (len < 9.9999997473787516355514526367188e-05)
    {
        return float2(0.0);
    }
    d /= float2(len);
    d.y *= fast::max(ratio, 9.9999997473787516355514526367188e-05);
    return fast::normalize(d);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_textureA [[texture(0)]], sampler u_textureASmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float2 param = uv;
    float2 param_1 = buffer.u_center;
    float2 dir = getAspectDir(param, param_1, buffer.ratio);
    float dist = distance(uv, buffer.u_center);
    float3 accum = float3(0.0);
    float totalW = 0.0;
    for (int i = 0; i < 10; i++)
    {
        float t = float(i) / 9.0;
        float w = 1.0 - t;
        float2 radialOffset = ((dir * buffer.u_radialStrength) * 0.119999997317790985107421875) * t;
        float2 baseUv = fast::clamp(uv - radialOffset, float2(0.0), float2(1.0));
        float shift = (buffer.u_chromaticShift * 0.0199999995529651641845703125) * t;
        float r = u_textureA.sample(u_textureASmplr, fast::clamp(baseUv + (dir * shift), float2(0.0), float2(1.0))).x;
        float g = u_textureA.sample(u_textureASmplr, baseUv).y;
        float b = u_textureA.sample(u_textureASmplr, fast::clamp(baseUv - (dir * shift), float2(0.0), float2(1.0))).z;
        accum += (float3(r, g, b) * w);
        totalW += w;
    }
    float3 col = accum / float3(fast::max(totalW, 9.9999997473787516355514526367188e-05));
    float centerMask = exp((-dist) * 10.0);
    col *= (1.0 + (buffer.u_centerBoost * centerMask));
    out.gl_FragColor = float4(col, 1.0);
    return out;
}

