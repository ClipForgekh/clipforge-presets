#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float2 uvScale;
    float2 uvOffset;
    float u_dissolveProgress;
    float u_pixelSize;
    float u_particleProgress;
    float u_particleAlpha;
    float u_blackMix;
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
float2 getMappedUv(thread const float2& uv, constant float2& uvScale, constant float2& uvOffset)
{
    return (uv * uvScale) + uvOffset;
}

static inline __attribute__((always_inline))
float2 getAspectCorrectUV(thread const float2& uv, constant float& ratio)
{
    float2 aspectUV = uv;
    if (ratio > 1.0)
    {
        aspectUV.y /= ratio;
        aspectUV.y += ((1.0 - (1.0 / ratio)) * 0.5);
    }
    else
    {
        aspectUV.x *= ratio;
        aspectUV.x += ((1.0 - ratio) * 0.5);
    }
    return aspectUV;
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float2 hash22(thread const float2& p)
{
    float2 param = p;
    float n = hash12(param);
    float2 param_1 = (p + float2(n)) + float2(17.729999542236328125);
    return float2(n, hash12(param_1));
}

static inline __attribute__((always_inline))
float heartSDF(thread float2& p)
{
    p.x = abs(p.x);
    if ((p.y + p.x) > 1.0)
    {
        return sqrt(dot(p - float2(0.25, 0.75), p - float2(0.25, 0.75))) - 0.3535533845424652099609375;
    }
    return sqrt(fast::min(dot(p - float2(0.0, 1.0), p - float2(0.0, 1.0)), dot(p - float2(0.5), p - float2(0.5)))) * sign(p.x - p.y);
}

static inline __attribute__((always_inline))
float generatePixelHeart(thread const float2& localUv)
{
    float2 p = (localUv * 2.0) - float2(1.0);
    p.y = -p.y;
    p *= 1.2000000476837158203125;
    p.y += 0.1500000059604644775390625;
    float2 param = p;
    float _203 = heartSDF(param);
    float d = _203;
    return 1.0 - smoothstep(-0.07999999821186065673828125, 0.07999999821186065673828125, d);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 mappedUv = getMappedUv(param, buffer.uvScale, buffer.uvOffset);
    float4 texColor = texture1.sample(texture1Smplr, mappedUv);
    float2 param_1 = in.vUv;
    float2 aspectUv = getAspectCorrectUV(param_1, buffer.ratio);
    float2 param_2 = float2(0.5);
    float2 center = getAspectCorrectUV(param_2, buffer.ratio);
    float2 delta = aspectUv - center;
    float radial = length(delta);
    float2 radialDir = fast::normalize(delta + float2(9.9999997473787516355514526367188e-06));
    float maxRadius = 0.7200000286102294921875;
    float dissolveRadius = buffer.u_dissolveProgress * maxRadius;
    float pixelSize = fast::max(buffer.u_pixelSize, 0.001000000047497451305389404296875);
    float2 cellId = floor(in.vUv / float2(pixelSize));
    float2 cellOrigin = cellId * pixelSize;
    float2 cellCenterUv = cellOrigin + float2(pixelSize * 0.5);
    float2 param_3 = cellCenterUv;
    float2 cellAspectUv = getAspectCorrectUV(param_3, buffer.ratio);
    float2 cellDelta = cellAspectUv - center;
    float cellRadial = length(cellDelta);
    float2 cellDir = fast::normalize(cellDelta + float2(9.9999997473787516355514526367188e-06));
    float2 param_4 = cellId;
    float2 rnd = hash22(param_4);
    float boundaryWidth = pixelSize * 1.75;
    float boundaryMask = 1.0 - smoothstep(boundaryWidth * 0.20000000298023223876953125, boundaryWidth, abs(cellRadial - dissolveRadius));
    float activationMask = step(cellRadial, dissolveRadius + boundaryWidth);
    float spawnMask = (step(0.4199999868869781494140625, rnd.x) * boundaryMask) * activationMask;
    float travel = buffer.u_particleProgress * (0.180000007152557373046875 + (0.4199999868869781494140625 * rnd.y));
    float2 particleUv = cellCenterUv + (cellDir * travel);
    float2 particleLocalUv = (in.vUv - (particleUv - float2(pixelSize * 0.5))) / float2(pixelSize);
    float2 param_5 = particleLocalUv;
    float heartMask = generatePixelHeart(param_5) * spawnMask;
    float2 param_6 = fast::clamp(cellCenterUv, float2(0.0), float2(1.0));
    float4 particleSample = texture1.sample(texture1Smplr, getMappedUv(param_6, buffer.uvScale, buffer.uvOffset));
    float particleVisible = (heartMask * buffer.u_particleAlpha) * (1.0 - smoothstep(0.85000002384185791015625, 1.0, buffer.u_particleProgress));
    float dissolvedCell = step(cellRadial, dissolveRadius);
    float3 baseColor = mix(texColor.xyz, float3(0.0), float3(dissolvedCell * buffer.u_blackMix));
    float3 finalColor = baseColor;
    finalColor = mix(finalColor, particleSample.xyz, float3(fast::clamp(particleVisible, 0.0, 1.0)));
    if ((buffer.u_blackMix >= 0.999000012874603271484375) && (buffer.u_particleAlpha <= 0.001000000047497451305389404296875))
    {
        finalColor = float3(0.0);
    }
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

