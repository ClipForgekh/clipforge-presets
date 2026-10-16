#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float ratio;
    float u_waveFront;
    float u_radialFalloff;
    float u_effectStrength;
    float u_rgbOffsetPx;
    float u_blurRadiusPx;
    float u_neonTintStrength;
    float u_exposureGain;
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
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float2& dir, thread const float& radiusPx, constant float2& u_resolution)
{
    float2 texel = float2(1.0 / fast::max(u_resolution.x, 1.0), 1.0 / fast::max(u_resolution.y, 1.0));
    float2 stepUV = (dir * texel) * radiusPx;
    float4 c = float4(0.0);
    c += (tex.sample(texSmplr, (uv - (stepUV * 4.0))) * 0.0500000007450580596923828125);
    c += (tex.sample(texSmplr, (uv - (stepUV * 3.0))) * 0.0900000035762786865234375);
    c += (tex.sample(texSmplr, (uv - (stepUV * 2.0))) * 0.119999997317790985107421875);
    c += (tex.sample(texSmplr, (uv - (stepUV * 1.0))) * 0.1500000059604644775390625);
    c += (tex.sample(texSmplr, uv) * 0.180000007152557373046875);
    c += (tex.sample(texSmplr, (uv + (stepUV * 1.0))) * 0.1500000059604644775390625);
    c += (tex.sample(texSmplr, (uv + (stepUV * 2.0))) * 0.119999997317790985107421875);
    c += (tex.sample(texSmplr, (uv + (stepUV * 3.0))) * 0.0900000035762786865234375);
    c += (tex.sample(texSmplr, (uv + (stepUV * 4.0))) * 0.0500000007450580596923828125);
    return c;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float2 center = float2(0.5);
    float2 toCenter = uv - center;
    float2 radialDir = fast::normalize(toCenter + float2(9.9999997473787516355514526367188e-06));
    float2 corrected = toCenter;
    if (buffer.ratio > 1.0)
    {
        corrected.y /= buffer.ratio;
    }
    else
    {
        corrected.x *= buffer.ratio;
    }
    float radial = fast::clamp(length(corrected) / 0.707106769084930419921875, 0.0, 1.0);
    float edgeFactor = mix(1.0, 0.699999988079071044921875, radial);
    float clearBoundary0 = buffer.u_waveFront - fast::max(buffer.u_radialFalloff, 9.9999997473787516355514526367188e-05);
    float clearBoundary1 = buffer.u_waveFront;
    float effectMask = smoothstep(clearBoundary0, clearBoundary1, radial);
    float localStrength = fast::clamp((buffer.u_effectStrength * edgeFactor) * effectMask, 0.0, 1.0);
    float rgbOffsetUvX = buffer.u_rgbOffsetPx / fast::max(buffer.u_resolution.x, 1.0);
    float rgbOffsetUvY = buffer.u_rgbOffsetPx / fast::max(buffer.u_resolution.y, 1.0);
    float2 chromaOffset = float2(radialDir.x * rgbOffsetUvX, radialDir.y * rgbOffsetUvY);
    float r = texture1.sample(texture1Smplr, fast::clamp(uv + chromaOffset, float2(0.0), float2(1.0))).x;
    float g = texture1.sample(texture1Smplr, uv).y;
    float b = texture1.sample(texture1Smplr, fast::clamp(uv - chromaOffset, float2(0.0), float2(1.0))).z;
    float4 chroma = float4(r, g, b, 1.0);
    float2 param = uv;
    float2 param_1 = float2(1.0, 0.0);
    float param_2 = buffer.u_blurRadiusPx;
    float4 blurH = gaussianBlur9(texture1, texture1Smplr, param, param_1, param_2, buffer.u_resolution);
    float2 param_3 = uv;
    float2 param_4 = float2(0.0, 1.0);
    float param_5 = buffer.u_blurRadiusPx / fast::max(buffer.ratio, 9.9999997473787516355514526367188e-05);
    float4 blurV = gaussianBlur9(texture1, texture1Smplr, param_3, param_4, param_5, buffer.u_resolution);
    float4 blurColor = (blurH + blurV) * 0.5;
    float3 neonTint = mix(float3(0.760999977588653564453125, 0.09399999678134918212890625, 0.35699999332427978515625), float3(0.3689999878406524658203125, 0.208000004291534423828125, 0.6940000057220458984375), float3(radial));
    float3 neonized = mix(chroma.xyz, neonTint * fast::max(dot(chroma.xyz, float3(0.333000004291534423828125)), 0.3499999940395355224609375), float3(buffer.u_neonTintStrength));
    float3 overExposed = mix(blurColor.xyz, neonized, float3(0.550000011920928955078125)) * buffer.u_exposureGain;
    float3 original = texture1.sample(texture1Smplr, uv).xyz;
    float3 finalColor = mix(original, overExposed, float3(localStrength));
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

