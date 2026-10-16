#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float layerFrontBlur;
    float layerFrontOffsetY;
    float layerMidBlur;
    float layerMidOffsetY;
    float layerBackBlur;
    float layerBackOffsetY;
    float goldExposure;
    float vignette;
    float u_timeSeed;
    float filmGrain;
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

static inline __attribute__((always_inline))
float4 sampleVerticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius, thread const float& offsetY)
{
    float2 baseUv = fast::clamp(float2(uv.x, uv.y + offsetY), float2(0.0), float2(1.0));
    if (radius <= 0.001000000047497451305389404296875)
    {
        return tex.sample(texSmplr, baseUv);
    }
    float px = radius / 1024.0;
    float4 color = float4(0.0);
    float weightSum = 0.0;
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    float2 stepVec = float2(0.0, px);
    color += (tex.sample(texSmplr, fast::clamp(baseUv, float2(0.0), float2(1.0))) * w0);
    weightSum += w0;
    color += (tex.sample(texSmplr, fast::clamp(baseUv + (stepVec * 1.0), float2(0.0), float2(1.0))) * w1);
    color += (tex.sample(texSmplr, fast::clamp(baseUv - (stepVec * 1.0), float2(0.0), float2(1.0))) * w1);
    weightSum += (w1 * 2.0);
    color += (tex.sample(texSmplr, fast::clamp(baseUv + (stepVec * 2.0), float2(0.0), float2(1.0))) * w2);
    color += (tex.sample(texSmplr, fast::clamp(baseUv - (stepVec * 2.0), float2(0.0), float2(1.0))) * w2);
    weightSum += (w2 * 2.0);
    color += (tex.sample(texSmplr, fast::clamp(baseUv + (stepVec * 3.0), float2(0.0), float2(1.0))) * w3);
    color += (tex.sample(texSmplr, fast::clamp(baseUv - (stepVec * 3.0), float2(0.0), float2(1.0))) * w3);
    weightSum += (w3 * 2.0);
    color += (tex.sample(texSmplr, fast::clamp(baseUv + (stepVec * 4.0), float2(0.0), float2(1.0))) * w4);
    color += (tex.sample(texSmplr, fast::clamp(baseUv - (stepVec * 4.0), float2(0.0), float2(1.0))) * w4);
    weightSum += (w4 * 2.0);
    return color / float4(fast::max(weightSum, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float2 getAspectCorrectUV(thread const float2& uv, constant float& ratio)
{
    float2 aspectUV = uv;
    if (ratio > 1.0)
    {
        aspectUV.y /= ratio;
        aspectUV.y += ((1.0 - (1.0 / ratio)) * 0.5);
    }
    else
    {
        aspectUV.x *= ratio;
        aspectUV.x += ((1.0 - ratio) * 0.5);
    }
    return aspectUV;
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
    float param_1 = buffer.layerFrontBlur;
    float param_2 = buffer.layerFrontOffsetY;
    float4 frontColor = sampleVerticalBlur(texture1, texture1Smplr, param, param_1, param_2);
    float2 param_3 = uv;
    float param_4 = buffer.layerMidBlur;
    float param_5 = buffer.layerMidOffsetY;
    float4 midColor = sampleVerticalBlur(texture1, texture1Smplr, param_3, param_4, param_5);
    float2 param_6 = uv;
    float param_7 = buffer.layerBackBlur;
    float param_8 = buffer.layerBackOffsetY;
    float4 backColor = sampleVerticalBlur(texture1, texture1Smplr, param_6, param_7, param_8);
    float4 texColor = ((backColor * 0.300000011920928955078125) + (midColor * 0.4000000059604644775390625)) + (frontColor * 0.300000011920928955078125);
    float3 warmGold = float3(0.839215695858001708984375, 0.7019608020782470703125, 0.415686309337615966796875);
    float exposureLift = fast::max(buffer.goldExposure - 1.0, 0.0);
    float4 _327 = texColor;
    float4 _329 = texColor;
    float3 _340 = mix(_327.xyz, (_329.xyz * warmGold) * buffer.goldExposure, float3(fast::clamp(exposureLift * 0.89999997615814208984375, 0.0, 1.0)));
    texColor.x = _340.x;
    texColor.y = _340.y;
    texColor.z = _340.z;
    float4 _349 = texColor;
    float3 _351 = _349.xyz * buffer.goldExposure;
    texColor.x = _351.x;
    texColor.y = _351.y;
    texColor.z = _351.z;
    float2 param_9 = uv;
    float2 aspectUv = getAspectCorrectUV(param_9, buffer.ratio);
    float2 centered = aspectUv - float2(0.5);
    float dist = length(centered);
    float vignetteMask = smoothstep(0.2199999988079071044921875, 0.819999992847442626953125, dist);
    float4 _379 = texColor;
    float3 _381 = _379.xyz * (1.0 - (buffer.vignette * vignetteMask));
    texColor.x = _381.x;
    texColor.y = _381.y;
    texColor.z = _381.z;
    float2 param_10 = (uv * float2(517.0, 389.0)) + float2(buffer.u_timeSeed * 0.0130000002682209014892578125, buffer.u_timeSeed * 0.02099999971687793731689453125);
    float grain = random(param_10) - 0.5;
    float4 _410 = texColor;
    float3 _413 = _410.xyz + float3(grain * buffer.filmGrain);
    texColor.x = _413.x;
    texColor.y = _413.y;
    texColor.z = _413.z;
    float4 _422 = texColor;
    float3 _424 = _422.xyz * buffer.u_brightness;
    texColor.x = _424.x;
    texColor.y = _424.y;
    texColor.z = _424.z;
    out.gl_FragColor = float4(fast::clamp(texColor.xyz, float3(0.0), float3(1.0)), 1.0);
    return out;
}

