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

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    int u_phaseExtraMode;
    spvUnsafeArray<float4, 17> u_patternColor;
    int u_patternCount;
    spvUnsafeArray<float, 17> u_patternIndex;
    float u_patternSmooth;
    int u_filterMode;
    float4 u_filterColor;
    float u_filterWidth;
    float u_filterSmooth;
    int u_outputMode;
    float u_outputAlpha;
    int u_maskMode;
    int u_phaseInputSource;
    int u_phaseExtraSource;
    float u_phaseShift;
    float u_patternRepeat;
    float u_maskBlend;
    float u_inputMix;
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
float4 _f2(thread const float4& _p0)
{
    if (_p0.w == 0.0)
    {
        return float4(0.0);
    }
    return float4(_p0.xyz / float3(fast::max(_p0.w, 0.001000000047497451305389404296875)), _p0.w);
}

static inline __attribute__((always_inline))
float3 _f4(thread const float3& _p0)
{
    float _147 = fast::min(_p0.x, fast::min(_p0.y, _p0.z));
    float _156 = fast::max(_p0.x, fast::max(_p0.y, _p0.z));
    float _160 = _156 + _147;
    float _164 = _156 - _147;
    float3 _t5 = float3(0.0);
    if (_164 > 0.0)
    {
        _t5 = mod(((((_p0.yzx - _p0.zxy) / float3(_164)) + float3(0.0, 2.0, 4.0)) * 60.0) + float3(360.0), float3(360.0)) / float3(360.0);
    }
    return float3(mix(mix(_t5.z, _t5.y, step(_156, _p0.y)), _t5.x, step(_156, _p0.x)), _164 / fast::max(9.9999997473787516355514526367188e-06, fast::min(_160, 2.0 - _160)), _160 * 0.5);
}

static inline __attribute__((always_inline))
float _f6(thread const int& _p0, thread const float4& _p1, thread const float3& _p2)
{
    float _t10;
    if (_p0 == 0)
    {
        _t10 = ((_p1.x + _p1.y) + _p1.z) / 3.0;
    }
    else
    {
        if (_p0 == 1)
        {
            _t10 = _p1.x;
        }
        else
        {
            if (_p0 == 2)
            {
                _t10 = _p1.y;
            }
            else
            {
                if (_p0 == 3)
                {
                    _t10 = _p1.z;
                }
                else
                {
                    if (_p0 == 4)
                    {
                        _t10 = _p2.x;
                    }
                    else
                    {
                        if (_p0 == 5)
                        {
                            _t10 = _p2.z;
                        }
                        else
                        {
                            if (_p0 == 6)
                            {
                                _t10 = _p2.y;
                            }
                            else
                            {
                                if (_p0 == 7)
                                {
                                    _t10 = fast::max(fast::max(_p1.x, _p1.y), _p1.z);
                                }
                                else
                                {
                                    if (_p0 == 8)
                                    {
                                        _t10 = _p1.w;
                                    }
                                    else
                                    {
                                        _t10 = 0.0;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return _t10;
}

static inline __attribute__((always_inline))
float _f7(thread const float& _p0, thread const float& _p1, constant int& u_phaseExtraMode)
{
    if (u_phaseExtraMode == 0)
    {
        return fract(_p0 + _p1);
    }
    else
    {
        if (u_phaseExtraMode == 1)
        {
            return fast::clamp(_p0 + _p1, 0.0, 1.0);
        }
        else
        {
            if (u_phaseExtraMode == 2)
            {
                return (_p0 + _p1) * 0.5;
            }
            else
            {
                if (u_phaseExtraMode == 3)
                {
                    return 1.0 - ((1.0 - _p0) * (1.0 - _p1));
                }
                else
                {
                    return _p0;
                }
            }
        }
    }
}

static inline __attribute__((always_inline))
float _f0(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    return fast::clamp((_p2 - _p0) / ((_p1 - _p0) + 0.001000000047497451305389404296875), 0.0, 1.0);
}

static inline __attribute__((always_inline))
float4 _f8(thread const float& _p0, texture2d<float> u_inputTexture, sampler u_inputTextureSmplr, thread float2& v_uv, constant spvUnsafeArray<float4, 17>& u_patternColor, constant int& u_patternCount, constant spvUnsafeArray<float, 17>& u_patternIndex, constant float& u_patternSmooth)
{
    float4 param = u_inputTexture.sample(u_inputTextureSmplr, v_uv);
    float4 _t11 = _f2(param);
    float _427 = ((_t11.x + _t11.y) + _t11.z) / 3.0;
    if (abs(_427 - 1.0) < 0.001000000047497451305389404296875)
    {
        return u_patternColor[u_patternCount];
    }
    else
    {
        if (abs(_427) < 0.001000000047497451305389404296875)
        {
            return u_patternColor[0];
        }
    }
    for (int _t13 = 0; _t13 < 16; _t13++)
    {
        if (_t13 >= u_patternCount)
        {
            break;
        }
        int _478 = _t13 + 1;
        if ((u_patternIndex[_t13] <= _p0) && (_p0 <= u_patternIndex[_478]))
        {
            float param_1 = u_patternIndex[_t13];
            float param_2 = u_patternIndex[_478];
            float param_3 = _p0;
            return mix(u_patternColor[_t13], u_patternColor[_t13 + 1], float4(mix(step((u_patternIndex[_t13] + u_patternIndex[_478]) * 0.5, _p0), _f0(param_1, param_2, param_3), u_patternSmooth)));
        }
    }
    return float4(1.0);
}

static inline __attribute__((always_inline))
float3 _f5(thread const float3& _p0)
{
    return _p0.zzz + ((_p0.yyy * (fast::clamp(abs(mod((_p0.xxx * 6.0) + float3(0.0, 4.0, 2.0), float3(6.0)) - float3(3.0)) - float3(1.0), float3(0.0), float3(1.0)) - float3(0.5))) * (1.0 - abs((_p0.z + _p0.z) - 1.0)));
}

static inline __attribute__((always_inline))
float4 _f10(thread const float4& _p0, thread const float3& _p1, thread const float4& _p2, constant int& u_outputMode, constant float& u_outputAlpha)
{
    float4 _t38 = _p2;
    if (u_outputMode == 1)
    {
        _t38 = float4(_t38.x, _p0.y, _p0.z, _p0.w);
    }
    else
    {
        if (u_outputMode == 2)
        {
            _t38 = float4(_p0.x, _t38.y, _p0.z, _p0.w);
        }
        else
        {
            if (u_outputMode == 3)
            {
                _t38 = float4(_p0.x, _p0.y, _t38.z, _p0.w);
            }
            else
            {
                if (u_outputMode == 4)
                {
                    _t38 = float4(_t38.x, _t38.y, _p0.z, _p0.w);
                }
                else
                {
                    if (u_outputMode == 5)
                    {
                        _t38 = float4(_p0.x, _t38.y, _t38.z, _p0.w);
                    }
                    else
                    {
                        if (u_outputMode == 6)
                        {
                            _t38 = float4(_t38.x, _p0.y, _t38.z, _p0.w);
                        }
                    }
                }
            }
        }
    }
    float3 param = _t38.xyz;
    float3 _t39 = _f4(param);
    if (u_outputMode == 7)
    {
        _t39 = float3(_t39.x, _p1.y, _p1.z);
    }
    else
    {
        if (u_outputMode == 8)
        {
            _t39 = float3(_p1.x, _p1.y, _t39.z);
        }
        else
        {
            if (u_outputMode == 9)
            {
                _t39 = float3(_p1.x, _t39.y, _p1.z);
            }
            else
            {
                if (u_outputMode == 10)
                {
                    _t39 = float3(_t39.x, _p1.y, _t39.z);
                }
                else
                {
                    if (u_outputMode == 11)
                    {
                        _t39 = float3(_p1.x, _t39.y, _t39.z);
                    }
                    else
                    {
                        if (u_outputMode == 12)
                        {
                            _t39 = float3(_t39.x, _t39.y, _p1.z);
                        }
                        else
                        {
                            if (u_outputMode == 13)
                            {
                                _t39 = _p1;
                            }
                        }
                    }
                }
            }
        }
    }
    float3 param_1 = _t39;
    float3 _871 = _f5(param_1);
    _t38.x = _871.x;
    _t38.y = _871.y;
    _t38.z = _871.z;
    _t38.w = mix(_p0.w, _t38.w, u_outputAlpha);
    float4 _887 = _t38;
    float4 _891 = mix(_p0, _887, float4(_p0.w));
    _t38 = _891;
    return _891;
}

static inline __attribute__((always_inline))
float _f9(thread const float4& _p0, thread const float3& _p1, constant int& u_filterMode, constant float4& u_filterColor, constant float& u_filterWidth, constant float& u_filterSmooth)
{
    if (u_filterMode == 1)
    {
        float3 _540 = float3(u_filterWidth);
        float3 _541 = u_filterColor.xyz - _540;
        float3 _547 = u_filterColor.xyz + _540;
        float3 _552 = float3(fast::max(u_filterSmooth, 0.001000000047497451305389404296875));
        float3 _t23 = smoothstep(_541 - _552, _541, _p0.xyz) * smoothstep(_547 + _552, _547, _p0.xyz);
        return fast::min(fast::min(_t23.x, _t23.y), _t23.z);
    }
    else
    {
        if (u_filterMode == 2)
        {
            float3 param = u_filterColor.xyz;
            float3 _587 = _f4(param);
            float _588 = _587.x;
            float _614 = _588 - u_filterWidth;
            float _618 = _588 + u_filterWidth;
            float _621 = fast::max(u_filterSmooth, 0.001000000047497451305389404296875);
            return smoothstep(_614 - _621, _614, mix(_p1.x - 1.0, _p1.x, step(_p1.x, _588))) * smoothstep(_618 + _621, _618, mix(_p1.x + 1.0, _p1.x, step(_588, _p1.x)));
        }
        else
        {
            if (u_filterMode == 3)
            {
                float3 param_1 = u_filterColor.xyz;
                float3 _t31 = _f4(param_1);
                float _656 = (1.0 - abs(_t31.z - 1.0)) * _t31.y;
                float _665 = (1.0 - abs(_p1.z - 1.0)) * _p1.y;
                float _669 = _656 - u_filterWidth;
                float _673 = _656 + u_filterWidth;
                float _676 = fast::max(u_filterSmooth, 0.001000000047497451305389404296875);
                return smoothstep(_669 - _676, _669, _665) * smoothstep(_673 + _676, _673, _665);
            }
            else
            {
                return 1.0;
            }
        }
    }
}

static inline __attribute__((always_inline))
float _f3(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float _f11(thread float2& v_uv, constant int& u_maskMode, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr)
{
    if (u_maskMode == 1)
    {
        float3 param = u_maskTexture.sample(u_maskTextureSmplr, v_uv).xyz;
        return _f3(param);
    }
    else
    {
        if (u_maskMode == 2)
        {
            return u_maskTexture.sample(u_maskTextureSmplr, v_uv).w;
        }
        else
        {
            if (u_maskMode == 3)
            {
                float3 param_1 = u_maskTexture.sample(u_maskTextureSmplr, v_uv).xyz;
                return 1.0 - _f3(param_1);
            }
            else
            {
                if (u_maskMode == 4)
                {
                    return 1.0 - u_maskTexture.sample(u_maskTextureSmplr, v_uv).w;
                }
                else
                {
                    return 1.0;
                }
            }
        }
    }
}

static inline __attribute__((always_inline))
float4 _f1(thread const float4& _p0)
{
    if (_p0.w == 0.0)
    {
        return float4(0.0);
    }
    return float4(_p0.xyz * fast::max(_p0.w, 0.001000000047497451305389404296875), _p0.w);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], texture2d<float> u_maskTexture [[texture(1)]], texture2d<float> u_extraTexture [[texture(2)]], sampler u_inputTextureSmplr [[sampler(0)]], sampler u_maskTextureSmplr [[sampler(1)]], sampler u_extraTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 param = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _954 = _f2(param);
    float4 _t40 = _954;
    float3 param_1 = _954.xyz;
    float3 _959 = _f4(param_1);
    float4 param_2 = u_extraTexture.sample(u_extraTextureSmplr, in.v_uv);
    float4 _966 = _f2(param_2);
    float3 param_3 = _966.xyz;
    int param_4 = buffer.u_phaseInputSource;
    float4 param_5 = _t40;
    float3 param_6 = _959;
    float _t44 = _f6(param_4, param_5, param_6);
    int param_7 = buffer.u_phaseExtraSource;
    float4 param_8 = _966;
    float3 param_9 = _f4(param_3);
    float param_10 = _t44;
    float param_11 = _f6(param_7, param_8, param_9);
    float _1004 = fract(((_f7(param_10, param_11, buffer.u_phaseExtraMode) * 360.0) + buffer.u_phaseShift) * (buffer.u_patternRepeat / 360.0));
    _t44 = _1004;
    float param_12 = _1004;
    float4 _1008 = _f8(param_12, u_inputTexture, u_inputTextureSmplr, in.v_uv, buffer.u_patternColor, buffer.u_patternCount, buffer.u_patternIndex, buffer.u_patternSmooth);
    float4 _t46 = _1008;
    float4 param_13 = _t40;
    float3 param_14 = _959;
    float4 param_15 = _1008;
    float4 _1015 = _f10(param_13, param_14, param_15, buffer.u_outputMode, buffer.u_outputAlpha);
    _t46 = _1015;
    float4 param_16 = _t40;
    float3 param_17 = _959;
    float4 _1022 = _1015 * _f9(param_16, param_17, buffer.u_filterMode, buffer.u_filterColor, buffer.u_filterWidth, buffer.u_filterSmooth);
    _t46 = _1022;
    float4 _1025 = _1022 * _f11(in.v_uv, buffer.u_maskMode, u_maskTexture, u_maskTextureSmplr);
    _t46 = _1025;
    float _1027 = _t40.w;
    float4 _1028 = _t40;
    float3 _1030 = _1028.xyz * _1027;
    _t40.x = _1030.x;
    _t40.y = _1030.y;
    _t40.z = _1030.z;
    float _1038 = _t46.w;
    float3 _1041 = _1025.xyz * _1038;
    _t46.x = _1041.x;
    _t46.y = _1041.y;
    _t46.z = _1041.z;
    float _1053 = _t46.w;
    float4 _1056 = _t46;
    float4 _1063 = mix(_t40, _1056 + ((_t40 * buffer.u_maskBlend) * (1.0 - _1053)), float4(buffer.u_inputMix));
    _t46 = _1063;
    float4 param_18 = _1063;
    out.o_fragColor = _f1(param_18);
    return out;
}

