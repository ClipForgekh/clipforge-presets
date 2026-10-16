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

constant spvUnsafeArray<float, 10> _985 = {};

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
        float _805 = sqrt(dot(_88.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _811 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(0.0, -1.0) / buffer.FBS)));
        float _818 = sqrt(dot(_811.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _824 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(0.0, 1.0) / buffer.FBS)));
        float _831 = sqrt(dot(_824.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _837 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(-1.0, 0.0) / buffer.FBS)));
        float _844 = sqrt(dot(_837.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _850 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(1.0, 0.0) / buffer.FBS)));
        float _857 = sqrt(dot(_850.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float _150 = fast::max(_805, fast::max(fast::max(_818, _831), fast::max(_844, _857)));
        float _154 = _150 - fast::min(_805, fast::min(fast::min(_818, _831), fast::min(_844, _857)));
        if (_154 < fast::max(0.031199999153614044189453125, _150 * 0.125))
        {
            out.gl_FragColor = _88;
            break;
        }
        float4 _863 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(-1.0) / buffer.FBS)));
        float _870 = sqrt(dot(_863.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _876 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + _75));
        float _883 = sqrt(dot(_876.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _889 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(-1.0, 1.0) / buffer.FBS)));
        float _896 = sqrt(dot(_889.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float4 _902 = inputImageTexture.sample(inputImageTextureSmplr, (in.TexCoord + (float2(1.0, -1.0) / buffer.FBS)));
        float _909 = sqrt(dot(_902.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
        float _204 = _818 + _831;
        float _208 = _844 + _857;
        float _212 = _870 + _896;
        float _220 = _909 + _883;
        bool _268 = (fma(abs(fma(-2.0, _805, _204)), 2.0, abs(fma(-2.0, _844, _212))) + abs(fma(-2.0, _857, _220))) >= (fma(abs(fma(-2.0, _805, _208)), 2.0, abs(fma(-2.0, _831, _883 + _896))) + abs(fma(-2.0, _818, _870 + _909)));
        float _273 = _268 ? _818 : _844;
        float _278 = _268 ? _831 : _857;
        float _289 = abs(_273 - _805);
        float _291 = abs(_278 - _805);
        float _300 = 0.25 * fast::max(_289, _291);
        float _986;
        if (_268)
        {
            _986 = _75.y;
        }
        else
        {
            _986 = _75.x;
        }
        float _987;
        float _993;
        if (_289 >= _291)
        {
            _993 = 0.5 * (_273 + _805);
            _987 = -_986;
        }
        else
        {
            _993 = 0.5 * (_278 + _805);
            _987 = _986;
        }
        float2 _990;
        if (_268)
        {
            float2 _949 = in.TexCoord;
            _949.y = fma(_987, 0.5, in.TexCoord.y);
            _990 = _949;
        }
        else
        {
            float2 _952 = in.TexCoord;
            _952.x = fma(_987, 0.5, in.TexCoord.x);
            _990 = _952;
        }
        float2 _988;
        if (_268)
        {
            _988 = float2(_75.x, 0.0);
        }
        else
        {
            _988 = float2(0.0, _75.y);
        }
        float2 _364 = _990 - _988;
        float2 _368 = _990 + _988;
        float4 _372 = inputImageTexture.sample(inputImageTextureSmplr, _364);
        float4 _379 = inputImageTexture.sample(inputImageTextureSmplr, _368);
        float _385 = sqrt(dot(_372.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))) - _993;
        float _388 = sqrt(dot(_379.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))) - _993;
        bool _393 = abs(_385) >= _300;
        bool _398 = abs(_388) >= _300;
        float2 _1004;
        if (!_393)
        {
            _1004 = _364 - _988;
        }
        else
        {
            _1004 = _364;
        }
        float2 _1013;
        if (!_398)
        {
            _1013 = _368 + _988;
        }
        else
        {
            _1013 = _368;
        }
        float2 _1084;
        float2 _1106;
        float _1143;
        float _1165;
        if (!(_393 && _398))
        {
            int _998;
            bool _999;
            float2 _1002;
            bool _1009;
            float2 _1012;
            float _1017;
            float _1022;
            _1022 = _388;
            _1017 = _385;
            _1012 = _1013;
            _1009 = _398;
            _1002 = _1004;
            _999 = _393;
            _998 = 2;
            bool _460;
            bool _464;
            float _1016;
            float _1020;
            float2 _1085;
            float2 _1087;
            float2 _1107;
            float2 _1108;
            float _1144;
            float _1166;
            for (;;)
            {
                if (_998 < 7)
                {
                    if (!_999)
                    {
                        _1016 = sqrt(dot(inputImageTexture.sample(inputImageTextureSmplr, _1002).xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))) - _993;
                    }
                    else
                    {
                        _1016 = _1017;
                    }
                    if (!_1009)
                    {
                        _1020 = sqrt(dot(inputImageTexture.sample(inputImageTextureSmplr, _1012).xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))) - _993;
                    }
                    else
                    {
                        _1020 = _1022;
                    }
                    _460 = abs(_1016) >= _300;
                    _464 = abs(_1020) >= _300;
                    if (!_460)
                    {
                        float2 _1088;
                        if (_998 == 2)
                        {
                            _1088 = _1002 - (_988 * 2.0);
                        }
                        else
                        {
                            float2 _1089;
                            if (_998 == 3)
                            {
                                _1089 = _1002 - (_988 * 2.0);
                            }
                            else
                            {
                                float2 _1090;
                                if (_998 == 4)
                                {
                                    _1090 = _1002 - (_988 * 2.0);
                                }
                                else
                                {
                                    float2 _1091;
                                    if (_998 == 5)
                                    {
                                        _1091 = _1002 - (_988 * 4.0);
                                    }
                                    else
                                    {
                                        float2 _1092;
                                        if (_998 == 6)
                                        {
                                            _1092 = _1002 - (_988 * 8.0);
                                        }
                                        else
                                        {
                                            float2 _1093;
                                            if (_998 == 7)
                                            {
                                                _1093 = _1002 - (_988 * _985[7]);
                                            }
                                            else
                                            {
                                                float2 _1094;
                                                if (_998 == 8)
                                                {
                                                    _1094 = _1002 - (_988 * _985[8]);
                                                }
                                                else
                                                {
                                                    float2 _1095;
                                                    if (_998 == 9)
                                                    {
                                                        _1095 = _1002 - (_988 * _985[9]);
                                                    }
                                                    else
                                                    {
                                                        _1095 = _1002;
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
                        _1087 = _1088;
                    }
                    else
                    {
                        _1087 = _1002;
                    }
                    if (!_464)
                    {
                        float2 _1109;
                        if (_998 == 2)
                        {
                            _1109 = _1012 + (_988 * 2.0);
                        }
                        else
                        {
                            float2 _1110;
                            if (_998 == 3)
                            {
                                _1110 = _1012 + (_988 * 2.0);
                            }
                            else
                            {
                                float2 _1111;
                                if (_998 == 4)
                                {
                                    _1111 = _1012 + (_988 * 2.0);
                                }
                                else
                                {
                                    float2 _1112;
                                    if (_998 == 5)
                                    {
                                        _1112 = _1012 + (_988 * 4.0);
                                    }
                                    else
                                    {
                                        float2 _1113;
                                        if (_998 == 6)
                                        {
                                            _1113 = _1012 + (_988 * 8.0);
                                        }
                                        else
                                        {
                                            float2 _1114;
                                            if (_998 == 7)
                                            {
                                                _1114 = _1012 + (_988 * _985[7]);
                                            }
                                            else
                                            {
                                                float2 _1115;
                                                if (_998 == 8)
                                                {
                                                    _1115 = _1012 + (_988 * _985[8]);
                                                }
                                                else
                                                {
                                                    float2 _1116;
                                                    if (_998 == 9)
                                                    {
                                                        _1116 = _1012 + (_988 * _985[9]);
                                                    }
                                                    else
                                                    {
                                                        _1116 = _1012;
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
                        _1108 = _1109;
                    }
                    else
                    {
                        _1108 = _1012;
                    }
                    if (_460 && _464)
                    {
                        _1166 = _1020;
                        _1144 = _1016;
                        _1107 = _1108;
                        _1085 = _1087;
                        break;
                    }
                    _1022 = _1020;
                    _1017 = _1016;
                    _1012 = _1108;
                    _1009 = _464;
                    _1002 = _1087;
                    _999 = _460;
                    _998++;
                    continue;
                }
                else
                {
                    _1166 = _1022;
                    _1144 = _1017;
                    _1107 = _1012;
                    _1085 = _1002;
                    break;
                }
            }
            _1165 = _1166;
            _1143 = _1144;
            _1106 = _1107;
            _1084 = _1085;
        }
        else
        {
            _1165 = _388;
            _1143 = _385;
            _1106 = _1013;
            _1084 = _1004;
        }
        float _1104;
        if (_268)
        {
            _1104 = in.TexCoord.x - _1084.x;
        }
        else
        {
            _1104 = in.TexCoord.y - _1084.y;
        }
        float _1117;
        if (_268)
        {
            _1117 = _1106.x - in.TexCoord.x;
        }
        else
        {
            _1117 = _1106.y - in.TexCoord.y;
        }
        float _744 = fast::clamp(abs(fma(0.083333335816860198974609375, fma(2.0, _204 + _208, _212) + _220, -_805)) / _154, 0.0, 1.0);
        float _753 = (fma(-2.0, _744, 3.0) * _744) * _744;
        float _762 = fast::max(((((_1104 < _1117) ? _1143 : _1165) < 0.0) != (_805 < _993)) ? (((-fast::min(_1104, _1117)) / (_1104 + _1117)) + 0.5) : 0.0, (_753 * _753) * 0.75);
        float2 _1214;
        if (_268)
        {
            float2 _981 = in.TexCoord;
            _981.y = fma(_762, _987, in.TexCoord.y);
            _1214 = _981;
        }
        else
        {
            float2 _984 = in.TexCoord;
            _984.x = fma(_762, _987, in.TexCoord.x);
            _1214 = _984;
        }
        out.gl_FragColor = inputImageTexture.sample(inputImageTextureSmplr, _1214);
        break;
    } while(false);
    return out;
}

