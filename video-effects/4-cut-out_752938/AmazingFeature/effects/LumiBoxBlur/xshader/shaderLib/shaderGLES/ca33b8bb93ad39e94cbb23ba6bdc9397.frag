precision highp float;
precision highp int;

uniform float u_sampleY;
uniform mediump sampler2D u_inputTexture;
uniform float u_stepY;
uniform mediump int u_borderType;

varying vec2 uv0;

void main()
{
    if (u_sampleY < 9.9999997473787516355514526367188e-06)
    {
        gl_FragData[0] = texture2D(u_inputTexture, uv0);
        return;
    }
    float _t1 = 1.0;
    vec4 _t2 = texture2D(u_inputTexture, uv0) * 1.0;
    vec2 _t3 = uv0;
    for (mediump int _t4 = 1; _t4 <= 1024; _t4++)
    {
        mediump float _58 = float(_t4);
        if (_58 > u_sampleY)
        {
            break;
        }
        float _69 = _58 * u_stepY;
        _t3.y = uv0.y - _69;
        if (_t3.y < 0.0)
        {
            if (u_borderType == 1)
            {
                _t3.y = 0.0;
                _t2 += texture2D(u_inputTexture, _t3);
                _t1 += 1.0;
            }
            else
            {
                if (u_borderType == 2)
                {
                    _t1 += 1.0;
                }
                else
                {
                    if (u_borderType == 3)
                    {
                        _t3.y = -_t3.y;
                        _t2 += texture2D(u_inputTexture, _t3);
                        _t1 += 1.0;
                    }
                }
            }
        }
        else
        {
            _t2 += texture2D(u_inputTexture, _t3);
            _t1 += 1.0;
        }
        _t3.y = uv0.y + _69;
        if (_t3.y > 1.0)
        {
            if (u_borderType == 1)
            {
                _t3.y = 1.0;
                _t2 += texture2D(u_inputTexture, _t3);
                _t1 += 1.0;
            }
            else
            {
                if (u_borderType == 2)
                {
                    _t1 += 1.0;
                }
                else
                {
                    if (u_borderType == 3)
                    {
                        _t3.y = 2.0 - _t3.y;
                        _t2 += texture2D(u_inputTexture, _t3);
                        _t1 += 1.0;
                    }
                }
            }
        }
        else
        {
            _t2 += texture2D(u_inputTexture, _t3);
            _t1 += 1.0;
        }
    }
    vec4 _188 = _t2;
    vec4 _190 = _188 / vec4(_t1);
    _t2 = _190;
    gl_FragData[0] = _190;
}

