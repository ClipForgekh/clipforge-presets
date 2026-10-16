#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float pullStrength;
    float slideUp;
    float blurMax;
    float warmStrength;
    float grainStart;
    float progress;
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
float tween(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 2.0);
}

static inline __attribute__((always_inline))
float layerWindow(thread const float& p, thread const float& s, thread const float& e)
{
    float a = smoothstep(s, e, p);
    float b = 1.0 - smoothstep(e, fast::min(1.0, e + 0.2199999988079071044921875), p);
    return a * b;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& amount)
{
    float2 off = float2(0.0, amount);
    float4 c = float4(0.0);
    float2 param = uv - (off * 4.0);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.0599999986588954925537109375);
    float2 param_1 = uv - (off * 3.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.0900000035762786865234375);
    float2 param_2 = uv - (off * 2.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.119999997317790985107421875);
    float2 param_3 = uv - (off * 1.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.1500000059604644775390625);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.1599999964237213134765625);
    float2 param_5 = uv + (off * 1.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.1500000059604644775390625);
    float2 param_6 = uv + (off * 2.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.119999997317790985107421875);
    float2 param_7 = uv + (off * 3.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.0900000035762786865234375);
    float2 param_8 = uv + (off * 4.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.0599999986588954925537109375);
    return c;
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 345.45001220703125));
    p += float2(dot(p, p + float2(34.345001220703125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& pullStrength, constant float& slideUp, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& blurMax, constant float& warmStrength, constant float& grainStart)
{
    float inv = 1.0 - p;
    float bgBlurF = 1.0 - smoothstep(0.0, 0.449999988079071044921875, p);
    float mdBlurF = 1.0 - smoothstep(0.20000000298023223876953125, 0.75, p);
    float fgBlurF = 1.0 - smoothstep(0.449999988079071044921875, 1.0, p);
    float param = p;
    float param_1 = 0.0199999995529651641845703125;
    float param_2 = 0.4199999868869781494140625;
    float bgW = layerWindow(param, param_1, param_2);
    float param_3 = p;
    float param_4 = 0.2199999988079071044921875;
    float param_5 = 0.7200000286102294921875;
    float mdW = layerWindow(param_3, param_4, param_5);
    float param_6 = p;
    float param_7 = 0.4799999892711639404296875;
    float param_8 = 0.980000019073486328125;
    float fgW = layerWindow(param_6, param_7, param_8);
    float zBg = 1.0 + (pullStrength * bgW);
    float zMd = 1.0 + ((pullStrength * 0.75) * mdW);
    float zFg = 1.0 + ((pullStrength * 0.550000011920928955078125) * fgW);
    float yBg = (-slideUp) * bgW;
    float yMd = (-slideUp) * mdW;
    float yFg = (-slideUp) * fgW;
    float2 uvBg = (float2(0.5) + ((vUv - float2(0.5)) * zBg)) + float2(0.0, yBg);
    float2 uvMd = (float2(0.5) + ((vUv - float2(0.5)) * zMd)) + float2(0.0, yMd);
    float2 uvFg = (float2(0.5) + ((vUv - float2(0.5)) * zFg)) + float2(0.0, yFg);
    float2 param_9 = uvBg;
    uvBg = handleUVBounds(param_9);
    float2 param_10 = uvMd;
    uvMd = handleUVBounds(param_10);
    float2 param_11 = uvFg;
    uvFg = handleUVBounds(param_11);
    float2 param_12 = uvBg;
    float param_13 = blurMax * bgBlurF;
    float4 colBg = verticalBlur(tDiffuse, tDiffuseSmplr, param_12, param_13);
    float2 param_14 = uvMd;
    float param_15 = (blurMax * 0.75) * mdBlurF;
    float4 colMd = verticalBlur(tDiffuse, tDiffuseSmplr, param_14, param_15);
    float2 param_16 = uvFg;
    float param_17 = (blurMax * 0.5) * fgBlurF;
    float4 colFg = verticalBlur(tDiffuse, tDiffuseSmplr, param_16, param_17);
    float luma = dot(texel.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float center = 1.0 - fast::clamp(length(vUv - float2(0.5)) * 1.7999999523162841796875, 0.0, 1.0);
    float fgMask = smoothstep(0.519999980926513671875, 0.949999988079071044921875, luma) * smoothstep(0.20000000298023223876953125, 0.949999988079071044921875, center);
    float mdMask = smoothstep(0.2199999988079071044921875, 0.75, luma) * (1.0 - (fgMask * 0.699999988079071044921875));
    float bgMask = fast::clamp((1.0 - fgMask) - mdMask, 0.0, 1.0);
    float sumMask = fast::max((fgMask + mdMask) + bgMask, 9.9999997473787516355514526367188e-05);
    fgMask /= sumMask;
    mdMask /= sumMask;
    bgMask /= sumMask;
    float4 layered = ((colBg * bgMask) + (colMd * mdMask)) + (colFg * fgMask);
    float warm = warmStrength * inv;
    float3 warmTint = float3(1.10000002384185791015625, 1.0299999713897705078125, 0.89999997615814208984375);
    float4 _439 = layered;
    float4 _441 = layered;
    float3 _447 = mix(_439.xyz, _441.xyz * warmTint, float3(warm));
    layered.x = _447.x;
    layered.y = _447.y;
    layered.z = _447.z;
    float grainAmount = grainStart * inv;
    float2 param_18 = (vUv * float2(1280.0, 720.0)) + float2(p * 13.1700000762939453125);
    float _472 = hash21(param_18);
    float g = _472 - 0.5;
    float4 _477 = layered;
    float3 _480 = _477.xyz + float3(g * grainAmount);
    layered.x = _480.x;
    layered.y = _480.y;
    layered.z = _480.z;
    float4 _487 = layered;
    float3 _491 = fast::clamp(_487.xyz, float3(0.0), float3(1.0));
    layered.x = _491.x;
    layered.y = _491.y;
    layered.z = _491.z;
    return float4(layered.xyz, texel.w);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float param = effectProgress;
    effectProgress = tween(param);
    float4 param_1 = texel;
    float param_2 = effectProgress;
    float4 effectColor = effect(param_1, param_2, buffer.pullStrength, buffer.slideUp, in.vUv, tDiffuse, tDiffuseSmplr, buffer.blurMax, buffer.warmStrength, buffer.grainStart);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

