#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 uvScale;
    float2 uvOffset;
    float u_impactScale;
    float u_ringRotation;
    float u_ringDepth;
    float u_ringScale;
    float u_dissolveProgress;
    float u_ringVisibility;
    float u_revealProgress;
    float u_waveAmplitude;
    float u_distortionStrength;
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
float revealMask(thread const float2& uv, constant float& u_revealProgress)
{
    float dist = distance(uv, float2(0.5));
    float front = mix(0.0, 0.7799999713897705078125, fast::clamp(u_revealProgress, 0.0, 1.0));
    float mask = 1.0 - smoothstep(front - 0.1599999964237213134765625, front + 0.0199999995529651641845703125, dist);
    return fast::clamp(mask, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float2 safeMappedUv(thread const float2& uv, constant float2& uvScale, constant float2& uvOffset)
{
    return fast::clamp((uv * uvScale) + uvOffset, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float2 rotate2D(thread const float2& p, thread const float& a)
{
    float s = sin(a);
    float c = cos(a);
    return float2x2(float2(c, -s), float2(s, c)) * p;
}

static inline __attribute__((always_inline))
float ringField(thread const float2& p, thread const float& radius, thread const float& thickness)
{
    float len = length(p);
    return 1.0 - smoothstep(thickness, thickness + 0.02999999932944774627685546875, abs(len - radius));
}

static inline __attribute__((always_inline))
float hash21(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float sparkleLayer(thread const float2& p, thread const float& seed)
{
    float2 cell = floor(((p + float2(1.5)) * 18.0) + float2(seed));
    float2 local = fract(((p + float2(1.5)) * 18.0) + float2(seed)) - float2(0.5);
    float2 param = cell + float2(seed);
    float rnd = hash21(param);
    float d = length(local);
    float s = smoothstep(0.23999999463558197021484375, 0.0, d) * step(0.819999992847442626953125, rnd);
    return s;
}

static inline __attribute__((always_inline))
float3 particleRingColor(thread const float2& uv, constant float& u_impactScale, constant float& u_ringRotation, constant float& u_ringDepth, constant float& u_ringScale, constant float& u_dissolveProgress, constant float& u_ringVisibility)
{
    float2 p = (uv - float2(0.5)) * 2.0;
    p /= float2(fast::max(u_impactScale, 9.9999997473787516355514526367188e-05));
    float2 param = p;
    float param_1 = u_ringRotation;
    p = rotate2D(param, param_1);
    float perspectiveScale = mix(0.550000011920928955078125, 2.2000000476837158203125, fast::clamp((u_ringDepth + 12.0) / 14.0, 0.0, 1.0));
    float radius = u_ringScale * perspectiveScale;
    float thickness = 0.07999999821186065673828125 * mix(1.0, 0.550000011920928955078125, fast::clamp((u_ringDepth + 12.0) / 14.0, 0.0, 1.0));
    float2 param_2 = p;
    float param_3 = radius;
    float param_4 = thickness;
    float ring = ringField(param_2, param_3, param_4);
    float2 param_5 = p;
    float param_6 = radius;
    float param_7 = thickness * 1.89999997615814208984375;
    float innerGlow = ringField(param_5, param_6, param_7) * 0.550000011920928955078125;
    float2 param_8 = p * 0.949999988079071044921875;
    float param_9 = 3.7000000476837158203125;
    float2 param_10 = p;
    float param_11 = radius;
    float param_12 = thickness * 2.7999999523162841796875;
    float plume = sparkleLayer(param_8, param_9) * ringField(param_10, param_11, param_12);
    float2 param_13 = p;
    float param_14 = radius * 0.98500001430511474609375;
    float param_15 = thickness * 3.400000095367431640625;
    float trail = ringField(param_13, param_14, param_15) * 0.180000007152557373046875;
    float dissolve = fast::clamp(u_dissolveProgress, 0.0, 1.0);
    float2 dir = fast::normalize(p + float2(9.9999997473787516355514526367188e-05));
    float2 burstP = p - ((dir * dissolve) * 0.75);
    float2 param_16 = burstP * (1.0 + (dissolve * 2.2000000476837158203125));
    float param_17 = 12.0;
    float burstDust = sparkleLayer(param_16, param_17);
    float2 param_18 = (burstP + float2(0.10999999940395355224609375, -0.070000000298023223876953125)) * (1.2000000476837158203125 + (dissolve * 1.7999999523162841796875));
    float param_19 = 28.0;
    burstDust += (sparkleLayer(param_18, param_19) * 0.699999988079071044921875);
    burstDust *= (1.0 - smoothstep(0.3499999940395355224609375, 1.14999997615814208984375 + (dissolve * 0.85000002384185791015625), length(p)));
    burstDust *= dissolve;
    float intact = (((ring + innerGlow) + plume) + trail) * (1.0 - dissolve);
    float total = (intact + burstDust) * u_ringVisibility;
    float3 glowA = float3(0.0599999986588954925537109375, 0.3400000035762786865234375, 0.60000002384185791015625);
    float3 glowB = float3(0.36000001430511474609375, 0.7799999713897705078125, 1.0);
    float3 glowC = float3(0.7200000286102294921875, 0.939999997615814208984375, 1.0);
    float3 color = mix(glowA, glowB, float3(fast::clamp(total, 0.0, 1.0)));
    color = mix(color, glowC, float3(fast::clamp(innerGlow + (burstDust * 0.75), 0.0, 1.0)));
    return (color * total) * 1.4500000476837158203125;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 centered = in.vUv - float2(0.5);
    float dist = length(centered);
    float2 param = in.vUv;
    float reveal = revealMask(param, buffer.u_revealProgress);
    float waveFront = mix(-0.0199999995529651641845703125, 0.89999997615814208984375, fast::clamp(buffer.u_revealProgress, 0.0, 1.0));
    float waveBand = exp((-28.0) * abs(dist - waveFront));
    float rippleOffset = (sin((dist - waveFront) * 56.0) * buffer.u_waveAmplitude) * waveBand;
    float2 rippleDir = fast::normalize(centered + float2(9.9999997473787516355514526367188e-05));
    float2 distortionUv = in.vUv + (rippleDir * rippleOffset);
    distortionUv += (rippleDir * ((buffer.u_distortionStrength * 0.0350000001490116119384765625) * sin(dist * 22.0)));
    float2 param_1 = distortionUv;
    distortionUv = safeMappedUv(param_1, buffer.uvScale, buffer.uvOffset);
    float4 texColor = texture1.sample(texture1Smplr, distortionUv);
    float darkBase = 0.039999999105930328369140625 + (0.100000001490116119384765625 * reveal);
    float3 baseColor = mix(float3(darkBase, darkBase + 0.00999999977648258209228515625, darkBase + 0.02999999932944774627685546875), texColor.xyz, float3(reveal));
    float2 param_2 = in.vUv;
    float3 ringColor = particleRingColor(param_2, buffer.u_impactScale, buffer.u_ringRotation, buffer.u_ringDepth, buffer.u_ringScale, buffer.u_dissolveProgress, buffer.u_ringVisibility);
    float3 finalColor = baseColor + ringColor;
    float4 outColor = float4(finalColor, 1.0);
    float4 _513 = outColor;
    float3 _515 = _513.xyz * buffer.u_brightness;
    outColor.x = _515.x;
    outColor.y = _515.y;
    outColor.z = _515.z;
    out.gl_FragColor = outColor;
    return out;
}

