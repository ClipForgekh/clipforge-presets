precision highp float;
precision highp int;

uniform mediump int u_phaseExtraMode;
uniform mediump sampler2D u_inputTexture;
uniform vec4 u_patternColor[17];
uniform mediump int u_patternCount;
uniform float u_patternIndex[17];
uniform float u_patternSmooth;
uniform mediump int u_filterMode;
uniform vec4 u_filterColor;
uniform float u_filterWidth;
uniform float u_filterSmooth;
uniform mediump int u_outputMode;
uniform float u_outputAlpha;
uniform mediump int u_maskMode;
uniform mediump sampler2D u_maskTexture;
uniform mediump sampler2D u_extraTexture;
uniform mediump int u_phaseInputSource;
uniform mediump int u_phaseExtraSource;
uniform float u_phaseShift;
uniform float u_patternRepeat;
uniform float u_maskBlend;
uniform float u_inputMix;

varying vec2 v_uv;

vec4 _f2(vec4 _p0)
{
    if (_p0.w == 0.0)
    {
        return vec4(0.0);
    }
    return vec4(_p0.xyz / vec3(max(_p0.w, 0.001000000047497451305389404296875)), _p0.w);
}

vec3 _f4(vec3 _p0)
{
    float _147 = min(_p0.x, min(_p0.y, _p0.z));
    float _156 = max(_p0.x, max(_p0.y, _p0.z));
    float _160 = _156 + _147;
    float _164 = _156 - _147;
    vec3 _t5 = vec3(0.0);
    if (_164 > 0.0)
    {
        _t5 = mod(((((_p0.yzx - _p0.zxy) / vec3(_164)) + vec3(0.0, 2.0, 4.0)) * 60.0) + vec3(360.0), vec3(360.0)) / vec3(360.0);
    }
    return vec3(mix(mix(_t5.z, _t5.y, step(_156, _p0.y)), _t5.x, step(_156, _p0.x)), _164 / max(9.9999997473787516355514526367188e-06, min(_160, 2.0 - _160)), _160 * 0.5);
}

float _f6(mediump int _p0, vec4 _p1, vec3 _p2)
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
                                    _t10 = max(max(_p1.x, _p1.y), _p1.z);
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

float _f7(float _p0, float _p1)
{
    if (u_phaseExtraMode == 0)
    {
        return fract(_p0 + _p1);
    }
    else
    {
        if (u_phaseExtraMode == 1)
        {
            return clamp(_p0 + _p1, 0.0, 1.0);
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

float _f0(float _p0, float _p1, float _p2)
{
    return clamp((_p2 - _p0) / ((_p1 - _p0) + 0.001000000047497451305389404296875), 0.0, 1.0);
}

vec4 _f8(float _p0)
{
    vec4 param = texture2D(u_inputTexture, v_uv);
    vec4 _t11 = _f2(param);
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
    for (mediump int _t13 = 0; _t13 < 16; _t13++)
    {
        if (_t13 >= u_patternCount)
        {
            break;
        }
        mediump int _478 = _t13 + 1;
        if ((u_patternIndex[_t13] <= _p0) && (_p0 <= u_patternIndex[_478]))
        {
            float param_1 = u_patternIndex[_t13];
            float param_2 = u_patternIndex[_478];
            float param_3 = _p0;
            return mix(u_patternColor[_t13], u_patternColor[_t13 + 1], vec4(mix(step((u_patternIndex[_t13] + u_patternIndex[_478]) * 0.5, _p0), _f0(param_1, param_2, param_3), u_patternSmooth)));
        }
    }
    return vec4(1.0);
}

vec3 _f5(vec3 _p0)
{
    return _p0.zzz + ((_p0.yyy * (clamp(abs(mod((_p0.xxx * 6.0) + vec3(0.0, 4.0, 2.0), vec3(6.0)) - vec3(3.0)) - vec3(1.0), vec3(0.0), vec3(1.0)) - vec3(0.5))) * (1.0 - abs((_p0.z + _p0.z) - 1.0)));
}

vec4 _f10(vec4 _p0, vec3 _p1, vec4 _p2)
{
    vec4 _t38 = _p2;
    if (u_outputMode == 1)
    {
        _t38 = vec4(_t38.x, _p0.y, _p0.z, _p0.w);
    }
    else
    {
        if (u_outputMode == 2)
        {
            _t38 = vec4(_p0.x, _t38.y, _p0.z, _p0.w);
        }
        else
        {
            if (u_outputMode == 3)
            {
                _t38 = vec4(_p0.x, _p0.y, _t38.z, _p0.w);
            }
            else
            {
                if (u_outputMode == 4)
                {
                    _t38 = vec4(_t38.x, _t38.y, _p0.z, _p0.w);
                }
                else
                {
                    if (u_outputMode == 5)
                    {
                        _t38 = vec4(_p0.x, _t38.y, _t38.z, _p0.w);
                    }
                    else
                    {
                        if (u_outputMode == 6)
                        {
                            _t38 = vec4(_t38.x, _p0.y, _t38.z, _p0.w);
                        }
                    }
                }
            }
        }
    }
    vec3 param = _t38.xyz;
    vec3 _t39 = _f4(param);
    if (u_outputMode == 7)
    {
        _t39 = vec3(_t39.x, _p1.y, _p1.z);
    }
    else
    {
        if (u_outputMode == 8)
        {
            _t39 = vec3(_p1.x, _p1.y, _t39.z);
        }
        else
        {
            if (u_outputMode == 9)
            {
                _t39 = vec3(_p1.x, _t39.y, _p1.z);
            }
            else
            {
                if (u_outputMode == 10)
                {
                    _t39 = vec3(_t39.x, _p1.y, _t39.z);
                }
                else
                {
                    if (u_outputMode == 11)
                    {
                        _t39 = vec3(_p1.x, _t39.y, _t39.z);
                    }
                    else
                    {
                        if (u_outputMode == 12)
                        {
                            _t39 = vec3(_t39.x, _t39.y, _p1.z);
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
    vec3 param_1 = _t39;
    vec3 _871 = _f5(param_1);
    _t38.x = _871.x;
    _t38.y = _871.y;
    _t38.z = _871.z;
    _t38.w = mix(_p0.w, _t38.w, u_outputAlpha);
    vec4 _887 = _t38;
    vec4 _891 = mix(_p0, _887, vec4(_p0.w));
    _t38 = _891;
    return _891;
}

float _f9(vec4 _p0, vec3 _p1)
{
    if (u_filterMode == 1)
    {
        vec3 _540 = vec3(u_filterWidth);
        vec3 _541 = u_filterColor.xyz - _540;
        vec3 _547 = u_filterColor.xyz + _540;
        vec3 _552 = vec3(max(u_filterSmooth, 0.001000000047497451305389404296875));
        vec3 _t23 = smoothstep(_541 - _552, _541, _p0.xyz) * smoothstep(_547 + _552, _547, _p0.xyz);
        return min(min(_t23.x, _t23.y), _t23.z);
    }
    else
    {
        if (u_filterMode == 2)
        {
            vec3 param = u_filterColor.xyz;
            vec3 _587 = _f4(param);
            float _588 = _587.x;
            float _614 = _588 - u_filterWidth;
            float _618 = _588 + u_filterWidth;
            float _621 = max(u_filterSmooth, 0.001000000047497451305389404296875);
            return smoothstep(_614 - _621, _614, mix(_p1.x - 1.0, _p1.x, step(_p1.x, _588))) * smoothstep(_618 + _621, _618, mix(_p1.x + 1.0, _p1.x, step(_588, _p1.x)));
        }
        else
        {
            if (u_filterMode == 3)
            {
                vec3 param_1 = u_filterColor.xyz;
                vec3 _t31 = _f4(param_1);
                float _656 = (1.0 - abs(_t31.z - 1.0)) * _t31.y;
                float _665 = (1.0 - abs(_p1.z - 1.0)) * _p1.y;
                float _669 = _656 - u_filterWidth;
                float _673 = _656 + u_filterWidth;
                float _676 = max(u_filterSmooth, 0.001000000047497451305389404296875);
                return smoothstep(_669 - _676, _669, _665) * smoothstep(_673 + _676, _673, _665);
            }
            else
            {
                return 1.0;
            }
        }
    }
}

float _f3(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

float _f11()
{
    if (u_maskMode == 1)
    {
        vec3 param = texture2D(u_maskTexture, v_uv).xyz;
        return _f3(param);
    }
    else
    {
        if (u_maskMode == 2)
        {
            return texture2D(u_maskTexture, v_uv).w;
        }
        else
        {
            if (u_maskMode == 3)
            {
                vec3 param_1 = texture2D(u_maskTexture, v_uv).xyz;
                return 1.0 - _f3(param_1);
            }
            else
            {
                if (u_maskMode == 4)
                {
                    return 1.0 - texture2D(u_maskTexture, v_uv).w;
                }
                else
                {
                    return 1.0;
                }
            }
        }
    }
}

vec4 _f1(vec4 _p0)
{
    if (_p0.w == 0.0)
    {
        return vec4(0.0);
    }
    return vec4(_p0.xyz * max(_p0.w, 0.001000000047497451305389404296875), _p0.w);
}

void main()
{
    vec4 param = texture2D(u_inputTexture, v_uv);
    vec4 _954 = _f2(param);
    vec4 _t40 = _954;
    vec3 param_1 = _954.xyz;
    vec3 _959 = _f4(param_1);
    vec4 param_2 = texture2D(u_extraTexture, v_uv);
    vec4 _966 = _f2(param_2);
    vec3 param_3 = _966.xyz;
    mediump int param_4 = u_phaseInputSource;
    vec4 param_5 = _t40;
    vec3 param_6 = _959;
    float _t44 = _f6(param_4, param_5, param_6);
    mediump int param_7 = u_phaseExtraSource;
    vec4 param_8 = _966;
    vec3 param_9 = _f4(param_3);
    float param_10 = _t44;
    float param_11 = _f6(param_7, param_8, param_9);
    float _1004 = fract(((_f7(param_10, param_11) * 360.0) + u_phaseShift) * (u_patternRepeat / 360.0));
    _t44 = _1004;
    float param_12 = _1004;
    vec4 _1008 = _f8(param_12);
    vec4 _t46 = _1008;
    vec4 param_13 = _t40;
    vec3 param_14 = _959;
    vec4 param_15 = _1008;
    vec4 _1015 = _f10(param_13, param_14, param_15);
    _t46 = _1015;
    vec4 param_16 = _t40;
    vec3 param_17 = _959;
    vec4 _1022 = _1015 * _f9(param_16, param_17);
    _t46 = _1022;
    vec4 _1025 = _1022 * _f11();
    _t46 = _1025;
    float _1027 = _t40.w;
    vec4 _1028 = _t40;
    vec3 _1030 = _1028.xyz * _1027;
    _t40.x = _1030.x;
    _t40.y = _1030.y;
    _t40.z = _1030.z;
    float _1038 = _t46.w;
    vec3 _1041 = _1025.xyz * _1038;
    _t46.x = _1041.x;
    _t46.y = _1041.y;
    _t46.z = _1041.z;
    float _1053 = _t46.w;
    vec4 _1056 = _t46;
    vec4 _1063 = mix(_t40, _1056 + ((_t40 * u_maskBlend) * (1.0 - _1053)), vec4(u_inputMix));
    _t46 = _1063;
    vec4 param_18 = _1063;
    gl_FragData[0] = _f1(param_18);
}

