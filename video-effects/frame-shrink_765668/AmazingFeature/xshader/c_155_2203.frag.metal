#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_time;
    float u_particleDrift;
    float u_particleIntensity;
    float u_maskProgress;
    float u_maskFeather;
    float u_outputBlackHold;
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
float hash(thread const float& n)
{
    return fract(sin(n) * 43758.546875);
}

static inline __attribute__((always_inline))
float particleField(thread const float2& uv, thread const float& drift, thread const float& t)
{
    float acc = 0.0;
    for (int i = 0; i < 28; i++)
    {
        float fi = float(i);
        float param = (fi * 3.1700000762939453125) + 1.230000019073486328125;
        float s1 = hash(param);
        float param_1 = (fi * 7.110000133514404296875) + 2.309999942779541015625;
        float s2 = hash(param_1);
        float param_2 = (fi * 5.730000019073486328125) + 0.910000026226043701171875;
        float s3 = hash(param_2);
        float x = mix(-0.20000000298023223876953125, 1.2000000476837158203125, fast::clamp((drift * (0.64999997615814208984375 + (s1 * 0.64999997615814208984375))) + (s2 * 0.25), 0.0, 1.0));
        float y = ((0.5 + ((s3 - 0.5) * 0.85000002384185791015625)) + (0.07999999821186065673828125 * sin((t * (1.2000000476837158203125 + (s1 * 2.2000000476837158203125))) + (fi * 1.37000000476837158203125)))) + (0.0500000007450580596923828125 * cos((t * (0.89999997615814208984375 + (s2 * 1.7999999523162841796875))) + (fi * 0.910000026226043701171875)));
        float2 c = float2(x, y);
        float2 d = uv - c;
        float r = 0.01200000010430812835693359375 + (0.02999999932944774627685546875 * s1);
        float glow = exp((-dot(d, d)) / (r * r));
        acc += (glow * (0.5 + (0.800000011920928955078125 * s2)));
    }
    return fast::clamp(acc / 10.5, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& base, thread const float3& blend)
{
    return float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - blend));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float4 baseTex = texture1.sample(texture1Smplr, in.vUv);
    float3 color = baseTex.xyz;
    float t = buffer.u_time;
    float2 param = in.vUv;
    float param_1 = buffer.u_particleDrift;
    float param_2 = t;
    float particles = particleField(param, param_1, param_2);
    float3 warmWhite = float3(0.94900000095367431640625, 0.921999990940093994140625, 0.86699998378753662109375);
    float3 particleColor = ((warmWhite * particles) * buffer.u_particleIntensity) * 1.2000000476837158203125;
    float3 param_3 = color;
    float3 param_4 = particleColor;
    color = screenBlend(param_3, param_4);
    float distEdge = fast::max(abs(in.vUv.x - 0.5), abs(in.vUv.y - 0.5)) * 2.0;
    float threshold = 1.0 - fast::clamp(buffer.u_maskProgress, 0.0, 1.0);
    float edgeToCenterMask = smoothstep(threshold - buffer.u_maskFeather, threshold + buffer.u_maskFeather, distEdge);
    color = mix(color, float3(0.0), float3(edgeToCenterMask));
    color = mix(color, float3(0.0), float3(fast::clamp(buffer.u_outputBlackHold, 0.0, 1.0)));
    out.gl_FragColor = float4(color, 1.0);
    return out;
}

