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
    float2 FBS;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
void initQuality(thread spvUnsafeArray<float, 10>& QUALITY)
{
    QUALITY[0] = 1.5;
    QUALITY[1] = 2.0;
    QUALITY[2] = 2.0;
    QUALITY[3] = 2.0;
    QUALITY[4] = 2.0;
    QUALITY[5] = 4.0;
    QUALITY[6] = 8.0;
}

static inline __attribute__((always_inline))
float rgb2luma(thread const float3& rgb)
{
    return sqrt(dot(rgb, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
}

static inline __attribute__((always_inline))
float sampleNeighborLuma(texture2d<float> texSampler, sampler texSamplerSmplr, thread const float2& texCoord)
{
    float3 param = texSampler.sample(texSamplerSmplr, texCoord).xyz;
    return rgb2luma(param);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    spvUnsafeArray<float, 10> QUALITY;
    initQuality(QUALITY);
    float2 _75 = float2(1.0) / buffer.FBS;
    float2 inverseScreenSize = _75;
    float2 In = in.v_uv;
    float4 _88 = inputImageTexture.sample(inputImageTextureSmplr, in.v_uv);
    float3 param = _88.xyz;
    float _96 = rgb2luma(param);
    float2 param_1 = in.v_uv + (float2(0.0, -1.0) / buffer.FBS);
    float _106 = sampleNeighborLuma(inputImageTexture, inputImageTextureSmplr, param_1);
    float2 param_2 = in.v_uv + (float2(0.0, 1.0) / buffer.FBS);
    float _114 = sampleNeighborLuma(inputImageTexture, inputImageTextureSmplr, param_2);
    float2 param_3 = in.v_uv + (float2(-1.0, 0.0) / buffer.FBS);
    float _122 = sampleNeighborLuma(inputImageTexture, inputImageTextureSmplr, param_3);
    float2 param_4 = in.v_uv + (float2(1.0, 0.0) / buffer.FBS);
    float _130 = sampleNeighborLuma(inputImageTexture, inputImageTextureSmplr, param_4);
    float _150 = fast::max(_96, fast::max(fast::max(_106, _114), fast::max(_122, _130)));
    float _154 = _150 - fast::min(_96, fast::min(fast::min(_106, _114), fast::min(_122, _130)));
    if (_154 < fast::max(0.031199999153614044189453125, _150 * 0.125))
    {
        out.o_fragColor = _88;
        return out;
    }
    float2 param_5 = in.v_uv + (float2(-1.0) / buffer.FBS);
    float _176 = sampleNeighborLuma(inputImageTexture, inputImageTextureSmplr, param_5);
    float2 param_6 = in.v_uv + _75;
    float _184 = sampleNeighborLuma(inputImageTexture, inputImageTextureSmplr, param_6);
    float2 param_7 = in.v_uv + (float2(-1.0, 1.0) / buffer.FBS);
    float _192 = sampleNeighborLuma(inputImageTexture, inputImageTextureSmplr, param_7);
    float2 param_8 = in.v_uv + (float2(1.0, -1.0) / buffer.FBS);
    float _200 = sampleNeighborLuma(inputImageTexture, inputImageTextureSmplr, param_8);
    float _204 = _106 + _114;
    float _208 = _122 + _130;
    float _212 = _176 + _192;
    float _220 = _200 + _184;
    bool _268 = (fma(abs(fma(-2.0, _96, _204)), 2.0, abs(fma(-2.0, _122, _212))) + abs(fma(-2.0, _130, _220))) >= (fma(abs(fma(-2.0, _96, _208)), 2.0, abs(fma(-2.0, _114, _184 + _192))) + abs(fma(-2.0, _106, _176 + _200)));
    float _273 = _268 ? _106 : _122;
    float _278 = _268 ? _114 : _130;
    float _289 = abs(_273 - _96);
    float _291 = abs(_278 - _96);
    float _300 = 0.25 * fast::max(_289, _291);
    float _303;
    if (_268)
    {
        _303 = inverseScreenSize.y;
    }
    else
    {
        _303 = inverseScreenSize.x;
    }
    float stepLength = _303;
    float lumaLocalAverage = 0.0;
    if (_289 >= _291)
    {
        stepLength = -stepLength;
        lumaLocalAverage = 0.5 * (_273 + _96);
    }
    else
    {
        lumaLocalAverage = 0.5 * (_278 + _96);
    }
    float2 currentUv = in.v_uv;
    if (_268)
    {
        currentUv.y = fma(stepLength, 0.5, currentUv.y);
    }
    else
    {
        currentUv.x = fma(stepLength, 0.5, currentUv.x);
    }
    float2 _350;
    if (_268)
    {
        _350 = float2(inverseScreenSize.x, 0.0);
    }
    else
    {
        _350 = float2(0.0, inverseScreenSize.y);
    }
    float2 _364 = currentUv - _350;
    float2 uv1 = _364;
    float2 uv2 = currentUv + _350;
    float3 param_9 = inputImageTexture.sample(inputImageTextureSmplr, _364).xyz;
    float lumaEnd1 = rgb2luma(param_9);
    float3 param_10 = inputImageTexture.sample(inputImageTextureSmplr, uv2).xyz;
    float _384 = lumaEnd1;
    float _385 = _384 - lumaLocalAverage;
    lumaEnd1 = _385;
    float _388 = rgb2luma(param_10) - lumaLocalAverage;
    float lumaEnd2 = _388;
    bool _393 = abs(_385) >= _300;
    bool reached1 = _393;
    bool _398 = abs(_388) >= _300;
    bool reached2 = _398;
    bool reachedBoth = _393 && _398;
    if (!_393)
    {
        uv1 -= _350;
    }
    if (!reached2)
    {
        uv2 += _350;
    }
    if (!reachedBoth)
    {
        for (int i = 2; i < 12; i++)
        {
            if (!reached1)
            {
                float3 param_11 = inputImageTexture.sample(inputImageTextureSmplr, uv1).xyz;
                lumaEnd1 = rgb2luma(param_11) - lumaLocalAverage;
            }
            if (!reached2)
            {
                float3 param_12 = inputImageTexture.sample(inputImageTextureSmplr, uv2).xyz;
                lumaEnd2 = rgb2luma(param_12) - lumaLocalAverage;
            }
            bool _460 = abs(lumaEnd1) >= _300;
            reached1 = _460;
            bool _464 = abs(lumaEnd2) >= _300;
            reached2 = _464;
            reachedBoth = _460 && _464;
            if (!_460)
            {
                if (i == 2)
                {
                    uv1 -= (_350 * QUALITY[2]);
                }
                else
                {
                    if (i == 3)
                    {
                        uv1 -= (_350 * QUALITY[3]);
                    }
                    else
                    {
                        if (i == 4)
                        {
                            uv1 -= (_350 * QUALITY[4]);
                        }
                        else
                        {
                            if (i == 5)
                            {
                                uv1 -= (_350 * QUALITY[5]);
                            }
                            else
                            {
                                if (i == 6)
                                {
                                    uv1 -= (_350 * QUALITY[6]);
                                }
                                else
                                {
                                    if (i == 7)
                                    {
                                        uv1 -= (_350 * QUALITY[7]);
                                    }
                                    else
                                    {
                                        if (i == 8)
                                        {
                                            uv1 -= (_350 * QUALITY[8]);
                                        }
                                        else
                                        {
                                            if (i == 9)
                                            {
                                                uv1 -= (_350 * QUALITY[9]);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (!reached2)
            {
                if (i == 2)
                {
                    uv2 += (_350 * QUALITY[2]);
                }
                else
                {
                    if (i == 3)
                    {
                        uv2 += (_350 * QUALITY[3]);
                    }
                    else
                    {
                        if (i == 4)
                        {
                            uv2 += (_350 * QUALITY[4]);
                        }
                        else
                        {
                            if (i == 5)
                            {
                                uv2 += (_350 * QUALITY[5]);
                            }
                            else
                            {
                                if (i == 6)
                                {
                                    uv2 += (_350 * QUALITY[6]);
                                }
                                else
                                {
                                    if (i == 7)
                                    {
                                        uv2 += (_350 * QUALITY[7]);
                                    }
                                    else
                                    {
                                        if (i == 8)
                                        {
                                            uv2 += (_350 * QUALITY[8]);
                                        }
                                        else
                                        {
                                            if (i == 9)
                                            {
                                                uv2 += (_350 * QUALITY[9]);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (reachedBoth)
            {
                break;
            }
        }
    }
    float _661;
    if (_268)
    {
        _661 = In.x - uv1.x;
    }
    else
    {
        _661 = In.y - uv1.y;
    }
    float _678;
    if (_268)
    {
        _678 = uv2.x - In.x;
    }
    else
    {
        _678 = uv2.y - In.y;
    }
    float _745 = fast::clamp(abs(fma(0.083333335816860198974609375, fma(2.0, _204 + _208, _212) + _220, -_96)) / _154, 0.0, 1.0);
    float _754 = (fma(-2.0, _745, 3.0) * _745) * _745;
    float _763 = fast::max(((((_661 < _678) ? lumaEnd1 : lumaEnd2) < 0.0) != (_96 < lumaLocalAverage)) ? (((-fast::min(_661, _678)) / (_661 + _678)) + 0.5) : 0.0, (_754 * _754) * 0.75);
    float2 finalUv = in.v_uv;
    if (_268)
    {
        finalUv.y = fma(_763, stepLength, finalUv.y);
    }
    else
    {
        finalUv.x = fma(_763, stepLength, finalUv.x);
    }
    out.o_fragColor = inputImageTexture.sample(inputImageTextureSmplr, finalUv);
    return out;
}

