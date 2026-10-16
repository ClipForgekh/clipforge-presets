precision highp float;
precision highp int;

uniform mediump int u_inverseGammaCorrection;
uniform float u_gamma;
uniform float u_sampleY;
uniform mediump sampler2D u_inputTexture;
uniform float u_sigmaY;
uniform float u_stepY;
uniform mediump int u_borderType;
uniform mediump int u_blurAlpha;

varying vec2 uv0;

vec4 _f1(mediump sampler2D _p0, vec2 _p1)
{
    vec4 _t0 = texture2D(_p0, _p1);
    if (u_inverseGammaCorrection == 1)
    {
        vec4 _51 = _t0;
        vec3 _57 = pow(_51.xyz, vec3(u_gamma));
        _t0.x = _57.x;
        _t0.y = _57.y;
        _t0.z = _57.z;
    }
    return _t0;
}

float _f0(float _p0, float _p1)
{
    return exp((((-0.5) * _p0) * _p0) / (_p1 * _p1));
}

void main()
{
    if (u_sampleY < 9.9999997473787516355514526367188e-06)
    {
        gl_FragData[0] = texture2D(u_inputTexture, uv0);
        return;
    }
    vec2 param = uv0;
    vec4 _89 = _f1(u_inputTexture, param);
    vec4 _t1 = _89;
    float param_1 = 0.0;
    float param_2 = u_sigmaY;
    float _96 = _f0(param_1, param_2);
    float _t2 = _96;
    vec4 _t3 = _89 * _96;
    vec2 _t4 = uv0;
    for (mediump int _t5 = 1; _t5 <= 1024; _t5++)
    {
        mediump float _115 = float(_t5);
        if (_115 > u_sampleY)
        {
            break;
        }
        float _126 = _115 * u_stepY;
        float param_3 = _126;
        float param_4 = u_sigmaY;
        float _132 = _f0(param_3, param_4);
        _t4.y = uv0.y - _126;
        if (_t4.y < 0.0)
        {
            if (u_borderType == 1)
            {
                _t4.y = 0.0;
                vec2 param_5 = _t4;
                _t3 += (_f1(u_inputTexture, param_5) * _132);
                _t2 += _132;
            }
            else
            {
                if (u_borderType == 2)
                {
                    _t2 += _132;
                }
                else
                {
                    if (u_borderType == 3)
                    {
                        _t4.y = -_t4.y;
                        vec2 param_6 = _t4;
                        _t3 += (_f1(u_inputTexture, param_6) * _132);
                        _t2 += _132;
                    }
                }
            }
        }
        else
        {
            vec2 param_7 = _t4;
            _t3 += (_f1(u_inputTexture, param_7) * _132);
            _t2 += _132;
        }
        _t4.y = uv0.y + _126;
        if (_t4.y > 1.0)
        {
            if (u_borderType == 1)
            {
                _t4.y = 1.0;
                vec2 param_8 = _t4;
                _t3 += (_f1(u_inputTexture, param_8) * _132);
                _t2 += _132;
            }
            else
            {
                if (u_borderType == 2)
                {
                    _t2 += _132;
                }
                else
                {
                    if (u_borderType == 3)
                    {
                        _t4.y = 2.0 - _t4.y;
                        vec2 param_9 = _t4;
                        _t3 += (_f1(u_inputTexture, param_9) * _132);
                        _t2 += _132;
                    }
                }
            }
        }
        else
        {
            vec2 param_10 = _t4;
            _t3 += (_f1(u_inputTexture, param_10) * _132);
            _t2 += _132;
        }
    }
    _t3 /= vec4(_t2);
    if (u_inverseGammaCorrection == 1)
    {
        vec4 _275 = _t3;
        vec3 _280 = pow(_275.xyz, vec3(1.0 / u_gamma));
        _t3.x = _280.x;
        _t3.y = _280.y;
        _t3.z = _280.z;
    }
    if (u_blurAlpha == 0)
    {
        _t3.w = _t1.w;
    }
    gl_FragData[0] = _t3;
}

