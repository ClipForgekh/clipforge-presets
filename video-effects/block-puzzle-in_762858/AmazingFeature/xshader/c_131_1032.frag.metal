#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float offsetX;
    float offsetY;
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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 offset = float2(buffer.offsetX, buffer.offsetY) * buffer.progress;
    offset *= length(in.vUv - float2(0.5));
    float r = tDiffuse.sample(tDiffuseSmplr, (in.vUv + offset)).x;
    float g = tDiffuse.sample(tDiffuseSmplr, in.vUv).y;
    float b = tDiffuse.sample(tDiffuseSmplr, (in.vUv - offset)).z;
    float a = tDiffuse.sample(tDiffuseSmplr, in.vUv).w;
    out.gl_FragColor = float4(r, g, b, a);
    return out;
}

