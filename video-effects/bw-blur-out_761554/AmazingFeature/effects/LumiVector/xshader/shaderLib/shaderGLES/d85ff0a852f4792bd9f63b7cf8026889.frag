precision highp float;
precision highp int;

uniform float u_angle;
uniform float u_aspectRatio;
uniform vec2 u_rotationPoint;
uniform vec2 u_screenSize;
uniform float u_radius;
uniform float u_fade0;
uniform float u_fade1;
uniform float u_opacity;
uniform vec2 u_maskPosition;
uniform vec2 u_maskSize;
uniform mediump int u_maskType;

varying vec2 v_uv;

vec4 _f0()
{
    float _27 = (u_angle * 3.141590118408203125) / 180.0;
    float _32 = cos(_27);
    float _34 = sin(_27);
    vec2 _72 = u_screenSize * 0.5;
    vec2 _83 = abs((((mat2(vec2(_32, (-_34) * u_aspectRatio), vec2(_34 / u_aspectRatio, _32)) * (v_uv - u_rotationPoint)) + u_rotationPoint) * u_screenSize) - _72) - (_72 - vec2(u_radius));
    vec2 _t6 = _83;
    return ((vec4(1.0) * smoothstep(u_fade0, u_fade1, -((length(max(_83, vec2(0.0))) + min(max(_t6.x, _t6.y), 0.0)) - u_radius))) * u_opacity) * (step(0.001000000047497451305389404296875, u_screenSize.x) * step(0.001000000047497451305389404296875, u_screenSize.y));
}

float _f1(vec2 _p0)
{
    vec2 _140 = vec2(u_maskPosition.x - (_p0.x * 0.5), u_maskPosition.y - (_p0.y * 0.5));
    vec2 _t9 = _140;
    vec2 _154 = vec2(u_maskPosition.x + (_p0.x * 0.5), u_maskPosition.y + (_p0.y * 0.5));
    vec2 _t10 = _154;
    vec2 _t11 = (_140 + _154) / vec2(2.0);
    float _168 = (_t10.x - _t9.x) / 2.0;
    float _175 = (_t10.y - _t9.y) / 2.0;
    return smoothstep(1.0, 1.0 - ((3.0 / u_screenSize.x) / max(_168, _175)), (((v_uv.x - _t11.x) * (v_uv.x - _t11.x)) / (_168 * _168)) + (((v_uv.y - _t11.y) * (v_uv.y - _t11.y)) / (_175 * _175)));
}

vec4 _f2()
{
    vec2 param = u_maskSize;
    return (vec4(1.0) * u_opacity) * _f1(param);
}

void main()
{
    vec4 _t20 = vec4(0.0);
    if (u_maskType == 0)
    {
        _t20 = _f0();
    }
    else
    {
        if (u_maskType == 1)
        {
            _t20 = _f2();
        }
    }
    gl_FragData[0] = _t20;
}

