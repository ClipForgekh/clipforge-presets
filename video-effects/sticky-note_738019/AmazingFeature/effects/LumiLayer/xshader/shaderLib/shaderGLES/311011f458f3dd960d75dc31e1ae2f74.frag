precision highp float;
precision highp int;

uniform mediump int u_blendMode;
uniform mediump int u_layerType;
uniform float u_layerOpacity;
uniform mediump int u_enableMatte;
uniform mediump sampler2D u_maskTexture;
uniform mediump int u_matteMode;
uniform mediump int u_hasBlend;
uniform mediump int u_hasBaseTexture;
uniform mediump sampler2D u_baseTexure;
uniform mediump int u_hasSourceTexture;
uniform mediump sampler2D u_sourceTexture;
uniform mediump int u_hasMatte;

varying vec2 uv0;

vec3 _2026;
vec4 _2027;

float getLuminosity(vec3 color)
{
    return dot(color, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

vec4 mattePass(vec4 srcColor)
{
    if (u_enableMatte == 0)
    {
        return srcColor;
    }
    mediump vec4 _1685 = texture2D(u_maskTexture, uv0);
    float _1688 = _1685.w;
    float _2008;
    if (u_matteMode == 1)
    {
        vec3 param = _1685.xyz;
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
                vec3 param_1 = _1685.xyz;
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

float softLightf(float s, float d)
{
    float _1965;
    if (s < 0.5)
    {
        _1965 = (-(((-2.0) * s + 1.0) * d)) * (1.0 - d) + d;
    }
    else
    {
        float _1964;
        if (d < 0.25)
        {
            _1964 = ((2.0 * s + (-1.0)) * d) * ((16.0 * d + (-12.0)) * d + 3.0) + d;
        }
        else
        {
            _1964 = (2.0 * s + (-1.0)) * (sqrt(d) - d) + d;
        }
        _1965 = _1964;
    }
    return _1965;
}

vec3 BlendSoftLight(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(softLightf(param, param_1), softLightf(param_2, param_3), softLightf(param_4, param_5));
}

float hardLightf(float s, float d)
{
    float _1966;
    if (s < 0.5)
    {
        _1966 = (2.0 * s) * d;
    }
    else
    {
        _1966 = ((1.0 - s) * (-2.0)) * (1.0 - d) + 1.0;
    }
    return _1966;
}

vec3 BlendHardLight(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(hardLightf(param, param_1), hardLightf(param_2, param_3), hardLightf(param_4, param_5));
}

float getSaturation(vec3 c)
{
    return max(c.x, max(c.y, c.z)) - min(c.x, min(c.y, c.z));
}

vec3 setSaturationMinMidMax(inout vec3 cSorted, float s)
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

vec3 setSaturation(inout vec3 c, float s)
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
            vec3 param = c;
            float param_1 = s;
            vec3 _453 = setSaturationMinMidMax(param, param_1);
            c = _453;
        }
        else
        {
            vec3 param_2 = c.xzy;
            float param_3 = s;
            vec3 _460 = setSaturationMinMidMax(param_2, param_3);
            c = vec3(_460.x, _460.z, _460.y);
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
                vec3 param_4 = c.yxz;
                float param_5 = s;
                vec3 _491 = setSaturationMinMidMax(param_4, param_5);
                c = vec3(_491.y, _491.x, _491.z);
            }
            else
            {
                vec3 param_6 = c.yzx;
                float param_7 = s;
                vec3 _500 = setSaturationMinMidMax(param_6, param_7);
                c = vec3(_500.z, _500.x, _500.y);
            }
        }
        else
        {
            if (c.x <= c.y)
            {
                vec3 param_8 = c.zxy;
                float param_9 = s;
                vec3 _516 = setSaturationMinMidMax(param_8, param_9);
                c = vec3(_516.y, _516.z, _516.x);
            }
            else
            {
                vec3 param_10 = c.zyx;
                float param_11 = s;
                vec3 _525 = setSaturationMinMidMax(param_10, param_11);
                c = vec3(_525.z, _525.y, _525.x);
            }
        }
    }
    return c;
}

vec3 setLuminosity(inout vec3 c, inout float lum)
{
    vec3 param = c;
    c += vec3(lum - getLuminosity(param));
    vec3 param_1 = c;
    lum = getLuminosity(param_1);
    float _331 = min(c.x, min(c.y, c.z));
    float _334 = c.x;
    float _336 = c.y;
    float _338 = c.z;
    float _340 = max(_334, max(_336, _338));
    if (_331 < 0.0)
    {
        c = mix(vec3(lum, lum, lum), c, vec3(lum / (lum - _331)));
    }
    if (_340 > 1.0)
    {
        c = mix(vec3(lum, lum, lum), c, vec3((1.0 - lum) / (_340 - lum)));
    }
    return c;
}

vec3 BlendHue(vec3 s, vec3 d)
{
    vec3 param = d;
    vec3 param_1 = s;
    float param_2 = getSaturation(param);
    vec3 _537 = setSaturation(param_1, param_2);
    vec3 param_3 = d;
    vec3 param_4 = _537;
    float param_5 = getLuminosity(param_3);
    vec3 _543 = setLuminosity(param_4, param_5);
    return _543;
}

vec3 BlendSaturation(vec3 s, vec3 d)
{
    vec3 param = s;
    vec3 param_1 = d;
    float param_2 = getSaturation(param);
    vec3 _552 = setSaturation(param_1, param_2);
    vec3 param_3 = d;
    vec3 param_4 = _552;
    float param_5 = getLuminosity(param_3);
    vec3 _558 = setLuminosity(param_4, param_5);
    return _558;
}

vec3 BlendColor(vec3 s, vec3 d)
{
    vec3 param = d;
    vec3 param_1 = s;
    float param_2 = getLuminosity(param);
    vec3 _567 = setLuminosity(param_1, param_2);
    return _567;
}

float colorBurn(float s, float d)
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
            return 1.0 - min(1.0, (1.0 - d) / s);
        }
    }
}

vec3 BlendColorBurn(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(colorBurn(param, param_1), colorBurn(param_2, param_3), colorBurn(param_4, param_5));
}

float linearBurn(float s, float d)
{
    return max(0.0, (d + s) - 1.0);
}

vec3 BlendLinearBurn(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(linearBurn(param, param_1), linearBurn(param_2, param_3), linearBurn(param_4, param_5));
}

float colorDodge(float s, float d)
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
        return min(1.0, d / (1.0 - s));
    }
}

vec3 BlendColorDodge(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(colorDodge(param, param_1), colorDodge(param_2, param_3), colorDodge(param_4, param_5));
}

float linearDodge(float s, float d)
{
    return min(1.0, d + s);
}

vec3 BlendLinearDodge(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(linearDodge(param, param_1), linearDodge(param_2, param_3), linearDodge(param_4, param_5));
}

float vividLight(float s, float d)
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

vec3 BlendVividLight(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(vividLight(param, param_1), vividLight(param_2, param_3), vividLight(param_4, param_5));
}

float linearLight(float s, float d)
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

vec3 BlendLinearLight(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(linearLight(param, param_1), linearLight(param_2, param_3), linearLight(param_4, param_5));
}

float pinLight(float s, float d)
{
    float _1969;
    if (s <= 0.5)
    {
        _1969 = min(d, 2.0 * s);
    }
    else
    {
        _1969 = max(d, 2.0 * (s - 0.5));
    }
    return _1969;
}

vec3 BlendPinLight(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(pinLight(param, param_1), pinLight(param_2, param_3), pinLight(param_4, param_5));
}

float hardMix(float s, float d)
{
    return float((d + s) >= 1.0);
}

vec3 BlendHardMix(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(hardMix(param, param_1), hardMix(param_2, param_3), hardMix(param_4, param_5));
}

float divide(float s, float d)
{
    float _1970;
    if (s > 0.0)
    {
        _1970 = min(1.0, d / s);
    }
    else
    {
        _1970 = 1.0;
    }
    return _1970;
}

vec3 BlendDivide(vec3 s, vec3 d)
{
    float param = s.x;
    float param_1 = d.x;
    float param_2 = s.y;
    float param_3 = d.y;
    float param_4 = s.z;
    float param_5 = d.z;
    return vec3(divide(param, param_1), divide(param_2, param_3), divide(param_4, param_5));
}

vec3 BlendLuminosity(vec3 s, vec3 d)
{
    vec3 param = s;
    vec3 param_1 = d;
    float param_2 = getLuminosity(param);
    vec3 _603 = setLuminosity(param_1, param_2);
    return _603;
}

vec3 BlendLighterColor(vec3 s, vec3 d)
{
    vec3 param = d;
    vec3 param_1 = s;
    bvec3 _593 = bvec3(getLuminosity(param) > getLuminosity(param_1));
    return vec3(_593.x ? d.x : s.x, _593.y ? d.y : s.y, _593.z ? d.z : s.z);
}

vec3 BlendDarkerColor(vec3 s, vec3 d)
{
    vec3 param = d;
    vec3 param_1 = s;
    bvec3 _580 = bvec3(getLuminosity(param) <= getLuminosity(param_1));
    return vec3(_580.x ? d.x : s.x, _580.y ? d.y : s.y, _580.z ? d.z : s.z);
}

float random(vec2 st)
{
    return fract(sin(dot(st, vec2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

vec4 blendPass(inout vec4 srcColor, inout vec4 baseColor)
{
    float _957 = srcColor.w;
    vec4 _960 = srcColor;
    vec3 _963 = _960.xyz / vec3(max(_957, 9.9999997473787516355514526367188e-06));
    srcColor.x = _963.x;
    srcColor.y = _963.y;
    srcColor.z = _963.z;
    float _971 = baseColor.w;
    vec4 _973 = baseColor;
    vec3 _976 = _973.xyz / vec3(max(_971, 9.9999997473787516355514526367188e-06));
    baseColor.x = _976.x;
    baseColor.y = _976.y;
    baseColor.z = _976.z;
    vec4 _1979;
    if (u_blendMode == 1)
    {
        vec3 _997 = srcColor.xyz + baseColor.xyz;
        vec4 _1773 = _2027;
        _1773.x = _997.x;
        vec4 _1775 = _1773;
        _1775.y = _997.y;
        vec4 _1777 = _1775;
        _1777.z = _997.z;
        _1979 = _1777;
    }
    else
    {
        vec4 _1980;
        if (u_blendMode == 2)
        {
            vec3 _1014 = srcColor.xyz * baseColor.xyz;
            vec4 _1779 = _2027;
            _1779.x = _1014.x;
            vec4 _1781 = _1779;
            _1781.y = _1014.y;
            vec4 _1783 = _1781;
            _1783.z = _1014.z;
            _1980 = _1783;
        }
        else
        {
            vec4 _1981;
            if (u_blendMode == 3)
            {
                vec3 _1032 = abs(srcColor.xyz - baseColor.xyz);
                vec4 _1785 = _2027;
                _1785.x = _1032.x;
                vec4 _1787 = _1785;
                _1787.y = _1032.y;
                vec4 _1789 = _1787;
                _1789.z = _1032.z;
                _1981 = _1789;
            }
            else
            {
                vec4 _1982;
                if (u_blendMode == 4)
                {
                    float _1973;
                    if (baseColor.x < 0.5)
                    {
                        _1973 = (2.0 * baseColor.x) * srcColor.x;
                    }
                    else
                    {
                        _1973 = ((1.0 - baseColor.x) * (-2.0)) * (1.0 - srcColor.x) + 1.0;
                    }
                    float _1974;
                    if (baseColor.y < 0.5)
                    {
                        _1974 = (2.0 * baseColor.y) * srcColor.y;
                    }
                    else
                    {
                        _1974 = ((1.0 - baseColor.y) * (-2.0)) * (1.0 - srcColor.y) + 1.0;
                    }
                    float _1975;
                    if (baseColor.z < 0.5)
                    {
                        _1975 = (2.0 * baseColor.z) * srcColor.z;
                    }
                    else
                    {
                        _1975 = ((1.0 - baseColor.z) * (-2.0)) * (1.0 - srcColor.z) + 1.0;
                    }
                    vec4 _1791 = _2027;
                    _1791.x = _1973;
                    vec4 _1793 = _1791;
                    _1793.y = _1974;
                    vec4 _1795 = _1793;
                    _1795.z = _1975;
                    _1982 = _1795;
                }
                else
                {
                    vec4 _1983;
                    if (u_blendMode == 5)
                    {
                        vec3 _1131 = min(srcColor.xyz, baseColor.xyz);
                        vec4 _1797 = _2027;
                        _1797.x = _1131.x;
                        vec4 _1799 = _1797;
                        _1799.y = _1131.y;
                        vec4 _1801 = _1799;
                        _1801.z = _1131.z;
                        _1983 = _1801;
                    }
                    else
                    {
                        vec4 _1984;
                        if (u_blendMode == 6)
                        {
                            vec3 _1148 = max(srcColor.xyz, baseColor.xyz);
                            vec4 _1803 = _2027;
                            _1803.x = _1148.x;
                            vec4 _1805 = _1803;
                            _1805.y = _1148.y;
                            vec4 _1807 = _1805;
                            _1807.z = _1148.z;
                            _1984 = _1807;
                        }
                        else
                        {
                            vec4 _1985;
                            if (u_blendMode == 7)
                            {
                                vec3 param = srcColor.xyz;
                                vec3 param_1 = baseColor.xyz;
                                vec3 _1167 = BlendSoftLight(param, param_1);
                                vec4 _1809 = _2027;
                                _1809.x = _1167.x;
                                vec4 _1811 = _1809;
                                _1811.y = _1167.y;
                                vec4 _1813 = _1811;
                                _1813.z = _1167.z;
                                _1985 = _1813;
                            }
                            else
                            {
                                vec4 _1986;
                                if (u_blendMode == 8)
                                {
                                    vec3 param_2 = srcColor.xyz;
                                    vec3 param_3 = baseColor.xyz;
                                    vec3 _1186 = BlendHardLight(param_2, param_3);
                                    vec4 _1815 = _2027;
                                    _1815.x = _1186.x;
                                    vec4 _1817 = _1815;
                                    _1817.y = _1186.y;
                                    vec4 _1819 = _1817;
                                    _1819.z = _1186.z;
                                    _1986 = _1819;
                                }
                                else
                                {
                                    vec4 _1987;
                                    if (u_blendMode == 9)
                                    {
                                        vec3 param_4 = srcColor.xyz;
                                        vec3 param_5 = baseColor.xyz;
                                        vec3 _1205 = BlendHue(param_4, param_5);
                                        vec4 _1821 = _2027;
                                        _1821.x = _1205.x;
                                        vec4 _1823 = _1821;
                                        _1823.y = _1205.y;
                                        vec4 _1825 = _1823;
                                        _1825.z = _1205.z;
                                        _1987 = _1825;
                                    }
                                    else
                                    {
                                        vec4 _1988;
                                        if (u_blendMode == 10)
                                        {
                                            vec3 param_6 = srcColor.xyz;
                                            vec3 param_7 = baseColor.xyz;
                                            vec3 _1224 = BlendSaturation(param_6, param_7);
                                            vec4 _1827 = _2027;
                                            _1827.x = _1224.x;
                                            vec4 _1829 = _1827;
                                            _1829.y = _1224.y;
                                            vec4 _1831 = _1829;
                                            _1831.z = _1224.z;
                                            _1988 = _1831;
                                        }
                                        else
                                        {
                                            vec4 _1989;
                                            if (u_blendMode == 11)
                                            {
                                                vec3 param_8 = srcColor.xyz;
                                                vec3 param_9 = baseColor.xyz;
                                                vec3 _1243 = BlendColor(param_8, param_9);
                                                vec4 _1833 = _2027;
                                                _1833.x = _1243.x;
                                                vec4 _1835 = _1833;
                                                _1835.y = _1243.y;
                                                vec4 _1837 = _1835;
                                                _1837.z = _1243.z;
                                                _1989 = _1837;
                                            }
                                            else
                                            {
                                                vec4 _1990;
                                                if (u_blendMode == 12)
                                                {
                                                    vec3 _1266 = (-srcColor.xyz) * baseColor.xyz + (srcColor.xyz + baseColor.xyz);
                                                    vec4 _1839 = _2027;
                                                    _1839.x = _1266.x;
                                                    vec4 _1841 = _1839;
                                                    _1841.y = _1266.y;
                                                    vec4 _1843 = _1841;
                                                    _1843.z = _1266.z;
                                                    _1990 = _1843;
                                                }
                                                else
                                                {
                                                    vec4 _1991;
                                                    if (u_blendMode == 13)
                                                    {
                                                        vec3 param_10 = srcColor.xyz;
                                                        vec3 param_11 = baseColor.xyz;
                                                        vec3 _1285 = BlendColorBurn(param_10, param_11);
                                                        vec4 _1845 = _2027;
                                                        _1845.x = _1285.x;
                                                        vec4 _1847 = _1845;
                                                        _1847.y = _1285.y;
                                                        vec4 _1849 = _1847;
                                                        _1849.z = _1285.z;
                                                        _1991 = _1849;
                                                    }
                                                    else
                                                    {
                                                        vec4 _1992;
                                                        if (u_blendMode == 14)
                                                        {
                                                            vec3 param_12 = srcColor.xyz;
                                                            vec3 param_13 = baseColor.xyz;
                                                            vec3 _1304 = BlendLinearBurn(param_12, param_13);
                                                            vec4 _1851 = _2027;
                                                            _1851.x = _1304.x;
                                                            vec4 _1853 = _1851;
                                                            _1853.y = _1304.y;
                                                            vec4 _1855 = _1853;
                                                            _1855.z = _1304.z;
                                                            _1992 = _1855;
                                                        }
                                                        else
                                                        {
                                                            vec4 _1993;
                                                            if (u_blendMode == 15)
                                                            {
                                                                vec3 param_14 = srcColor.xyz;
                                                                vec3 param_15 = baseColor.xyz;
                                                                vec3 _1323 = BlendColorDodge(param_14, param_15);
                                                                vec4 _1857 = _2027;
                                                                _1857.x = _1323.x;
                                                                vec4 _1859 = _1857;
                                                                _1859.y = _1323.y;
                                                                vec4 _1861 = _1859;
                                                                _1861.z = _1323.z;
                                                                _1993 = _1861;
                                                            }
                                                            else
                                                            {
                                                                vec4 _1994;
                                                                if (u_blendMode == 16)
                                                                {
                                                                    vec3 param_16 = srcColor.xyz;
                                                                    vec3 param_17 = baseColor.xyz;
                                                                    vec3 _1342 = BlendLinearDodge(param_16, param_17);
                                                                    vec4 _1863 = _2027;
                                                                    _1863.x = _1342.x;
                                                                    vec4 _1865 = _1863;
                                                                    _1865.y = _1342.y;
                                                                    vec4 _1867 = _1865;
                                                                    _1867.z = _1342.z;
                                                                    _1994 = _1867;
                                                                }
                                                                else
                                                                {
                                                                    vec4 _1995;
                                                                    if (u_blendMode == 17)
                                                                    {
                                                                        vec3 param_18 = srcColor.xyz;
                                                                        vec3 param_19 = baseColor.xyz;
                                                                        vec3 _1361 = BlendVividLight(param_18, param_19);
                                                                        vec4 _1869 = _2027;
                                                                        _1869.x = _1361.x;
                                                                        vec4 _1871 = _1869;
                                                                        _1871.y = _1361.y;
                                                                        vec4 _1873 = _1871;
                                                                        _1873.z = _1361.z;
                                                                        _1995 = _1873;
                                                                    }
                                                                    else
                                                                    {
                                                                        vec4 _1996;
                                                                        if (u_blendMode == 18)
                                                                        {
                                                                            vec3 param_20 = srcColor.xyz;
                                                                            vec3 param_21 = baseColor.xyz;
                                                                            vec3 _1380 = BlendLinearLight(param_20, param_21);
                                                                            vec4 _1875 = _2027;
                                                                            _1875.x = _1380.x;
                                                                            vec4 _1877 = _1875;
                                                                            _1877.y = _1380.y;
                                                                            vec4 _1879 = _1877;
                                                                            _1879.z = _1380.z;
                                                                            _1996 = _1879;
                                                                        }
                                                                        else
                                                                        {
                                                                            vec4 _1997;
                                                                            if (u_blendMode == 19)
                                                                            {
                                                                                vec3 param_22 = srcColor.xyz;
                                                                                vec3 param_23 = baseColor.xyz;
                                                                                vec3 _1399 = BlendPinLight(param_22, param_23);
                                                                                vec4 _1881 = _2027;
                                                                                _1881.x = _1399.x;
                                                                                vec4 _1883 = _1881;
                                                                                _1883.y = _1399.y;
                                                                                vec4 _1885 = _1883;
                                                                                _1885.z = _1399.z;
                                                                                _1997 = _1885;
                                                                            }
                                                                            else
                                                                            {
                                                                                vec4 _1998;
                                                                                if (u_blendMode == 20)
                                                                                {
                                                                                    vec3 param_24 = srcColor.xyz;
                                                                                    vec3 param_25 = baseColor.xyz;
                                                                                    vec3 _1418 = BlendHardMix(param_24, param_25);
                                                                                    vec4 _1887 = _2027;
                                                                                    _1887.x = _1418.x;
                                                                                    vec4 _1889 = _1887;
                                                                                    _1889.y = _1418.y;
                                                                                    vec4 _1891 = _1889;
                                                                                    _1891.z = _1418.z;
                                                                                    _1998 = _1891;
                                                                                }
                                                                                else
                                                                                {
                                                                                    vec4 _1999;
                                                                                    if (u_blendMode == 21)
                                                                                    {
                                                                                        vec3 _1442 = (-(baseColor.xyz * 2.0)) * srcColor.xyz + (baseColor.xyz + srcColor.xyz);
                                                                                        vec4 _1893 = _2027;
                                                                                        _1893.x = _1442.x;
                                                                                        vec4 _1895 = _1893;
                                                                                        _1895.y = _1442.y;
                                                                                        vec4 _1897 = _1895;
                                                                                        _1897.z = _1442.z;
                                                                                        _1999 = _1897;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        vec4 _2000;
                                                                                        if (u_blendMode == 22)
                                                                                        {
                                                                                            vec3 _1461 = max(vec3(0.0), baseColor.xyz - srcColor.xyz);
                                                                                            vec4 _1899 = _2027;
                                                                                            _1899.x = _1461.x;
                                                                                            vec4 _1901 = _1899;
                                                                                            _1901.y = _1461.y;
                                                                                            vec4 _1903 = _1901;
                                                                                            _1903.z = _1461.z;
                                                                                            _2000 = _1903;
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            vec4 _2001;
                                                                                            if (u_blendMode == 23)
                                                                                            {
                                                                                                vec3 param_26 = srcColor.xyz;
                                                                                                vec3 param_27 = baseColor.xyz;
                                                                                                vec3 _1480 = BlendDivide(param_26, param_27);
                                                                                                vec4 _1905 = _2027;
                                                                                                _1905.x = _1480.x;
                                                                                                vec4 _1907 = _1905;
                                                                                                _1907.y = _1480.y;
                                                                                                vec4 _1909 = _1907;
                                                                                                _1909.z = _1480.z;
                                                                                                _2001 = _1909;
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                vec4 _2002;
                                                                                                if (u_blendMode == 24)
                                                                                                {
                                                                                                    vec3 param_28 = srcColor.xyz;
                                                                                                    vec3 param_29 = baseColor.xyz;
                                                                                                    vec3 _1499 = BlendLuminosity(param_28, param_29);
                                                                                                    vec4 _1911 = _2027;
                                                                                                    _1911.x = _1499.x;
                                                                                                    vec4 _1913 = _1911;
                                                                                                    _1913.y = _1499.y;
                                                                                                    vec4 _1915 = _1913;
                                                                                                    _1915.z = _1499.z;
                                                                                                    _2002 = _1915;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    vec4 _2003;
                                                                                                    if (u_blendMode == 25)
                                                                                                    {
                                                                                                        vec3 param_30 = srcColor.xyz;
                                                                                                        vec3 param_31 = baseColor.xyz;
                                                                                                        vec3 _1518 = BlendLighterColor(param_30, param_31);
                                                                                                        vec4 _1917 = _2027;
                                                                                                        _1917.x = _1518.x;
                                                                                                        vec4 _1919 = _1917;
                                                                                                        _1919.y = _1518.y;
                                                                                                        vec4 _1921 = _1919;
                                                                                                        _1921.z = _1518.z;
                                                                                                        _2003 = _1921;
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        vec4 _2004;
                                                                                                        if (u_blendMode == 26)
                                                                                                        {
                                                                                                            vec3 param_32 = srcColor.xyz;
                                                                                                            vec3 param_33 = baseColor.xyz;
                                                                                                            vec3 _1537 = BlendDarkerColor(param_32, param_33);
                                                                                                            vec4 _1923 = _2027;
                                                                                                            _1923.x = _1537.x;
                                                                                                            vec4 _1925 = _1923;
                                                                                                            _1925.y = _1537.y;
                                                                                                            vec4 _1927 = _1925;
                                                                                                            _1927.z = _1537.z;
                                                                                                            _2004 = _1927;
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                            vec4 _2005;
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
                                                                                                                        vec2 param_34 = uv0;
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
                                                                                                                vec4 _2006;
                                                                                                                if (_1570)
                                                                                                                {
                                                                                                                    vec4 _1929 = _2027;
                                                                                                                    _1929.x = srcColor.x;
                                                                                                                    vec4 _1931 = _1929;
                                                                                                                    _1931.y = srcColor.y;
                                                                                                                    vec4 _1933 = _1931;
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
                                                                                                                vec4 _1935 = _2027;
                                                                                                                _1935.x = srcColor.x;
                                                                                                                vec4 _1937 = _1935;
                                                                                                                _1937.y = srcColor.y;
                                                                                                                vec4 _1939 = _1937;
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
    vec4 _2007;
    if (u_layerType == 1)
    {
        vec4 _1610 = mix(baseColor, vec4(_1979.xyz, srcColor.w), vec4(u_layerOpacity));
        vec3 _1615 = _1610.xyz * _1610.w;
        vec4 _1942 = _1610;
        _1942.x = _1615.x;
        vec4 _1944 = _1942;
        _1944.y = _1615.y;
        vec4 _1946 = _1944;
        _1946.z = _1615.z;
        _2007 = _1946;
    }
    else
    {
        _2007 = vec4((((baseColor.xyz * baseColor.w) * (1.0 - srcColor.w)) + ((srcColor.xyz * srcColor.w) * (1.0 - baseColor.w))) + (_1979.xyz * (srcColor.w * baseColor.w)), baseColor.w * (1.0 - srcColor.w) + srcColor.w);
    }
    return _2007;
}

void main()
{
    bool _1724 = u_hasBlend == 1;
    vec4 _1961;
    if (_1724)
    {
        vec4 _1962;
        if (u_hasBaseTexture == 1)
        {
            _1962 = texture2D(u_baseTexure, uv0);
        }
        else
        {
            _1962 = vec4(0.0);
        }
        if (u_hasSourceTexture == 0)
        {
            gl_FragData[0] = _1962;
            return;
        }
        _1961 = _1962;
    }
    else
    {
        _1961 = vec4(0.0);
    }
    vec4 _1957;
    if (u_hasSourceTexture == 1)
    {
        _1957 = texture2D(u_sourceTexture, uv0);
    }
    else
    {
        _1957 = vec4(0.0);
    }
    vec4 _1958;
    if (u_hasMatte == 1)
    {
        vec4 param = _1957;
        _1958 = mattePass(param);
    }
    else
    {
        _1958 = _1957;
    }
    vec4 _1963;
    if (_1724)
    {
        vec4 param_1 = _1958;
        vec4 param_2 = _1961;
        vec4 _1770 = blendPass(param_1, param_2);
        _1963 = _1770;
    }
    else
    {
        _1963 = _1958;
    }
    gl_FragData[0] = _1963;
}

