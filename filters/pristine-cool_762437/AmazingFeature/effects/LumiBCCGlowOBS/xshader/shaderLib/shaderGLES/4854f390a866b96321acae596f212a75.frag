precision highp float;
precision highp int;

uniform mediump int u_edgeMode;
uniform vec4 u_ScreenParams;
uniform mediump sampler2D u_InputTexture;
uniform float u_Radius;
uniform float u_MaxRadius;
uniform float u_Sigma;

varying vec2 uv0;

float _f2(float _p0, float _p1)
{
    return exp((-(_p0 * _p0)) / _p1);
}

vec2 _f0(float _p0, float _p1)
{
    vec2 _t0 = vec2(1.0);
    if (u_edgeMode == 0)
    {
        _t0.x = step(0.0, _p0) * step(_p0, 1.0);
        _t0.y = step(0.0, _p1) * step(_p1, 1.0);
    }
    return _t0;
}

vec4 _f1(float _p0)
{
    vec2 _67 = vec2(1.0) / u_ScreenParams.xy;
    vec2 _76 = uv0 + (_67 * vec2(0.0, _p0));
    vec2 _t2 = _76;
    vec2 _83 = uv0 - (_67 * vec2(0.0, _p0));
    vec2 _t3 = _83;
    float param = _t2.y;
    float param_1 = _t3.y;
    vec2 _t4 = _f0(param, param_1);
    return (texture2D(u_InputTexture, _76) * _t4.x) + (texture2D(u_InputTexture, _83) * _t4.y);
}

vec4 _f3(inout vec4 _p0)
{
    vec4 _t5 = vec4(1.0);
    vec4 _t6 = vec4(0.0);
    float _134 = max(1.0, u_Radius / u_MaxRadius);
    float _t9 = 1.0;
    for (float _t10 = 1.0; _t10 <= 128.0; _t10 += 1.0)
    {
        if (_t9 > 128.0)
        {
            break;
        }
        if ((_t9 > (u_MaxRadius * _134)) || (!(_t9 <= u_Radius)))
        {
            break;
        }
        float param = _t9;
        float param_1 = u_Sigma;
        _t6.x = step(_t9, u_Radius) * _f2(param, param_1);
        float param_2 = _t9;
        float param_3 = u_Sigma;
        _t6.y = step(_t9, u_Radius) * _f2(param_2, param_3);
        float param_4 = _t9;
        float param_5 = u_Sigma;
        _t6.z = step(_t9, u_Radius) * _f2(param_4, param_5);
        float param_6 = _t9;
        float param_7 = u_Sigma;
        _t6.w = step(_t9, u_Radius) * _f2(param_6, param_7);
        float param_8 = _t9;
        _p0 += (_f1(param_8) * _t6);
        _t5 += (_t6 * 2.0);
        _t9 += _134;
    }
    _p0 /= _t5;
    return _p0;
}

void main()
{
    vec4 param = texture2D(u_InputTexture, uv0);
    vec4 _238 = _f3(param);
    gl_FragData[0] = _238;
}

