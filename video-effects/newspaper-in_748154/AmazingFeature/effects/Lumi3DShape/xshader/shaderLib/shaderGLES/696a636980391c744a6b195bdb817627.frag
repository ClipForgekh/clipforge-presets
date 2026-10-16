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
    vec2 _20 = (v_uv - vec2(0.5)) * u_uvScale + vec2(0.5);
    mediump vec2 _130;
    if (u_uvWrapMode == 1)
    {
        _130 = fract(_20);
    }
    else
    {
        mediump vec2 _131;
        if (u_uvWrapMode == 2)
        {
            _131 = abs(mod(_20 + vec2(1.0), vec2(2.0)) - vec2(1.0));
        }
        else
        {
            _131 = _20;
        }
        _130 = _131;
    }
    mediump vec4 _57 = texture2D(u_inputTexture, _130);
    mediump vec4 inputMask = texture2D(u_mask, v_uv);
    bool _68 = _130.x > 1.0;
    bool _76;
    if (!_68)
    {
        _76 = _130.x < 0.0;
    }
    else
    {
        _76 = _68;
    }
    bool _84;
    if (!_76)
    {
        _84 = _130.y > 1.0;
    }
    else
    {
        _84 = _76;
    }
    bool _91;
    if (!_84)
    {
        _91 = _130.y < 0.0;
    }
    else
    {
        _91 = _84;
    }
    mediump vec4 _134;
    if (_91)
    {
        mediump vec4 _138;
        if (u_uvWrapMode == 3)
        {
            _138 = vec4(0.0);
        }
        else
        {
            mediump vec4 _139;
            if (u_uvWrapMode == 4)
            {
                _139 = vec4(1.0);
            }
            else
            {
                bool _110 = u_uvWrapMode == 5;
                if (_110)
                {
                    inputMask = vec4(0.0);
                }
                bvec4 _144 = bvec4(_110);
                _139 = vec4(_144.x ? vec4(0.0).x : _57.x, _144.y ? vec4(0.0).y : _57.y, _144.z ? vec4(0.0).z : _57.z, _144.w ? vec4(0.0).w : _57.w);
            }
            _138 = _139;
        }
        _134 = _138;
    }
    else
    {
        _134 = _57;
    }
    gl_FragData[0] = vec4(_134.xyz, inputMask[u_maskChannel]);
}

