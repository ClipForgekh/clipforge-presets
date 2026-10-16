#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float hasFaceFlag;
    float skinIntensity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(uv0)]];
    float2 skinUV [[user(skinUV)]];
};

static inline __attribute__((always_inline))
float3 rgb2hsv(thread const float3& c)
{
    float4 K = float4(0.0, -0.3333300054073333740234375, 0.666670024394989013671875, -1.0);
    float4 p = mix(float4(c.zy, K.wz), float4(c.yz, K.xy), float4(step(c.z, c.y)));
    float4 q = mix(float4(p.xyw, c.x), float4(c.x, p.yzx), float4(step(p.x, c.x)));
    float d = q.x - fast::min(q.w, q.y);
    float e = 1.0000000133514319600180897396058e-10;
    float s = 0.0;
    float3 hsv = float3(abs(q.z + ((q.w - q.y) / ((6.0 * d) + e))), s, q.x);
    return hsv;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> skinsegMaskTexture [[texture(1)]], texture2d<float> faceMaskTexture [[texture(2)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler skinsegMaskTextureSmplr [[sampler(1)]], sampler faceMaskTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float3 srcColor = inputImageTexture.sample(inputImageTextureSmplr, in.uv0).xyz;
    float skinColorAlpha = skinsegMaskTexture.sample(skinsegMaskTextureSmplr, in.skinUV).w;
    float3 param = srcColor;
    float3 hsvSpace = rgb2hsv(param);
    float opacity = 1.0;
    bool _141 = 0.100000001490116119384765625 <= hsvSpace.x;
    bool _148;
    if (_141)
    {
        _148 = hsvSpace.x <= 0.88999998569488525390625;
    }
    else
    {
        _148 = _141;
    }
    bool _156;
    if (!_148)
    {
        _156 = hsvSpace.z <= 0.300000011920928955078125;
    }
    else
    {
        _156 = _148;
    }
    if (_156)
    {
        opacity = 0.0;
    }
    bool _161 = 0.300000011920928955078125 < hsvSpace.z;
    bool _168;
    if (_161)
    {
        _168 = hsvSpace.z < 0.319999992847442626953125;
    }
    else
    {
        _168 = _161;
    }
    if (_168)
    {
        opacity = fast::min(opacity, (0.319999992847442626953125 - hsvSpace.z) * 50.0);
    }
    if (buffer.hasFaceFlag > 0.0)
    {
        float4 faceMask = faceMaskTexture.sample(faceMaskTextureSmplr, in.uv0);
        float3 resColor = float3(faceMask.x, faceMask.y, fast::min(faceMask.z, opacity));
        float skinArea = mix(skinColorAlpha * buffer.skinIntensity, faceMask.y * faceMask.w, step(0.100000001490116119384765625, faceMask.y));
        out.gl_FragColor = float4(float3(resColor), skinArea);
    }
    else
    {
        out.gl_FragColor = float4(float3(0.0, 0.0, skinColorAlpha), skinColorAlpha * buffer.skinIntensity);
    }
    return out;
}

