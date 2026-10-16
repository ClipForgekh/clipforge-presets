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

constant spvUnsafeArray<float, 10> _986 = {};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 TexCoord [[user(TexCoord)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    do
    {
        float2 _75 = float2(1.0) / buffer.FBS;
        float4 _88 = inputImageTexture.sample(inputImageTextureSmplr, in.TexCoord);
        float _806 = sqrt(dot(_88.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _812 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(0.0, -1.0) / buffer.FBS)));
        float _819 = sqrt(dot(_812.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _825 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(0.0, 1.0) / buffer.FBS)));
        float _832 = sqrt(dot(_825.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _838 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(-1.0, 0.0) / buffer.FBS)));
        float _845 = sqrt(dot(_838.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _851 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(1.0, 0.0) / buffer.FBS)));
        float _858 = sqrt(dot(_851.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float _150 = fast::max(_806, fast::max(fast::max(_819, _832), fast::max(_845, _858)));
        float _154 = _150 - fast::min(_806, fast::min(fast::min(_819, _832), fast::min(_845, _858)));
        if (_154 < fast::max(0.031199999153614044189453125, _150 * 0.125))
        {
            out.gl_FragColor = _88;
            break;
        }
        float4 _864 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(-1.0) / buffer.FBS)));
        float _871 = sqrt(dot(_864.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _877 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + _75));
        float _884 = sqrt(dot(_877.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _890 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(-1.0, 1.0) / buffer.FBS)));
        float _897 = sqrt(dot(_890.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _903 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(1.0, -1.0) / buffer.FBS)));
        float _910 = sqrt(dot(_903.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float _204 = _819 + _832;
        float _208 = _845 + _858;
        float _212 = _871 + _897;
        float _220 = _910 + _884;
        bool _268 = (fma(abs(fma(-2.0, _806, _204)), 2.0, abs(fma(-2.0, _845, _212))) + abs(fma(-2.0, _858, _220))) >= (fma(abs(fma(-2.0, _806, _208)), 2.0, abs(fma(-2.0, _832, _884 + _897))) + abs(fma(-2.0, _819, _871 + _910)));
        float _273 = _268 ? _819 : _845;
        float _278 = _268 ? _832 : _858;
        float _289 = abs(_273 - _806);
        float _291 = abs(_278 - _806);
        float _300 = 0.25 * fast::max(_289, _291);
        float _987;
        if (_268)
        {
            _987 = _75.y;
        }
        else
        {
            _987 = _75.x;
        }
        float _988;
        float _994;
        if (_289 >= _291)
        {
            _994 = 0.5 * (_273 + _806);
            _988 = -_987;
        }
        else
        {
            _994 = 0.5 * (_278 + _806);
            _988 = _987;
        }
        float2 _991;
        if (_268)
        {
            float2 _950 = in.TexCoord;
            _950.y = fma(_988, 0.5, in.TexCoord.y);
            _991 = _950;
        }
        else
        {
            float2 _953 = in.TexCoord;
            _953.x = fma(_988, 0.5, in.TexCoord.x);
            _991 = _953;
        }
        float2 _989;
        if (_268)
        {
            _989 = float2(_75.x, 0.0);
        }
        else
        {
            _989 = float2(0.0, _75.y);
        }
        float2 _364 = _991 - _989;
        float2 _368 = _991 + _989;
        float4 _372 = inputImageTexture.sample(inputImageTextureSmplr, _364);
        float4 _379 = inputImageTexture.sample(inputImageTextureSmplr, _368);
        float _385 = sqrt(dot(_372.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))) - _994;
        float _388 = sqrt(dot(_379.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))) - _994;
        bool _393 = abs(_385) >= _300;
        bool _398 = abs(_388) >= _300;
        float2 _1005;
        if (!_393)
        {
            _1005 = _364 - _989;
        }
        else
        {
            _1005 = _364;
        }
        float2 _1014;
        if (!_398)
        {
            _1014 = _368 + _989;
        }
        else
        {
            _1014 = _368;
        }
        float2 _1085;
        float2 _1107;
        float _1144;
        float _1166;
        if (!(_393 && _398))
        {
            int _999;
            bool _1000;
            float2 _1003;
            bool _1010;
            float2 _1013;
            float _1018;
            float _1023;
            _1023 = _388;
            _1018 = _385;
            _1013 = _1014;
            _1010 = _398;
            _1003 = _1005;
            _1000 = _393;
            _999 = 2;
            bool _460;
            bool _464;
            float _1017;
            float _1021;
            float2 _1086;
            float2 _1088;
            float2 _1108;
            float2 _1109;
            float _1145;
            float _1167;
            for (;;)
            {
                if (_999 < 12)
                {
                    if (!_1000)
                    {
                        _1017 = sqrt(dot(inputImageTexture.sample(inputImageTextureSmplr, _1003).xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))) - _994;
                    }
                    else
                    {
                        _1017 = _1018;
                    }
                    if (!_1010)
                    {
                        _1021 = sqrt(dot(inputImageTexture.sample(inputImageTextureSmplr, _1013).xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))) - _994;
                    }
                    else
                    {
                        _1021 = _1023;
                    }
                    _460 = abs(_1017) >= _300;
                    _464 = abs(_1021) >= _300;
                    if (!_460)
                    {
                        float2 _1089;
                        if (_999 == 2)
                        {
                            _1089 = _1003 - (_989 * 2.0);
                        }
                        else
                        {
                            float2 _1090;
                            if (_999 == 3)
                            {
                                _1090 = _1003 - (_989 * 2.0);
                            }
                            else
                            {
                                float2 _1091;
                                if (_999 == 4)
                                {
                                    _1091 = _1003 - (_989 * 2.0);
                                }
                                else
                                {
                                    float2 _1092;
                                    if (_999 == 5)
                                    {
                                        _1092 = _1003 - (_989 * 4.0);
                                    }
                                    else
                                    {
                                        float2 _1093;
                                        if (_999 == 6)
                                        {
                                            _1093 = _1003 - (_989 * 8.0);
                                        }
                                        else
                                        {
                                            float2 _1094;
                                            if (_999 == 7)
                                            {
                                                _1094 = _1003 - (_989 * _986[7]);
                                            }
                                            else
                                            {
                                                float2 _1095;
                                                if (_999 == 8)
                                                {
                                                    _1095 = _1003 - (_989 * _986[8]);
                                                }
                                                else
                                                {
                                                    float2 _1096;
                                                    if (_999 == 9)
                                                    {
                                                        _1096 = _1003 - (_989 * _986[9]);
                                                    }
                                                    else
                                                    {
                                                        _1096 = _1003;
                                                    }
                                                    _1095 = _1096;
                                                }
                                                _1094 = _1095;
                                            }
                                            _1093 = _1094;
                                        }
                                        _1092 = _1093;
                                    }
                                    _1091 = _1092;
                                }
                                _1090 = _1091;
                            }
                            _1089 = _1090;
                        }
                        _1088 = _1089;
                    }
                    else
                    {
                        _1088 = _1003;
                    }
                    if (!_464)
                    {
                        float2 _1110;
                        if (_999 == 2)
                        {
                            _1110 = _1013 + (_989 * 2.0);
                        }
                        else
                        {
                            float2 _1111;
                            if (_999 == 3)
                            {
                                _1111 = _1013 + (_989 * 2.0);
                            }
                            else
                            {
                                float2 _1112;
                                if (_999 == 4)
                                {
                                    _1112 = _1013 + (_989 * 2.0);
                                }
                                else
                                {
                                    float2 _1113;
                                    if (_999 == 5)
                                    {
                                        _1113 = _1013 + (_989 * 4.0);
                                    }
                                    else
                                    {
                                        float2 _1114;
                                        if (_999 == 6)
                                        {
                                            _1114 = _1013 + (_989 * 8.0);
                                        }
                                        else
                                        {
                                            float2 _1115;
                                            if (_999 == 7)
                                            {
                                                _1115 = _1013 + (_989 * _986[7]);
                                            }
                                            else
                                            {
                                                float2 _1116;
                                                if (_999 == 8)
                                                {
                                                    _1116 = _1013 + (_989 * _986[8]);
                                                }
                                                else
                                                {
                                                    float2 _1117;
                                                    if (_999 == 9)
                                                    {
                                                        _1117 = _1013 + (_989 * _986[9]);
                                                    }
                                                    else
                                                    {
                                                        _1117 = _1013;
                                                    }
                                                    _1116 = _1117;
                                                }
                                                _1115 = _1116;
                                            }
                                            _1114 = _1115;
                                        }
                                        _1113 = _1114;
                                    }
                                    _1112 = _1113;
                                }
                                _1111 = _1112;
                            }
                            _1110 = _1111;
                        }
                        _1109 = _1110;
                    }
                    else
                    {
                        _1109 = _1013;
                    }
                    if (_460 && _464)
                    {
                        _1167 = _1021;
                        _1145 = _1017;
                        _1108 = _1109;
                        _1086 = _1088;
                        break;
                    }
                    _1023 = _1021;
                    _1018 = _1017;
                    _1013 = _1109;
                    _1010 = _464;
                    _1003 = _1088;
                    _1000 = _460;
                    _999++;
                    continue;
                }
                else
                {
                    _1167 = _1023;
                    _1145 = _1018;
                    _1108 = _1013;
                    _1086 = _1003;
                    break;
                }
            }
            _1166 = _1167;
            _1144 = _1145;
            _1107 = _1108;
            _1085 = _1086;
        }
        else
        {
            _1166 = _388;
            _1144 = _385;
            _1107 = _1014;
            _1085 = _1005;
        }
        float _1105;
        if (_268)
        {
            _1105 = in.TexCoord.x - _1085.x;
        }
        else
        {
            _1105 = in.TexCoord.y - _1085.y;
        }
        float _1118;
        if (_268)
        {
            _1118 = _1107.x - in.TexCoord.x;
        }
        else
        {
            _1118 = _1107.y - in.TexCoord.y;
        }
        float _745 = fast::clamp(abs(fma(0.083333335816860198974609375, fma(2.0, _204 + _208, _212) + _220, -_806)) / _154, 0.0, 1.0);
        float _754 = (fma(-2.0, _745, 3.0) * _745) * _745;
        float _763 = fast::max(((((_1105 < _1118) ? _1144 : _1166) < 0.0) != (_806 < _994)) ? (((-fast::min(_1105, _1118)) / (_1105 + _1118)) + 0.5) : 0.0, (_754 * _754) * 0.75);
        float2 _1215;
        if (_268)
        {
            float2 _982 = in.TexCoord;
            _982.y = fma(_763, _988, in.TexCoord.y);
            _1215 = _982;
        }
        else
        {
            float2 _985 = in.TexCoord;
            _985.x = fma(_763, _988, in.TexCoord.x);
            _1215 = _985;
        }
        out.gl_FragColor = inputImageTexture.sample(inputImageTextureSmplr, _1215);
        break;
    } while(false);
    return out;
}

