precision highp float;
precision highp int;

uniform mediump sampler2D maskTexture;
uniform float offset;
uniform float offsetRandom;
uniform float maxLength;
uniform float randomSeed;

varying vec2 v_uv;

float _f0(vec2 _p0)
{
    vec2 _17 = fract(_p0 * 1324.5179443359375);
    vec2 _t0 = _17 + vec2(dot(_17, _17.yx + vec2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

void main()
{
    vec4 _t1 = texture2D(maskTexture, v_uv);
    vec2 _t2 = vec2(0.00390625);
    _t2.y = 0.0;
    float _t3 = 0.0;
    float _t4 = 0.0;
    if (_t1.x < 0.5)
    {
        gl_FragData[0] = _t1;
        return;
    }
    if (((offset < 0.001000000047497451305389404296875) && (offsetRandom < 0.001000000047497451305389404296875)) && (maxLength >= 0.999000012874603271484375))
    {
        gl_FragData[0] = _t1;
        return;
    }
    for (float _t5 = 1.0; _t5 < 256.0; _t5 += 1.0)
    {
        vec2 _106 = v_uv - (_t2 * _t5);
        if (any(notEqual(_106, clamp(_106, vec2(0.0), vec2(1.0)))))
        {
            break;
        }
        vec4 _t7 = texture2D(maskTexture, _106);
        if (_t7.x < 0.5)
        {
            break;
        }
        _t3 = _t5;
    }
    for (float _t8 = 1.0; _t8 < 256.0; _t8 += 1.0)
    {
        vec2 _144 = v_uv + (_t2 * _t8);
        if (any(notEqual(_144, clamp(_144, vec2(0.0), vec2(1.0)))))
        {
            break;
        }
        vec4 _t10 = texture2D(maskTexture, _144);
        if (_t10.x < 0.5)
        {
            break;
        }
        _t4 = _t8;
    }
    float _172 = (_t3 + _t4) + 1.0;
    vec2 param = vec2(_172 + randomSeed, _172);
    float _190 = _172 * (offset + ((_f0(param) - 0.5) * offsetRandom));
    bool _193 = _t3 < _190;
    bool _204;
    if (!_193)
    {
        _204 = _t3 > (_190 + (_172 * maxLength));
    }
    else
    {
        _204 = _193;
    }
    if (_204)
    {
        _t1.x = 0.0;
    }
    gl_FragData[0] = _t1;
}

