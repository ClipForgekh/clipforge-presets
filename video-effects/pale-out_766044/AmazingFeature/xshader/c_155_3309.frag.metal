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
    float u_time;
    float u_sectorCount;
    float u_progress;
    float u_blurRadius;
    float u_radialStretch;
    float u_grainAmount;
    float u_paperBlend;
    float3 u_paperColor;
    float u_fadeToBlack;
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
float2 aspectPolarCoord(thread const float2& uv, constant float& ratio)
{
    float2 p = uv - float2(0.5);
    if (ratio > 1.0)
    {
        p.y /= ratio;
    }
    else
    {
        p.x *= ratio;
    }
    return p;
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 456.209991455078125));
    p += float2(dot(p, p + float2(45.31999969482421875)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float4 watercolorSample(thread const float2& uv, thread const float2& dir, thread const float& blur, thread const float& stretch, thread const float& grain, thread const float& radialMask, constant float& u_time, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 tangential = float2(-dir.y, dir.x);
    float4 accum = float4(0.0);
    float weightSum = 0.0;
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        float w = 1.0 - (abs(fi) / 4.5);
        float radialStep = (((fi * blur) * 0.0599999986588954925537109375) * (1.0 + (stretch * 1.60000002384185791015625))) * (0.3499999940395355224609375 + (radialMask * 1.35000002384185791015625));
        float tangentStep = (fi * blur) * 0.017999999225139617919921875;
        float2 param = (uv * 120.0) + float2(fi, u_time * 7.30000019073486328125);
        float _149 = hash21(param);
        float n = _149 - 0.5;
        float2 grainOffset = (((tangential * n) * grain) * 0.0280000008642673492431640625) + (((dir * n) * grain) * 0.01200000010430812835693359375);
        float2 sampleUv = ((uv + (dir * radialStep)) + (tangential * tangentStep)) + grainOffset;
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        accum += (texture1.sample(texture1Smplr, sampleUv) * w);
        weightSum += w;
    }
    return accum / float4(fast::max(weightSum, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float2 param = uv;
    float2 p = aspectPolarCoord(param, buffer.ratio);
    float r = length(p);
    float angle = precise::atan2(p.y, p.x) + 3.1415927410125732421875;
    float sectorN = fast::max(1.0, buffer.u_sectorCount);
    float sectorSpan = 6.283185482025146484375 / sectorN;
    float sectorIndex = floor(angle / sectorSpan);
    float sectorCenterAngle = ((sectorIndex + 0.5) * sectorSpan) - 3.1415927410125732421875;
    float2 sectorDir = fast::normalize(float2(cos(sectorCenterAngle), sin(sectorCenterAngle)));
    float stageExpand = smoothstep(0.0500000007450580596923828125, 0.949999988079071044921875, buffer.u_progress - (r * 0.7200000286102294921875));
    float centerFourMask = 1.0;
    if (buffer.u_sectorCount > 4.5)
    {
        float m = mod(sectorIndex, 3.0);
        centerFourMask = 1.0 - smoothstep(0.1500000059604644775390625, 0.550000011920928955078125, m);
        centerFourMask = fast::max(centerFourMask, smoothstep(0.25, 0.949999988079071044921875, buffer.u_progress));
    }
    float activeMask = fast::clamp(stageExpand * centerFourMask, 0.0, 1.0);
    float localBlur = buffer.u_blurRadius * (0.3499999940395355224609375 + (activeMask * 1.2999999523162841796875));
    float localStretch = buffer.u_radialStretch * (0.3499999940395355224609375 + (activeMask * 1.39999997615814208984375));
    float localGrain = buffer.u_grainAmount * (0.60000002384185791015625 + (activeMask * 0.800000011920928955078125));
    float2 param_1 = uv;
    float2 param_2 = sectorDir;
    float param_3 = localBlur;
    float param_4 = localStretch;
    float param_5 = localGrain;
    float param_6 = r;
    float4 texColor = watercolorSample(param_1, param_2, param_3, param_4, param_5, param_6, buffer.u_time, texture1, texture1Smplr);
    float centerResidue = ((1.0 - smoothstep(0.0, 0.36000001430511474609375, r)) * activeMask) * (1.0 - buffer.u_paperBlend);
    float4 _341 = texColor;
    float3 _343 = _341.xyz * (1.0 + (centerResidue * 0.25));
    texColor.x = _343.x;
    texColor.y = _343.y;
    texColor.z = _343.z;
    float3 paperMixed = mix(texColor.xyz, buffer.u_paperColor, float3(fast::clamp(buffer.u_paperBlend, 0.0, 1.0)));
    float3 finalColor = mix(paperMixed, float3(0.0), float3(fast::clamp(buffer.u_fadeToBlack, 0.0, 1.0)));
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

