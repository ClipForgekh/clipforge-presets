#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uBlur;
    float uRadius;
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
float roundedBox(thread const float2& p, thread const float2& b, thread const float& r)
{
    float2 q = (abs(p) - b) + float2(r);
    return (fast::min(fast::max(q.x, q.y), 0.0) + length(fast::max(q, float2(0.0)))) - r;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel;
    if (buffer.uBlur > 0.00999999977648258209228515625)
    {
        float offset = buffer.uBlur * 0.0500000007450580596923828125;
        texel = ((((tDiffuse.sample(tDiffuseSmplr, in.vUv) + tDiffuse.sample(tDiffuseSmplr, (in.vUv + float2(offset, 0.0)))) + tDiffuse.sample(tDiffuseSmplr, (in.vUv - float2(offset, 0.0)))) + tDiffuse.sample(tDiffuseSmplr, (in.vUv + float2(0.0, offset)))) + tDiffuse.sample(tDiffuseSmplr, (in.vUv - float2(0.0, offset)))) / float4(5.0);
    }
    else
    {
        texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    }
    float2 centerP = in.vUv - float2(0.5);
    float2 param = centerP;
    float2 param_1 = float2(0.5);
    float param_2 = buffer.uRadius * 0.100000001490116119384765625;
    float d = roundedBox(param, param_1, param_2);
    float mask = 1.0 - smoothstep(0.0, 0.00999999977648258209228515625, d);
    out.gl_FragColor = float4(texel.xyz, texel.w * mask);
    return out;
}

