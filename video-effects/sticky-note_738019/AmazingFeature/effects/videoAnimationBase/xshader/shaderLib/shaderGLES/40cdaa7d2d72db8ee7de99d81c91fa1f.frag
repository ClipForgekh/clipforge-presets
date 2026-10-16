precision highp float;
precision highp int;

uniform mediump vec2 FBS;
uniform mediump sampler2D inputImageTexture;

varying vec2 v_uv;
mediump float QUALITY[10];

void initQuality()
{
    QUALITY[0] = 1.5;
    QUALITY[1] = 2.0;
    QUALITY[2] = 2.0;
    QUALITY[3] = 2.0;
    QUALITY[4] = 2.0;
    QUALITY[5] = 4.0;
    QUALITY[6] = 8.0;
}

mediump float rgb2luma(mediump vec3 rgb)
{
    return sqrt(dot(rgb, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
}

mediump float sampleNeighborLuma(mediump sampler2D texSampler, mediump vec2 texCoord)
{
    mediump vec3 param = texture2D(texSampler, texCoord).xyz;
    return rgb2luma(param);
}

void main()
{
    initQuality();
    mediump vec2 _75 = vec2(1.0) / FBS;
    mediump vec2 inverseScreenSize = _75;
    mediump vec2 In = v_uv;
    mediump vec4 _88 = texture2D(inputImageTexture, v_uv);
    mediump vec3 param = _88.xyz;
    mediump float _96 = rgb2luma(param);
    mediump vec2 param_1 = v_uv + (vec2(0.0, -1.0) / FBS);
    mediump float _106 = sampleNeighborLuma(inputImageTexture, param_1);
    mediump vec2 param_2 = v_uv + (vec2(0.0, 1.0) / FBS);
    mediump float _114 = sampleNeighborLuma(inputImageTexture, param_2);
    mediump vec2 param_3 = v_uv + (vec2(-1.0, 0.0) / FBS);
    mediump float _122 = sampleNeighborLuma(inputImageTexture, param_3);
    mediump vec2 param_4 = v_uv + (vec2(1.0, 0.0) / FBS);
    mediump float _130 = sampleNeighborLuma(inputImageTexture, param_4);
    mediump float _150 = max(_96, max(max(_106, _114), max(_122, _130)));
    mediump float _154 = _150 - min(_96, min(min(_106, _114), min(_122, _130)));
    if (_154 < max(0.031199999153614044189453125, _150 * 0.125))
    {
        gl_FragData[0] = _88;
        return;
    }
    mediump vec2 param_5 = v_uv + (vec2(-1.0) / FBS);
    mediump float _176 = sampleNeighborLuma(inputImageTexture, param_5);
    mediump vec2 param_6 = v_uv + _75;
    mediump float _184 = sampleNeighborLuma(inputImageTexture, param_6);
    mediump vec2 param_7 = v_uv + (vec2(-1.0, 1.0) / FBS);
    mediump float _192 = sampleNeighborLuma(inputImageTexture, param_7);
    mediump vec2 param_8 = v_uv + (vec2(1.0, -1.0) / FBS);
    mediump float _200 = sampleNeighborLuma(inputImageTexture, param_8);
    mediump float _204 = _106 + _114;
    mediump float _208 = _122 + _130;
    mediump float _212 = _176 + _192;
    mediump float _220 = _200 + _184;
    bool _268 = ((abs((-2.0) * _96 + _204) * 2.0 + abs((-2.0) * _122 + _212)) + abs((-2.0) * _130 + _220)) >= ((abs((-2.0) * _96 + _208) * 2.0 + abs((-2.0) * _114 + (_184 + _192))) + abs((-2.0) * _106 + (_176 + _200)));
    float _273 = _268 ? _106 : _122;
    float _278 = _268 ? _114 : _130;
    mediump float _289 = abs(_273 - _96);
    mediump float _291 = abs(_278 - _96);
    mediump float _300 = 0.25 * max(_289, _291);
    mediump float _303;
    if (_268)
    {
        _303 = inverseScreenSize.y;
    }
    else
    {
        _303 = inverseScreenSize.x;
    }
    mediump float stepLength = _303;
    mediump float lumaLocalAverage = 0.0;
    if (_289 >= _291)
    {
        stepLength = -stepLength;
        lumaLocalAverage = 0.5 * (_273 + _96);
    }
    else
    {
        lumaLocalAverage = 0.5 * (_278 + _96);
    }
    mediump vec2 currentUv = v_uv;
    if (_268)
    {
        currentUv.y = stepLength * 0.5 + currentUv.y;
    }
    else
    {
        currentUv.x = stepLength * 0.5 + currentUv.x;
    }
    mediump vec2 _350;
    if (_268)
    {
        _350 = vec2(inverseScreenSize.x, 0.0);
    }
    else
    {
        _350 = vec2(0.0, inverseScreenSize.y);
    }
    mediump vec2 _364 = currentUv - _350;
    mediump vec2 uv1 = _364;
    mediump vec2 uv2 = currentUv + _350;
    mediump vec3 param_9 = texture2D(inputImageTexture, _364).xyz;
    mediump float lumaEnd1 = rgb2luma(param_9);
    mediump vec3 param_10 = texture2D(inputImageTexture, uv2).xyz;
    mediump float _384 = lumaEnd1;
    mediump float _385 = _384 - lumaLocalAverage;
    lumaEnd1 = _385;
    mediump float _388 = rgb2luma(param_10) - lumaLocalAverage;
    mediump float lumaEnd2 = _388;
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
        for (mediump int i = 2; i < 12; i++)
        {
            if (!reached1)
            {
                mediump vec3 param_11 = texture2D(inputImageTexture, uv1).xyz;
                lumaEnd1 = rgb2luma(param_11) - lumaLocalAverage;
            }
            if (!reached2)
            {
                mediump vec3 param_12 = texture2D(inputImageTexture, uv2).xyz;
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
    mediump float _661;
    if (_268)
    {
        _661 = In.x - uv1.x;
    }
    else
    {
        _661 = In.y - uv1.y;
    }
    mediump float _678;
    if (_268)
    {
        _678 = uv2.x - In.x;
    }
    else
    {
        _678 = uv2.y - In.y;
    }
    mediump float _745 = clamp(abs(0.083333335816860198974609375 * ((2.0 * (_204 + _208) + _212) + _220) + (-_96)) / _154, 0.0, 1.0);
    mediump float _754 = (((-2.0) * _745 + 3.0) * _745) * _745;
    mediump float _763 = max(((((_661 < _678) ? lumaEnd1 : lumaEnd2) < 0.0) != (_96 < lumaLocalAverage)) ? (((-min(_661, _678)) / (_661 + _678)) + 0.5) : 0.0, (_754 * _754) * 0.75);
    mediump vec2 finalUv = v_uv;
    if (_268)
    {
        finalUv.y = _763 * stepLength + finalUv.y;
    }
    else
    {
        finalUv.x = _763 * stepLength + finalUv.x;
    }
    gl_FragData[0] = texture2D(inputImageTexture, finalUv);
}

