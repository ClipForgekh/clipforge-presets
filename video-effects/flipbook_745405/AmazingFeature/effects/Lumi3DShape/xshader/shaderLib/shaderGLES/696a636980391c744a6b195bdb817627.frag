precision highp float;
precision highp int;

uniform mediump vec2 u_uvScale;
uniform mediump int u_uvWrapMode;
uniform mediump sampler2D u_inputTexture;
uniform mediump sampler2D u_mask;
uniform mediump int u_maskChannel;

varying vec2 v_uv;

void main()
{
    mediump vec2 _t0 = ((v_uv - vec2(0.5)) * u_uvScale) + vec2(0.5);
    if (u_uvWrapMode == 1)
    {
        _t0 = fract(_t0);
    }
    else
    {
        if (u_uvWrapMode == 2)
        {
            _t0 = abs(mod(_t0 + vec2(1.0), vec2(2.0)) - vec2(1.0));
        }
    }
    mediump vec4 _t1 = texture2D(u_inputTexture, _t0);
    mediump vec4 _t2 = texture2D(u_mask, v_uv);
    bool _68 = _t0.x > 1.0;
    bool _76;
    if (!_68)
    {
        _76 = _t0.x < 0.0;
    }
    else
    {
        _76 = _68;
    }
    bool _84;
    if (!_76)
    {
        _84 = _t0.y > 1.0;
    }
    else
    {
        _84 = _76;
    }
    bool _91;
    if (!_84)
    {
        _91 = _t0.y < 0.0;
    }
    else
    {
        _91 = _84;
    }
    if (_91)
    {
        if (u_uvWrapMode == 3)
        {
            _t1 = vec4(0.0);
        }
        else
        {
            if (u_uvWrapMode == 4)
            {
                _t1 = vec4(1.0);
            }
            else
            {
                if (u_uvWrapMode == 5)
                {
                    _t1 = vec4(0.0);
                    _t2 = vec4(0.0);
                }
            }
        }
    }
    mediump vec4 _t3 = vec4(_t1.xyz, _t2[u_maskChannel] * _t1.w);
    if (_t2[u_maskChannel] != 1.0)
    {
        _t3 = vec4(1.0);
    }
    mediump float _136 = _t3.w;
    mediump vec4 _139 = _t3;
    mediump vec3 _142 = _139.xyz / vec3(max(_136, 9.9999997473787516355514526367188e-06));
    _t3.x = _142.x;
    _t3.y = _142.y;
    _t3.z = _142.z;
    gl_FragData[0] = _t3;
}

