precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform mediump sampler2D inputImageTexture;
uniform float signalStrength;

varying vec2 v_uv;

float _f0(vec3 _p0)
{
    return ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
}

float _f1(vec2 _p0)
{
    vec2 _49 = fract(_p0 * 1324.5179443359375);
    vec2 _t0 = _49 + vec2(dot(_49, _49.yx + vec2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

vec4 _f2(vec2 _p0)
{
    return vec4(floor(_p0.x * 255.0) / 255.0, fract(_p0.x * 255.0), floor(_p0.y * 255.0) / 255.0, fract(_p0.y * 255.0));
}

void main()
{
    vec2 _t6 = vec2(1.0) / ((u_ScreenParams.xy / vec2(min(u_ScreenParams.x, u_ScreenParams.y))) * 720.0);
    float _t7 = 0.0;
    float _t8 = v_uv.x;
    for (float _t9 = -10.0; _t9 <= 30.0; _t9 += 2.0)
    {
        vec3 param = texture2D(inputImageTexture, v_uv - vec2((_t9 + 1.0) * _t6.x, 0.0)).xyz - texture2D(inputImageTexture, v_uv - vec2((_t9 - 1.0) * _t6.x, 0.0)).xyz;
        float _176 = abs(_f0(param)) / 1.0;
        float _179 = step(_t7, _176);
        _t8 = ((1.0 - _179) * _t8) + (_179 * (v_uv.x - (_t9 * _t6.x)));
        _t7 = max(_t7, _176);
    }
    vec2 param_1 = vec2(v_uv.y);
    float _215 = _t8;
    float _255 = clamp(_215, 0.0, 1.0);
    _t8 = _255;
    vec2 param_2 = vec2(clamp(1.0 * pow((min(0.4000000059604644775390625, _t7) * (1.0 - (((step(v_uv.x, _215) * (_215 - v_uv.x)) / _t6.x) / 10.0))) * (1.0 - (((step(_215, v_uv.x) * (v_uv.x - _215)) / _t6.x) / 30.0)), 1.2000000476837158203125 + (_f1(param_1) * signalStrength)), 0.0, 1.0), _255);
    gl_FragData[0] = _f2(param_2);
}

