#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_time;
    float u_bgBlur;
    float u_bgDistort;
    float u_bgChromatic;
    float u_midBlur;
    float u_midDistort;
    float u_midChromatic;
    float u_fgBlur;
    float u_fgDistort;
    float u_fgChromatic;
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
float getLuma(thread const float3& color)
{
    return dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
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
float3 sampleLayer(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurRadius, thread const float& distortStrength, thread const float& chromaticStrength, thread const float& waveSeed, constant float& ratio, constant float& u_time)
{
    float2 center = float2(0.5);
    float2 param = uv;
    float2 aspectUv = getAspectCorrectUV(param, ratio);
    float2 dir = aspectUv - center;
    float dist = length(dir);
    float wave1 = sin(((aspectUv.y + waveSeed) * 18.0) + (u_time * 4.19999980926513671875));
    float wave2 = cos(((aspectUv.x - (waveSeed * 0.699999988079071044921875)) * 15.0) - (u_time * 3.599999904632568359375));
    float wave3 = sin((((aspectUv.x + aspectUv.y) * 12.0) + (u_time * 2.7000000476837158203125)) + (waveSeed * 6.28318023681640625));
    float2 flow = float2(wave1 + wave3, wave2 - wave3) * 0.5;
    float2 distortedUv = fast::clamp(uv + ((flow * distortStrength) * (0.800000011920928955078125 + (dist * 0.699999988079071044921875))), float2(0.0), float2(1.0));
    float blurStep = blurRadius * 0.00120000005699694156646728515625;
    float2 blurVecX = float2(blurStep, 0.0);
    float2 blurVecY = float2(0.0, blurStep / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float2 blurDiagA = float2(blurStep * 0.7070000171661376953125, (blurStep * 0.7070000171661376953125) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float2 blurDiagB = float2((-blurStep) * 0.7070000171661376953125, (blurStep * 0.7070000171661376953125) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float2 chromaDir = fast::normalize(dir + float2(9.9999997473787516355514526367188e-05));
    float2 chromaOffset = (chromaDir * chromaticStrength) * 0.017999999225139617919921875;
    float r = 0.0;
    float g = 0.0;
    float b = 0.0;
    float2 sampleUv = fast::clamp(distortedUv, float2(0.0), float2(1.0));
    r += (tex.sample(texSmplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x * 0.20000000298023223876953125);
    g += (tex.sample(texSmplr, sampleUv).y * 0.20000000298023223876953125);
    b += (tex.sample(texSmplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z * 0.20000000298023223876953125);
    sampleUv = fast::clamp(distortedUv + blurVecX, float2(0.0), float2(1.0));
    r += (tex.sample(texSmplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x * 0.100000001490116119384765625);
    g += (tex.sample(texSmplr, sampleUv).y * 0.100000001490116119384765625);
    b += (tex.sample(texSmplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z * 0.100000001490116119384765625);
    sampleUv = fast::clamp(distortedUv - blurVecX, float2(0.0), float2(1.0));
    r += (tex.sample(texSmplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x * 0.100000001490116119384765625);
    g += (tex.sample(texSmplr, sampleUv).y * 0.100000001490116119384765625);
    b += (tex.sample(texSmplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z * 0.100000001490116119384765625);
    sampleUv = fast::clamp(distortedUv + blurVecY, float2(0.0), float2(1.0));
    r += (tex.sample(texSmplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x * 0.100000001490116119384765625);
    g += (tex.sample(texSmplr, sampleUv).y * 0.100000001490116119384765625);
    b += (tex.sample(texSmplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z * 0.100000001490116119384765625);
    sampleUv = fast::clamp(distortedUv - blurVecY, float2(0.0), float2(1.0));
    r += (tex.sample(texSmplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x * 0.100000001490116119384765625);
    g += (tex.sample(texSmplr, sampleUv).y * 0.100000001490116119384765625);
    b += (tex.sample(texSmplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z * 0.100000001490116119384765625);
    sampleUv = fast::clamp(distortedUv + blurDiagA, float2(0.0), float2(1.0));
    r += (tex.sample(texSmplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x * 0.100000001490116119384765625);
    g += (tex.sample(texSmplr, sampleUv).y * 0.100000001490116119384765625);
    b += (tex.sample(texSmplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z * 0.100000001490116119384765625);
    sampleUv = fast::clamp(distortedUv - blurDiagA, float2(0.0), float2(1.0));
    r += (tex.sample(texSmplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x * 0.100000001490116119384765625);
    g += (tex.sample(texSmplr, sampleUv).y * 0.100000001490116119384765625);
    b += (tex.sample(texSmplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z * 0.100000001490116119384765625);
    sampleUv = fast::clamp(distortedUv + blurDiagB, float2(0.0), float2(1.0));
    r += (tex.sample(texSmplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x * 0.100000001490116119384765625);
    g += (tex.sample(texSmplr, sampleUv).y * 0.100000001490116119384765625);
    b += (tex.sample(texSmplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z * 0.100000001490116119384765625);
    sampleUv = fast::clamp(distortedUv - blurDiagB, float2(0.0), float2(1.0));
    r += (tex.sample(texSmplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x * 0.100000001490116119384765625);
    g += (tex.sample(texSmplr, sampleUv).y * 0.100000001490116119384765625);
    b += (tex.sample(texSmplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z * 0.100000001490116119384765625);
    return float3(r, g, b);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float4 baseTexel = texture1.sample(texture1Smplr, in.vUv);
    float3 param = baseTexel.xyz;
    float luma = getLuma(param);
    float bgMask = 1.0 - smoothstep(0.25, 0.519999980926513671875, luma);
    float fgMask = smoothstep(0.62000000476837158203125, 0.87999999523162841796875, luma);
    float midMask = fast::clamp((1.0 - bgMask) - fgMask, 0.0, 1.0);
    float2 param_1 = in.vUv;
    float param_2 = buffer.u_bgBlur;
    float param_3 = buffer.u_bgDistort;
    float param_4 = buffer.u_bgChromatic;
    float param_5 = 0.17000000178813934326171875;
    float3 bgColor = sampleLayer(texture1, texture1Smplr, param_1, param_2, param_3, param_4, param_5, buffer.ratio, buffer.u_time);
    float2 param_6 = in.vUv;
    float param_7 = buffer.u_midBlur;
    float param_8 = buffer.u_midDistort;
    float param_9 = buffer.u_midChromatic;
    float param_10 = 0.430000007152557373046875;
    float3 midColor = sampleLayer(texture1, texture1Smplr, param_6, param_7, param_8, param_9, param_10, buffer.ratio, buffer.u_time);
    float2 param_11 = in.vUv;
    float param_12 = buffer.u_fgBlur;
    float param_13 = buffer.u_fgDistort;
    float param_14 = buffer.u_fgChromatic;
    float param_15 = 0.790000021457672119140625;
    float3 fgColor = sampleLayer(texture1, texture1Smplr, param_11, param_12, param_13, param_14, param_15, buffer.ratio, buffer.u_time);
    float totalMask = fast::max((bgMask + midMask) + fgMask, 9.9999997473787516355514526367188e-05);
    float3 finalColor = (((bgColor * bgMask) + (midColor * midMask)) + (fgColor * fgMask)) / float3(totalMask);
    float4 texColor = float4(finalColor, baseTexel.w);
    float4 _662 = texColor;
    float3 _664 = _662.xyz * buffer.u_brightness;
    texColor.x = _664.x;
    texColor.y = _664.y;
    texColor.z = _664.z;
    out.gl_FragColor = texColor;
    return out;
}

