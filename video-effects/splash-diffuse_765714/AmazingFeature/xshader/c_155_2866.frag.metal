#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_watercolorAmount;
    float u_radialBlur;
    float u_ringRadius;
    float3 u_ringColor;
    float u_ringAlpha;
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
float hash(thread const float2& p)
{
    return fract(sin(dot(p, float2(127.09999847412109375, 311.70001220703125))) * 43758.546875);
}

static inline __attribute__((always_inline))
float _noise(thread const float2& p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    float2 param = i;
    float a = hash(param);
    float2 param_1 = i + float2(1.0, 0.0);
    float b = hash(param_1);
    float2 param_2 = i + float2(0.0, 1.0);
    float c = hash(param_2);
    float2 param_3 = i + float2(1.0);
    float d = hash(param_3);
    float2 u = (f * f) * (float2(3.0) - (f * 2.0));
    return (mix(a, b, u.x) + (((c - a) * u.y) * (1.0 - u.x))) + (((d - b) * u.x) * u.y);
}

static inline __attribute__((always_inline))
float4 radialBlurSample(thread const float2& uv, thread const float2& center, thread const float& strength, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 dir = uv - center;
    float dist = length(dir);
    float2 _161;
    if (dist > 9.9999997473787516355514526367188e-05)
    {
        _161 = dir / float2(dist);
    }
    else
    {
        _161 = float2(0.0);
    }
    float2 nd = _161;
    float4 col = float4(0.0);
    float total = 0.0;
    for (int i = 0; i < 10; i++)
    {
        float t = float(i) / 9.0;
        float w = 1.0 - t;
        float2 sampleUv = uv - (((nd * t) * strength) * 0.3499999940395355224609375);
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        col += (texture1.sample(texture1Smplr, sampleUv) * w);
        total += w;
    }
    return col / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 center = float2(0.5);
    float2 param = in.vUv;
    float2 uvAspect = getAspectCorrectUV(param, buffer.ratio);
    float2 param_1 = center;
    float2 centerAspect = getAspectCorrectUV(param_1, buffer.ratio);
    float d = length(uvAspect - centerAspect);
    float wc = buffer.u_watercolorAmount;
    float2 param_2 = (in.vUv * 18.0) + float2(1.7000000476837158203125);
    float2 param_3 = (in.vUv * 18.0) + float2(8.30000019073486328125);
    float2 wcOffset = float2(_noise(param_2) - 0.5, _noise(param_3) - 0.5) * (0.0350000001490116119384765625 * wc);
    float2 mappedUv = fast::clamp(in.vUv + wcOffset, float2(0.0), float2(1.0));
    float2 param_4 = mappedUv;
    float2 param_5 = center;
    float param_6 = buffer.u_radialBlur;
    float4 baseColor = radialBlurSample(param_4, param_5, param_6, texture1, texture1Smplr);
    float2 param_7 = (in.vUv * 24.0) + float2(3.099999904632568359375);
    float edgeNoise = (_noise(param_7) - 0.5) * (0.07999999821186065673828125 + (wc * 0.180000007152557373046875));
    float ringDist = abs((d - buffer.u_ringRadius) + edgeNoise);
    float ringWidth = 0.017999999225139617919921875 + (wc * 0.02999999932944774627685546875);
    float ringMask = 1.0 - smoothstep(ringWidth, ringWidth * 2.400000095367431640625, ringDist);
    float2 param_8 = (in.vUv * 16.0) + float2(11.69999980926513671875);
    float pigment = smoothstep(0.0, 1.0, wc) * (0.3499999940395355224609375 + (0.64999997615814208984375 * _noise(param_8)));
    float3 watercolorTint = mix(baseColor.xyz, baseColor.xyz * float3(0.939999997615814208984375, 0.980000019073486328125, 1.019999980926513671875), float3(pigment * 0.2199999988079071044921875));
    float3 ringAdd = ((buffer.u_ringColor * ringMask) * buffer.u_ringAlpha) * (1.0 + (wc * 0.64999997615814208984375));
    float3 finalColor = watercolorTint + ringAdd;
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

