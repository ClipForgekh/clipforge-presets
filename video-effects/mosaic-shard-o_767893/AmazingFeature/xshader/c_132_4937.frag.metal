#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float shardDensity;
    float flyDistance;
    float maxBlur;
    float glowIntensity;
    float rainbowStrength;
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
float tween(thread const float& p)
{
    return (((p * p) * p) * p) * p;
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 345.45001220703125));
    p += float2(dot(p, p + float2(34.345001220703125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float2 hash22(thread const float2& p)
{
    float2 param = p;
    float _109 = hash21(param);
    float n = _109;
    float2 param_1 = (p + float2(n)) + float2(17.1299991607666015625);
    float _119 = hash21(param_1);
    return float2(n, _119);
}

static inline __attribute__((always_inline))
float4 voronoiInfo(thread const float2& uv, thread const float& cells)
{
    float2 gv = uv * cells;
    float2 id = floor(gv);
    float2 f = fract(gv);
    float d1 = 10.0;
    float d2 = 10.0;
    float2 bestId = id;
    for (int j = -1; j <= 1; j++)
    {
        for (int i = -1; i <= 1; i++)
        {
            float2 o = float2(float(i), float(j));
            float2 cid = id + o;
            float2 param = cid;
            float2 p = hash22(param);
            float2 r = (o + p) - f;
            float d = length(r);
            if (d < d1)
            {
                d2 = d1;
                d1 = d;
                bestId = cid;
            }
            else
            {
                if (d < d2)
                {
                    d2 = d;
                }
            }
        }
    }
    return float4(d1, d2, bestId);
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 blur9(thread const float2& uv, thread const float& radius, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 stepUV = float2(radius, radius / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float2 param = uv;
    float2 uv0 = handleUVBounds(param);
    float4 c = tDiffuse.sample(tDiffuseSmplr, uv0) * 0.227026998996734619140625;
    float2 param_1 = uv0 + float2(stepUV.x, 0.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.19459460675716400146484375);
    float2 param_2 = uv0 - float2(stepUV.x, 0.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.19459460675716400146484375);
    float2 param_3 = uv0 + float2(0.0, stepUV.y);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.19459460675716400146484375);
    float2 param_4 = uv0 - float2(0.0, stepUV.y);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.19459460675716400146484375);
    float2 param_5 = uv0 + stepUV;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * 0.06059800088405609130859375);
    float2 param_6 = uv0 - stepUV;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * 0.06059800088405609130859375);
    float2 param_7 = uv0 + float2(stepUV.x, -stepUV.y);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_7)) * 0.06059800088405609130859375);
    float2 param_8 = uv0 + float2(-stepUV.x, stepUV.y);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_8)) * 0.06059800088405609130859375);
    return c / float4(1.25360643863677978515625);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& shardDensity, thread float2& vUv, constant float& flyDistance, constant float& maxBlur, constant float& glowIntensity, constant float& rainbowStrength)
{
    if (p <= 9.9999999747524270787835121154785e-07)
    {
        return texel;
    }
    float cells = shardDensity;
    float2 param = vUv;
    float param_1 = cells;
    float4 vi = voronoiInfo(param, param_1);
    float edgeDist = vi.y - vi.x;
    float2 cid = vi.zw;
    float2 param_2 = cid + float2(2.71000003814697265625);
    float _372 = hash21(param_2);
    float rnd = _372;
    float2 param_3 = cid + float2(9.36999988555908203125);
    float2 rnd2 = hash22(param_3);
    float2 radial = vUv - float2(0.5);
    if (ratio > 1.0)
    {
        radial.y /= ratio;
    }
    else
    {
        radial.x *= ratio;
    }
    float2 dir = fast::normalize(radial + ((rnd2 - float2(0.5)) * 0.75));
    if (length(dir) < 9.9999997473787516355514526367188e-05)
    {
        dir = fast::normalize(rnd2 - float2(0.5));
    }
    float accel = pow(p, 1.7999999523162841796875);
    float speed = accel * (0.60000002384185791015625 + (0.800000011920928955078125 * rnd));
    float2 displacement = (dir * flyDistance) * speed;
    float2 srcUV = vUv - displacement;
    float2 param_4 = srcUV;
    float srcMask = getHardBoundaryMask(param_4);
    float blurRadius = maxBlur * speed;
    float2 param_5 = srcUV;
    float param_6 = blurRadius;
    float4 blurred = blur9(param_5, param_6, ratio, tDiffuse, tDiffuseSmplr);
    float crackWidth = 0.0350000001490116119384765625 / fast::max(cells / 18.0, 0.5);
    float crack = 1.0 - smoothstep(0.0, crackWidth, edgeDist);
    float2 local = fract(vUv * cells);
    float2 param_7 = cid;
    float2 cp = hash22(param_7);
    float localD = length(local - cp);
    float edgeToInner = smoothstep(0.119999997317790985107421875, 0.579999983310699462890625, localD);
    float cover = smoothstep(0.0, 1.0, ((p * 1.35000002384185791015625) + (edgeToInner * 0.89999997615814208984375)) - 0.25);
    float3 iceBlue = float3(0.449999988079071044921875, 0.7799999713897705078125, 1.0);
    float glow = glowIntensity * (((0.2800000011920928955078125 * crack) * (1.0 - p)) + (cover * pow(p, 1.5)));
    float2 param_8 = cid + float2(21.0);
    float _527 = hash21(param_8);
    float ang = 6.283185482025146484375 * _527;
    float2 n = float2(cos(ang), sin(ang));
    float ch = ((0.001000000047497451305389404296875 + (0.0040000001899898052215576171875 * speed)) * rainbowStrength) * (0.20000000298023223876953125 + crack);
    float2 chOff = float2(ch, ch / fast::max(ratio, 9.9999997473787516355514526367188e-05)) * n;
    float2 param_9 = srcUV + chOff;
    float2 uvR = handleUVBounds(param_9);
    float2 param_10 = srcUV;
    float2 uvG = handleUVBounds(param_10);
    float2 param_11 = srcUV - chOff;
    float2 uvB = handleUVBounds(param_11);
    float3 refractRGB = float3(tDiffuse.sample(tDiffuseSmplr, uvR).x, tDiffuse.sample(tDiffuseSmplr, uvG).y, tDiffuse.sample(tDiffuseSmplr, uvB).z);
    float3 rgb = blurred.xyz;
    rgb += (iceBlue * glow);
    rgb += (((refractRGB * crack) * glow) * 0.64999997615814208984375);
    rgb = fast::min(rgb, float3(2.5));
    float vanish = 1.0 - pow(p, 1.25);
    float tailFade = 1.0 - smoothstep(0.89999997615814208984375, 1.0, p);
    float a = ((blurred.w * srcMask) * vanish) * tailFade;
    rgb *= ((srcMask * vanish) * tailFade);
    return float4(rgb, a);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, buffer.shardDensity, in.vUv, buffer.flyDistance, buffer.maxBlur, buffer.glowIntensity, buffer.rainbowStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

