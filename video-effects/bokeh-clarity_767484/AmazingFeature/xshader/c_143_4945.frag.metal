#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_bokehDensity;
    float u_bokehSize;
    float u_bokehIntensity;
    float u_grainIntensity;
    float u_bgBlur;
    float u_bgZ;
    float u_midBlur;
    float u_midZ;
    float u_fgBlur;
    float u_fgZ;
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
float4 radialBlurLayer(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, thread const float& depthBias)
{
    float2 center = float2(0.5);
    float2 dir = uv - center;
    float dist = length(dir);
    float2 _135;
    if (dist > 9.9999997473787516355514526367188e-05)
    {
        _135 = fast::normalize(dir);
    }
    else
    {
        _135 = float2(0.0);
    }
    float2 safeDir = _135;
    float blur = blurStrength * (0.0199999995529651641845703125 + (abs(depthBias) * 0.014999999664723873138427734375));
    float4 color = float4(0.0);
    color += (tex.sample(texSmplr, fast::clamp(uv + ((safeDir * blur) * (-1.2000000476837158203125)), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    color += (tex.sample(texSmplr, fast::clamp(uv + ((safeDir * blur) * (-0.800000011920928955078125)), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    color += (tex.sample(texSmplr, fast::clamp(uv + ((safeDir * blur) * (-0.449999988079071044921875)), float2(0.0), float2(1.0))) * 0.1500000059604644775390625);
    color += (tex.sample(texSmplr, fast::clamp(uv + ((safeDir * blur) * 0.0), float2(0.0), float2(1.0))) * 0.300000011920928955078125);
    color += (tex.sample(texSmplr, fast::clamp(uv + ((safeDir * blur) * 0.449999988079071044921875), float2(0.0), float2(1.0))) * 0.1500000059604644775390625);
    color += (tex.sample(texSmplr, fast::clamp(uv + ((safeDir * blur) * 0.800000011920928955078125), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    color += (tex.sample(texSmplr, fast::clamp(uv + ((safeDir * blur) * 1.2000000476837158203125), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    return color;
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
float circleGlow(thread const float2& uv, thread const float2& center, thread const float& radius, thread const float& softness)
{
    float d = length(uv - center);
    return 1.0 - smoothstep(radius, radius + softness, d);
}

static inline __attribute__((always_inline))
float3 generateBokeh(thread const float2& uv, constant float& ratio, constant float& u_bokehDensity, constant float& u_bokehSize, constant float& u_bokehIntensity)
{
    float2 param = uv;
    float2 aspectUV = getAspectCorrectUV(param, ratio);
    float2 center = float2(0.5);
    float2 spreadUv = ((aspectUV - center) * (1.0 + ((1.0 - u_bokehDensity) * 1.25))) + center;
    float3 warmGold = float3(0.8389999866485595703125, 0.70200002193450927734375, 0.41600000858306884765625);
    float3 softBrown = float3(0.4309999942779541015625, 0.384000003337860107421875, 0.333000004291534423828125);
    float3 paleGold = float3(0.902000010013580322265625, 0.842999994754791259765625, 0.72200000286102294921875);
    float s = fast::max(u_bokehSize, 0.0);
    float d = fast::clamp(u_bokehDensity, 0.0, 1.0);
    float accum = 0.0;
    float2 param_1 = spreadUv;
    float2 param_2 = center + float2(-0.180000007152557373046875, 0.100000001490116119384765625);
    float param_3 = 0.180000007152557373046875 * s;
    float param_4 = (0.07999999821186065673828125 * s) + 0.00999999977648258209228515625;
    accum += (circleGlow(param_1, param_2, param_3, param_4) * (0.949999988079071044921875 * d));
    float2 param_5 = spreadUv;
    float2 param_6 = center + float2(0.119999997317790985107421875, 0.0599999986588954925537109375);
    float param_7 = 0.14000000059604644775390625 * s;
    float param_8 = (0.070000000298023223876953125 * s) + 0.00999999977648258209228515625;
    accum += (circleGlow(param_5, param_6, param_7, param_8) * (0.89999997615814208984375 * d));
    float2 param_9 = spreadUv;
    float2 param_10 = center + float2(-0.039999999105930328369140625, -0.119999997317790985107421875);
    float param_11 = 0.1599999964237213134765625 * s;
    float param_12 = (0.07999999821186065673828125 * s) + 0.00999999977648258209228515625;
    accum += (circleGlow(param_9, param_10, param_11, param_12) * (0.85000002384185791015625 * d));
    float2 param_13 = spreadUv;
    float2 param_14 = center + float2(0.20000000298023223876953125, -0.07999999821186065673828125);
    float param_15 = 0.119999997317790985107421875 * s;
    float param_16 = (0.0599999986588954925537109375 * s) + 0.00999999977648258209228515625;
    accum += (circleGlow(param_13, param_14, param_15, param_16) * (0.75 * d));
    float2 param_17 = spreadUv;
    float2 param_18 = center + float2(0.0);
    float param_19 = 0.2199999988079071044921875 * s;
    float param_20 = (0.100000001490116119384765625 * s) + 0.00999999977648258209228515625;
    accum += (circleGlow(param_17, param_18, param_19, param_20) * (1.0 * d));
    float edgeFade = 1.0 - smoothstep(0.0, 0.75, length(aspectUV - center));
    accum *= edgeFade;
    float3 bokehColor = (mix(softBrown, warmGold, float3(0.64999997615814208984375)) * 0.449999988079071044921875) + (paleGold * 0.550000011920928955078125);
    return (bokehColor * accum) * u_bokehIntensity;
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float3 applyFilmGrain(thread const float2& uv, thread const float3& color, constant float& u_grainIntensity)
{
    float2 param = (uv * 500.0) + float2(12.30000019073486328125, 48.700000762939453125);
    float n1 = hash12(param);
    float2 param_1 = (uv * 820.0) + float2(91.09999847412109375, 23.3999996185302734375);
    float n2 = hash12(param_1);
    float grain = (((n1 * 0.60000002384185791015625) + (n2 * 0.4000000059604644775390625)) - 0.5) * 2.0;
    return color + float3((grain * u_grainIntensity) * 0.119999997317790985107421875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float2 param = uv;
    float param_1 = buffer.u_bgBlur;
    float param_2 = buffer.u_bgZ;
    float4 bgColor = radialBlurLayer(texture1, texture1Smplr, param, param_1, param_2);
    float2 param_3 = uv;
    float param_4 = buffer.u_midBlur;
    float param_5 = buffer.u_midZ;
    float4 midColor = radialBlurLayer(texture1, texture1Smplr, param_3, param_4, param_5);
    float2 param_6 = uv;
    float param_7 = buffer.u_fgBlur;
    float param_8 = buffer.u_fgZ;
    float4 fgColor = radialBlurLayer(texture1, texture1Smplr, param_6, param_7, param_8);
    float bgWeight = 1.0 + (abs(buffer.u_bgZ) * 0.3499999940395355224609375);
    float midWeight = 1.0 + (abs(buffer.u_midZ) * 0.1500000059604644775390625);
    float fgWeight = 1.0 + (abs(buffer.u_fgZ) * 0.3499999940395355224609375);
    float weightSum = (bgWeight + midWeight) + fgWeight;
    float4 texColor = (((bgColor * bgWeight) + (midColor * midWeight)) + (fgColor * fgWeight)) / float4(weightSum);
    float2 param_9 = uv;
    float4 _578 = texColor;
    float3 _580 = _578.xyz + generateBokeh(param_9, buffer.ratio, buffer.u_bokehDensity, buffer.u_bokehSize, buffer.u_bokehIntensity);
    texColor.x = _580.x;
    texColor.y = _580.y;
    texColor.z = _580.z;
    float2 param_10 = uv;
    float3 param_11 = texColor.xyz;
    float3 _592 = applyFilmGrain(param_10, param_11, buffer.u_grainIntensity);
    texColor.x = _592.x;
    texColor.y = _592.y;
    texColor.z = _592.z;
    float4 _601 = texColor;
    float3 _603 = _601.xyz * buffer.u_brightness;
    texColor.x = _603.x;
    texColor.y = _603.y;
    texColor.z = _603.z;
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _618 = texColor;
    float3 _625 = mix(_618.xyz, float3(gray), float3(buffer.u_grayscale));
    texColor.x = _625.x;
    texColor.y = _625.y;
    texColor.z = _625.z;
    float2 mappedUv = uv;
    float2 dir = mappedUv - float2(0.5);
    float offset = buffer.u_chromatic * 0.0199999995529651641845703125;
    float r = texture1.sample(texture1Smplr, fast::clamp(mappedUv + (dir * offset), float2(0.0), float2(1.0))).x;
    float g = texColor.y;
    float b = texture1.sample(texture1Smplr, fast::clamp(mappedUv - (dir * offset), float2(0.0), float2(1.0))).z;
    float3 chromaColor = float3(r, g, b);
    float4 _673 = texColor;
    float3 _679 = mix(_673.xyz, chromaColor, float3(fast::clamp(buffer.u_chromatic, 0.0, 1.0)));
    texColor.x = _679.x;
    texColor.y = _679.y;
    texColor.z = _679.z;
    out.gl_FragColor = float4(fast::clamp(texColor.xyz, float3(0.0), float3(1.0)), 1.0);
    return out;
}

