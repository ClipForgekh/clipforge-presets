#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blurOffsetZ;
    float u_brightness;
    float u_vignette;
    float u_highlightStrength;
    float3 u_highlightColor;
    float u_grainStrength;
    float u_opacity;
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
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float3 overlayBlend(thread const float3& baseColor, thread const float3& blendColor)
{
    float3 low = (baseColor * 2.0) * blendColor;
    float3 high = float3(1.0) - (((float3(1.0) - baseColor) * 2.0) * (float3(1.0) - blendColor));
    return mix(low, high, step(float3(0.5), baseColor));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 dir = in.vUv - float2(0.5);
    float blurAmount = buffer.u_blurOffsetZ * 0.0599999986588954925537109375;
    float4 sample0 = texture1.sample(texture1Smplr, fast::clamp(in.vUv, float2(0.0), float2(1.0)));
    float4 sample1 = texture1.sample(texture1Smplr, fast::clamp(in.vUv + ((dir * blurAmount) * 0.5), float2(0.0), float2(1.0)));
    float4 sample2 = texture1.sample(texture1Smplr, fast::clamp(in.vUv - ((dir * blurAmount) * 0.5), float2(0.0), float2(1.0)));
    float4 sample3 = texture1.sample(texture1Smplr, fast::clamp(in.vUv + (dir * blurAmount), float2(0.0), float2(1.0)));
    float4 sample4 = texture1.sample(texture1Smplr, fast::clamp(in.vUv - (dir * blurAmount), float2(0.0), float2(1.0)));
    float4 texColor = ((((sample0 * 0.3400000035762786865234375) + (sample1 * 0.2199999988079071044921875)) + (sample2 * 0.2199999988079071044921875)) + (sample3 * 0.10999999940395355224609375)) + (sample4 * 0.10999999940395355224609375);
    float4 _151 = texColor;
    float3 _153 = _151.xyz * buffer.u_brightness;
    texColor.x = _153.x;
    texColor.y = _153.y;
    texColor.z = _153.z;
    float distToCenter = length(in.vUv - float2(0.5));
    float vignetteMask = smoothstep(0.20000000298023223876953125, 0.87999999523162841796875, distToCenter);
    float4 _178 = texColor;
    float3 _180 = _178.xyz * (1.0 - (vignetteMask * buffer.u_vignette));
    texColor.x = _180.x;
    texColor.y = _180.y;
    texColor.z = _180.z;
    float highlightRadius = 0.100000001490116119384765625 + (buffer.u_highlightStrength * 0.64999997615814208984375);
    float highlightCore = 1.0 - smoothstep(0.0, highlightRadius, distToCenter);
    float highlightHalo = 1.0 - smoothstep(highlightRadius * 0.3499999940395355224609375, highlightRadius, distToCenter);
    float3 screenAdd = float3(1.0) - ((float3(1.0) - texColor.xyz) * (float3(1.0) - ((buffer.u_highlightColor * highlightHalo) * buffer.u_highlightStrength)));
    float4 _224 = texColor;
    float3 _230 = mix(_224.xyz, screenAdd, float3(fast::clamp(buffer.u_highlightStrength, 0.0, 1.0)));
    texColor.x = _230.x;
    texColor.y = _230.y;
    texColor.z = _230.z;
    float2 param = (in.vUv * float2(256.0)) + float2(buffer.u_highlightStrength * 10.0, buffer.u_grainStrength * 20.0);
    float grain = random(param);
    float3 grainColor = float3(grain);
    float3 param_1 = texColor.xyz;
    float3 param_2 = mix(float3(0.5), grainColor, float3(0.89999997615814208984375));
    float3 overlayColor = overlayBlend(param_1, param_2);
    float4 _267 = texColor;
    float3 _275 = mix(_267.xyz, overlayColor, float3(fast::clamp(buffer.u_grainStrength * highlightCore, 0.0, 1.0)));
    texColor.x = _275.x;
    texColor.y = _275.y;
    texColor.z = _275.z;
    out.gl_FragColor = float4(texColor.xyz, texColor.w * buffer.u_opacity);
    return out;
}

