#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float shakeFrequency;
    float shakeSpeed;
    float shakeIntensity;
    float2 shakeDirection;
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
float2 random2(thread const float& x)
{
    return float2(fract(sin(x * 12.98980045318603515625) * 43758.546875), fract(sin(x * 78.233001708984375) * 43758.546875));
}

static inline __attribute__((always_inline))
float2 getShakeOffset(thread const float& time, constant float& shakeFrequency, constant float& shakeSpeed, constant float& shakeIntensity, constant float2& shakeDirection, constant float& progress)
{
    float t1 = (time * shakeFrequency) * shakeSpeed;
    float param = floor(t1);
    float2 shake1 = (random2(param) - float2(0.5)) * 2.0;
    float t2 = ((time * shakeFrequency) * shakeSpeed) * 2.5;
    float param_1 = floor(t2);
    float2 shake2 = (random2(param_1) - float2(0.5)) * 0.5;
    float t3 = ((time * shakeFrequency) * shakeSpeed) * 5.0;
    float param_2 = floor(t3);
    float2 shake3 = (random2(param_2) - float2(0.5)) * 0.20000000298023223876953125;
    float2 totalShake = (shake1 + shake2) + shake3;
    return ((totalShake * shakeIntensity) * shakeDirection) * progress;
}

static inline __attribute__((always_inline))
float4 textureSafe(texture2d<float> tex, sampler texSmplr, thread float2& uv)
{
    uv = fast::clamp(uv, float2(0.0), float2(1.0));
    float4 _123 = tex.sample(texSmplr, uv);
    return _123;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float time = buffer.progress * 10.0;
    float param = time;
    float2 shakeOffset = getShakeOffset(param, buffer.shakeFrequency, buffer.shakeSpeed, buffer.shakeIntensity, buffer.shakeDirection, buffer.progress);
    float2 shakenUv = uv + shakeOffset;
    float2 param_1 = shakenUv;
    float4 _147 = textureSafe(tDiffuse, tDiffuseSmplr, param_1);
    float4 color = _147;
    out.gl_FragColor = color;
    return out;
}

