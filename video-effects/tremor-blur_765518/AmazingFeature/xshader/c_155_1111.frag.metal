#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blurRadiusY;
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
    float2 uv = in.vUv;
    float4 sum = float4(0.0);
    float radius = buffer.u_blurRadiusY;
    float stepY = radius / 2048.0;
    sum += (u_texture.sample(u_textureSmplr, fast::clamp(uv + float2(0.0, (-4.0) * stepY), float2(0.0), float2(1.0))) * 0.100000001490116119384765625);
    sum += (u_texture.sample(u_textureSmplr, fast::clamp(uv + float2(0.0, (-3.0) * stepY), float2(0.0), float2(1.0))) * 0.10999999940395355224609375);
    sum += (u_texture.sample(u_textureSmplr, fast::clamp(uv + float2(0.0, (-2.0) * stepY), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    sum += (u_texture.sample(u_textureSmplr, fast::clamp(uv + float2(0.0, (-1.0) * stepY), float2(0.0), float2(1.0))) * 0.12999999523162841796875);
    sum += (u_texture.sample(u_textureSmplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    sum += (u_texture.sample(u_textureSmplr, fast::clamp(uv + float2(0.0, 1.0 * stepY), float2(0.0), float2(1.0))) * 0.12999999523162841796875);
    sum += (u_texture.sample(u_textureSmplr, fast::clamp(uv + float2(0.0, 2.0 * stepY), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    sum += (u_texture.sample(u_textureSmplr, fast::clamp(uv + float2(0.0, 3.0 * stepY), float2(0.0), float2(1.0))) * 0.10999999940395355224609375);
    sum += (u_texture.sample(u_textureSmplr, fast::clamp(uv + float2(0.0, 4.0 * stepY), float2(0.0), float2(1.0))) * 0.100000001490116119384765625);
    out.gl_FragColor = sum;
    return out;
}

