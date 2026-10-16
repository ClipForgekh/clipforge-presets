#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_time;
    float u_particleDrift;
    float u_glowSoftness;
    float u_particleIntensity;
    float u_textureOpacity;
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
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float _noise(thread const float2& p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    float2 param = i;
    float a = hash12(param);
    float2 param_1 = i + float2(1.0, 0.0);
    float b = hash12(param_1);
    float2 param_2 = i + float2(0.0, 1.0);
    float c = hash12(param_2);
    float2 param_3 = i + float2(1.0);
    float d = hash12(param_3);
    float2 u = (f * f) * (float2(3.0) - (f * 2.0));
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

static inline __attribute__((always_inline))
float fbm3(thread const float2& p)
{
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    for (int i = 0; i < 3; i++)
    {
        float2 param = p * frequency;
        value += (_noise(param) * amplitude);
        frequency *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

static inline __attribute__((always_inline))
float particleField(thread const float2& uv, thread const float& drift, constant float& u_time)
{
    float2 driftedUv = uv;
    float2 param = float2(uv.y * 11.0, uv.x * 7.0);
    driftedUv.x -= (drift * (0.20000000298023223876953125 + (0.119999997317790985107421875 * _noise(param))));
    float2 param_1 = float2((uv.x * 13.0) + 4.0, (uv.y * 9.0) + 8.0);
    driftedUv.y += (((_noise(param_1) - 0.5) * 0.119999997317790985107421875) * drift);
    float leftWeight = smoothstep(1.14999997615814208984375, 0.07999999821186065673828125, uv.x);
    float2 param_2 = (driftedUv * 10.0) + float2(u_time * 0.00025000001187436282634735107421875, 0.0);
    float n1 = fbm3(param_2);
    float2 param_3 = ((driftedUv * 18.0) + float2(13.3999996185302734375, 2.7000000476837158203125)) + float2(u_time * 0.0003300000098533928394317626953125, u_time * 0.00011000000085914507508277893066406);
    float n2 = fbm3(param_3);
    float2 param_4 = ((driftedUv * 31.0) + float2(-7.19999980926513671875, 9.1000003814697265625)) + float2(u_time * 0.00041000000783242285251617431640625, (-u_time) * 0.00018000000272877514362335205078125);
    float n3 = fbm3(param_4);
    float p1 = smoothstep(0.7799999713897705078125, 0.980000019073486328125, n1);
    float p2 = smoothstep(0.819999992847442626953125, 0.9900000095367431640625, n2);
    float p3 = smoothstep(0.86000001430511474609375, 0.99500000476837158203125, n3);
    float particles = ((p1 * 0.550000011920928955078125) + (p2 * 0.300000011920928955078125)) + (p3 * 0.1500000059604644775390625);
    return particles * leftWeight;
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& base, thread const float3& blend)
{
    return float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - blend));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = in.vUv;
    float4 texColor = texture1.sample(texture1Smplr, mappedUv);
    float2 param = mappedUv;
    float param_1 = buffer.u_particleDrift;
    float particles = particleField(param, param_1, buffer.u_time);
    float glow = smoothstep(0.0, 1.0, particles) * (0.550000011920928955078125 + (buffer.u_glowSoftness * 0.89999997615814208984375));
    glow += (smoothstep(0.1500000059604644775390625, 1.0, particles) * 0.3499999940395355224609375);
    float3 warmA = float3(0.85098040103912353515625, 0.643137276172637939453125, 0.2549019753932952880859375);
    float3 warmB = float3(0.784313738346099853515625, 0.4784313738346099853515625, 0.16862745583057403564453125);
    float3 warmC = float3(0.909803926944732666015625, 0.847058832645416259765625, 0.721568644046783447265625);
    float2 param_2 = (mappedUv * 6.0) + float2(2.2999999523162841796875, 1.7000000476837158203125);
    float colorMix1 = _noise(param_2);
    float2 param_3 = (mappedUv * 12.0) + float2(-4.099999904632568359375, 5.19999980926513671875);
    float colorMix2 = _noise(param_3);
    float3 particleColor = mix(warmA, warmB, float3(colorMix1));
    particleColor = mix(particleColor, warmC, float3(colorMix2 * 0.449999988079071044921875));
    float particleStrength = buffer.u_particleIntensity * (particles + (glow * 0.85000002384185791015625));
    float3 particleLayer = (particleColor * particleStrength) * 1.35000002384185791015625;
    float3 baseLayer = texColor.xyz * buffer.u_textureOpacity;
    float3 param_4 = baseLayer;
    float3 param_5 = particleLayer;
    float3 composed = screenBlend(param_4, param_5);
    float4 finalColor = float4(composed, fast::max(buffer.u_textureOpacity, fast::clamp(particleStrength, 0.0, 1.0)));
    float4 _427 = finalColor;
    float3 _429 = _427.xyz * buffer.u_brightness;
    finalColor.x = _429.x;
    finalColor.y = _429.y;
    finalColor.z = _429.z;
    out.gl_FragColor = finalColor;
    return out;
}

