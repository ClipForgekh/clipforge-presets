#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blurRadiusY;
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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float blur = fast::max(buffer.u_blurRadiusY, 0.0);
    float maxOffset = 0.180000007152557373046875 * blur;
    float4 color = float4(0.0);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-1.0) * maxOffset), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-0.75) * maxOffset), float2(0.0), float2(1.0))) * 0.100000001490116119384765625);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-0.5) * maxOffset), float2(0.0), float2(1.0))) * 0.100000001490116119384765625);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-0.25) * maxOffset), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.20000000298023223876953125);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 0.25 * maxOffset), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 0.5 * maxOffset), float2(0.0), float2(1.0))) * 0.100000001490116119384765625);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 0.75 * maxOffset), float2(0.0), float2(1.0))) * 0.100000001490116119384765625);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 1.0 * maxOffset), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    float4 _160 = color;
    float3 _162 = _160.xyz * buffer.u_brightness;
    color.x = _162.x;
    color.y = _162.y;
    color.z = _162.z;
    out.gl_FragColor = color;
    return out;
}

