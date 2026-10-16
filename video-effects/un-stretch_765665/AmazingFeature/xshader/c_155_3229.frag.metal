#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_verticalStretchEdge;
    float ratio;
    float u_verticalBlurPx;
    float u_highlightConverge;
    float u_highlightTop;
    float u_highlightBottom;
    float3 u_highlightColor;
    float u_filmGrain;
    float u_chromatic;
    float u_grayscale;
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
float2 getMappedUv(thread const float2& uv, constant float& u_verticalStretchEdge)
{
    float edgeDist = abs(uv.y - 0.5) * 2.0;
    float edgeWeight = pow(fast::clamp(edgeDist, 0.0, 1.0), 0.699999988079071044921875);
    float stretch = mix(1.0, u_verticalStretchEdge, edgeWeight);
    float mappedY = ((uv.y - 0.5) / fast::max(stretch, 9.9999997473787516355514526367188e-05)) + 0.5;
    return float2(uv.x, fast::clamp(mappedY, 0.0, 1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurPx, constant float& ratio)
{
    float baseStep = blurPx / 600.0;
    float stepY = baseStep / fast::max(ratio, 9.9999997473787516355514526367188e-05);
    float4 c = float4(0.0);
    c += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, (-4.0) * stepY), float2(0.0), float2(1.0))) * 0.0599999986588954925537109375);
    c += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, (-3.0) * stepY), float2(0.0), float2(1.0))) * 0.0900000035762786865234375);
    c += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, (-2.0) * stepY), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    c += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, (-1.0) * stepY), float2(0.0), float2(1.0))) * 0.1500000059604644775390625);
    c += (tex.sample(texSmplr, uv) * 0.1599999964237213134765625);
    c += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, 1.0 * stepY), float2(0.0), float2(1.0))) * 0.1500000059604644775390625);
    c += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, 2.0 * stepY), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    c += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, 3.0 * stepY), float2(0.0), float2(1.0))) * 0.0900000035762786865234375);
    c += (tex.sample(texSmplr, fast::clamp(uv + float2(0.0, 4.0 * stepY), float2(0.0), float2(1.0))) * 0.0599999986588954925537109375);
    return c;
}

static inline __attribute__((always_inline))
float rand(thread const float2& co)
{
    return fract(sin(dot(co, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 mappedUv = getMappedUv(param, buffer.u_verticalStretchEdge);
    float2 param_1 = mappedUv;
    float param_2 = buffer.u_verticalBlurPx;
    float4 texColor = verticalBlur(texture1, texture1Smplr, param_1, param_2, buffer.ratio);
    float topPos = mix(0.920000016689300537109375, 0.5, buffer.u_highlightConverge);
    float bottomPos = mix(0.07999999821186065673828125, 0.5, buffer.u_highlightConverge);
    float bandWidth = mix(0.02500000037252902984619140625, 0.070000000298023223876953125, buffer.u_highlightConverge);
    float topBand = exp(-pow((mappedUv.y - topPos) / bandWidth, 2.0)) * buffer.u_highlightTop;
    float bottomBand = exp(-pow((mappedUv.y - bottomPos) / bandWidth, 2.0)) * buffer.u_highlightBottom;
    float highlight = fast::clamp(topBand + bottomBand, 0.0, 1.0);
    float4 _283 = texColor;
    float3 _285 = _283.xyz + ((buffer.u_highlightColor * highlight) * 0.449999988079071044921875);
    texColor.x = _285.x;
    texColor.y = _285.y;
    texColor.z = _285.z;
    float2 param_3 = in.vUv * float2(913.0999755859375, 527.70001220703125);
    float grain = (rand(param_3) - 0.5) * buffer.u_filmGrain;
    float4 _306 = texColor;
    float3 _309 = _306.xyz + float3(grain);
    texColor.x = _309.x;
    texColor.y = _309.y;
    texColor.z = _309.z;
    float2 dir = mappedUv - float2(0.5);
    float offset = buffer.u_chromatic * 0.0199999995529651641845703125;
    float r = texture1.sample(texture1Smplr, fast::clamp(mappedUv + (dir * offset), float2(0.0), float2(1.0))).x;
    float g = texture1.sample(texture1Smplr, mappedUv).y;
    float b = texture1.sample(texture1Smplr, fast::clamp(mappedUv - (dir * offset), float2(0.0), float2(1.0))).z;
    texColor = mix(texColor, float4(r, g, b, texColor.w), float4(step(9.9999997473787516355514526367188e-05, buffer.u_chromatic)));
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _374 = texColor;
    float3 _381 = mix(_374.xyz, float3(gray), float3(buffer.u_grayscale));
    texColor.x = _381.x;
    texColor.y = _381.y;
    texColor.z = _381.z;
    float4 _390 = texColor;
    float3 _392 = _390.xyz * buffer.u_brightness;
    texColor.x = _392.x;
    texColor.y = _392.y;
    texColor.z = _392.z;
    out.gl_FragColor = float4(texColor.xyz, 1.0);
    return out;
}

