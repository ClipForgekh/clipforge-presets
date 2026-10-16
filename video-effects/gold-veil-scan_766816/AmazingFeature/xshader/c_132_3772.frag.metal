#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float blurMax;
    float sweepWidth;
    float particleStrength;
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
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 blur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius, constant float& ratio)
{
    if (radius <= 9.9999997473787516355514526367188e-06)
    {
        float4 _83 = tex.sample(texSmplr, uv);
        return _83;
    }
    float2 stepUV = float2(radius, radius / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param = uv + (stepUV * float2(-1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 1.0);
    float2 param_1 = uv + (stepUV * float2(0.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 2.0);
    float2 param_2 = uv + (stepUV * float2(1.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 1.0);
    float2 param_3 = uv + (stepUV * float2(-1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 2.0);
    float2 param_4 = uv + (stepUV * float2(0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 4.0);
    float2 param_5 = uv + (stepUV * float2(1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 2.0);
    float2 param_6 = uv + (stepUV * float2(-1.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 1.0);
    float2 param_7 = uv + (stepUV * float2(0.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 2.0);
    float2 param_8 = uv + (stepUV * float2(1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 1.0);
    return c / float4(16.0);
}

static inline __attribute__((always_inline))
float hash11(thread const float& n)
{
    return fract(sin(n * 127.09999847412109375) * 43758.546875);
}

static inline __attribute__((always_inline))
float hash21(thread const float2& p)
{
    return fract(sin(dot(p, float2(127.09999847412109375, 311.70001220703125))) * 43758.546875);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& blurMax, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& sweepWidth, constant float& particleStrength)
{
    float eased = fast::clamp(p, 0.0, 1.0);
    float strength = 1.0 - eased;
    float reveal = eased;
    float blurAmount = blurMax * strength;
    float2 param = vUv;
    float param_1 = blurAmount;
    float4 base = blur9(tDiffuse, tDiffuseSmplr, param, param_1, ratio) * reveal;
    float head = (-0.20000000298023223876953125) + (1.39999997615814208984375 * eased);
    float spread = sweepWidth * (0.64999997615814208984375 + (0.3499999940395355224609375 * (1.0 - (abs(eased - 0.3499999940395355224609375) / 0.3499999940395355224609375))));
    float envelope = pow(strength, 1.14999997615814208984375) * particleStrength;
    float3 gold = float3(1.0, 0.7799999713897705078125, 0.3499999940395355224609375);
    float3 warm = float3(1.0, 0.920000016689300537109375, 0.699999988079071044921875);
    float particles = 0.0;
    for (int i = 0; i < 24; i++)
    {
        float fi = float(i);
        float param_2 = fi + 1.230000019073486328125;
        float r1 = hash11(param_2);
        float param_3 = (fi * 2.71000003814697265625) + 4.559999942779541015625;
        float r2 = hash11(param_3);
        float param_4 = (fi * 5.13000011444091796875) + 7.889999866485595703125;
        float r3 = hash11(param_4);
        float param_5 = (fi * 9.1700000762939453125) + 2.3399999141693115234375;
        float r4 = hash11(param_5);
        float x = (head + ((r1 - 0.5) * spread)) + ((1.0 - eased) * (0.119999997317790985107421875 + (0.119999997317790985107421875 * r2)));
        float y = r2;
        y += (((r3 - 0.5) * 0.180000007152557373046875) * (1.0 - eased));
        y += (((1.0 - eased) * 0.07999999821186065673828125) * (0.5 + r4));
        float2 pos = float2(x, y);
        float2 d = vUv - pos;
        if (ratio > 1.0)
        {
            d.y /= ratio;
        }
        else
        {
            d.x *= ratio;
        }
        float rad = mix(0.0030000000260770320892333984375, 0.017999999225139617919921875, r3) * (0.75 + (0.25 * strength));
        float g = exp((-dot(d, d)) / fast::max(rad * rad, 9.9999999747524270787835121154785e-07));
        float2 param_6 = float2(fi, floor(eased * 10.0));
        float sparkle = 0.60000002384185791015625 + (0.4000000059604644775390625 * hash21(param_6));
        particles += (g * sparkle);
    }
    particles *= ((envelope / 24.0) * 7.5);
    float streak = smoothstep(0.0, 1.0, 1.0 - (abs(vUv.x - head) / fast::max(spread, 0.001000000047497451305389404296875)));
    streak *= (0.3499999940395355224609375 * envelope);
    float3 glow = (((gold * particles) * 1.5) + ((warm * (particles * particles)) * 0.60000002384185791015625)) + (gold * streak);
    float3 outColor = base.xyz + glow;
    outColor = fast::clamp(outColor, float3(0.0), float3(1.0));
    return float4(outColor, 1.0);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.blurMax, tDiffuse, tDiffuseSmplr, in.vUv, buffer.sweepWidth, buffer.particleStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

