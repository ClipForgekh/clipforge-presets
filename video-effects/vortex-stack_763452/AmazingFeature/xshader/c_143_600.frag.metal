#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_outlineWidth;
    float3 u_outlineColor;
    float u_outlineOpacity;
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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_texture [[texture(0)]], sampler u_textureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texColor = u_texture.sample(u_textureSmplr, in.vUv);
    float edgeDist = fast::min(fast::min(in.vUv.x, 1.0 - in.vUv.x), fast::min(in.vUv.y, 1.0 - in.vUv.y));
    float outlineMask = 1.0 - smoothstep(buffer.u_outlineWidth, buffer.u_outlineWidth + 0.00200000009499490261077880859375, edgeDist);
    float3 color = mix(texColor.xyz, buffer.u_outlineColor, float3(outlineMask * buffer.u_outlineOpacity));
    color *= buffer.u_brightness;
    out.gl_FragColor = float4(color, texColor.w);
    return out;
}

