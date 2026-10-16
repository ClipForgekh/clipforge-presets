#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_timePhase;
    float u_progress;
    float u_maskFeather;
    float u_particleDensity;
    float u_particleIntensity;
    float u_glowRadius;
    float3 u_layerSpeedRatio;
    float3 u_layerColor1;
    float3 u_layerColor2;
    float3 u_layerColor3;
    float u_chromatic;
    float u_glitchAmount;
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
float2 rotate2D(thread const float2& p, thread const float& a)
{
    float s = sin(a);
    float c = cos(a);
    return float2x2(float2(c, -s), float2(s, c)) * p;
}

static inline __attribute__((always_inline))
float hash21(thread const float2& p)
{
    return fract(sin(dot(p, float2(127.09999847412109375, 311.70001220703125))) * 43758.546875);
}

static inline __attribute__((always_inline))
float noise21(thread const float2& p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    float2 param = i;
    float a = hash21(param);
    float2 param_1 = i + float2(1.0, 0.0);
    float b = hash21(param_1);
    float2 param_2 = i + float2(0.0, 1.0);
    float c = hash21(param_2);
    float2 param_3 = i + float2(1.0);
    float d = hash21(param_3);
    float2 u = (f * f) * (float2(3.0) - (f * 2.0));
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

static inline __attribute__((always_inline))
float fbm(thread float2& p)
{
    float value = 0.0;
    float amp = 0.5;
    for (int i = 0; i < 4; i++)
    {
        float2 param = p;
        value += (noise21(param) * amp);
        p = (p * 2.0299999713897705078125) + float2(13.69999980926513671875, 9.19999980926513671875);
        amp *= 0.5;
    }
    return value;
}

static inline __attribute__((always_inline))
float particleLayer(thread const float2& uv, thread const float& layerIndex, thread const float& speedRatio, thread const float& angle, thread const float& radius, thread const float& edgeWeight, thread const float& density, thread const float& intensity, thread const float& glowRadius, constant float& u_timePhase)
{
    float2 p = uv - float2(0.5);
    float2 param = p;
    float param_1 = (-angle) * speedRatio;
    p = rotate2D(param, param_1);
    float r = length(p);
    float a = precise::atan2(p.y, p.x);
    float2 param_2 = float2((a * 2.5) + (layerIndex * 8.0), ((r * 9.0) - (layerIndex * 3.0)) + ((u_timePhase * 0.3499999940395355224609375) * speedRatio));
    float _216 = fbm(param_2);
    float ringNoise = _216;
    float radialBand = exp((-abs(r - radius)) * (18.0 + (layerIndex * 4.0)));
    float edgeBand = exp((-abs(r - radius)) * (42.0 + (layerIndex * 10.0)));
    float scatter = smoothstep(1.0 - density, 1.0, ringNoise);
    float2 param_3 = floor((p + float2(1.5)) * (42.0 + (layerIndex * 12.0))) + float2(layerIndex * 17.0);
    float sparkleSeed = hash21(param_3);
    float flicker = 0.64999997615814208984375 + (0.3499999940395355224609375 * sin(((u_timePhase * 24.0) + (sparkleSeed * 20.0)) + (layerIndex * 3.099999904632568359375)));
    float core = ((radialBand * scatter) * intensity) * flicker;
    float glow = (edgeBand * glowRadius) * (0.449999988079071044921875 + (0.25 * ringNoise));
    float edgeBoost = ((edgeWeight * edgeBand) * intensity) * 0.699999988079071044921875;
    return fast::max((core + glow) + edgeBoost, 0.0);
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& baseColor, thread const float3& blendColor)
{
    return float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - blendColor));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float2 centered = uv - float2(0.5);
    float radius = length(centered);
    float angle = precise::atan2(centered.y, centered.x);
    float gatherToCenter = 1.0 - smoothstep(0.0, 0.2199999988079071044921875, buffer.u_progress);
    float spiralPhase = smoothstep(0.0199999995529651641845703125, 1.0, buffer.u_progress);
    float edgeRadius = mix(0.7799999713897705078125, 0.100000001490116119384765625, gatherToCenter);
    float spiralRadius = fast::clamp(buffer.u_progress, 0.0, 1.0) * 0.819999992847442626953125;
    float spiralAngle = (-6.283185482025146484375) * (0.89999997615814208984375 + (buffer.u_progress * 1.7000000476837158203125));
    float spiralArm = spiralRadius + (0.054999999701976776123046875 * sin((angle * 3.0) + (buffer.u_timePhase * 1.7999999523162841796875)));
    float activeRadius = mix(edgeRadius, spiralArm, spiralPhase);
    float activeAngle = mix(0.0, spiralAngle, spiralPhase);
    float sweepMask = smoothstep(activeRadius + buffer.u_maskFeather, activeRadius - buffer.u_maskFeather, radius);
    float finalRevealMask = fast::max(sweepMask, smoothstep(0.920000016689300537109375, 1.0, buffer.u_progress));
    float edgeWeight = (smoothstep(0.87999999523162841796875, 0.519999980926513671875, radius) * gatherToCenter) + smoothstep(buffer.u_maskFeather * 1.7999999523162841796875, 0.0, abs(radius - activeRadius));
    float density = fast::clamp(buffer.u_particleDensity, 0.0, 1.0);
    float intensity = fast::clamp(buffer.u_particleIntensity, 0.0, 2.0);
    float glowRadius = fast::clamp(buffer.u_glowRadius, 0.0, 1.5);
    float2 param = uv;
    float param_1 = 1.0;
    float param_2 = buffer.u_layerSpeedRatio.x;
    float param_3 = activeAngle;
    float param_4 = activeRadius + 0.014999999664723873138427734375;
    float param_5 = edgeWeight;
    float param_6 = density;
    float param_7 = intensity;
    float param_8 = glowRadius;
    float layer1 = particleLayer(param, param_1, param_2, param_3, param_4, param_5, param_6, param_7, param_8, buffer.u_timePhase);
    float2 param_9 = uv;
    float param_10 = 2.0;
    float param_11 = buffer.u_layerSpeedRatio.y;
    float param_12 = activeAngle;
    float param_13 = activeRadius - 0.00999999977648258209228515625;
    float param_14 = edgeWeight;
    float param_15 = density * 0.959999978542327880859375;
    float param_16 = intensity * 0.949999988079071044921875;
    float param_17 = glowRadius * 1.0499999523162841796875;
    float layer2 = particleLayer(param_9, param_10, param_11, param_12, param_13, param_14, param_15, param_16, param_17, buffer.u_timePhase);
    float2 param_18 = uv;
    float param_19 = 3.0;
    float param_20 = buffer.u_layerSpeedRatio.z;
    float param_21 = activeAngle;
    float param_22 = activeRadius + 0.0280000008642673492431640625;
    float param_23 = edgeWeight;
    float param_24 = density * 0.920000016689300537109375;
    float param_25 = intensity * 0.89999997615814208984375;
    float param_26 = glowRadius * 1.10000002384185791015625;
    float layer3 = particleLayer(param_18, param_19, param_20, param_21, param_22, param_23, param_24, param_25, param_26, buffer.u_timePhase);
    float3 particleColor = float3(0.0);
    float3 param_27 = particleColor;
    float3 param_28 = buffer.u_layerColor1 * layer1;
    particleColor = screenBlend(param_27, param_28);
    float3 param_29 = particleColor;
    float3 param_30 = buffer.u_layerColor2 * layer2;
    particleColor = screenBlend(param_29, param_30);
    float3 param_31 = particleColor;
    float3 param_32 = buffer.u_layerColor3 * layer3;
    particleColor = screenBlend(param_31, param_32);
    float particleMask = fast::clamp(fast::max(fast::max(layer1, layer2), layer3), 0.0, 1.0);
    float revealMask = fast::clamp(fast::max(finalRevealMask, smoothstep(0.100000001490116119384765625, 0.85000002384185791015625, particleMask) * (1.0 - gatherToCenter)), 0.0, 1.0);
    float2 dir = uv - float2(0.5);
    float offset = buffer.u_chromatic * 0.00200000009499490261077880859375;
    float rTex = texture1.sample(texture1Smplr, fast::clamp(uv + (dir * offset), float2(0.0), float2(1.0))).x;
    float gTex = texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))).y;
    float bTex = texture1.sample(texture1Smplr, fast::clamp(uv - (dir * offset), float2(0.0), float2(1.0))).z;
    float4 texColor = float4(rTex, gTex, bTex, 1.0);
    float2 param_33 = float2(floor(uv.y * 220.0), floor((buffer.u_timePhase + uv.x) * 120.0));
    float glitchNoise = hash21(param_33);
    float glitchLine = (step(0.910000026226043701171875, glitchNoise) * buffer.u_glitchAmount) * smoothstep(0.119999997317790985107421875, 0.89999997615814208984375, abs(radius - activeRadius) + 0.0199999995529651641845703125);
    float3 glitchColor = float3(glitchLine * 0.60000002384185791015625, glitchLine * 0.25, glitchLine * 0.800000011920928955078125);
    float3 revealColor = texColor.xyz * revealMask;
    float3 param_34 = revealColor;
    float3 param_35 = particleColor + glitchColor;
    float3 composed = screenBlend(param_34, param_35);
    if (buffer.u_progress < 0.0199999995529651641845703125)
    {
        composed *= 0.0;
    }
    composed *= buffer.u_brightness;
    out.gl_FragColor = float4(fast::clamp(composed, float3(0.0), float3(1.0)), 1.0);
    return out;
}

