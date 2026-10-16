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
    float ratio;
    float u_segments;
    float u_time;
    float u_stretchBase;
    float u_compressBase;
    float u_blurRadius;
    float u_neonAberration;
    float u_fadeToBlack;
    float u_alpha;
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
float4 blur5(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius, constant float& ratio)
{
    float2 stepSize = float2(radius * 0.0199999995529651641845703125, (radius * 0.0199999995529651641845703125) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    c += (tex.sample(texSmplr, fast::clamp(uv + (float2(-2.0, 0.0) * stepSize), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    c += (tex.sample(texSmplr, fast::clamp(uv + (float2(-1.0, 0.0) * stepSize), float2(0.0), float2(1.0))) * 0.2199999988079071044921875);
    c += (tex.sample(texSmplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.319999992847442626953125);
    c += (tex.sample(texSmplr, fast::clamp(uv + (float2(1.0, 0.0) * stepSize), float2(0.0), float2(1.0))) * 0.2199999988079071044921875);
    c += (tex.sample(texSmplr, fast::clamp(uv + (float2(2.0, 0.0) * stepSize), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    return c;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float segH = 1.0 / buffer.u_segments;
    float segIdx = floor((1.0 - uv.y) * buffer.u_segments);
    segIdx = fast::clamp(segIdx, 0.0, buffer.u_segments - 1.0);
    float t = buffer.u_time;
    float stage1 = fast::clamp((t - 0.0) / 0.300000011920928955078125, 0.0, 1.0);
    float stage2Global = fast::clamp((t - 0.300000011920928955078125) / 0.89999997615814208984375, 0.0, 1.0);
    float stage3Global = fast::clamp((t - 1.2000000476837158203125) / 0.4000000059604644775390625, 0.0, 1.0);
    float segDelay = segIdx * 0.07500000298023223876953125;
    float segProg = fast::clamp(((t - 0.300000011920928955078125) - segDelay) / 0.89999997615814208984375, 0.0, 1.0);
    float segExp = pow(segProg, 2.2000000476837158203125);
    float isOddSeg = step(0.5, 1.0 - mod(segIdx, 2.0));
    float dirY = mix(-1.0, 1.0, isOddSeg);
    float stretch = segExp * buffer.u_stretchBase;
    float compress = fast::clamp(segProg * buffer.u_compressBase, 0.0, 0.98500001430511474609375);
    float2 mappedUv = uv;
    mappedUv.y += (((dirY * stretch) * 0.3499999940395355224609375) * (1.0 - (abs(uv.y - (1.0 - ((segIdx + 0.5) * segH))) * (buffer.u_segments * 0.550000011920928955078125))));
    if (isOddSeg > 0.5)
    {
        mappedUv.x *= (1.0 - compress);
    }
    else
    {
        mappedUv.x = 1.0 - ((1.0 - mappedUv.x) * (1.0 - compress));
    }
    mappedUv = fast::clamp(mappedUv, float2(0.0), float2(1.0));
    float blurAmount = buffer.u_blurRadius;
    if ((segIdx > 0.0) && (t < 0.300000011920928955078125))
    {
        blurAmount = 0.0;
    }
    float2 param = mappedUv;
    float param_1 = blurAmount;
    float4 baseCol = blur5(texture1, texture1Smplr, param, param_1, buffer.ratio);
    float ab = buffer.u_neonAberration * (0.00200000009499490261077880859375 + (0.017999999225139617919921875 * segProg));
    float2 centerDir = fast::normalize((mappedUv - float2(0.5)) + float2(9.9999997473787516355514526367188e-05));
    float r = texture1.sample(texture1Smplr, fast::clamp(mappedUv + (centerDir * ab), float2(0.0), float2(1.0))).x;
    float g = texture1.sample(texture1Smplr, mappedUv).y;
    float b = texture1.sample(texture1Smplr, fast::clamp(mappedUv - (centerDir * ab), float2(0.0), float2(1.0))).z;
    float3 chroma = float3(r, g, b);
    float edgeGlow = smoothstep(0.100000001490116119384765625, 0.949999988079071044921875, abs(mappedUv.x - 0.5) * 2.0) * segProg;
    float3 neonTint = mix(float3(1.0, 0.310000002384185791015625, 0.85000002384185791015625), float3(0.2199999988079071044921875, 0.7799999713897705078125, 1.0), float3(0.5 + (0.5 * sin(segIdx * 1.2000000476837158203125))));
    float3 color = mix(baseCol.xyz, chroma, float3(0.449999988079071044921875 * stage2Global));
    color += ((neonTint * edgeGlow) * (0.3499999940395355224609375 + (0.64999997615814208984375 * buffer.u_neonAberration)));
    float segDissolve = fast::clamp(((t - 1.2000000476837158203125) - (segIdx * 0.0199999995529651641845703125)) / 0.4000000059604644775390625, 0.0, 1.0);
    float segAlpha = 1.0 - segDissolve;
    color = mix(color, float3(0.0), float3(buffer.u_fadeToBlack));
    float finalAlpha = (baseCol.w * segAlpha) * buffer.u_alpha;
    out.gl_FragColor = float4(color, finalAlpha);
    return out;
}

