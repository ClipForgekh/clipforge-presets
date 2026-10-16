#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float blurStrength;
    float bandWidth;
    float glowWidth;
    float neonIntensity;
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
    return 1.0 - pow(1.0 - p, 3.0);
}

static inline __attribute__((always_inline))
float revealByLine(thread const float2& uv, thread const float& xPos, thread const float& b, thread const float& softness)
{
    float lineX = (uv.y + xPos) - b;
    return smoothstep(-softness, softness, lineX - uv.x);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 directionalBlur45(thread const float2& uv, thread const float& amount, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 dir = fast::normalize(float2(1.0, 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05)));
    float4 sum = float4(0.0);
    float wsum = 0.0;
    float w0 = 0.180000007152557373046875;
    float w1 = 0.1500000059604644775390625;
    float w2 = 0.119999997317790985107421875;
    float w3 = 0.100000001490116119384765625;
    float w4 = 0.07999999821186065673828125;
    float _101;
    float _110;
    float _119;
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        if (abs(fi) < 0.5)
        {
            _101 = w0;
        }
        else
        {
            if (abs(fi) < 1.5)
            {
                _110 = w1;
            }
            else
            {
                if (abs(fi) < 2.5)
                {
                    _119 = w2;
                }
                else
                {
                    _119 = (abs(fi) < 3.5) ? w3 : w4;
                }
                _110 = _119;
            }
            _101 = _110;
        }
        float w = _101;
        float2 param = uv + ((dir * fi) * amount);
        float2 suv = handleUVBounds(param);
        sum += (tDiffuse.sample(tDiffuseSmplr, suv) * w);
        wsum += w;
    }
    return sum / float4(fast::max(wsum, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float lineDistance(thread const float2& uv, thread const float& xPos, thread const float& b)
{
    float f = uv.y - ((uv.x - xPos) + b);
    return abs(f) * 0.707106769084930419921875;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& blurStrength, constant float& bandWidth, constant float& glowWidth, constant float& neonIntensity)
{
    float x1 = (-1.2000000476837158203125) + (3.099999904632568359375 * pow(p, 0.89999997615814208984375));
    float x2 = (-1.2000000476837158203125) + (3.099999904632568359375 * pow(p, 0.7200000286102294921875));
    float x3 = (-1.2000000476837158203125) + (3.099999904632568359375 * pow(p, 0.87999999523162841796875));
    float b1 = 0.180000007152557373046875;
    float b2 = 0.5;
    float b3 = 0.819999992847442626953125;
    float2 param = vUv;
    float param_1 = x1;
    float param_2 = b1;
    float param_3 = 0.02999999932944774627685546875;
    float r1 = revealByLine(param, param_1, param_2, param_3);
    float2 param_4 = vUv;
    float param_5 = x2;
    float param_6 = b2;
    float param_7 = 0.02999999932944774627685546875;
    float r2 = revealByLine(param_4, param_5, param_6, param_7);
    float2 param_8 = vUv;
    float param_9 = x3;
    float param_10 = b3;
    float param_11 = 0.02999999932944774627685546875;
    float r3 = revealByLine(param_8, param_9, param_10, param_11);
    float reveal = fast::clamp(fast::max(r1, fast::max(r2, r3)), 0.0, 1.0);
    float localBlur = blurStrength * pow(1.0 - reveal, 2.599999904632568359375);
    float2 param_12 = vUv;
    float param_13 = localBlur;
    float4 blurred = directionalBlur45(param_12, param_13, ratio, tDiffuse, tDiffuseSmplr);
    float4 base = mix(float4(0.0, 0.0, 0.0, 1.0), blurred, float4(reveal));
    float2 param_14 = vUv;
    float param_15 = x1;
    float param_16 = b1;
    float d1 = lineDistance(param_14, param_15, param_16);
    float2 param_17 = vUv;
    float param_18 = x2;
    float param_19 = b2;
    float d2 = lineDistance(param_17, param_18, param_19);
    float2 param_20 = vUv;
    float param_21 = x3;
    float param_22 = b3;
    float d3 = lineDistance(param_20, param_21, param_22);
    float core1 = exp((-d1) / fast::max(bandWidth, 9.9999997473787516355514526367188e-05));
    float core2 = exp((-d2) / fast::max(bandWidth, 9.9999997473787516355514526367188e-05));
    float core3 = exp((-d3) / fast::max(bandWidth, 9.9999997473787516355514526367188e-05));
    float glow1 = exp((-d1) / fast::max(glowWidth, 9.9999997473787516355514526367188e-05));
    float glow2 = exp((-d2) / fast::max(glowWidth, 9.9999997473787516355514526367188e-05));
    float glow3 = exp((-d3) / fast::max(glowWidth, 9.9999997473787516355514526367188e-05));
    float3 c1 = float3(1.0, 0.119999997317790985107421875, 0.7200000286102294921875);
    float3 c2 = float3(0.100000001490116119384765625, 0.920000016689300537109375, 1.0);
    float3 c3 = float3(1.0, 0.920000016689300537109375, 0.20000000298023223876953125);
    float neonFade = pow(1.0 - p, 1.14999997615814208984375);
    float3 neon = ((c1 * ((core1 * 0.949999988079071044921875) + (glow1 * 0.449999988079071044921875))) + (c2 * ((core2 * 1.0) + (glow2 * 0.449999988079071044921875)))) + (c3 * ((core3 * 0.949999988079071044921875) + (glow3 * 0.449999988079071044921875)));
    float3 color = base.xyz + ((neon * neonIntensity) * neonFade);
    color = fast::clamp(color, float3(0.0), float3(1.0));
    return float4(color, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, in.vUv, buffer.blurStrength, buffer.bandWidth, buffer.glowWidth, buffer.neonIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

