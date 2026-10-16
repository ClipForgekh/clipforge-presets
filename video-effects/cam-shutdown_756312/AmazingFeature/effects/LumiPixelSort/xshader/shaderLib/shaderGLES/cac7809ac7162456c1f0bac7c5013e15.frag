precision highp float;
precision highp int;

uniform mediump sampler2D maskTexture;

varying vec2 v_uv;

void main()
{
    vec4 _t0 = texture2D(maskTexture, v_uv);
    vec2 _t1 = vec2(0.00390625);
    _t1.y = 0.0;
    vec4 _t2 = vec4(0.0);
    float _t3 = 0.0;
    if (_t0.x < 0.5)
    {
        gl_FragData[0] = _t2;
        return;
    }
    for (float _t4 = 1.0; _t4 < 256.0; _t4 += 1.0)
    {
        vec2 _59 = v_uv - (_t1 * _t4);
        if (any(notEqual(_59, clamp(_59, vec2(0.0), vec2(1.0)))))
        {
            break;
        }
        vec4 _t6 = texture2D(maskTexture, _59);
        if (_t6.x < 0.5)
        {
            break;
        }
        _t2.x = _t4;
        if (_t6.y <= _t0.y)
        {
            _t3 += 1.0;
        }
    }
    for (float _t7 = 1.0; _t7 < 256.0; _t7 += 1.0)
    {
        vec2 _107 = v_uv + (_t1 * _t7);
        if (any(notEqual(_107, clamp(_107, vec2(0.0), vec2(1.0)))))
        {
            break;
        }
        vec4 _t9 = texture2D(maskTexture, _107);
        if (_t9.x < 0.5)
        {
            break;
        }
        _t2.y = _t7;
        if (_t9.y < _t0.y)
        {
            _t3 += 1.0;
        }
    }
    _t2.z = clamp(_t3, 0.0, 255.0);
    _t2.w = clamp(_t3 - 255.0, 0.0, 255.0);
    gl_FragData[0] = _t2 / vec4(255.0);
}

