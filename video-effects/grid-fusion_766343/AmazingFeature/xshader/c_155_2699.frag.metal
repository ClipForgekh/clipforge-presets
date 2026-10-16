#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_seed;
    float ratio;
    float u_pixelSize;
    float u_heartDensity;
    float u_maskFeather;
    float u_heartScale;
    float u_progress;
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
float hash12(thread const float2& p, constant float& u_seed)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, (p3.yzx + float3(33.3300018310546875)) + float3(u_seed)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float sdHeartCore(thread float2& p)
{
    p.x = abs(p.x);
    if ((p.y + p.x) > 1.0)
    {
        return length(p - float2(0.25, 0.75)) - 0.3535533845424652099609375;
    }
    float d1 = length(p - float2(0.0, 1.0));
    float d2 = length(p - float2(0.5));
    return fast::min(d1, d2) * sign(p.x - p.y);
}

static inline __attribute__((always_inline))
float heartSDF(thread const float2& p, thread const float& size, constant float& ratio)
{
    float2 q = p;
    if (ratio > 1.0)
    {
        q.y /= ratio;
    }
    else
    {
        q.x *= ratio;
    }
    q /= float2(fast::max(size, 9.9999997473787516355514526367188e-05));
    q.y = -q.y;
    q.y += 0.449999988079071044921875;
    float2 param = q;
    float _146 = sdHeartCore(param);
    return _146 * size;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = in.vUv;
    if (buffer.u_pixelSize > 0.001000000047497451305389404296875)
    {
        float2 pixelGrid = float2(fast::max(1.0, buffer.u_pixelSize * fast::max(buffer.ratio, 1.0)), fast::max(1.0, buffer.u_pixelSize));
        mappedUv = (floor(mappedUv * pixelGrid) / pixelGrid) + (float2(0.5) / pixelGrid);
    }
    float density = mix(2.0, 18.0, fast::clamp(buffer.u_heartDensity, 0.0, 1.0));
    float2 gridUv = mappedUv * density;
    float2 baseId = floor(gridUv);
    float heartMask = 0.0;
    float feather = fast::max(buffer.u_maskFeather, 0.0007999999797903001308441162109375);
    float scaleK = fast::clamp(buffer.u_heartScale / 1.25, 0.0, 1.0);
    for (int ix = -1; ix <= 1; ix++)
    {
        for (int iy = -1; iy <= 1; iy++)
        {
            float2 cellId = baseId + float2(float(ix), float(iy));
            float2 param = cellId + float2(7.099999904632568359375);
            float2 param_1 = cellId + float2(19.700000762939453125);
            float2 rnd = float2(hash12(param, buffer.u_seed), hash12(param_1, buffer.u_seed));
            float2 center = float2(0.20000000298023223876953125) + (rnd * 0.60000002384185791015625);
            float2 localP = (gridUv - cellId) - center;
            float2 param_2 = cellId + float2(5.30000019073486328125);
            float sizeRnd = mix(0.64999997615814208984375, 1.25, hash12(param_2, buffer.u_seed));
            float heartSize = (0.0599999986588954925537109375 + (0.439999997615814208984375 * scaleK)) * sizeRnd;
            float2 param_3 = localP;
            float param_4 = heartSize;
            float d = heartSDF(param_3, param_4, buffer.ratio);
            float a = 1.0 - smoothstep(-feather, feather, d);
            heartMask = fast::max(heartMask, a);
        }
    }
    float birthGate = smoothstep(0.0199999995529651641845703125, 0.180000007152557373046875, buffer.u_progress);
    heartMask *= birthGate;
    float fusion = smoothstep(0.819999992847442626953125, 1.0, buffer.u_progress);
    float finalMask = fast::max(heartMask, fusion);
    float4 texColor = texture1.sample(texture1Smplr, in.vUv);
    float3 finalColor = mix(float3(0.0), texColor.xyz, float3(fast::clamp(finalMask, 0.0, 1.0)));
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

