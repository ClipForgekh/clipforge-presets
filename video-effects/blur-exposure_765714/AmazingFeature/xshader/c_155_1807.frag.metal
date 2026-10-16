#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    float ratio;
    float u_blurRadius;
    float u_exposureIntensity;
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
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, constant float& ratio)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    spvUnsafeArray<float, 25> kernel0;
    kernel0[0] = 1.0;
    kernel0[1] = 4.0;
    kernel0[2] = 6.0;
    kernel0[3] = 4.0;
    kernel0[4] = 1.0;
    kernel0[5] = 4.0;
    kernel0[6] = 16.0;
    kernel0[7] = 24.0;
    kernel0[8] = 16.0;
    kernel0[9] = 4.0;
    kernel0[10] = 6.0;
    kernel0[11] = 24.0;
    kernel0[12] = 36.0;
    kernel0[13] = 24.0;
    kernel0[14] = 6.0;
    kernel0[15] = 4.0;
    kernel0[16] = 16.0;
    kernel0[17] = 24.0;
    kernel0[18] = 16.0;
    kernel0[19] = 4.0;
    kernel0[20] = 1.0;
    kernel0[21] = 4.0;
    kernel0[22] = 6.0;
    kernel0[23] = 4.0;
    kernel0[24] = 1.0;
    float baseStep = 0.001000000047497451305389404296875 * blurStrength;
    float2 stepSize = float2(baseStep, baseStep / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    for (int i = -2; i <= 2; i++)
    {
        for (int j = -2; j <= 2; j++)
        {
            float weight = kernel0[((i + 2) * 5) + (j + 2)];
            float2 offset = float2(float(i) * stepSize.x, float(j) * stepSize.y);
            float2 sampleUV = fast::clamp(uv + offset, float2(0.0), float2(1.0));
            color += (tex.sample(texSmplr, sampleUV) * weight);
            totalWeight += weight;
        }
    }
    return color / float4(fast::max(totalWeight, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_blurRadius;
    float4 texColor = gaussianBlur(texture1, texture1Smplr, param, param_1, buffer.ratio);
    float4 _184 = texColor;
    float3 _186 = _184.xyz * buffer.u_exposureIntensity;
    texColor.x = _186.x;
    texColor.y = _186.y;
    texColor.z = _186.z;
    float4 _194 = texColor;
    float3 _203 = mix(_194.xyz, float3(1.0), float3(fast::clamp((buffer.u_exposureIntensity - 1.0) / 2.0, 0.0, 1.0)));
    texColor.x = _203.x;
    texColor.y = _203.y;
    texColor.z = _203.z;
    float4 _212 = texColor;
    float3 _214 = _212.xyz * buffer.u_brightness;
    texColor.x = _214.x;
    texColor.y = _214.y;
    texColor.z = _214.z;
    out.gl_FragColor = float4(fast::clamp(texColor.xyz, float3(0.0), float3(1.0)), texColor.w);
    return out;
}

