#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float u_verticalBlurPx;
    float u_noiseIntensity;
    float u_exposureEV;
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
float4 verticalGaussianBlur(thread const float2& uv, thread const float& blurPx, texture2d<float> texture1, sampler texture1Smplr, constant float2& u_resolution)
{
    if (blurPx <= 0.001000000047497451305389404296875)
    {
        return texture1.sample(texture1Smplr, uv);
    }
    float texelY = 1.0 / fast::max(u_resolution.y, 1.0);
    float radius = blurPx * texelY;
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    color += (texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))) * w0);
    totalWeight += w0;
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, radius * 1.0), float2(0.0), float2(1.0))) * w1);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv - float2(0.0, radius * 1.0), float2(0.0), float2(1.0))) * w1);
    totalWeight += (w1 * 2.0);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, radius * 2.0), float2(0.0), float2(1.0))) * w2);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv - float2(0.0, radius * 2.0), float2(0.0), float2(1.0))) * w2);
    totalWeight += (w2 * 2.0);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, radius * 3.0), float2(0.0), float2(1.0))) * w3);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv - float2(0.0, radius * 3.0), float2(0.0), float2(1.0))) * w3);
    totalWeight += (w3 * 2.0);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, radius * 4.0), float2(0.0), float2(1.0))) * w4);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv - float2(0.0, radius * 4.0), float2(0.0), float2(1.0))) * w4);
    totalWeight += (w4 * 2.0);
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float lineNoise(thread const float2& uv)
{
    float columnIndex = floor(uv.x * 280.0);
    float2 param = float2(columnIndex, floor(uv.y * 8.0));
    float base = random(param);
    float2 param_1 = float2(columnIndex * 1.73099994659423828125, floor(uv.y * 22.0) + 13.69999980926513671875);
    float fine = random(param_1);
    float combined = mix(base, fine, 0.449999988079071044921875);
    return (combined * 2.0) - 1.0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_verticalBlurPx;
    float4 texColor = verticalGaussianBlur(param, param_1, texture1, texture1Smplr, buffer.u_resolution);
    float2 param_2 = in.vUv;
    float stripeMask = smoothstep(0.1500000059604644775390625, 0.949999988079071044921875, abs(lineNoise(param_2)));
    float2 param_3 = in.vUv + float2(0.0, in.vUv.y * 0.03125);
    float noiseValue = lineNoise(param_3);
    float signedNoise = noiseValue * stripeMask;
    float4 _308 = texColor;
    float3 _311 = _308.xyz + float3((signedNoise * buffer.u_noiseIntensity) * 0.3499999940395355224609375);
    texColor.x = _311.x;
    texColor.y = _311.y;
    texColor.z = _311.z;
    float exposureScale = pow(2.0, buffer.u_exposureEV);
    float4 _324 = texColor;
    float3 _326 = _324.xyz * exposureScale;
    texColor.x = _326.x;
    texColor.y = _326.y;
    texColor.z = _326.z;
    float4 _335 = texColor;
    float3 _337 = _335.xyz * buffer.u_brightness;
    texColor.x = _337.x;
    texColor.y = _337.y;
    texColor.z = _337.z;
    out.gl_FragColor = float4(texColor.xyz, texColor.w);
    return out;
}

