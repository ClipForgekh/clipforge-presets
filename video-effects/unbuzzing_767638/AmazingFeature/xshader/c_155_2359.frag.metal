#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL radians() function
template<typename T>
inline T radians(T d)
{
    return d * T(0.01745329251);
}

struct buffer_t
{
    float u_stripSwingDeg;
    float2 uvScale;
    float2 uvOffset;
    float u_chromaticOffsetRG;
    float u_verticalBlur;
    float u_time;
    float u_scanlineSpeed;
    float u_scanlineIntensity;
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
float2 rotateAroundCenter(thread const float2& uv, thread const float& angle)
{
    float2 centered = uv - float2(0.5);
    float s = sin(angle);
    float c = cos(angle);
    centered = float2x2(float2(c, -s), float2(s, c)) * centered;
    return centered + float2(0.5);
}

static inline __attribute__((always_inline))
float4 sampleVerticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurAmount)
{
    float blurRadius = 0.180000007152557373046875 * blurAmount;
    float4 color = float4(0.0);
    float weightSum = 0.0;
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        float w = 1.0 - (abs(fi) / 5.0);
        float2 sampleUv = uv + float2(0.0, (blurRadius * fi) * 0.119999997317790985107421875);
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        color += (tex.sample(texSmplr, sampleUv) * w);
        weightSum += w;
    }
    return color / float4(fast::max(weightSum, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float angle = radians(buffer.u_stripSwingDeg);
    float2 param = in.vUv;
    float param_1 = angle;
    float2 swungUv = rotateAroundCenter(param, param_1);
    float2 mappedUv = (swungUv * buffer.uvScale) + buffer.uvOffset;
    mappedUv = fast::clamp(mappedUv, float2(0.0), float2(1.0));
    float2 dir = mappedUv - float2(0.5);
    float offsetAmount = buffer.u_chromaticOffsetRG * 0.0199999995529651641845703125;
    float2 param_2 = mappedUv;
    float param_3 = buffer.u_verticalBlur;
    float4 blurredCenter = sampleVerticalBlur(texture1, texture1Smplr, param_2, param_3);
    float2 param_4 = fast::clamp(mappedUv + (dir * offsetAmount), float2(0.0), float2(1.0));
    float param_5 = buffer.u_verticalBlur;
    float r = sampleVerticalBlur(texture1, texture1Smplr, param_4, param_5).x;
    float g = blurredCenter.y;
    float2 param_6 = fast::clamp(mappedUv - ((dir * offsetAmount) * 0.60000002384185791015625), float2(0.0), float2(1.0));
    float param_7 = buffer.u_verticalBlur;
    float b = sampleVerticalBlur(texture1, texture1Smplr, param_6, param_7).z;
    float3 crtColor = float3(r, g, b);
    float scanPhase = (in.vUv.y * 320.0) - ((buffer.u_time * buffer.u_scanlineSpeed) * 20.0);
    float scanBand = 0.5 + (0.5 * sin(scanPhase));
    float scanMask = mix(1.0, 0.550000011920928955078125 + (0.449999988079071044921875 * scanBand), buffer.u_scanlineIntensity);
    float noiseLine = step(0.5, fract((in.vUv.y * 220.0) - ((buffer.u_time * buffer.u_scanlineSpeed) * 8.0)));
    float bwMix = (0.119999997317790985107421875 * buffer.u_scanlineIntensity) * noiseLine;
    float gray = dot(crtColor, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    crtColor = mix(crtColor, float3(gray), float3(bwMix));
    crtColor *= scanMask;
    out.gl_FragColor = float4(crtColor, 1.0);
    return out;
}

