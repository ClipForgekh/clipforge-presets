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
    vec2 _209;
    vec4 _210;
    float _211;
    _211 = 1.0;
    _210 = texture2D(u_inputTexture, uv0) * 1.0;
    _209 = uv0;
    vec2 _234;
    vec4 _238;
    float _242;
    for (mediump int _208 = 1; _208 <= 1024; _208++)
    {
        mediump float _58 = float(_208);
        if (_58 > u_sampleY)
        {
            break;
        }
        float _76 = (-_58) * u_stepY + uv0.y;
        vec2 _193 = _209;
        _193.y = _76;
        vec2 _212;
        vec4 _216;
        float _220;
        if (_76 < 0.0)
        {
            vec2 _213;
            vec4 _217;
            float _221;
            if (u_borderType == 1)
            {
                vec2 _196 = _193;
                _196.y = 0.0;
                _221 = _211 + 1.0;
                _217 = _210 + texture2D(u_inputTexture, _196);
                _213 = _196;
            }
            else
            {
                vec2 _214;
                vec4 _218;
                float _222;
                if (u_borderType == 2)
                {
                    _222 = _211 + 1.0;
                    _218 = _210;
                    _214 = _193;
                }
                else
                {
                    vec2 _215;
                    vec4 _219;
                    float _223;
                    if (u_borderType == 3)
                    {
                        vec2 _199 = _193;
                        _199.y = -_76;
                        _223 = _211 + 1.0;
                        _219 = _210 + texture2D(u_inputTexture, _199);
                        _215 = _199;
                    }
                    else
                    {
                        _223 = _211;
                        _219 = _210;
                        _215 = _193;
                    }
                    _222 = _223;
                    _218 = _219;
                    _214 = _215;
                }
                _221 = _222;
                _217 = _218;
                _213 = _214;
            }
            _220 = _221;
            _216 = _217;
            _212 = _213;
        }
        else
        {
            _220 = _211 + 1.0;
            _216 = _210 + texture2D(u_inputTexture, _193);
            _212 = _193;
        }
        float _134 = _58 * u_stepY + uv0.y;
        vec2 _201 = _212;
        _201.y = _134;
        if (_134 > 1.0)
        {
            vec2 _235;
            vec4 _239;
            float _243;
            if (u_borderType == 1)
            {
                vec2 _204 = _201;
                _204.y = 1.0;
                _243 = _220 + 1.0;
                _239 = _216 + texture2D(u_inputTexture, _204);
                _235 = _204;
            }
            else
            {
                vec2 _236;
                vec4 _240;
                float _244;
                if (u_borderType == 2)
                {
                    _244 = _220 + 1.0;
                    _240 = _216;
                    _236 = _201;
                }
                else
                {
                    vec2 _237;
                    vec4 _241;
                    float _245;
                    if (u_borderType == 3)
                    {
                        vec2 _207 = _201;
                        _207.y = 2.0 - _134;
                        _245 = _220 + 1.0;
                        _241 = _216 + texture2D(u_inputTexture, _207);
                        _237 = _207;
                    }
                    else
                    {
                        _245 = _220;
                        _241 = _216;
                        _237 = _201;
                    }
                    _244 = _245;
                    _240 = _241;
                    _236 = _237;
                }
                _243 = _244;
                _239 = _240;
                _235 = _236;
            }
            _242 = _243;
            _238 = _239;
            _234 = _235;
        }
        else
        {
            _242 = _220 + 1.0;
            _238 = _216 + texture2D(u_inputTexture, _201);
            _234 = _201;
        }
        _211 = _242; _210 = _238; _209 = _234;
    }
    gl_FragData[0] = _210 / vec4(_211);
}

