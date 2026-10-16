precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump sampler2D u_inputTexture;
uniform float u_height;
uniform float u_causticsSize;
uniform mediump int u_enable;

varying vec2 v_xy;

vec2 _f0()
{
    return u_ScreenParams.xy;
}

vec2 _f1(vec2 _p0)
{
    return (_p0 / _f0()) + vec2(0.5);
}

float _f3(vec4 _p0)
{
    return ((_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0)) + (_p0.w / 16581375.0);
}

float _f4(vec2 _p0)
{
    vec2 param = _p0;
    vec4 param_1 = texture2D(u_inputTexture, _f1(param));
    return _f3(param_1) * u_height;
}

float _f5(vec2 _p0)
{
    vec2 param = _p0;
    float _126 = _f4(param);
    float _131 = max(u_causticsSize, 1.0);
    vec2 _134 = vec2(_131, 0.0);
    vec2 _137 = vec2(0.0, _131);
    vec2 param_1 = _p0 + _134;
    float _143 = _f4(param_1);
    vec2 param_2 = _p0 - _134;
    float _149 = _f4(param_2);
    vec2 param_3 = _p0 + _137;
    float _155 = _f4(param_3);
    vec2 param_4 = _p0 - _137;
    float _161 = _f4(param_4);
    float _183 = min(_126, min(_143, min(_149, min(_155, _161))));
    float _197 = max(_126, max(_143, max(_149, max(_155, _161)))) - _183;
    return mix(0.5, ((((((_126 + _143) + _149) + _155) + _161) * 0.20000000298023223876953125) - _183) / max(_197, 9.9999999747524270787835121154785e-07), step(0.20000000298023223876953125, _197));
}

vec4 _f2(inout float _p0)
{
    vec4 _t0 = vec4(0.0);
    _p0 *= 255.0;
    _t0.x = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.y = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.z = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _t0.w = _p0;
    return _t0;
}

void main()
{
    if (u_enable > 0)
    {
        vec2 param = v_xy;
        float param_1 = _f5(param);
        vec4 _231 = _f2(param_1);
        gl_FragData[0] = _231;
    }
    else
    {
        float param_2 = 0.5;
        vec4 _234 = _f2(param_2);
        gl_FragData[0] = _234;
    }
}

