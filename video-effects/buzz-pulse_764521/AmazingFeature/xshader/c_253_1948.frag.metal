#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float depthMotionBlur;
    float verticalSmear;
    float filmBloom;
    float uLayerIndex;
    float uZDistance;
    float filmGrain;
    float u_brightness;
    float uOpacity;
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
float3 sampleBlurred(thread const float2& uv, thread const float& blurAmount, thread const float& smearAmount, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 dirZ = float2(0.0, blurAmount * 0.02999999932944774627685546875);
    float2 dirY = float2(0.0, smearAmount * 0.0199999995529651641845703125);
    float3 color = float3(0.0);
    float total = 0.0;
    for (int i = -4; i <= 4; i++)
    {
        float t = float(i) / 4.0;
        float2 offset = (dirZ * t) + ((dirY * t) * abs(t));
        float2 sampleUv = fast::clamp(uv + offset, float2(0.0), float2(1.0));
        float weight = 1.0 - (abs(t) * 0.119999997317790985107421875);
        color += (texture1.sample(texture1Smplr, sampleUv).xyz * weight);
        total += weight;
    }
    return color / float3(fast::max(total, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float2 param = uv;
    float param_1 = buffer.depthMotionBlur;
    float param_2 = buffer.verticalSmear;
    float3 blurred = sampleBlurred(param, param_1, param_2, texture1, texture1Smplr);
    float4 baseTexel = texture1.sample(texture1Smplr, uv);
    float edge = smoothstep(0.949999988079071044921875, 0.449999988079071044921875, distance(uv, float2(0.5)));
    float3 bloomColor = blurred + (((blurred * buffer.filmBloom) * edge) * 0.449999988079071044921875);
    float2 param_3 = (uv * (120.0 + (buffer.uLayerIndex * 17.0))) + float2(buffer.uLayerIndex * 3.099999904632568359375, buffer.uZDistance * 0.12999999523162841796875);
    float grain = ((random(param_3) - 0.5) * buffer.filmGrain) * 0.180000007152557373046875;
    float3 finalColor = mix(blurred, bloomColor, float3(fast::clamp(buffer.filmBloom, 0.0, 1.0)));
    finalColor += float3(grain);
    finalColor = mix(finalColor, baseTexel.xyz, float3(1.0 - fast::clamp((buffer.depthMotionBlur + (buffer.verticalSmear * 0.800000011920928955078125)) + (buffer.filmBloom * 0.300000011920928955078125), 0.0, 1.0)));
    finalColor *= buffer.u_brightness;
    out.gl_FragColor = float4(finalColor, baseTexel.w * buffer.uOpacity);
    return out;
}

