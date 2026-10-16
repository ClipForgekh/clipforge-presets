#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_OutputWidth;
    float u_OutputHeight;
    float4x4 fitMat;
    float4x4 userMat;
};

struct main0_out
{
    float2 TexCoords [[user(TexCoords)]];
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
    float _93 = buffer.u_OutputWidth / buffer.u_OutputHeight;
    float4 _112 = (buffer.fitMat * buffer.userMat) * float4(fma(in.attUV.x, 2.0, -1.0) * _93, fma(in.attUV.y, 2.0, -1.0), 0.0, 1.0);
    out.TexCoords = float2(((_112.x / _93) + 1.0) * 0.5, (_112.y + 1.0) * 0.5);
    out.gl_Position = float4(in.attPosition, 1.0);
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

