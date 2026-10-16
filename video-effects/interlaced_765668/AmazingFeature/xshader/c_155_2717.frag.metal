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
    float u_segmentCount;
    float u_decayStepDelay;
    float u_timeProgress;
    float u_verticalOffset;
    float u_blurRadius;
    float u_scanlineWidthPx;
    float u_scanlineIntensity;
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
float4 verticalBlurSample(thread const float2& uv, thread const float& radius, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 stepOffset = float2(0.0, radius);
    float4 color = float4(0.0);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + (stepOffset * (-2.0)), float2(0.0), float2(1.0))) * 0.121621601283550262451171875);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + (stepOffset * (-1.0)), float2(0.0), float2(1.0))) * 0.2332431972026824951171875);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.2902702987194061279296875);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + (stepOffset * 1.0), float2(0.0), float2(1.0))) * 0.2332431972026824951171875);
    color += (texture1.sample(texture1Smplr, fast::clamp(uv + (stepOffset * 2.0), float2(0.0), float2(1.0))) * 0.121621601283550262451171875);
    return color;
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
    float segmentHeight = 1.0 / buffer.u_segmentCount;
    float segmentIndex = floor((1.0 - uv.y) * buffer.u_segmentCount);
    segmentIndex = fast::clamp(segmentIndex, 0.0, buffer.u_segmentCount - 1.0);
    float delay = segmentIndex * buffer.u_decayStepDelay;
    float localProgress = fast::clamp((buffer.u_timeProgress - delay) / fast::max(1.0 - delay, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
    float remain = 1.0 - localProgress;
    float parity = mod(segmentIndex, 2.0);
    float direction = mix(1.0, -1.0, parity);
    float2 sampleUv = uv;
    sampleUv.y += ((direction * buffer.u_verticalOffset) * remain);
    sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
    float blurRadius = buffer.u_blurRadius * remain;
    float2 param = sampleUv;
    float param_1 = blurRadius;
    float4 texColor = verticalBlurSample(param, param_1, texture1, texture1Smplr);
    float screenHeight = 600.0;
    float lineWidthUv = buffer.u_scanlineWidthPx / screenHeight;
    float withinSegment = mod(uv.y, segmentHeight);
    float edgeDist = fast::min(withinSegment, segmentHeight - withinSegment);
    float scanMask = 1.0 - smoothstep(0.0, lineWidthUv, edgeDist);
    float scanlineAmount = (buffer.u_scanlineIntensity * remain) * scanMask;
    float2 param_2 = (uv * float2(512.0)) + float2(segmentIndex * 7.13000011444091796875, buffer.u_timeProgress * 19.3700008392333984375);
    float grain = (hash12(param_2) - 0.5) * 2.0;
    float grainAmount = (grain * buffer.u_grainIntensity) * remain;
    float4 _264 = texColor;
    float3 _266 = _264.xyz + float3(scanlineAmount);
    texColor.x = _266.x;
    texColor.y = _266.y;
    texColor.z = _266.z;
    float4 _275 = texColor;
    float3 _277 = _275.xyz + float3(grainAmount);
    texColor.x = _277.x;
    texColor.y = _277.y;
    texColor.z = _277.z;
    float4 _284 = texColor;
    float3 _288 = fast::clamp(_284.xyz, float3(0.0), float3(1.0));
    texColor.x = _288.x;
    texColor.y = _288.y;
    texColor.z = _288.z;
    out.gl_FragColor = texColor;
    return out;
}

