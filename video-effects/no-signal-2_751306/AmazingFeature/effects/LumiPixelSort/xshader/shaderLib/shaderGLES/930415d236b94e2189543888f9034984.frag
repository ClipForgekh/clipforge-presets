precision highp float;
precision highp int;

uniform mediump sampler2D infoTexture;
uniform float reverseSort;
uniform float cycle;
uniform mediump sampler2D maskTexture;
uniform mediump sampler2D inputImageTexture;

varying vec2 v_uv;

void main()
{
    vec2 _t0 = vec2(0.00390625);
    _t0.y = 0.0;
    vec4 _t1 = texture2D(infoTexture, v_uv);
    float _34 = _t1.x * 255.0;
    float _38 = _t1.y * 255.0;
    float _t5 = _34;
    if (reverseSort > 0.5)
    {
        _t5 = _38;
    }
    float _65 = floor((_34 + _38) + 1.0);
    _t5 = mod(_t5 + (_65 * mod(cycle, 1.0)), _65);
    vec4 _t6 = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 _t7 = texture2D(maskTexture, v_uv);
    bool _86 = _t7.x < 0.5;
    bool _95;
    if (!_86)
    {
        _95 = abs(((_t1.z + _t1.w) * 255.0) - _t5) < 1.0;
    }
    else
    {
        _95 = _86;
    }
    if (_95)
    {
        mediump vec3 _103 = texture2D(inputImageTexture, v_uv).xyz;
        _t6.x = _103.x;
        _t6.y = _103.y;
        _t6.z = _103.z;
        gl_FragData[0] = _t6;
        return;
    }
    float _t8 = 0.0;
    float _t9 = 1024.0;
    float _t10 = 0.0;
    for (float _t11 = 1.0; _t11 < 256.0; _t11 += 1.0)
    {
        vec2 _132 = v_uv - (_t0 * _t11);
        if (any(notEqual(_132, clamp(_132, vec2(0.0), vec2(1.0)))) || (_t11 > _34))
        {
            break;
        }
        vec4 _t13 = texture2D(infoTexture, _132);
        float _163 = abs(((_t13.z + _t13.w) * 255.0) - _t5);
        if (_163 < 1.0)
        {
            _t8 = -_t11;
            _t10 = 1.0;
            break;
        }
        else
        {
            if (_163 < _t9)
            {
                _t9 = _163;
                _t8 = -_t11;
            }
        }
    }
    if (_t10 < 0.5)
    {
        for (float _t16 = 1.0; _t16 < 256.0; _t16 += 1.0)
        {
            vec2 _199 = v_uv + (_t0 * _t16);
            if (any(notEqual(_199, clamp(_199, vec2(0.0), vec2(1.0)))) || (_t16 > _38))
            {
                break;
            }
            vec4 _t18 = texture2D(infoTexture, _199);
            float _229 = abs(((_t18.z + _t18.w) * 255.0) - _t5);
            if (_229 < 1.0)
            {
                _t8 = _t16;
                _t10 = 1.0;
                break;
            }
            else
            {
                if (_229 < _t9)
                {
                    _t9 = _229;
                    _t8 = _t16;
                }
            }
        }
    }
    mediump vec3 _255 = texture2D(inputImageTexture, v_uv + (_t0 * _t8)).xyz;
    _t6.x = _255.x;
    _t6.y = _255.y;
    _t6.z = _255.z;
    gl_FragData[0] = _t6;
}

