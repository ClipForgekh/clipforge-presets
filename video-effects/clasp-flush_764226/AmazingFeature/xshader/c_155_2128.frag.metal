#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_blurDirection;
    float u_blurRadius;
    float u_bottomBarProgress;
    float u_topBarProgress;
    float u_centerBandStrength;
    float u_exposure;
    float u_brightness;
    float u_blackMask;
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
float3 sampleDirectionalBlur(thread const float2& uv, thread const float2& dir, thread const float& radius, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 nDir = fast::normalize(dir * fast::max(length(dir), 9.9999997473787516355514526367188e-05));
    float r = radius * 0.00120000005699694156646728515625;
    float3 sum = float3(0.0);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv - ((nDir * r) * 2.0), float2(0.0), float2(1.0))).xyz * 0.119999997317790985107421875);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv - (nDir * r), float2(0.0), float2(1.0))).xyz * 0.2199999988079071044921875);
    sum += (texture1.sample(texture1Smplr, uv).xyz * 0.319999992847442626953125);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv + (nDir * r), float2(0.0), float2(1.0))).xyz * 0.2199999988079071044921875);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv + ((nDir * r) * 2.0), float2(0.0), float2(1.0))).xyz * 0.119999997317790985107421875);
    return sum;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float3 baseTex = texture1.sample(texture1Smplr, uv).xyz;
    float2 param = uv;
    float2 param_1 = buffer.u_blurDirection;
    float param_2 = buffer.u_blurRadius;
    float3 blurTex = sampleDirectionalBlur(param, param_1, param_2, texture1, texture1Smplr);
    float bottomEdge = 1.0 - smoothstep(buffer.u_bottomBarProgress - 0.07999999821186065673828125, buffer.u_bottomBarProgress + 0.07999999821186065673828125, uv.y);
    float topEdge = smoothstep((1.0 - buffer.u_topBarProgress) - 0.07999999821186065673828125, (1.0 - buffer.u_topBarProgress) + 0.07999999821186065673828125, uv.y);
    float horizontalBars = fast::clamp(fast::max(bottomEdge, topEdge), 0.0, 1.0);
    float centerBand = exp((-abs(uv.x - 0.5)) * 20.0) * buffer.u_centerBandStrength;
    float3 warmGlow = float3(1.0, 0.62000000476837158203125, 0.25) * ((horizontalBars * 1.2000000476837158203125) + (centerBand * 1.7999999523162841796875));
    float3 composited = mix(baseTex, blurTex, float3(0.75));
    composited = (composited * buffer.u_exposure) + warmGlow;
    composited *= buffer.u_brightness;
    composited = mix(composited, float3(0.0), float3(fast::clamp(buffer.u_blackMask, 0.0, 1.0)));
    if (buffer.u_blackMask > 0.99500000476837158203125)
    {
        out.gl_FragColor = float4(0.0, 0.0, 0.0, 1.0);
    }
    else
    {
        out.gl_FragColor = float4(composited, 1.0);
    }
    return out;
}

