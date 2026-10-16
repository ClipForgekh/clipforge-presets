
struct SpaceTransform
{
    mat4 local2target;
    mat4 target2local;
};

uniform int u_twistType;
uniform float u_angle;
uniform mat4 u_targetMatrix;
uniform float u_completion;

attribute vec2 a_position;
varying vec2 v_uv;
attribute vec2 a_texcoord0;

mat4 _f0(mat4 _p0)
{
    float _96 = (_p0[0].x * _p0[1].y) - (_p0[0].y * _p0[1].x);
    float _104 = (_p0[0].x * _p0[1].z) - (_p0[0].z * _p0[1].x);
    float _112 = (_p0[0].x * _p0[1].w) - (_p0[0].w * _p0[1].x);
    float _120 = (_p0[0].y * _p0[1].z) - (_p0[0].z * _p0[1].y);
    float _128 = (_p0[0].y * _p0[1].w) - (_p0[0].w * _p0[1].y);
    float _136 = (_p0[0].z * _p0[1].w) - (_p0[0].w * _p0[1].z);
    float _144 = (_p0[2].x * _p0[3].y) - (_p0[2].y * _p0[3].x);
    float _152 = (_p0[2].x * _p0[3].z) - (_p0[2].z * _p0[3].x);
    float _160 = (_p0[2].x * _p0[3].w) - (_p0[2].w * _p0[3].x);
    float _168 = (_p0[2].y * _p0[3].z) - (_p0[2].z * _p0[3].y);
    float _176 = (_p0[2].y * _p0[3].w) - (_p0[2].w * _p0[3].y);
    float _184 = (_p0[2].z * _p0[3].w) - (_p0[2].w * _p0[3].z);
    float _208 = (((((_96 * _184) - (_104 * _176)) + (_112 * _168)) + (_120 * _160)) - (_128 * _152)) + (_136 * _144);
    float _t28 = _208;
    if (_208 == 0.0)
    {
        return mat4(vec4(0.0), vec4(0.0), vec4(0.0), vec4(0.0));
    }
    float _219 = _t28;
    float _220 = 1.0 / _219;
    _t28 = _220;
    return mat4(vec4((((_p0[1].y * _184) - (_p0[1].z * _176)) + (_p0[1].w * _168)) * _220, (((_p0[0].z * _176) - (_p0[0].y * _184)) - (_p0[0].w * _168)) * _220, (((_p0[3].y * _136) - (_p0[3].z * _128)) + (_p0[3].w * _120)) * _220, (((_p0[2].z * _128) - (_p0[2].y * _136)) - (_p0[2].w * _120)) * _220), vec4((((_p0[1].z * _160) - (_p0[1].x * _184)) - (_p0[1].w * _152)) * _220, (((_p0[0].x * _184) - (_p0[0].z * _160)) + (_p0[0].w * _152)) * _220, (((_p0[3].z * _112) - (_p0[3].x * _136)) - (_p0[3].w * _104)) * _220, (((_p0[2].x * _136) - (_p0[2].z * _112)) + (_p0[2].w * _104)) * _220), vec4((((_p0[1].x * _176) - (_p0[1].y * _160)) + (_p0[1].w * _144)) * _220, (((_p0[0].y * _160) - (_p0[0].x * _176)) - (_p0[0].w * _144)) * _220, (((_p0[3].x * _128) - (_p0[3].y * _112)) + (_p0[3].w * _96)) * _220, (((_p0[2].y * _112) - (_p0[2].x * _128)) - (_p0[2].w * _96)) * _220), vec4((((_p0[1].y * _152) - (_p0[1].x * _168)) - (_p0[1].z * _144)) * _220, (((_p0[0].x * _168) - (_p0[0].y * _152)) + (_p0[0].z * _144)) * _220, (((_p0[3].y * _104) - (_p0[3].x * _120)) - (_p0[3].z * _96)) * _220, (((_p0[2].x * _120) - (_p0[2].y * _104)) + (_p0[2].z * _96)) * _220));
}

void _f1(inout SpaceTransform _p0, mat4 _p1, mat4 _p2)
{
    mat4 param = _p2;
    _p0.local2target = _f0(param) * _p1;
    mat4 param_1 = _p0.local2target;
    _p0.target2local = _f0(param_1);
}

vec3 _f2(vec3 _p0, float _p1, SpaceTransform _p2)
{
    vec3 _t30 = (_p2.local2target * vec4(_p0, 1.0)).xyz;
    float _461 = _t30.z;
    float _464 = _t30.x;
    float _467 = _t30.y;
    float _474 = _467 * radians(_p1);
    float _477 = sin(_474);
    float _480 = cos(_474);
    float _t37 = _480;
    if (u_twistType == 0)
    {
        if (_t37 < 0.0)
        {
            _t37 = 0.0;
        }
    }
    else
    {
        _t37 = abs(_480);
    }
    vec3 _523 = (_p2.target2local * vec4(vec3((_461 * _477) + (_464 * _t37), _467, (_461 * _t37) - (_464 * _477)), 1.0)).xyz;
    _t30 = _523;
    return _523;
}

void main()
{
    float _538 = mix(0.670000016689300537109375, 1.0, 1.0 - abs(sin(radians(u_angle * 2.0))));
    mat4 param_1 = mat4(vec4(vec4(_538, 0.0, 0.0, 0.0)), vec4(vec4(0.0, _538, 0.0, 0.0)), vec4(vec4(0.0, 0.0, _538, 0.0)), vec4(0.0, 0.0, 0.0, 1.0));
    mat4 param_2 = u_targetMatrix;
    SpaceTransform param;
    _f1(param, param_1, param_2);
    vec3 param_3 = vec3(a_position, 0.0);
    float param_4 = u_completion;
    SpaceTransform param_5 = param;
    gl_Position = vec4(_f2(param_3, param_4, param_5).xy, 0.0, 1.0);
    v_uv = a_texcoord0;
}

