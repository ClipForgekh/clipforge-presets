#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int u_blendMode;
    int u_layerType;
    float u_layerOpacity;
    int u_enableMatte;
    int u_matteMode;
    int u_hasBlend;
    int u_hasBaseTexture;
    int u_hasSourceTexture;
    int u_hasMatte;
};

constant float3 _2026 = {};
constant float4 _2027 = {};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

static inline __attribute__((always_inline))
float getLuminosity(thread const float3& color)
{
    return dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float4 mattePass(thread const float4& srcColor, thread float2& uv0, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, constant int& u_matteMode)
{
    if (u_enableMatte == 0)
    {
        return srcColor;
    }
    float4 _1685 = u_maskTexture.sample(u_maskTextureSmplr, uv0);
    float _1688 = _1685.w;
    float _2008;
    if (u_matteMode == 1)
    {
        float3 param = _1685.xyz;
        _2008 = getLuminosity(param);
    }
    else
    {
        float _2009;
        if (u_matteMode == 2)
        {
            _2009 = 1.0 - _1688;
        }
        else
        {
            float _2010;
            if (u_matteMode == 3)
            {
                float3 param_1 = _1685.xyz;
                _2010 = 1.0 - getLuminosity(param_1);
            }
            else
            {
                _2010 = _1688;
            }
            _2009 = _2010;
        }
        _2008 = _2009;
    }
    return srcColor * _2008;
}

static inline __attribute__((always_inline))
float softLightf(thread const float& s, thread const float& d)
{
    float _1965;
    if (s < 0.5)
    {
        _1965 = fma(-(fma(-2.0, s, 1.0) * d), 1.0 - d, d);
    }
    else
    {
        float _1964;
        if (d < 0.25)
        {
            _1964 = fma(fma(2.0, s, -1.0) * d, fma(fma(16.0, d, -12.0), d, 3.0), d);
        }
        else
        {
            _1964 = fma(fma(2.0, s, -1.0), sqrt(d) - d, d);
        }
        _1965 = _1964;
    }
    return _1965;
}

static inline __attribute__((always_inline))
float3 BlendSoftLight(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(softLightf(param, param_1), softLightf(param_2, param_3), softLightf(param_4, param_5));
}

static inline __attribute__((always_inline))
float hardLightf(thread const float& s, thread const float& d)
{
    float _1966;
    if (s < 0.5)
    {
        _1966 = (2.0 * s) * d;
    }
    else
    {
        _1966 = fma((1.0 - s) * (-2.0), 1.0 - d, 1.0);
    }
    return _1966;
}

static inline __attribute__((always_inline))
float3 BlendHardLight(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(hardLightf(param, param_1), hardLightf(param_2, param_3), hardLightf(param_4, param_5));
}

static inline __attribute__((always_inline))
float getSaturation(thread const float3& c)
{
    return fast::max(c.x, fast::max(c.y, c.z)) - fast::min(c.x, fast::min(c.y, c.z));
}

static inline __attribute__((always_inline))
float3 setSaturationMinMidMax(thread float3& cSorted, thread const float& s)
{
    if (cSorted.z > cSorted.x)
    {
        cSorted.y = ((cSorted.y - cSorted.x) * s) / (cSorted.z - cSorted.x);
        cSorted.z = s;
    }
    else
    {
        cSorted.y = 0.0;
        cSorted.z = 0.0;
    }
    cSorted.x = 0.0;
    return cSorted;
}

static inline __attribute__((always_inline))
float3 setSaturation(thread float3& c, thread const float& s)
{
    bool _431 = c.x <= c.y;
    bool _439;
    if (_431)
    {
        _439 = c.x <= c.z;
    }
    else
    {
        _439 = _431;
    }
    if (_439)
    {
        if (c.y <= c.z)
        {
            float3 param = c;
            float param_1 = s;
            float3 _453 = setSaturationMinMidMax(param, param_1);
            c = _453;
        }
        else
        {
            float3 param_2 = c.xzy;
            float param_3 = s;
            float3 _460 = setSaturationMinMidMax(param_2, param_3);
            c = float3(_460.x, _460.z, _460.y);
        }
    }
    else
    {
        bool _468 = c.y <= c.x;
        bool _476;
        if (_468)
        {
            _476 = c.y <= c.z;
        }
        else
        {
            _476 = _468;
        }
        if (_476)
        {
            if (c.x <= c.z)
            {
                float3 param_4 = c.yxz;
                float param_5 = s;
                float3 _491 = setSaturationMinMidMax(param_4, param_5);
                c = float3(_491.y, _491.x, _491.z);
            }
            else
            {
                float3 param_6 = c.yzx;
                float param_7 = s;
                float3 _500 = setSaturationMinMidMax(param_6, param_7);
                c = float3(_500.z, _500.x, _500.y);
            }
        }
        else
        {
            if (c.x <= c.y)
            {
                float3 param_8 = c.zxy;
                float param_9 = s;
                float3 _516 = setSaturationMinMidMax(param_8, param_9);
                c = float3(_516.y, _516.z, _516.x);
            }
            else
            {
                float3 param_10 = c.zyx;
                float param_11 = s;
                float3 _525 = setSaturationMinMidMax(param_10, param_11);
                c = float3(_525.z, _525.y, _525.x);
            }
        }
    }
    return c;
}

static inline __attribute__((always_inline))
float3 setLuminosity(thread float3& c, thread float& lum)
{
    float3 param = c;
    c += float3(lum - getLuminosity(param));
    float3 param_1 = c;
    lum = getLuminosity(param_1);
    float _331 = fast::min(c.x, fast::min(c.y, c.z));
    float _334 = c.x;
    float _336 = c.y;
    float _338 = c.z;
    float _340 = fast::max(_334, fast::max(_336, _338));
    if (_331 < 0.0)
    {
        c = mix(float3(lum, lum, lum), c, float3(lum / (lum - _331)));
    }
    if (_340 > 1.0)
    {
        c = mix(float3(lum, lum, lum), c, float3((1.0 - lum) / (_340 - lum)));
    }
    return c;
}

static inline __attribute__((always_inline))
float3 BlendHue(thread const float3& s, thread const float3& d)
{
    float3 param = d;
    float3 param_1 = s;
    float param_2 = getSaturation(param);
    float3 _537 = setSaturation(param_1, param_2);
    float3 param_3 = d;
    float3 param_4 = _537;
    float param_5 = getLuminosity(param_3);
    float3 _543 = setLuminosity(param_4, param_5);
    return _543;
}

static inline __attribute__((always_inline))
float3 BlendSaturation(thread const float3& s, thread const float3& d)
{
    float3 param = s;
    float3 param_1 = d;
    float param_2 = getSaturation(param);
    float3 _552 = setSaturation(param_1, param_2);
    float3 param_3 = d;
    float3 param_4 = _552;
    float param_5 = getLuminosity(param_3);
    float3 _558 = setLuminosity(param_4, param_5);
    return _558;
}

static inline __attribute__((always_inline))
float3 BlendColor(thread const float3& s, thread const float3& d)
{
    float3 param = d;
    float3 param_1 = s;
    float param_2 = getLuminosity(param);
    float3 _567 = setLuminosity(param_1, param_2);
    return _567;
}

static inline __attribute__((always_inline))
float colorBurn(thread const float& s, thread const float& d)
{
    if (d >= 1.0)
    {
        return 1.0;
    }
    else
    {
        if (s <= 0.0)
        {
            return 0.0;
        }
        else
        {
            return 1.0 - fast::min(1.0, (1.0 - d) / s);
        }
    }
}

static inline __attribute__((always_inline))
float3 BlendColorBurn(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(colorBurn(param, param_1), colorBurn(param_2, param_3), colorBurn(param_4, param_5));
}

static inline __attribute__((always_inline))
float linearBurn(thread const float& s, thread const float& d)
{
    return fast::max(0.0, (d + s) - 1.0);
}

static inline __attribute__((always_inline))
float3 BlendLinearBurn(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(linearBurn(param, param_1), linearBurn(param_2, param_3), linearBurn(param_4, param_5));
}

static inline __attribute__((always_inline))
float colorDodge(thread const float& s, thread const float& d)
{
    if (d <= 0.0)
    {
        return 0.0;
    }
    if (s >= 1.0)
    {
        return 1.0;
    }
    else
    {
        return fast::min(1.0, d / (1.0 - s));
    }
}

static inline __attribute__((always_inline))
float3 BlendColorDodge(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(colorDodge(param, param_1), colorDodge(param_2, param_3), colorDodge(param_4, param_5));
}

static inline __attribute__((always_inline))
float linearDodge(thread const float& s, thread const float& d)
{
    return fast::min(1.0, d + s);
}

static inline __attribute__((always_inline))
float3 BlendLinearDodge(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(linearDodge(param, param_1), linearDodge(param_2, param_3), linearDodge(param_4, param_5));
}

static inline __attribute__((always_inline))
float vividLight(thread const float& s, thread const float& d)
{
    float _1967;
    if (s <= 0.5)
    {
        float param = d;
        float param_1 = 2.0 * s;
        _1967 = colorBurn(param, param_1);
    }
    else
    {
        float param_2 = d;
        float param_3 = 2.0 * (s - 0.5);
        _1967 = colorDodge(param_2, param_3);
    }
    return _1967;
}

static inline __attribute__((always_inline))
float3 BlendVividLight(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(vividLight(param, param_1), vividLight(param_2, param_3), vividLight(param_4, param_5));
}

static inline __attribute__((always_inline))
float linearLight(thread const float& s, thread const float& d)
{
    float _1968;
    if (s <= 0.5)
    {
        float param = d;
        float param_1 = 2.0 * s;
        _1968 = linearBurn(param, param_1);
    }
    else
    {
        float param_2 = d;
        float param_3 = 2.0 * (s - 0.5);
        _1968 = linearDodge(param_2, param_3);
    }
    return _1968;
}

static inline __attribute__((always_inline))
float3 BlendLinearLight(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(linearLight(param, param_1), linearLight(param_2, param_3), linearLight(param_4, param_5));
}

static inline __attribute__((always_inline))
float pinLight(thread const float& s, thread const float& d)
{
    float _1969;
    if (s <= 0.5)
    {
        _1969 = fast::min(d, 2.0 * s);
    }
    else
    {
        _1969 = fast::max(d, 2.0 * (s - 0.5));
    }
    return _1969;
}

static inline __attribute__((always_inline))
float3 BlendPinLight(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(pinLight(param, param_1), pinLight(param_2, param_3), pinLight(param_4, param_5));
}

static inline __attribute__((always_inline))
float hardMix(thread const float& s, thread const float& d)
{
    return float((d + s) >= 1.0);
}

static inline __attribute__((always_inline))
float3 BlendHardMix(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(hardMix(param, param_1), hardMix(param_2, param_3), hardMix(param_4, param_5));
}

static inline __attribute__((always_inline))
float divide(thread const float& s, thread const float& d)
{
    float _1970;
    if (s > 0.0)
    {
        _1970 = fast::min(1.0, d / s);
    }
    else
    {
        _1970 = 1.0;
    }
    return _1970;
}

static inline __attribute__((always_inline))
float3 BlendDivide(thread const float3& s, thread const float3& d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return float3(divide(param, param_1), divide(param_2, param_3), divide(param_4, param_5));
}

static inline __attribute__((always_inline))
float3 BlendLuminosity(thread const float3& s, thread const float3& d)
{
    float3 param = s;
    float3 param_1 = d;
    float param_2 = getLuminosity(param);
    float3 _603 = setLuminosity(param_1, param_2);
    return _603;
}

static inline __attribute__((always_inline))
float3 BlendLighterColor(thread const float3& s, thread const float3& d)
{
    float3 param = d;
    float3 param_1 = s;
    return select(s, d, bool3(getLuminosity(param) > getLuminosity(param_1)));
}

static inline __attribute__((always_inline))
float3 BlendDarkerColor(thread const float3& s, thread const float3& d)
{
    float3 param = d;
    float3 param_1 = s;
    return select(s, d, bool3(getLuminosity(param) <= getLuminosity(param_1)));
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float4 blendPass(thread float4& srcColor, thread float4& baseColor, constant int& u_blendMode, thread float2& uv0, constant int& u_layerType, constant float& u_layerOpacity)
{
    float _957 = srcColor.w;
    float4 _960 = srcColor;
    float3 _963 = _960.xyz / float3(fast::max(_957, 9.9999997473787516355514526367188e-06));
    srcColor.x = _963.x;
    srcColor.y = _963.y;
    srcColor.z = _963.z;
    float _971 = baseColor.w;
    float4 _973 = baseColor;
    float3 _976 = _973.xyz / float3(fast::max(_971, 9.9999997473787516355514526367188e-06));
    baseColor.x = _976.x;
    baseColor.y = _976.y;
    baseColor.z = _976.z;
    float4 _1979;
    if (u_blendMode == 1)
    {
        float3 _997 = srcColor.xyz + baseColor.xyz;
        float4 _1773 = _2027;
        _1773.x = _997.x;
        float4 _1775 = _1773;
        _1775.y = _997.y;
        float4 _1777 = _1775;
        _1777.z = _997.z;
        _1979 = _1777;
    }
    else
    {
        float4 _1980;
        if (u_blendMode == 2)
        {
            float3 _1014 = srcColor.xyz * baseColor.xyz;
            float4 _1779 = _2027;
            _1779.x = _1014.x;
            float4 _1781 = _1779;
            _1781.y = _1014.y;
            float4 _1783 = _1781;
            _1783.z = _1014.z;
            _1980 = _1783;
        }
        else
        {
            float4 _1981;
            if (u_blendMode == 3)
            {
                float3 _1032 = abs(srcColor.xyz - baseColor.xyz);
                float4 _1785 = _2027;
                _1785.x = _1032.x;
                float4 _1787 = _1785;
                _1787.y = _1032.y;
                float4 _1789 = _1787;
                _1789.z = _1032.z;
                _1981 = _1789;
            }
            else
            {
                float4 _1982;
                if (u_blendMode == 4)
                {
                    float _1973;
                    if (baseColor.x < 0.5)
                    {
                        _1973 = (2.0 * baseColor.x) * srcColor.x;
                    }
                    else
                    {
                        _1973 = fma((1.0 - baseColor.x) * (-2.0), 1.0 - srcColor.x, 1.0);
                    }
                    float _1974;
                    if (baseColor.y < 0.5)
                    {
                        _1974 = (2.0 * baseColor.y) * srcColor.y;
                    }
                    else
                    {
                        _1974 = fma((1.0 - baseColor.y) * (-2.0), 1.0 - srcColor.y, 1.0);
                    }
                    float _1975;
                    if (baseColor.z < 0.5)
                    {
                        _1975 = (2.0 * baseColor.z) * srcColor.z;
                    }
                    else
                    {
                        _1975 = fma((1.0 - baseColor.z) * (-2.0), 1.0 - srcColor.z, 1.0);
                    }
                    float4 _1791 = _2027;
                    _1791.x = _1973;
                    float4 _1793 = _1791;
                    _1793.y = _1974;
                    float4 _1795 = _1793;
                    _1795.z = _1975;
                    _1982 = _1795;
                }
                else
                {
                    float4 _1983;
                    if (u_blendMode == 5)
                    {
                        float3 _1131 = fast::min(srcColor.xyz, baseColor.xyz);
                        float4 _1797 = _2027;
                        _1797.x = _1131.x;
                        float4 _1799 = _1797;
                        _1799.y = _1131.y;
                        float4 _1801 = _1799;
                        _1801.z = _1131.z;
                        _1983 = _1801;
                    }
                    else
                    {
                        float4 _1984;
                        if (u_blendMode == 6)
                        {
                            float3 _1148 = fast::max(srcColor.xyz, baseColor.xyz);
                            float4 _1803 = _2027;
                            _1803.x = _1148.x;
                            float4 _1805 = _1803;
                            _1805.y = _1148.y;
                            float4 _1807 = _1805;
                            _1807.z = _1148.z;
                            _1984 = _1807;
                        }
                        else
                        {
                            float4 _1985;
                            if (u_blendMode == 7)
                            {
                                float3 param = srcColor.xyz;
                                float3 param_1 = baseColor.xyz;
                                float3 _1167 = BlendSoftLight(param, param_1);
                                float4 _1809 = _2027;
                                _1809.x = _1167.x;
                                float4 _1811 = _1809;
                                _1811.y = _1167.y;
                                float4 _1813 = _1811;
                                _1813.z = _1167.z;
                                _1985 = _1813;
                            }
                            else
                            {
                                float4 _1986;
                                if (u_blendMode == 8)
                                {
                                    float3 param_2 = srcColor.xyz;
                                    float3 param_3 = baseColor.xyz;
                                    float3 _1186 = BlendHardLight(param_2, param_3);
                                    float4 _1815 = _2027;
                                    _1815.x = _1186.x;
                                    float4 _1817 = _1815;
                                    _1817.y = _1186.y;
                                    float4 _1819 = _1817;
                                    _1819.z = _1186.z;
                                    _1986 = _1819;
                                }
                                else
                                {
                                    float4 _1987;
                                    if (u_blendMode == 9)
                                    {
                                        float3 param_4 = srcColor.xyz;
                                        float3 param_5 = baseColor.xyz;
                                        float3 _1205 = BlendHue(param_4, param_5);
                                        float4 _1821 = _2027;
                                        _1821.x = _1205.x;
                                        float4 _1823 = _1821;
                                        _1823.y = _1205.y;
                                        float4 _1825 = _1823;
                                        _1825.z = _1205.z;
                                        _1987 = _1825;
                                    }
                                    else
                                    {
                                        float4 _1988;
                                        if (u_blendMode == 10)
                                        {
                                            float3 param_6 = srcColor.xyz;
                                            float3 param_7 = baseColor.xyz;
                                            float3 _1224 = BlendSaturation(param_6, param_7);
                                            float4 _1827 = _2027;
                                            _1827.x = _1224.x;
                                            float4 _1829 = _1827;
                                            _1829.y = _1224.y;
                                            float4 _1831 = _1829;
                                            _1831.z = _1224.z;
                                            _1988 = _1831;
                                        }
                                        else
                                        {
                                            float4 _1989;
                                            if (u_blendMode == 11)
                                            {
                                                float3 param_8 = srcColor.xyz;
                                                float3 param_9 = baseColor.xyz;
                                                float3 _1243 = BlendColor(param_8, param_9);
                                                float4 _1833 = _2027;
                                                _1833.x = _1243.x;
                                                float4 _1835 = _1833;
                                                _1835.y = _1243.y;
                                                float4 _1837 = _1835;
                                                _1837.z = _1243.z;
                                                _1989 = _1837;
                                            }
                                            else
                                            {
                                                float4 _1990;
                                                if (u_blendMode == 12)
                                                {
                                                    float3 _1266 = fma(-srcColor.xyz, baseColor.xyz, srcColor.xyz + baseColor.xyz);
                                                    float4 _1839 = _2027;
                                                    _1839.x = _1266.x;
                                                    float4 _1841 = _1839;
                                                    _1841.y = _1266.y;
                                                    float4 _1843 = _1841;
                                                    _1843.z = _1266.z;
                                                    _1990 = _1843;
                                                }
                                                else
                                                {
                                                    float4 _1991;
                                                    if (u_blendMode == 13)
                                                    {
                                                        float3 param_10 = srcColor.xyz;
                                                        float3 param_11 = baseColor.xyz;
                                                        float3 _1285 = BlendColorBurn(param_10, param_11);
                                                        float4 _1845 = _2027;
                                                        _1845.x = _1285.x;
                                                        float4 _1847 = _1845;
                                                        _1847.y = _1285.y;
                                                        float4 _1849 = _1847;
                                                        _1849.z = _1285.z;
                                                        _1991 = _1849;
                                                    }
                                                    else
                                                    {
                                                        float4 _1992;
                                                        if (u_blendMode == 14)
                                                        {
                                                            float3 param_12 = srcColor.xyz;
                                                            float3 param_13 = baseColor.xyz;
                                                            float3 _1304 = BlendLinearBurn(param_12, param_13);
                                                            float4 _1851 = _2027;
                                                            _1851.x = _1304.x;
                                                            float4 _1853 = _1851;
                                                            _1853.y = _1304.y;
                                                            float4 _1855 = _1853;
                                                            _1855.z = _1304.z;
                                                            _1992 = _1855;
                                                        }
                                                        else
                                                        {
                                                            float4 _1993;
                                                            if (u_blendMode == 15)
                                                            {
                                                                float3 param_14 = srcColor.xyz;
                                                                float3 param_15 = baseColor.xyz;
                                                                float3 _1323 = BlendColorDodge(param_14, param_15);
                                                                float4 _1857 = _2027;
                                                                _1857.x = _1323.x;
                                                                float4 _1859 = _1857;
                                                                _1859.y = _1323.y;
                                                                float4 _1861 = _1859;
                                                                _1861.z = _1323.z;
                                                                _1993 = _1861;
                                                            }
                                                            else
                                                            {
                                                                float4 _1994;
                                                                if (u_blendMode == 16)
                                                                {
                                                                    float3 param_16 = srcColor.xyz;
                                                                    float3 param_17 = baseColor.xyz;
                                                                    float3 _1342 = BlendLinearDodge(param_16, param_17);
                                                                    float4 _1863 = _2027;
                                                                    _1863.x = _1342.x;
                                                                    float4 _1865 = _1863;
                                                                    _1865.y = _1342.y;
                                                                    float4 _1867 = _1865;
                                                                    _1867.z = _1342.z;
                                                                    _1994 = _1867;
                                                                }
                                                                else
                                                                {
                                                                    float4 _1995;
                                                                    if (u_blendMode == 17)
                                                                    {
                                                                        float3 param_18 = srcColor.xyz;
                                                                        float3 param_19 = baseColor.xyz;
                                                                        float3 _1361 = BlendVividLight(param_18, param_19);
                                                                        float4 _1869 = _2027;
                                                                        _1869.x = _1361.x;
                                                                        float4 _1871 = _1869;
                                                                        _1871.y = _1361.y;
                                                                        float4 _1873 = _1871;
                                                                        _1873.z = _1361.z;
                                                                        _1995 = _1873;
                                                                    }
                                                                    else
                                                                    {
                                                                        float4 _1996;
                                                                        if (u_blendMode == 18)
                                                                        {
                                                                            float3 param_20 = srcColor.xyz;
                                                                            float3 param_21 = baseColor.xyz;
                                                                            float3 _1380 = BlendLinearLight(param_20, param_21);
                                                                            float4 _1875 = _2027;
                                                                            _1875.x = _1380.x;
                                                                            float4 _1877 = _1875;
                                                                            _1877.y = _1380.y;
                                                                            float4 _1879 = _1877;
                                                                            _1879.z = _1380.z;
                                                                            _1996 = _1879;
                                                                        }
                                                                        else
                                                                        {
                                                                            float4 _1997;
                                                                            if (u_blendMode == 19)
                                                                            {
                                                                                float3 param_22 = srcColor.xyz;
                                                                                float3 param_23 = baseColor.xyz;
                                                                                float3 _1399 = BlendPinLight(param_22, param_23);
                                                                                float4 _1881 = _2027;
                                                                                _1881.x = _1399.x;
                                                                                float4 _1883 = _1881;
                                                                                _1883.y = _1399.y;
                                                                                float4 _1885 = _1883;
                                                                                _1885.z = _1399.z;
                                                                                _1997 = _1885;
                                                                            }
                                                                            else
                                                                            {
                                                                                float4 _1998;
                                                                                if (u_blendMode == 20)
                                                                                {
                                                                                    float3 param_24 = srcColor.xyz;
                                                                                    float3 param_25 = baseColor.xyz;
                                                                                    float3 _1418 = BlendHardMix(param_24, param_25);
                                                                                    float4 _1887 = _2027;
                                                                                    _1887.x = _1418.x;
                                                                                    float4 _1889 = _1887;
                                                                                    _1889.y = _1418.y;
                                                                                    float4 _1891 = _1889;
                                                                                    _1891.z = _1418.z;
                                                                                    _1998 = _1891;
                                                                                }
                                                                                else
                                                                                {
                                                                                    float4 _1999;
                                                                                    if (u_blendMode == 21)
                                                                                    {
                                                                                        float3 _1442 = fma(-(baseColor.xyz * 2.0), srcColor.xyz, baseColor.xyz + srcColor.xyz);
                                                                                        float4 _1893 = _2027;
                                                                                        _1893.x = _1442.x;
                                                                                        float4 _1895 = _1893;
                                                                                        _1895.y = _1442.y;
                                                                                        float4 _1897 = _1895;
                                                                                        _1897.z = _1442.z;
                                                                                        _1999 = _1897;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        float4 _2000;
                                                                                        if (u_blendMode == 22)
                                                                                        {
                                                                                            float3 _1461 = fast::max(float3(0.0), baseColor.xyz - srcColor.xyz);
                                                                                            float4 _1899 = _2027;
                                                                                            _1899.x = _1461.x;
                                                                                            float4 _1901 = _1899;
                                                                                            _1901.y = _1461.y;
                                                                                            float4 _1903 = _1901;
                                                                                            _1903.z = _1461.z;
                                                                                            _2000 = _1903;
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            float4 _2001;
                                                                                            if (u_blendMode == 23)
                                                                                            {
                                                                                                float3 param_26 = srcColor.xyz;
                                                                                                float3 param_27 = baseColor.xyz;
                                                                                                float3 _1480 = BlendDivide(param_26, param_27);
                                                                                                float4 _1905 = _2027;
                                                                                                _1905.x = _1480.x;
                                                                                                float4 _1907 = _1905;
                                                                                                _1907.y = _1480.y;
                                                                                                float4 _1909 = _1907;
                                                                                                _1909.z = _1480.z;
                                                                                                _2001 = _1909;
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                float4 _2002;
                                                                                                if (u_blendMode == 24)
                                                                                                {
                                                                                                    float3 param_28 = srcColor.xyz;
                                                                                                    float3 param_29 = baseColor.xyz;
                                                                                                    float3 _1499 = BlendLuminosity(param_28, param_29);
                                                                                                    float4 _1911 = _2027;
                                                                                                    _1911.x = _1499.x;
                                                                                                    float4 _1913 = _1911;
                                                                                                    _1913.y = _1499.y;
                                                                                                    float4 _1915 = _1913;
                                                                                                    _1915.z = _1499.z;
                                                                                                    _2002 = _1915;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    float4 _2003;
                                                                                                    if (u_blendMode == 25)
                                                                                                    {
                                                                                                        float3 param_30 = srcColor.xyz;
                                                                                                        float3 param_31 = baseColor.xyz;
                                                                                                        float3 _1518 = BlendLighterColor(param_30, param_31);
                                                                                                        float4 _1917 = _2027;
                                                                                                        _1917.x = _1518.x;
                                                                                                        float4 _1919 = _1917;
                                                                                                        _1919.y = _1518.y;
                                                                                                        float4 _1921 = _1919;
                                                                                                        _1921.z = _1518.z;
                                                                                                        _2003 = _1921;
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        float4 _2004;
                                                                                                        if (u_blendMode == 26)
                                                                                                        {
                                                                                                            float3 param_32 = srcColor.xyz;
                                                                                                            float3 param_33 = baseColor.xyz;
                                                                                                            float3 _1537 = BlendDarkerColor(param_32, param_33);
                                                                                                            float4 _1923 = _2027;
                                                                                                            _1923.x = _1537.x;
                                                                                                            float4 _1925 = _1923;
                                                                                                            _1925.y = _1537.y;
                                                                                                            float4 _1927 = _1925;
                                                                                                            _1927.z = _1537.z;
                                                                                                            _2004 = _1927;
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                            float4 _2005;
                                                                                                            if (u_blendMode == 27)
                                                                                                            {
                                                                                                                bool _1552 = srcColor.w == 1.0;
                                                                                                                bool _1570;
                                                                                                                if (!_1552)
                                                                                                                {
                                                                                                                    bool _1558 = srcColor.w > 0.0;
                                                                                                                    bool _1569;
                                                                                                                    if (_1558)
                                                                                                                    {
                                                                                                                        float2 param_34 = uv0;
                                                                                                                        _1569 = srcColor.w > random(param_34);
                                                                                                                    }
                                                                                                                    else
                                                                                                                    {
                                                                                                                        _1569 = _1558;
                                                                                                                    }
                                                                                                                    _1570 = _1569;
                                                                                                                }
                                                                                                                else
                                                                                                                {
                                                                                                                    _1570 = _1552;
                                                                                                                }
                                                                                                                float4 _2006;
                                                                                                                if (_1570)
                                                                                                                {
                                                                                                                    float4 _1929 = _2027;
                                                                                                                    _1929.x = srcColor.x;
                                                                                                                    float4 _1931 = _1929;
                                                                                                                    _1931.y = srcColor.y;
                                                                                                                    float4 _1933 = _1931;
                                                                                                                    _1933.z = srcColor.z;
                                                                                                                    _2006 = _1933;
                                                                                                                }
                                                                                                                else
                                                                                                                {
                                                                                                                    _2006 = baseColor;
                                                                                                                }
                                                                                                                _2005 = _2006;
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                                float4 _1935 = _2027;
                                                                                                                _1935.x = srcColor.x;
                                                                                                                float4 _1937 = _1935;
                                                                                                                _1937.y = srcColor.y;
                                                                                                                float4 _1939 = _1937;
                                                                                                                _1939.z = srcColor.z;
                                                                                                                _2005 = _1939;
                                                                                                            }
                                                                                                            _2004 = _2005;
                                                                                                        }
                                                                                                        _2003 = _2004;
                                                                                                    }
                                                                                                    _2002 = _2003;
                                                                                                }
                                                                                                _2001 = _2002;
                                                                                            }
                                                                                            _2000 = _2001;
                                                                                        }
                                                                                        _1999 = _2000;
                                                                                    }
                                                                                    _1998 = _1999;
                                                                                }
                                                                                _1997 = _1998;
                                                                            }
                                                                            _1996 = _1997;
                                                                        }
                                                                        _1995 = _1996;
                                                                    }
                                                                    _1994 = _1995;
                                                                }
                                                                _1993 = _1994;
                                                            }
                                                            _1992 = _1993;
                                                        }
                                                        _1991 = _1992;
                                                    }
                                                    _1990 = _1991;
                                                }
                                                _1989 = _1990;
                                            }
                                            _1988 = _1989;
                                        }
                                        _1987 = _1988;
                                    }
                                    _1986 = _1987;
                                }
                                _1985 = _1986;
                            }
                            _1984 = _1985;
                        }
                        _1983 = _1984;
                    }
                    _1982 = _1983;
                }
                _1981 = _1982;
            }
            _1980 = _1981;
        }
        _1979 = _1980;
    }
    float4 _2007;
    if (u_layerType == 1)
    {
        float4 _1610 = mix(baseColor, float4(_1979.xyz, srcColor.w), float4(u_layerOpacity));
        float3 _1615 = _1610.xyz * _1610.w;
        float4 _1942 = _1610;
        _1942.x = _1615.x;
        float4 _1944 = _1942;
        _1944.y = _1615.y;
        float4 _1946 = _1944;
        _1946.z = _1615.z;
        _2007 = _1946;
    }
    else
    {
        _2007 = float4((((baseColor.xyz * baseColor.w) * (1.0 - srcColor.w)) + ((srcColor.xyz * srcColor.w) * (1.0 - baseColor.w))) + (_1979.xyz * (srcColor.w * baseColor.w)), fma(baseColor.w, 1.0 - srcColor.w, srcColor.w));
    }
    return _2007;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_maskTexture [[texture(0)]], texture2d<float> u_baseTexure [[texture(1)]], texture2d<float> u_sourceTexture [[texture(2)]], sampler u_maskTextureSmplr [[sampler(0)]], sampler u_baseTexureSmplr [[sampler(1)]], sampler u_sourceTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    bool _1724 = buffer.u_hasBlend == 1;
    float4 _1961;
    if (_1724)
    {
        float4 _1962;
        if (buffer.u_hasBaseTexture == 1)
        {
            _1962 = u_baseTexure.sample(u_baseTexureSmplr, in.uv0);
        }
        else
        {
            _1962 = float4(0.0);
        }
        if (buffer.u_hasSourceTexture == 0)
        {
            out.o_fragColor = _1962;
            return out;
        }
        _1961 = _1962;
    }
    else
    {
        _1961 = float4(0.0);
    }
    float4 _1957;
    if (buffer.u_hasSourceTexture == 1)
    {
        _1957 = u_sourceTexture.sample(u_sourceTextureSmplr, in.uv0);
    }
    else
    {
        _1957 = float4(0.0);
    }
    float4 _1958;
    if (buffer.u_hasMatte == 1)
    {
        float4 param = _1957;
        _1958 = mattePass(param, in.uv0, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, buffer.u_matteMode);
    }
    else
    {
        _1958 = _1957;
    }
    float4 _1963;
    if (_1724)
    {
        float4 param_1 = _1958;
        float4 param_2 = _1961;
        float4 _1770 = blendPass(param_1, param_2, buffer.u_blendMode, in.uv0, buffer.u_layerType, buffer.u_layerOpacity);
        _1963 = _1770;
    }
    else
    {
        _1963 = _1958;
    }
    out.o_fragColor = _1963;
    return out;
}

