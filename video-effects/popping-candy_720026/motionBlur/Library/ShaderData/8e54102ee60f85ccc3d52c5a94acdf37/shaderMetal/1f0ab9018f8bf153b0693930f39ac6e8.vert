#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_flipX;
    float u_flipY;
};

struct main0_out
{
    float2 uv [[user(uv)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 attPosition [[attribute(0)]];
    float2 attUV [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    out.gl_Position = float4(in.attPosition, 1.0);
    out.uv = (in.attUV * 2.0) - float2(1.0);
    if (buffer.u_flipX > 0.5)
    {
        out.uv.x = -out.uv.x;
    }
    if (buffer.u_flipY > 0.5)
    {
        out.uv.y = -out.uv.y;
    }
    out.uv = (out.uv * 0.5) + float2(0.5);
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

