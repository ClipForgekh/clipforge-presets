#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float perspectiveStrength;
    float foldAxis;
    float foldEdge;
    float progress;
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
float tween(thread const float& progress)
{
    return 1.0 - pow(1.0 - progress, 3.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& perspectiveStrength, thread float2& vUv, constant float& foldAxis, constant float& foldEdge, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float theta = (progress * 1.57079637050628662109375) + 0.001000000047497451305389404296875;
    float sinT = sin(theta);
    float cosT = cos(theta);
    float persp = perspectiveStrength;
    float2 uv = vUv;
    float sx;
    float sy;
    float u;
    float v;
    if (foldAxis < 0.5)
    {
        float _60;
        if (foldEdge < 0.5)
        {
            _60 = uv.x;
        }
        else
        {
            _60 = 1.0 - uv.x;
        }
        sx = _60;
        sy = uv.y;
        float denom = sinT - ((sx * cosT) * persp);
        if (abs(denom) < 9.9999997473787516355514526367188e-05)
        {
            return float4(0.0);
        }
        u = sx / denom;
        float z3d = u * cosT;
        v = ((sy - 0.5) * (1.0 + (z3d * persp))) + 0.5;
        if ((((u < 0.0) || (u > 1.0)) || (v < 0.0)) || (v > 1.0))
        {
            return float4(0.0);
        }
        if (foldEdge >= 0.5)
        {
            u = 1.0 - u;
        }
        float4 _139 = tDiffuse.sample(tDiffuseSmplr, float2(u, v));
        return _139;
    }
    else
    {
        float _145;
        if (foldEdge < 0.5)
        {
            _145 = uv.y;
        }
        else
        {
            _145 = 1.0 - uv.y;
        }
        sx = _145;
        sy = uv.x;
        float denom_1 = sinT - ((sx * cosT) * persp);
        if (abs(denom_1) < 9.9999997473787516355514526367188e-05)
        {
            return float4(0.0);
        }
        u = sx / denom_1;
        float z3d_1 = u * cosT;
        v = ((sy - 0.5) * (1.0 + (z3d_1 * persp))) + 0.5;
        if ((((u < 0.0) || (u > 1.0)) || (v < 0.0)) || (v > 1.0))
        {
            return float4(0.0);
        }
        if (foldEdge >= 0.5)
        {
            u = 1.0 - u;
        }
        float4 _211 = tDiffuse.sample(tDiffuseSmplr, float2(v, u));
        return _211;
    }
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float param = effectProgress;
    effectProgress = tween(param);
    float4 param_1 = texel;
    float param_2 = effectProgress;
    float4 effectColor = effect(param_1, param_2, buffer.perspectiveStrength, in.vUv, buffer.foldAxis, buffer.foldEdge, tDiffuse, tDiffuseSmplr);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

