#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blurStrength;
    float2 u_shadowOffset;
    float3 u_shadowColor;
    float u_shadowAlpha;
    float u_borderThickness;
    float u_brightness;
    float3 u_borderColor;
    float u_borderAlpha;
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
float4 sampleSoftBlur(thread const float2& uv, texture2d<float> texture1, sampler texture1Smplr, constant float& u_blurStrength)
{
    float2 texel = float2(0.0035000001080334186553955078125);
    float4 color = texture1.sample(texture1Smplr, uv) * 0.227026998996734619140625;
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((float2(texel.x, 0.0) * u_blurStrength) * 2.0), float2(0.0), float2(1.0))) * 0.19459460675716400146484375);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv - ((float2(texel.x, 0.0) * u_blurStrength) * 2.0), float2(0.0), float2(1.0))) * 0.19459460675716400146484375);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((float2(0.0, texel.y) * u_blurStrength) * 2.0), float2(0.0), float2(1.0))) * 0.19459460675716400146484375);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv - ((float2(0.0, texel.y) * u_blurStrength) * 2.0), float2(0.0), float2(1.0))) * 0.19459460675716400146484375);
    return color;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float4 _114;
    if (buffer.u_blurStrength > 9.9999997473787516355514526367188e-05)
    {
        float2 param = uv;
        _114 = sampleSoftBlur(param, texture1, texture1Smplr, buffer.u_blurStrength);
    }
    else
    {
        _114 = texture1.sample(texture1Smplr, uv);
    }
    float4 imageColor = _114;
    float2 shadowUv = uv - buffer.u_shadowOffset;
    float shadowMask = ((step(0.0, shadowUv.x) * step(0.0, shadowUv.y)) * step(shadowUv.x, 1.0)) * step(shadowUv.y, 1.0);
    float shadowImageMask = ((step(0.0, shadowUv.x) * step(0.0, shadowUv.y)) * step(shadowUv.x, 1.0)) * step(shadowUv.y, 1.0);
    float4 color = mix(float4(0.0), float4(buffer.u_shadowColor, (buffer.u_shadowAlpha * shadowMask) * shadowImageMask), float4(1.0));
    float minEdge = fast::min(fast::min(uv.x, 1.0 - uv.x), fast::min(uv.y, 1.0 - uv.y));
    float borderMask = 1.0 - step(buffer.u_borderThickness, minEdge);
    float4 cardColor = imageColor;
    float4 _205 = cardColor;
    float3 _207 = _205.xyz * buffer.u_brightness;
    cardColor.x = _207.x;
    cardColor.y = _207.y;
    cardColor.z = _207.z;
    cardColor = mix(cardColor, float4(buffer.u_borderColor, 1.0), float4(borderMask * buffer.u_borderAlpha));
    color = mix(color, cardColor, float4(float(cardColor.w > 0.0)));
    out.gl_FragColor = color;
    return out;
}

