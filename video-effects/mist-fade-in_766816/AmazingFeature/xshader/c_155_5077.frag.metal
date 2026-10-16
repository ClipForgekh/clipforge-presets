#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_glowIntensity;
    float u_flowProgress;
    float u_particleAlpha;
    float3 u_color2;
    float3 u_color1;
    float3 u_highlightColor;
    float u_textureAlpha;
    float3 u_bgColor;
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
float2x2 rot(thread const float& a)
{
    float s = sin(a);
    float c = cos(a);
    return float2x2(float2(c, -s), float2(s, c));
}

static inline __attribute__((always_inline))
float2 swirlWarp(thread const float2& uv, thread const float& progress)
{
    float2 center = float2(0.519999980926513671875, 0.5299999713897705078125);
    float2 p = uv - center;
    float d = length(p);
    float influence = exp((-d) * 4.0);
    float angle = (((0.89999997615814208984375 - d) * 2.2000000476837158203125) * progress) * influence;
    float param = angle;
    return center + (rot(param) * p);
}

static inline __attribute__((always_inline))
float hash11(thread float& p)
{
    p = fract(p * 0.103100001811981201171875);
    p *= (p + 33.3300018310546875);
    p *= (p + p);
    return fract(p);
}

static inline __attribute__((always_inline))
float2 particlePath(thread const float& t, thread const float& id)
{
    float param = id * 1.17299997806549072265625;
    float _159 = hash11(param);
    float startY = 0.180000007152557373046875 + (0.540000021457672119140625 * _159);
    float param_1 = id * 2.4170000553131103515625;
    float _167 = hash11(param_1);
    float arc = (_167 - 0.5) * 0.4199999868869781494140625;
    float param_2 = id * 3.9110000133514404296875;
    float _179 = hash11(param_2);
    float param_3 = id * 5.21700000762939453125;
    float _195 = hash11(param_3);
    float wave = sin(((t * 6.28318023681640625) * (1.0 + (_179 * 1.7000000476837158203125))) + (id * 0.17000000178813934326171875)) * (0.0350000001490116119384765625 + (0.0500000007450580596923828125 * _195));
    float x = ((-0.20000000298023223876953125) + (1.39999997615814208984375 * t)) + (0.0500000007450580596923828125 * sin((id * 0.310000002384185791015625) + (t * 5.099999904632568359375)));
    float centerBias = exp(-pow((t - 0.560000002384185791015625) * 4.599999904632568359375, 2.0));
    float y = mix(startY, 0.579999983310699462890625 + arc, smoothstep(0.0, 0.680000007152557373046875, t));
    y += wave;
    y += ((sin((t * 9.0) + (id * 0.12999999523162841796875)) * 0.0350000001490116119384765625) * centerBias);
    float param_4 = id * 6.73099994659423828125;
    float _258 = hash11(param_4);
    y += (smoothstep(0.550000011920928955078125, 1.0, t) * (0.180000007152557373046875 + (0.119999997317790985107421875 * _258)));
    return float2(x, y);
}

static inline __attribute__((always_inline))
float particleLayer(thread const float2& uv, thread const float& progress, constant float& u_glowIntensity)
{
    float acc = 0.0;
    float p = fast::clamp(progress, 0.0, 1.0);
    float2 param = uv;
    float param_1 = smoothstep(0.180000007152557373046875, 0.85000002384185791015625, p);
    float2 warpedUv = swirlWarp(param, param_1);
    for (int i = 0; i < 48; i++)
    {
        float id = float(i) + 1.0;
        float param_2 = id * 9.13700008392333984375;
        float _302 = hash11(param_2);
        float localOffset = _302 * 0.2199999988079071044921875;
        float localTime = fast::clamp((p - localOffset) / ((1.0 - localOffset) + 9.9999997473787516355514526367188e-05), 0.0, 1.0);
        float param_3 = localTime;
        float param_4 = id;
        float2 pos = particlePath(param_3, param_4);
        float param_5 = id * 7.11100006103515625;
        float _328 = hash11(param_5);
        float size = mix(0.006000000052154064178466796875, 0.017999999225139617919921875, _328);
        float centerBoost = 1.0 + (1.7999999523162841796875 * exp(-pow((localTime - 0.579999983310699462890625) * 7.0, 2.0)));
        float d = length(warpedUv - pos);
        float core = exp((-pow(d / size, 2.0)) * 2.7999999523162841796875);
        float glow = exp((-pow(d / (size * 5.19999980926513671875), 2.0)) * 1.0499999523162841796875);
        float lifeFadeIn = smoothstep(0.0, 0.07999999821186065673828125, localTime);
        float lifeFadeOut = 1.0 - smoothstep(0.7200000286102294921875, 1.0, localTime);
        float life = lifeFadeIn * lifeFadeOut;
        acc += ((((core * 1.10000002384185791015625) + ((glow * 0.550000011920928955078125) * u_glowIntensity)) * life) * centerBoost);
    }
    float2 center = float2(0.5, 0.560000002384185791015625);
    float band = exp(-pow(((warpedUv.y - center.y) - (sin((warpedUv.x + p) * 5.5) * 0.039999999105930328369140625)) / 0.12999999523162841796875, 2.0));
    float centerMask = exp(-pow(length((warpedUv - center) * float2(1.0, 1.5499999523162841796875)) / 0.3499999940395355224609375, 2.0));
    float stream = (band * mix(0.20000000298023223876953125, 1.2000000476837158203125, smoothstep(0.1500000059604644775390625, 0.75, p))) * (0.4000000059604644775390625 + (centerMask * 1.60000002384185791015625));
    return (acc * 0.04500000178813934326171875) + stream;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 uv = getAspectCorrectUV(param, buffer.ratio);
    float4 texColor = texture1.sample(texture1Smplr, in.vUv);
    float2 param_1 = uv;
    float param_2 = buffer.u_flowProgress;
    float particleMask = particleLayer(param_1, param_2, buffer.u_glowIntensity);
    particleMask *= buffer.u_particleAlpha;
    float3 particleColorBase = mix(buffer.u_color2, buffer.u_color1, float3(fast::clamp((uv.x * 0.75) + 0.25, 0.0, 1.0)));
    float3 particleColor = mix(particleColorBase, buffer.u_highlightColor, float3(fast::clamp((particleMask * 0.85000002384185791015625) + (buffer.u_glowIntensity * 0.20000000298023223876953125), 0.0, 1.0)));
    float revealMask = fast::clamp(smoothstep(0.0599999986588954925537109375, 0.75, (particleMask * 0.949999988079071044921875) + (buffer.u_flowProgress * 0.64999997615814208984375)) * smoothstep(0.0, 0.25, buffer.u_textureAlpha), 0.0, 1.0);
    float finalTextureAlpha = fast::clamp(fast::max(buffer.u_textureAlpha * 0.85000002384185791015625, revealMask) + (buffer.u_textureAlpha * 0.1500000059604644775390625), 0.0, 1.0);
    float3 baseColor = buffer.u_bgColor;
    float3 screenMix = float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - (particleColor * fast::clamp(particleMask * (0.64999997615814208984375 + (buffer.u_glowIntensity * 0.800000011920928955078125)), 0.0, 1.0))));
    float3 additiveMix = baseColor + ((particleColor * particleMask) * (0.3499999940395355224609375 + (buffer.u_glowIntensity * 1.10000002384185791015625)));
    float3 glowLayer = mix(screenMix, additiveMix, float3(0.449999988079071044921875));
    float3 composed = mix(glowLayer, texColor.xyz, float3(finalTextureAlpha));
    composed += ((((particleColor * particleMask) * buffer.u_glowIntensity) * 0.180000007152557373046875) * (1.0 - finalTextureAlpha));
    composed *= buffer.u_brightness;
    float finalAlpha = fast::max(finalTextureAlpha, fast::clamp(particleMask * 0.60000002384185791015625, 0.0, 1.0));
    out.gl_FragColor = float4(composed, finalAlpha);
    return out;
}

