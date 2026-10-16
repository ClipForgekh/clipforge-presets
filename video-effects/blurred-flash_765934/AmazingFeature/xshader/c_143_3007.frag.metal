#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float u_verticalBlurPx;
    float u_exposureGain;
    float u_flashOpacity;
    float u_brightness;
    float u_grayscale;
    float u_chromatic;
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
float4 sampleVerticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurPx, constant float2& u_resolution)
{
    float texelY = 1.0 / fast::max(u_resolution.y, 1.0);
    float radius = blurPx * texelY;
    float4 color = float4(0.0);
    float total = 0.0;
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    color += (tex.sample(texSmplr, fast::clamp(uv, float2(0.0), float2(1.0))) * w0);
    total += w0;
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, radius * 1.0), float2(0.0), float2(1.0))) * w1);
    color += (tex.sample(texSmplr, fast::clamp(uv - float2(0.0, radius * 1.0), float2(0.0), float2(1.0))) * w1);
    total += (w1 * 2.0);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, radius * 2.0), float2(0.0), float2(1.0))) * w2);
    color += (tex.sample(texSmplr, fast::clamp(uv - float2(0.0, radius * 2.0), float2(0.0), float2(1.0))) * w2);
    total += (w2 * 2.0);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, radius * 3.0), float2(0.0), float2(1.0))) * w3);
    color += (tex.sample(texSmplr, fast::clamp(uv - float2(0.0, radius * 3.0), float2(0.0), float2(1.0))) * w3);
    total += (w3 * 2.0);
    color += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, radius * 4.0), float2(0.0), float2(1.0))) * w4);
    color += (tex.sample(texSmplr, fast::clamp(uv - float2(0.0, radius * 4.0), float2(0.0), float2(1.0))) * w4);
    total += (w4 * 2.0);
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float getFlashMask(thread const float2& uv)
{
    float2 p = uv - float2(0.5);
    float radial = exp((-dot(p, p)) * 10.0);
    float verticalBand = smoothstep(0.449999988079071044921875, 0.0, abs(p.y));
    float horizontalBand = smoothstep(0.550000011920928955078125, 0.0, abs(p.x));
    float streak = fast::max(verticalBand * 0.60000002384185791015625, horizontalBand * 0.3499999940395355224609375);
    return fast::clamp((radial * 0.75) + streak, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& baseColor, thread const float3& blendColor)
{
    return float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - blendColor));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = in.vUv;
    float2 param = mappedUv;
    float param_1 = buffer.u_verticalBlurPx;
    float4 texColor = sampleVerticalBlur(texture1, texture1Smplr, param, param_1, buffer.u_resolution);
    float4 _280 = texColor;
    float3 _282 = _280.xyz * buffer.u_exposureGain;
    texColor.x = _282.x;
    texColor.y = _282.y;
    texColor.z = _282.z;
    float2 param_2 = mappedUv;
    float flashMask = getFlashMask(param_2) * buffer.u_flashOpacity;
    float3 flashColor = float3(1.0) * flashMask;
    float3 param_3 = texColor.xyz;
    float3 param_4 = flashColor;
    float3 _306 = screenBlend(param_3, param_4);
    texColor.x = _306.x;
    texColor.y = _306.y;
    texColor.z = _306.z;
    float4 _315 = texColor;
    float3 _317 = _315.xyz * buffer.u_brightness;
    texColor.x = _317.x;
    texColor.y = _317.y;
    texColor.z = _317.z;
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _332 = texColor;
    float3 _339 = mix(_332.xyz, float3(gray), float3(buffer.u_grayscale));
    texColor.x = _339.x;
    texColor.y = _339.y;
    texColor.z = _339.z;
    float2 dir = mappedUv - float2(0.5);
    float offset = buffer.u_chromatic * 0.0199999995529651641845703125;
    float r = texture1.sample(texture1Smplr, fast::clamp(mappedUv + (dir * offset), float2(0.0), float2(1.0))).x;
    float g = texColor.y;
    float b = texture1.sample(texture1Smplr, fast::clamp(mappedUv - (dir * offset), float2(0.0), float2(1.0))).z;
    float3 chromaColor = float3(r, g, b);
    out.gl_FragColor = float4(mix(texColor.xyz, chromaColor, float3(step(9.9999997473787516355514526367188e-05, buffer.u_chromatic))), 1.0);
    return out;
}

