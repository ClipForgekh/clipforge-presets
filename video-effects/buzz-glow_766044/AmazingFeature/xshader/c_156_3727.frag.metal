#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float u_stripeCount;
    float u_evenRecovery;
    float u_oddRecovery;
    float u_tailRecovery;
    float2 u_resolution;
    float u_globalBlurPx;
    float u_globalExposure;
    float u_rgOffsetPx;
    float u_time;
    float u_grainBaseIntensity;
    float u_grainIntensity;
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
float saturateFloat(thread const float& v)
{
    return fast::clamp(v, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float getStripeRecovery(thread const float& stripeIndex, constant float& u_stripeCount, constant float& u_evenRecovery, constant float& u_oddRecovery, constant float& u_tailRecovery)
{
    float normalizedIndex = stripeIndex / fast::max(u_stripeCount - 1.0, 1.0);
    float leftToRightAttenuation = 1.0 - normalizedIndex;
    float parityRecovery = (mod(stripeIndex, 2.0) < 0.5) ? u_evenRecovery : u_oddRecovery;
    float recovery = fast::max(parityRecovery * (0.550000011920928955078125 + (0.449999988079071044921875 * leftToRightAttenuation)), u_tailRecovery);
    float param = recovery;
    return saturateFloat(param);
}

static inline __attribute__((always_inline))
float4 sampleVerticalBlur(thread const float2& uv, thread const float& radiusPx, thread const float& chromaPx, constant float2& u_resolution, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 texel = float2(1.0 / fast::max(u_resolution.x, 1.0), 1.0 / fast::max(u_resolution.y, 1.0));
    float radiusY = radiusPx * texel.y;
    float chroma = chromaPx * texel.x;
    float2 centerDir = uv - float2(0.5);
    if (length(centerDir) < 9.9999997473787516355514526367188e-05)
    {
        centerDir = float2(1.0, 0.0);
    }
    else
    {
        centerDir = fast::normalize(centerDir);
    }
    float2 rgShift = centerDir * chroma;
    float4 accum = float4(0.0);
    float total = 0.0;
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        float w = exp(((-0.5) * (fi * fi)) / 4.0);
        float feather = 1.0 + (abs(fi) * 0.07999999821186065673828125);
        float2 offset = float2(0.0, ((fi * radiusY) * 0.3499999940395355224609375) * feather);
        float2 sampleUv = fast::clamp(uv + offset, float2(0.0), float2(1.0));
        float r = texture1.sample(texture1Smplr, fast::clamp(sampleUv + rgShift, float2(0.0), float2(1.0))).x;
        float g = texture1.sample(texture1Smplr, sampleUv).y;
        float b = texture1.sample(texture1Smplr, fast::clamp(sampleUv - rgShift, float2(0.0), float2(1.0))).z;
        accum += (float4(r, g, b, 1.0) * w);
        total += w;
    }
    return accum / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
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
    float2 uv = in.vUv;
    float stripeWidth = 1.0 / buffer.u_stripeCount;
    float stripeIndex = floor(uv.x / stripeWidth);
    stripeIndex = fast::clamp(stripeIndex, 0.0, buffer.u_stripeCount - 1.0);
    float param = stripeIndex;
    float recovery = getStripeRecovery(param, buffer.u_stripeCount, buffer.u_evenRecovery, buffer.u_oddRecovery, buffer.u_tailRecovery);
    float stripeBlurBase = mix(25.0, 5.0, recovery);
    float stripeExposure = mix(2.5, 1.0, recovery);
    float blurPx = fast::max(mix(buffer.u_globalBlurPx, stripeBlurBase, step(9.9999997473787516355514526367188e-05, fast::max(buffer.u_oddRecovery, buffer.u_evenRecovery))), 0.0);
    blurPx = mix(blurPx, 0.0, buffer.u_tailRecovery);
    float exposure = mix(buffer.u_globalExposure, stripeExposure, step(9.9999997473787516355514526367188e-05, fast::max(buffer.u_oddRecovery, buffer.u_evenRecovery)));
    exposure = mix(exposure, 1.0, buffer.u_tailRecovery);
    float2 param_1 = uv;
    float param_2 = blurPx;
    float param_3 = buffer.u_rgOffsetPx;
    float4 color = sampleVerticalBlur(param_1, param_2, param_3, buffer.u_resolution, texture1, texture1Smplr);
    float edgeBlend = abs(fract(uv.x * buffer.u_stripeCount) - 0.5);
    float overlapGlow = (smoothstep(0.5, 0.0, edgeBlend) * (1.0 - recovery)) * 0.100000001490116119384765625;
    exposure += overlapGlow;
    float4 _334 = color;
    float3 _336 = _334.xyz * exposure;
    color.x = _336.x;
    color.y = _336.y;
    color.z = _336.z;
    float2 param_4 = (uv * float2(813.16998291015625, 451.730010986328125)) + float2(buffer.u_time * 17.3099994659423828125, buffer.u_time * 29.1700000762939453125);
    float grain = (hash12(param_4) - 0.5) * 2.0;
    float4 _369 = color;
    float3 _372 = _369.xyz + float3(grain * (buffer.u_grainBaseIntensity * buffer.u_grainIntensity));
    color.x = _372.x;
    color.y = _372.y;
    color.z = _372.z;
    float4 _379 = color;
    float3 _382 = fast::max(_379.xyz, float3(0.0));
    color.x = _382.x;
    color.y = _382.y;
    color.z = _382.z;
    out.gl_FragColor = float4(color.xyz, 1.0);
    return out;
}

