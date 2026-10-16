#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blurRadius;
    float2 u_texelSize;
    float u_exposure;
    float u_whiteFade;
    float u_blackFade;
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
float4 sampleBlur9(thread const float2& uv, thread const float2& direction, thread const float& radius, texture2d<float> texture1, sampler texture1Smplr)
{
    float4 color = float4(0.0);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((direction * radius) * (-4.0)), float2(0.0), float2(1.0))) * 0.05099999904632568359375);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((direction * radius) * (-3.0)), float2(0.0), float2(1.0))) * 0.091799996793270111083984375);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((direction * radius) * (-2.0)), float2(0.0), float2(1.0))) * 0.122450001537799835205078125);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((direction * radius) * (-1.0)), float2(0.0), float2(1.0))) * 0.15309999883174896240234375);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.16329999268054962158203125);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((direction * radius) * 1.0), float2(0.0), float2(1.0))) * 0.15309999883174896240234375);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((direction * radius) * 2.0), float2(0.0), float2(1.0))) * 0.122450001537799835205078125);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((direction * radius) * 3.0), float2(0.0), float2(1.0))) * 0.091799996793270111083984375);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + ((direction * radius) * 4.0), float2(0.0), float2(1.0))) * 0.05099999904632568359375);
    return color;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float radius = buffer.u_blurRadius;
    float2 horizontalDir = float2(buffer.u_texelSize.x, 0.0);
    float2 verticalDir = float2(0.0, buffer.u_texelSize.y);
    float2 param = in.vUv;
    float2 param_1 = horizontalDir;
    float param_2 = radius;
    float4 blurH = sampleBlur9(param, param_1, param_2, texture1, texture1Smplr);
    float2 param_3 = in.vUv;
    float2 param_4 = verticalDir;
    float param_5 = radius;
    float4 blurV = sampleBlur9(param_3, param_4, param_5, texture1, texture1Smplr);
    float4 blurred = mix(texture1.sample(texture1Smplr, in.vUv), (blurH + blurV) * 0.5, float4(fast::clamp(radius / 24.0, 0.0, 1.0)));
    float3 exposed = blurred.xyz * buffer.u_exposure;
    exposed = fast::min(exposed, float3(1.0));
    float3 whiteMixed = mix(exposed, float3(0.939999997615814208984375), float3(fast::clamp(buffer.u_whiteFade, 0.0, 1.0)));
    float3 finalColor = mix(whiteMixed, float3(0.0), float3(fast::clamp(buffer.u_blackFade, 0.0, 1.0)));
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

