#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float2 uvScale;
    float2 uvOffset;
    float u_blurRadiusPx;
    float u_fogOcclusion;
    float u_exposureGain;
    float u_bokehOverlayStrength;
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
float4 blur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float2& resolution, thread const float& radiusPx)
{
    float2 texel = float2(1.0) / resolution;
    float2 offset = (texel * radiusPx) * 0.3499999940395355224609375;
    float4 color = float4(0.0);
    color += (tex.sample(texSmplr, uv) * 0.227026998996734619140625);
    color += (tex.sample(texSmplr, (uv + float2(offset.x, 0.0))) * 0.19459460675716400146484375);
    color += (tex.sample(texSmplr, (uv - float2(offset.x, 0.0))) * 0.19459460675716400146484375);
    color += (tex.sample(texSmplr, (uv + float2(0.0, offset.y))) * 0.121621601283550262451171875);
    color += (tex.sample(texSmplr, (uv - float2(0.0, offset.y))) * 0.121621601283550262451171875);
    color += (tex.sample(texSmplr, (uv + offset)) * 0.054053999483585357666015625);
    color += (tex.sample(texSmplr, (uv - offset)) * 0.054053999483585357666015625);
    color += (tex.sample(texSmplr, (uv + float2(offset.x, -offset.y))) * 0.01621600054204463958740234375);
    color += (tex.sample(texSmplr, (uv + float2(-offset.x, offset.y))) * 0.01621600054204463958740234375);
    return color;
}

static inline __attribute__((always_inline))
float softBokeh(thread const float2& uv, thread const float2& center, thread const float& radiusValue)
{
    float d = length(uv - center);
    return 1.0 - smoothstep(radiusValue * 0.3499999940395355224609375, radiusValue, d);
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 345.45001220703125));
    p += float2(dot(p, p + float2(34.345001220703125)));
    return fract(p.x * p.y);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.uvScale) + buffer.uvOffset;
    float2 param = mappedUv;
    float2 aspectUv = getAspectCorrectUV(param, buffer.ratio);
    float2 resolution = float2(600.0, 600.0 / fast::max(buffer.ratio, 9.9999997473787516355514526367188e-05));
    float4 clearTexel = texture1.sample(texture1Smplr, mappedUv);
    float2 param_1 = mappedUv;
    float2 param_2 = resolution;
    float param_3 = buffer.u_blurRadiusPx;
    float4 blurredTexel = blur9(texture1, texture1Smplr, param_1, param_2, param_3);
    float3 baseColor = mix(clearTexel.xyz, blurredTexel.xyz, float3(fast::clamp(buffer.u_blurRadiusPx / 30.0, 0.0, 1.0)));
    float2 param_4 = aspectUv;
    float2 param_5 = float2(0.5);
    float param_6 = 0.550000011920928955078125;
    float centerGlow = softBokeh(param_4, param_5, param_6);
    float2 param_7 = aspectUv;
    float2 param_8 = float2(0.3400000035762786865234375, 0.63999998569488525390625);
    float param_9 = 0.2199999988079071044921875;
    float2 param_10 = aspectUv;
    float2 param_11 = float2(0.680000007152557373046875, 0.37999999523162841796875);
    float param_12 = 0.180000007152557373046875;
    float2 param_13 = aspectUv;
    float2 param_14 = float2(0.519999980926513671875);
    float param_15 = 0.300000011920928955078125;
    float ringGlow = ((softBokeh(param_7, param_8, param_9) * 0.550000011920928955078125) + (softBokeh(param_10, param_11, param_12) * 0.449999988079071044921875)) + (softBokeh(param_13, param_14, param_15) * 0.4000000059604644775390625);
    float2 param_16 = floor(mappedUv * 28.0);
    float _321 = hash21(param_16);
    float _noise = _321 * 0.119999997317790985107421875;
    float fogMask = fast::clamp(((centerGlow * 0.800000011920928955078125) + ringGlow) + _noise, 0.0, 1.0) * buffer.u_fogOcclusion;
    float3 fogColor = float3(0.85000002384185791015625, 0.920000016689300537109375, 1.0) * (0.85000002384185791015625 + (buffer.u_exposureGain * 0.300000011920928955078125));
    float3 mixedColor = mix(baseColor, fogColor, float3(fogMask * 0.85000002384185791015625));
    float overlay = fast::clamp(((centerGlow * 0.699999988079071044921875) + (ringGlow * 1.14999997615814208984375)) * buffer.u_bokehOverlayStrength, 0.0, 1.0);
    mixedColor += ((float3(0.7200000286102294921875, 0.819999992847442626953125, 1.0) * overlay) * 0.75);
    mixedColor += ((float3(1.0) * buffer.u_exposureGain) * 0.2199999988079071044921875);
    mixedColor *= buffer.u_brightness;
    out.gl_FragColor = float4(fast::clamp(mixedColor, float3(0.0), float3(1.0)), clearTexel.w);
    return out;
}

