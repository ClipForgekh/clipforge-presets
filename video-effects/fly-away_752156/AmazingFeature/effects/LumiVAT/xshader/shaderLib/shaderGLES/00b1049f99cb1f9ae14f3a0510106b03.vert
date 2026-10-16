
uniform float u_frameCount;
uniform mediump sampler2D u_colTex;
uniform vec3 u_boundMin;
uniform vec3 u_boundMax;
uniform float u_displayFrame;
uniform mediump sampler2D u_posTex;
uniform mediump sampler2D u_rotTex;
uniform int u_useVertexColor;
uniform mat4 u_MVP;

attribute vec2 a_uv1;
attribute vec3 a_position;
attribute vec2 a_uv2;
attribute vec2 a_uv3;
attribute vec3 a_normal;
varying vec2 v_uv0;
attribute vec2 a_uv0;
varying vec3 v_posWS;
varying vec3 v_nDirWS;
varying vec3 v_tDirWS;
varying vec3 v_bDirWS;
varying vec2 v_uv1;
varying vec4 v_vertexColor;

vec2 _f0(vec2 _p0, float _p1)
{
    return vec2(a_uv1.x * _p0.x, ((1.0 - a_uv1.y) * _p0.y) + ((mod(floor(_p1) - 1.0, u_frameCount) / u_frameCount) * _p0.y));
}

vec3 _f1()
{
    return a_position - vec3(a_uv2.x * 1.0, a_uv3.x, 1.0 - a_uv3.y);
}

void _f2(vec3 _p0, float _p1, out vec4 _p2)
{
    float _121 = sqrt(((1.0 - pow(_p0.x, 2.0)) - pow(_p0.y, 2.0)) - pow(_p0.z, 2.0));
    vec4 _t3 = vec4(0.0, 0.0, 0.0, 1.0);
    if (_p1 < 0.5)
    {
        _t3 = vec4(_p0, _121);
    }
    else
    {
        if (_p1 < 1.5)
        {
            _t3 = vec4(_121, _p0.yzx);
        }
        else
        {
            if (_p1 < 2.5)
            {
                _t3 = vec4(_p0.x, -_121, _p0.z, -_p0.y);
            }
            else
            {
                if (_p1 < 3.5)
                {
                    _t3 = vec4(_p0.xy, -_121, -_p0.z);
                }
                else
                {
                    _t3 = vec4(_p0, _121);
                }
            }
        }
    }
    _p2 = _t3;
}

vec4 _f3(vec4 _p0, vec4 _p1)
{
    return vec4((((_p0.w * _p1.x) + (_p0.x * _p1.w)) + (_p0.z * _p1.y)) - (_p0.y * _p1.z), (((_p0.w * _p1.y) + (_p0.y * _p1.w)) + (_p0.x * _p1.z)) - (_p0.z * _p1.x), (((_p0.w * _p1.z) + (_p0.z * _p1.w)) + (_p0.y * _p1.x)) - (_p0.x * _p1.y), (((_p0.w * _p1.w) - (_p0.x * _p1.x)) - (_p0.y * _p1.y)) - (_p0.z * _p1.z));
}

vec3 _f4(vec3 _p0, vec4 _p1)
{
    vec4 param = _p1;
    vec4 param_1 = vec4(_p0, 0.0);
    vec4 param_2 = _f3(param, param_1);
    vec4 param_3 = vec4(-_p1.x, -_p1.y, -_p1.z, _p1.w);
    return _f3(param_2, param_3).xyz;
}

vec4 _f7(vec2 _p0)
{
    return texture2DLod(u_colTex, _p0, 0.0);
}

vec3 _f5(vec4 _p0, vec3 _p1)
{
    return normalize((cross(_p0.xyz, cross(_p0.xyz, _p1) + (_p1 * _p0.w)) * 2.0) + _p1);
}

vec3 _f6(vec4 _p0, vec3 _p1)
{
    vec3 _337 = normalize(cross(_p1, vec3(0.0, 1.0, 0.0)));
    return normalize((cross(_p0.xyz, cross(_p0.xyz, _337) + (_337 * _p0.w)) * 2.0) + _337);
}

void main()
{
    float _375 = u_boundMin.z * 10.0;
    float _386 = u_boundMax.x * (-10.0);
    vec2 param = vec2(1.0 - (ceil(_375) - _375), 1.0 - (_386 - floor(_386)));
    float param_1 = u_displayFrame;
    vec2 _400 = _f0(param, param_1);
    mediump vec4 _405 = texture2DLod(u_posTex, _400, 0.0);
    vec4 _t10 = _405;
    mediump vec4 _410 = texture2DLod(u_rotTex, _400, 0.0);
    vec3 param_2 = _410.xyz;
    float param_3 = floor(_t10.w * 4.0);
    vec4 param_4;
    _f2(param_2, param_3, param_4);
    vec3 param_5 = _f1();
    vec4 param_6 = param_4;
    if (u_useVertexColor > 0)
    {
        vec2 param_7 = _400;
    }
    vec4 param_8 = _410;
    vec3 param_9 = a_normal;
    vec3 _453 = _f5(param_8, param_9);
    vec4 param_10 = _410;
    vec3 param_11 = _453;
    vec3 _459 = _f6(param_10, param_11);
    vec3 _480 = (_405.xyz * vec3(-1.0, 1.0, 1.0)) + _f4(param_5, param_6);
    gl_Position = u_MVP * vec4(_480, 1.0);
    v_uv0 = vec2(a_uv0.x, a_uv0.y);
    v_posWS = _480;
    v_nDirWS = _453;
    v_tDirWS = _459;
    v_bDirWS = normalize(cross(_453, _459));
}

