#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float swayAmount;
    float glitchAmount;
    float tearBlur;
    float glowIntensity;
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
    return ((3.0 * p) * p) - (((2.0 * p) * p) * p);
}

static inline __attribute__((always_inline))
float hash(thread const float2& p)
{
    return fract(sin(dot(p, float2(127.09999847412109375, 311.70001220703125))) * 43758.546875);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalTearBlur(thread const float2& uv, thread const float& radiusUv, thread const float& strength, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    if (strength <= 9.9999997473787516355514526367188e-05)
    {
        float4 _94 = tDiffuse.sample(tDiffuseSmplr, uv);
        return _94;
    }
    float2 o = float2(0.0, radiusUv * strength);
    float4 c = float4(0.0);
    float2 param = uv - (o * 1.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * 0.119999997317790985107421875);
    float2 param_1 = uv - (o * 0.60000002384185791015625);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.180000007152557373046875);
    float2 param_2 = uv - (o * 0.300000011920928955078125);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.20000000298023223876953125);
    float2 param_3 = uv;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.20000000298023223876953125);
    float2 param_4 = uv + (o * 0.300000011920928955078125);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.1599999964237213134765625);
    float2 param_5 = uv + (o * 0.699999988079071044921875);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * 0.0900000035762786865234375);
    float2 param_6 = uv + (o * 1.10000002384185791015625);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * 0.0500000007450580596923828125);
    return c;
}

static inline __attribute__((always_inline))
float3 applyContrastBrightness(thread float3& col, thread const float& contrast, thread const float& brightness)
{
    col = ((col - float3(0.5)) * contrast) + float3(0.5);
    col *= brightness;
    return fast::clamp(col, float3(0.0), float3(1.0));
}

static inline __attribute__((always_inline))
float3 scanColor(thread const float& t)
{
    float3 purple = float3(0.7200000286102294921875, 0.2199999988079071044921875, 1.0);
    float3 orange = float3(1.0, 0.560000002384185791015625, 0.119999997317790985107421875);
    return mix(purple, orange, float3(fast::clamp(t, 0.0, 1.0)));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& swayAmount, thread float2& vUv, constant float& glitchAmount, constant float& tearBlur, constant float& glowIntensity)
{
    float p1 = p;
    float p2 = fast::clamp((p - 0.039999999105930328369140625) / 0.959999978542327880859375, 0.0, 1.0);
    float p3 = fast::clamp((p - 0.07999999821186065673828125) / 0.920000016689300537109375, 0.0, 1.0);
    float y1 = (-0.0625) + (p1 * 1.125);
    float y2 = (-0.0625) + (p2 * 1.125);
    float y3 = (-0.0625) + (p3 * 1.125);
    float sx1 = 0.1599999964237213134765625 + (sin(((p1 * 9.30000019073486328125) + 0.100000001490116119384765625) * 6.283185482025146484375) * swayAmount);
    float sx2 = 0.5 + (sin(((p2 * 8.69999980926513671875) + 0.4000000059604644775390625) * 6.283185482025146484375) * swayAmount);
    float sx3 = 0.839999973773956298828125 + (sin(((p3 * 9.8999996185302734375) + 0.699999988079071044921875) * 6.283185482025146484375) * swayAmount);
    float bandHalf = 0.0625;
    float trackHalf = 0.189999997615814208984375;
    float by1 = 1.0 - smoothstep(bandHalf, bandHalf + 0.0199999995529651641845703125, abs(vUv.y - y1));
    float by2 = 1.0 - smoothstep(bandHalf, bandHalf + 0.0199999995529651641845703125, abs(vUv.y - y2));
    float by3 = 1.0 - smoothstep(bandHalf, bandHalf + 0.0199999995529651641845703125, abs(vUv.y - y3));
    float bx1 = 1.0 - smoothstep(trackHalf, trackHalf + 0.119999997317790985107421875, abs(vUv.x - sx1));
    float bx2 = 1.0 - smoothstep(trackHalf, trackHalf + 0.119999997317790985107421875, abs(vUv.x - sx2));
    float bx3 = 1.0 - smoothstep(trackHalf, trackHalf + 0.119999997317790985107421875, abs(vUv.x - sx3));
    float band1 = by1 * bx1;
    float band2 = by2 * bx2;
    float band3 = by3 * bx3;
    float bandMask = fast::clamp((band1 + band2) + band3, 0.0, 1.0);
    float clean1 = step(vUv.y, y1 - bandHalf);
    float clean2 = step(vUv.y, y2 - bandHalf);
    float clean3 = step(vUv.y, y3 - bandHalf);
    float cleanMask = fast::clamp(fast::max(clean1, fast::max(clean2, clean3)), 0.0, 1.0);
    float recover = fast::clamp(fast::max(cleanMask, p), 0.0, 1.0);
    float glitchStrength = (1.0 - recover) * glitchAmount;
    float nearBand = 0.0;
    nearBand += ((1.0 - smoothstep(bandHalf, bandHalf + 0.0599999986588954925537109375, abs(vUv.y - y1))) * bx1);
    nearBand += ((1.0 - smoothstep(bandHalf, bandHalf + 0.0599999986588954925537109375, abs(vUv.y - y2))) * bx2);
    nearBand += ((1.0 - smoothstep(bandHalf, bandHalf + 0.0599999986588954925537109375, abs(vUv.y - y3))) * bx3);
    nearBand = fast::clamp(nearBand, 0.0, 1.0);
    float2 param = float2(floor(vUv.y * 260.0), floor(p * 180.0));
    float lineNoise = hash(param);
    float tearShift = ((lineNoise - 0.5) * 0.02999999932944774627685546875) * glitchStrength;
    float2 param_1 = vUv + float2(tearShift, 0.0);
    float2 baseUV = handleUVBounds(param_1);
    float blurRadiusUv = 0.02777777798473834991455078125 * tearBlur;
    float blurStrength = fast::clamp(glitchStrength * (0.3499999940395355224609375 + (0.64999997615814208984375 * nearBand)), 0.0, 1.0);
    float2 param_2 = baseUV;
    float param_3 = blurRadiusUv;
    float param_4 = blurStrength;
    float4 blurred = verticalTearBlur(param_2, param_3, param_4, tDiffuse, tDiffuseSmplr);
    float ca = 0.008000000379979610443115234375 * glitchStrength;
    float2 caVec = float2(ca * (0.5 + lineNoise), 0.0);
    float2 param_5 = baseUV + caVec;
    float2 uvR = handleUVBounds(param_5);
    float2 uvG = baseUV;
    float2 param_6 = baseUV - caVec;
    float2 uvB = handleUVBounds(param_6);
    float3 rgbShift = float3(tDiffuse.sample(tDiffuseSmplr, uvR).x, tDiffuse.sample(tDiffuseSmplr, uvG).y, tDiffuse.sample(tDiffuseSmplr, uvB).z);
    float3 glitched = mix(blurred.xyz, rgbShift, float3(fast::clamp(glitchStrength * 0.89999997615814208984375, 0.0, 1.0)));
    float contrast = mix(0.5, 1.0, recover);
    float brightness = mix(2.2000000476837158203125, 1.0, recover);
    float3 param_7 = glitched;
    float param_8 = contrast;
    float param_9 = brightness;
    float3 _582 = applyContrastBrightness(param_7, param_8, param_9);
    float3 col = _582;
    float glowFade = 1.0 - p;
    float3 glowCol = float3(0.0);
    float param_10 = vUv.x + (p1 * 0.300000011920928955078125);
    glowCol += (scanColor(param_10) * band1);
    float param_11 = (vUv.x + (p2 * 0.3499999940395355224609375)) + 0.20000000298023223876953125;
    glowCol += (scanColor(param_11) * band2);
    float param_12 = (vUv.x + (p3 * 0.4000000059604644775390625)) + 0.4000000059604644775390625;
    glowCol += (scanColor(param_12) * band3);
    col += (((glowCol * glowIntensity) * glowFade) * 0.449999988079071044921875);
    float dissolve = (1.0 - p) * smoothstep(0.85000002384185791015625, 1.0, p);
    float2 param_13 = floor(vUv * float2(220.0)) + float2(p * 40.0, p * 17.0);
    float px = step(0.819999992847442626953125, hash(param_13));
    col = mix(col, col * (0.75 + (0.25 * px)), float3(dissolve * bandMask));
    col = fast::clamp(col, float3(0.0), float3(1.0));
    return float4(col, texel.w);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, buffer.swayAmount, in.vUv, buffer.glitchAmount, buffer.tearBlur, buffer.glowIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

