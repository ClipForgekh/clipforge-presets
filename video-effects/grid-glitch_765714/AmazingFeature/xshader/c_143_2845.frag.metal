#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float ratio;
    float2 u_uvScale;
    float2 u_uvOffset;
    float2 u_blockOffsetPx;
    float u_rgbShiftPx;
    float u_blurRadiusPx;
    float u_exposure;
    float u_holoEdgeGlowPx;
    float3 u_holoEdgeColor;
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
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurPx, constant float2& u_resolution, constant float& ratio)
{
    if (blurPx <= 0.001000000047497451305389404296875)
    {
        return tex.sample(texSmplr, uv);
    }
    float2 texel = float2(1.0 / fast::max(u_resolution.x, 1.0), 1.0 / fast::max(u_resolution.y, 1.0));
    float2 stepV = float2(texel.x * blurPx, (texel.y * blurPx) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    c += (tex.sample(texSmplr, (uv + (stepV * float2(-1.0)))) * 0.0625);
    c += (tex.sample(texSmplr, (uv + (stepV * float2(0.0, -1.0)))) * 0.125);
    c += (tex.sample(texSmplr, (uv + (stepV * float2(1.0, -1.0)))) * 0.0625);
    c += (tex.sample(texSmplr, (uv + (stepV * float2(-1.0, 0.0)))) * 0.125);
    c += (tex.sample(texSmplr, uv) * 0.25);
    c += (tex.sample(texSmplr, (uv + (stepV * float2(1.0, 0.0)))) * 0.125);
    c += (tex.sample(texSmplr, (uv + (stepV * float2(-1.0, 1.0)))) * 0.0625);
    c += (tex.sample(texSmplr, (uv + (stepV * float2(0.0, 1.0)))) * 0.125);
    c += (tex.sample(texSmplr, (uv + (stepV * float2(1.0)))) * 0.0625);
    return c;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_texture [[texture(0)]], sampler u_textureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.u_uvScale) + buffer.u_uvOffset;
    float2 offsetUV = float2(buffer.u_blockOffsetPx.x / fast::max(buffer.u_resolution.x, 1.0), buffer.u_blockOffsetPx.y / fast::max(buffer.u_resolution.y, 1.0));
    mappedUv += offsetUV;
    mappedUv = fast::clamp(mappedUv, float2(0.0), float2(1.0));
    float2 dir = mappedUv - float2(0.5);
    float rgbOffset = buffer.u_rgbShiftPx / fast::max(fast::min(buffer.u_resolution.x, buffer.u_resolution.y), 1.0);
    float r = u_texture.sample(u_textureSmplr, fast::clamp(mappedUv + (fast::normalize(dir + float2(9.9999997473787516355514526367188e-05)) * rgbOffset), float2(0.0), float2(1.0))).x;
    float g = u_texture.sample(u_textureSmplr, mappedUv).y;
    float b = u_texture.sample(u_textureSmplr, fast::clamp(mappedUv - (fast::normalize(dir + float2(9.9999997473787516355514526367188e-05)) * rgbOffset), float2(0.0), float2(1.0))).z;
    float4 rgbSplitColor = float4(r, g, b, 1.0);
    float2 param = mappedUv;
    float param_1 = buffer.u_blurRadiusPx;
    float4 blurColor = gaussianBlur(u_texture, u_textureSmplr, param, param_1, buffer.u_resolution, buffer.ratio);
    float4 baseColor = mix(rgbSplitColor, blurColor, float4(fast::clamp(buffer.u_blurRadiusPx / 45.0, 0.0, 1.0)));
    float4 _266 = baseColor;
    float3 _268 = _266.xyz * buffer.u_exposure;
    baseColor.x = _268.x;
    baseColor.y = _268.y;
    baseColor.z = _268.z;
    float glowUvX = buffer.u_holoEdgeGlowPx / fast::max(buffer.u_resolution.x * buffer.u_uvScale.x, 1.0);
    float glowUvY = buffer.u_holoEdgeGlowPx / fast::max(buffer.u_resolution.y * buffer.u_uvScale.y, 1.0);
    float edgeDist = fast::min(fast::min(in.vUv.x, 1.0 - in.vUv.x), fast::min(in.vUv.y, 1.0 - in.vUv.y));
    float edgeMask = 1.0 - smoothstep(0.0, fast::max(glowUvX, glowUvY), edgeDist);
    float3 finalRgb = baseColor.xyz + (((buffer.u_holoEdgeColor * edgeMask) * fast::clamp(buffer.u_holoEdgeGlowPx / 2.0, 0.0, 1.0)) * 0.3499999940395355224609375);
    out.gl_FragColor = float4(finalRgb, 1.0);
    return out;
}

