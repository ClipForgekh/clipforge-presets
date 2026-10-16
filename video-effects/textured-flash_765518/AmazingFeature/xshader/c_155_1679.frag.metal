#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float ratio;
    float u_blurRadiusPx;
    float u_exposure;
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
float4 gaussianBlur5(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurRadiusPx, constant float2& u_resolution, constant float& ratio)
{
    if (blurRadiusPx <= 9.9999997473787516355514526367188e-05)
    {
        return tex.sample(texSmplr, uv);
    }
    float2 texel = float2(1.0 / fast::max(u_resolution.x, 1.0), 1.0 / fast::max(u_resolution.y, 1.0));
    float2 stepSize = float2(blurRadiusPx * texel.x, (blurRadiusPx * texel.y) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    color += (tex.sample(texSmplr, uv) * w0);
    totalWeight += w0;
    float _104;
    float _112;
    for (int i = 1; i <= 4; i++)
    {
        float fi = float(i);
        if (i == 1)
        {
            _104 = w1;
        }
        else
        {
            if (i == 2)
            {
                _112 = w2;
            }
            else
            {
                _112 = (i == 3) ? w3 : w4;
            }
            _104 = _112;
        }
        float wi = _104;
        float2 offsetX = float2(stepSize.x * fi, 0.0);
        float2 offsetY = float2(0.0, stepSize.y * fi);
        color += (tex.sample(texSmplr, fast::clamp(uv + offsetX, float2(0.0), float2(1.0))) * wi);
        color += (tex.sample(texSmplr, fast::clamp(uv - offsetX, float2(0.0), float2(1.0))) * wi);
        color += (tex.sample(texSmplr, fast::clamp(uv + offsetY, float2(0.0), float2(1.0))) * wi);
        color += (tex.sample(texSmplr, fast::clamp(uv - offsetY, float2(0.0), float2(1.0))) * wi);
        totalWeight += (wi * 4.0);
    }
    return color / float4(fast::max(totalWeight, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_blurRadiusPx;
    float4 texColor = gaussianBlur5(texture1, texture1Smplr, param, param_1, buffer.u_resolution, buffer.ratio);
    float4 _212 = texColor;
    float3 _214 = _212.xyz * buffer.u_exposure;
    texColor.x = _214.x;
    texColor.y = _214.y;
    texColor.z = _214.z;
    out.gl_FragColor = float4(texColor.xyz, 1.0);
    return out;
}

