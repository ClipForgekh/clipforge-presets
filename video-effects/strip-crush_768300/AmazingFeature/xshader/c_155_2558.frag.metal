#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_chromatic;
    float2 uvScale;
    float2 uvOffset;
    float u_verticalBlur;
    float u_neonExposure;
    float u_glitch;
    float u_maskTop;
    float u_maskBottom;
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
float3 sampleChromatic(thread const float2& uv, thread const float& amount, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 dir = float2(1.0, 0.0);
    float shift = amount * 0.0199999995529651641845703125;
    float r = texture1.sample(texture1Smplr, (uv + (dir * shift))).x;
    float g = texture1.sample(texture1Smplr, uv).y;
    float b = texture1.sample(texture1Smplr, (uv - (dir * shift))).z;
    return float3(r, g, b);
}

static inline __attribute__((always_inline))
float3 verticalBlur(thread const float2& uv, thread const float& strength, texture2d<float> texture1, sampler texture1Smplr, constant float& u_chromatic)
{
    float radius = 0.0199999995529651641845703125 * strength;
    float3 col = float3(0.0);
    float wsum = 0.0;
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        float w = 1.0 - (abs(fi) / 4.0);
        float2 suv = uv + float2(0.0, (fi * radius) * 0.25);
        suv = fast::clamp(suv, float2(0.0), float2(1.0));
        float2 param = suv;
        float param_1 = u_chromatic;
        col += (sampleChromatic(param, param_1, texture1, texture1Smplr) * w);
        wsum += w;
    }
    return col / float3(fast::max(wsum, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.uvScale) + buffer.uvOffset;
    mappedUv = fast::clamp(mappedUv, float2(0.0), float2(1.0));
    float2 param = mappedUv;
    float param_1 = buffer.u_verticalBlur;
    float3 blurCol = verticalBlur(param, param_1, texture1, texture1Smplr, buffer.u_chromatic);
    float2 param_2 = mappedUv;
    float param_3 = buffer.u_chromatic;
    float3 baseCol = sampleChromatic(param_2, param_3, texture1, texture1Smplr);
    float3 color = mix(baseCol, blurCol, float3(fast::clamp(buffer.u_verticalBlur, 0.0, 1.0)));
    float2 param_4 = float2(in.vUv.x * 97.0, floor(in.vUv.y * 70.0));
    float stripeNoise = hash12(param_4);
    float edgeGlow = smoothstep(0.0, 0.180000007152557373046875, in.vUv.x) * (1.0 - smoothstep(0.819999992847442626953125, 1.0, in.vUv.x));
    float3 neonTint = mix(float3(0.85000002384185791015625, 0.25, 0.949999988079071044921875), float3(0.12999999523162841796875, 0.829999983310699462890625, 0.930000007152557373046875), float3(stripeNoise));
    color += (neonTint * (buffer.u_neonExposure * (0.550000011920928955078125 + (edgeGlow * 0.699999988079071044921875))));
    float2 param_5 = float2(in.vUv.x * 43.0, 1.230000019073486328125);
    float topJitter = ((hash12(param_5) - 0.5) * buffer.u_glitch) * 0.07999999821186065673828125;
    float2 param_6 = float2(in.vUv.x * 57.0, 8.71000003814697265625);
    float bottomJitter = ((hash12(param_6) - 0.5) * buffer.u_glitch) * 0.07999999821186065673828125;
    float topEdge = (1.0 - buffer.u_maskTop) + topJitter;
    float bottomEdge = buffer.u_maskBottom + bottomJitter;
    float topMask = step(topEdge, in.vUv.y);
    float bottomMask = step(in.vUv.y, bottomEdge);
    float blackMask = fast::clamp(topMask + bottomMask, 0.0, 1.0);
    float3 finalColor = mix(color, float3(0.0), float3(blackMask));
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

