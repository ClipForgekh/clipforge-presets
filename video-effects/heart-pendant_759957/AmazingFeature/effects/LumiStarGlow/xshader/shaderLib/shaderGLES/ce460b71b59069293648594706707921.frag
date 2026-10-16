precision highp float;
precision highp int;

uniform float u_noiseScale;
uniform float u_phaseAngle;
uniform float u_noiseAmplitude;

varying vec2 v_uv;

float _f0(float _p0)
{
    return fract(sin(_p0) * 43758.546875);
}

mat2 _f1(float _p0)
{
    float _33 = cos(_p0);
    float _36 = sin(_p0);
    return mat2(vec2(_33, -_36), vec2(_36, _33));
}

float _f2(inout vec2 _p0, float _p1)
{
    float _t2 = 0.0;
    float _t3 = 1.0;
    float _t4 = 0.0;
    for (float _t7 = 0.0; _t7 < 4.0; _t7 += 1.0)
    {
        vec2 _68 = _p0 * _t3;
        vec2 _t8 = _68;
        vec2 _70 = floor(_68);
        float param = _70.x + _70.y;
        vec2 _83 = _t8;
        float param_1 = _f0(param) * 1000.0;
        vec2 _91 = (fract(_83) - vec2(0.5)) * _f1(param_1);
        _t8 = _91;
        _t2 += ((sin((_t8.x * 10.0) + _p1) * smoothstep(0.25, 0.0, dot(_91, _91))) / _t3);
        _p0 = (_p0 * mat2(vec2(0.540000021457672119140625, -0.839999973773956298828125), vec2(0.839999973773956298828125, 0.540000021457672119140625))) + vec2(_t7);
        _t4 += (1.0 / _t3);
        _t3 *= 1.2400000095367431640625;
    }
    return _t2 / _t4;
}

void main()
{
    vec2 _t11 = ((v_uv - vec2(0.5)) * u_noiseScale) + vec2(0.5);
    _t11.y = 1.0;
    vec2 param = _t11;
    float param_1 = u_phaseAngle;
    float _184 = _f2(param, param_1);
    gl_FragData[0] = vec4(vec3(((_184 * u_noiseAmplitude) * 0.5) + 0.5), 1.0);
}

