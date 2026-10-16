precision highp float;
precision highp int;

uniform float u_mirrorEdge;
uniform float u_tileEdge;
uniform vec2 u_transformPosition;
uniform vec4 u_ScreenParams;
uniform float u_transformRotation;
uniform vec2 u_transformScale;
uniform mediump sampler2D u_inputTexture;
uniform float u_overlayProgress;
uniform float u_blackWhiteContrast;
uniform float u_blackWhiteIntensity;
uniform float u_rgbSeparation;
uniform float u_rgbSeparationAngle;

varying vec2 v_uv;

vec2 _f3(vec2 _p0)
{
    vec2 _t0 = (_p0 - vec2(0.5)) - u_transformPosition;
    float _100 = max(u_ScreenParams.z, 9.9999997473787516355514526367188e-05);
    _t0.x *= _100;
    float _111 = radians(-u_transformRotation);
    float _114 = sin(_111);
    float _117 = cos(_111);
    _t0 = (mat2(vec2(_117, -_114), vec2(_114, _117)) * _t0) / max(abs(u_transformScale), vec2(9.9999997473787516355514526367188e-05));
    _t0.x /= _100;
    return _t0 + vec2(0.5);
}

bool _f1(vec2 _p0)
{
    bool _51 = all(greaterThanEqual(_p0, vec2(0.0)));
    bool _58;
    if (_51)
    {
        _58 = all(lessThanEqual(_p0, vec2(1.0)));
    }
    else
    {
        _58 = _51;
    }
    return _58;
}

vec2 _f0(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

vec2 _f2(vec2 _p0)
{
    if (u_mirrorEdge > 0.5)
    {
        vec2 param = _p0;
        return _f0(param);
    }
    if (u_tileEdge > 0.5)
    {
        return fract(_p0);
    }
    return _p0;
}

vec4 _f4(vec2 _p0)
{
    bool _149 = (u_mirrorEdge <= 0.5) && (u_tileEdge <= 0.5);
    bool _156;
    if (_149)
    {
        vec2 param = _p0;
        _156 = !_f1(param);
    }
    else
    {
        _156 = _149;
    }
    if (_156)
    {
        return vec4(0.0);
    }
    vec2 param_1 = _p0;
    return texture2D(u_inputTexture, _f2(param_1));
}

vec3 _f5(vec2 _p0)
{
    vec2 param = _p0;
    float _182 = clamp(u_overlayProgress, 0.0, 1.0);
    vec2 param_1 = ((_p0 - vec2(0.5)) / vec2(1.0 + _182)) + vec2(0.5);
    vec4 _196 = _f4(param_1);
    vec4 _t9 = _196;
    vec3 _212 = mix(_f4(param).xyz, _196.xyz, vec3((1.0 - _182) * _t9.w));
    return mix(_212, vec3(clamp(((dot(_212, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)) - 0.5) * clamp(1.0 + u_blackWhiteContrast, 0.0, 4.0)) + 0.5, 0.0, 1.0)), vec3(clamp(u_blackWhiteIntensity, 0.0, 1.0)));
}

void main()
{
    vec2 param = v_uv;
    vec2 _250 = _f3(param);
    bool _255 = (u_mirrorEdge <= 0.5) && (u_tileEdge <= 0.5);
    bool _262;
    if (_255)
    {
        vec2 param_1 = _250;
        _262 = !_f1(param_1);
    }
    else
    {
        _262 = _255;
    }
    if (_262)
    {
        gl_FragData[0] = vec4(0.0);
        return;
    }
    vec2 param_2 = _250;
    vec4 _t17 = _f4(param_2);
    vec2 param_3 = _250;
    vec3 _t18 = _f5(param_3);
    float _279 = max(u_rgbSeparation, 0.0);
    if (_279 > 9.9999997473787516355514526367188e-05)
    {
        vec2 _287 = max(u_ScreenParams.xy, vec2(1.0));
        vec2 _t20 = _287;
        float _304 = radians(u_rgbSeparationAngle);
        vec2 _316 = (vec2(cos(_304), sin(_304)) * (_279 * (min(_t20.x, _t20.y) / 720.0))) / _287;
        vec2 param_4 = _250 + _316;
        vec3 _t28 = _f5(param_4);
        vec2 param_5 = _250 - _316;
        vec3 _t29 = _f5(param_5);
        _t18.x = _t28.x;
        _t18.z = _t29.z;
    }
    gl_FragData[0] = vec4(_t18, _t17.w);
}

