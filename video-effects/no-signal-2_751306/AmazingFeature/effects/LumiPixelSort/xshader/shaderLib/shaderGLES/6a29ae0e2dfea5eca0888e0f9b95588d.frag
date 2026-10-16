precision highp float;
precision highp int;

uniform float randomSeed;
uniform mediump sampler2D inputImageTexture;
uniform float sortType;
uniform float triggerType;
uniform float blockSize;
uniform vec4 u_ScreenParams;
uniform float affectType;
uniform float threshold;
uniform float randomly;

varying vec2 v_uv;

float _f0(vec2 _p0)
{
    vec2 _65 = fract(_p0 * 1324.5179443359375);
    vec2 _t0 = _65 + vec2(dot(_65, _65.yx + vec2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

float _f7(vec4 _p0)
{
    return ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
}

float _f1(vec4 _p0)
{
    return ((_p0.x + _p0.y) + _p0.z) / 3.0;
}

float _f6(vec4 _p0)
{
    return min(min(_p0.x, _p0.y), _p0.z);
}

float _f5(vec4 _p0)
{
    return max(max(_p0.x, _p0.y), _p0.z);
}

float _f2(vec4 _p0)
{
    return _p0.x;
}

float _f3(vec4 _p0)
{
    return _p0.y;
}

float _f4(vec4 _p0)
{
    return _p0.z;
}

vec3 _f8(vec3 _p0)
{
    float _168 = max(max(_p0.x, _p0.y), _p0.z);
    float _172 = _168 - min(min(_p0.x, _p0.y), _p0.z);
    float _t4 = 0.0;
    float _t5 = 0.0;
    if (_172 != 0.0)
    {
        _t5 = _172 / _168;
        float _195 = _172 / 2.0;
        float _198 = (((_168 - _p0.x) / 6.0) + _195) / _172;
        float _209 = (((_168 - _p0.y) / 6.0) + _195) / _172;
        float _220 = (((_168 - _p0.z) / 6.0) + _195) / _172;
        if (_p0.x == _168)
        {
            _t4 = _220 - _209;
        }
        else
        {
            if (_p0.y == _168)
            {
                _t4 = (0.3333333432674407958984375 + _198) - _220;
            }
            else
            {
                if (_p0.z == _168)
                {
                    _t4 = (0.666666686534881591796875 + _209) - _198;
                }
            }
        }
        if (_t4 < 0.0)
        {
            _t4 += 1.0;
        }
        else
        {
            if (_t4 > 1.0)
            {
                _t4 -= 1.0;
            }
        }
    }
    return vec3(_t4, _t5, _168);
}

float _f9(vec4 _p0)
{
    vec3 param = _p0.xyz;
    return _f8(param).x;
}

float _f10(vec4 _p0)
{
    vec3 param = _p0.xyz;
    return _f8(param).y;
}

float _f11(inout vec2 _p0)
{
    float _t10 = 0.0;
    for (float _t11 = 0.0; _t11 < 8.0; _t11 += 1.0)
    {
        vec2 _t12 = floor(_p0);
        _p0 /= vec2(2.0);
        _t10 = (_t10 + mod(_t12.x + _t12.y, 2.0)) / 2.0;
    }
    return _t10 * 2.0;
}

float _f12(vec4 _p0)
{
    vec2 param = _p0.xy * 255.0;
    float _325 = _f11(param);
    vec2 param_1 = vec2(_325, _p0.z) * 255.0;
    float _331 = _f11(param_1);
    return _331;
}

float _f13(vec4 _p0, float _p1)
{
    if (_p1 < 0.5)
    {
        vec4 param = _p0;
        return _f7(param);
    }
    else
    {
        if (_p1 < 1.5)
        {
            vec4 param_1 = _p0;
            return _f1(param_1);
        }
        else
        {
            if (_p1 < 2.5)
            {
                vec4 param_2 = _p0;
                return _f6(param_2);
            }
            else
            {
                if (_p1 < 3.5)
                {
                    vec4 param_3 = _p0;
                    return _f5(param_3);
                }
                else
                {
                    if (_p1 < 4.5)
                    {
                        vec4 param_4 = _p0;
                        return _f2(param_4);
                    }
                    else
                    {
                        if (_p1 < 5.5)
                        {
                            vec4 param_5 = _p0;
                            return _f3(param_5);
                        }
                        else
                        {
                            if (_p1 < 6.5)
                            {
                                vec4 param_6 = _p0;
                                return _f4(param_6);
                            }
                            else
                            {
                                if (_p1 < 7.5)
                                {
                                    vec4 param_7 = _p0;
                                    return _f9(param_7);
                                }
                                else
                                {
                                    if (_p1 < 8.5)
                                    {
                                        vec4 param_8 = _p0;
                                        return _f10(param_8);
                                    }
                                    else
                                    {
                                        if (_p1 < 9.5)
                                        {
                                            vec4 param_9 = _p0;
                                            return _f12(param_9);
                                        }
                                        else
                                        {
                                            vec4 param_10 = _p0;
                                            return _f7(param_10);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

void main()
{
    vec2 _t13 = v_uv;
    vec2 param = vec2(_t13.x + (randomSeed * 10.0), _t13.y);
    mediump vec4 _466 = texture2D(inputImageTexture, _t13);
    vec4 _t15 = _466;
    if (_t15.w < 0.00999999977648258209228515625)
    {
        gl_FragData[0] = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    }
    vec4 param_1 = _466;
    float param_2 = sortType;
    float _484 = _f13(param_1, param_2);
    vec4 param_3 = _466;
    float param_4 = triggerType;
    float _t17 = _f13(param_3, param_4);
    if (blockSize >= 2.0)
    {
        vec2 _497 = _t13;
        float _504 = floor(blockSize);
        vec2 _513 = (floor((_497 * u_ScreenParams.xy) / vec2(_504)) * _504) / u_ScreenParams.xy;
        _t13 = _513;
        vec4 param_5 = texture2D(inputImageTexture, _513);
        float param_6 = sortType;
        _t17 = _f13(param_5, param_6);
    }
    bool _528 = (affectType <= 0.5) && (_t17 >= threshold);
    bool _538;
    if (!_528)
    {
        _538 = (affectType > 0.5) && (_t17 <= threshold);
    }
    else
    {
        _538 = _528;
    }
    bool _547;
    if (_538)
    {
        _547 = (_f0(param) + 0.001000000047497451305389404296875) >= (randomly / 16.0);
    }
    else
    {
        _547 = _538;
    }
    if (_547)
    {
        gl_FragData[0] = vec4(1.0, _484, _484, 1.0);
    }
    else
    {
        gl_FragData[0] = vec4(0.0, _484, _484, 1.0);
    }
}

