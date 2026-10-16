
uniform float u_frameCount;
uniform mediump sampler2D u_colTex;
uniform vec3 u_boundMin;
uniform vec3 u_boundMax;
uniform float u_displayFrame;
uniform mediump sampler2D u_posTex;
uniform mediump sampler2D u_rotTex;
uniform float u_interpolate;
uniform mat4 u_MVP;

attribute vec2 a_uv1;
attribute vec3 a_position;
attribute vec3 a_normal;
varying vec2 v_uv0;
attribute vec2 a_uv0;
varying vec3 v_nDirWS;
varying vec3 v_tDirWS;
varying vec3 v_bDirWS;
varying vec3 v_posWS;
varying vec4 v_vertexColor;
varying vec2 v_uv1;

vec2 _f0(vec2 _p0, float _p1)
{
    return vec2(a_uv1.x * _p0.x, ((1.0 - a_uv1.y) * _p0.y) + ((mod(floor(_p1) - 1.0, u_frameCount) / u_frameCount) * _p0.y));
}

vec4 _f2(vec2 _p0)
{
    return texture2DLod(u_colTex, _p0, 0.0);
}

void _f1(vec4 _p0, out vec3 _p1, out vec3 _p2)
{
    _p1 = normalize((cross(_p0.xyz, cross(_p0.xyz, vec3(0.0, 1.0, 0.0)) + (vec3(0.0, 1.0, 0.0) * _p0.w)) * 2.0) + vec3(0.0, 1.0, 0.0));
    _p2 = normalize((cross(_p0.xyz, cross(_p0.xyz, vec3(-1.0, 0.0, 0.0)) + (vec3(-1.0, 0.0, 0.0) * _p0.w)) * 2.0) + vec3(-1.0, 0.0, 0.0));
}

void main()
{
    float _129 = u_boundMin.z * 10.0;
    float _140 = u_boundMax.x * (-10.0);
    vec2 _147 = vec2(1.0 - (ceil(_129) - _129), 1.0 - (_140 - floor(_140)));
    vec2 param = _147;
    float param_1 = u_displayFrame;
    vec2 _154 = _f0(param, param_1);
    vec2 param_2 = _154;
    vec4 _168 = _f2(param_2);
    vec3 _t11 = a_normal;
    vec4 param_3 = texture2DLod(u_rotTex, _154, 0.0);
    vec3 param_4;
    vec3 param_5;
    _f1(param_3, param_4, param_5);
    _t11 = param_4;
    vec3 _182 = texture2DLod(u_posTex, _154, 0.0).xyz;
    vec3 _t13 = _182;
    vec3 _t14 = param_4;
    vec3 _t15 = param_5;
    vec4 _t16 = _168;
    if (u_interpolate > 0.5)
    {
        vec2 param_6 = _147;
        float param_7 = u_displayFrame + 1.0;
        vec2 _202 = _f0(param_6, param_7);
        vec2 param_8 = _202;
        vec4 param_9 = texture2DLod(u_rotTex, _202, 0.0);
        vec3 param_10;
        vec3 param_11;
        _f1(param_9, param_10, param_11);
        float _226 = fract(u_displayFrame);
        vec3 _232 = vec3(_226);
        _t13 = mix(_182, texture2DLod(u_posTex, _202, 0.0).xyz, _232);
        _t14 = mix(_t11, param_10, _232);
        _t15 = mix(param_5, param_11, _232);
        _t16 = mix(_168, _f2(param_8), vec4(_226));
    }
    vec3 _254 = (_t13 * vec3(-1.0, 1.0, 1.0)) + a_position;
    bvec3 _262 = bvec3(a_uv1.y <= 0.100000001490116119384765625);
    vec3 _263 = vec3(_262.x ? vec3(0.0).x : _254.x, _262.y ? vec3(0.0).y : _254.y, _262.z ? vec3(0.0).z : _254.z);
    gl_Position = u_MVP * vec4(_263, 1.0);
    v_uv0 = vec2(a_uv0.x, a_uv0.y);
    v_nDirWS = normalize(_t14);
    v_tDirWS = normalize(_t15);
    v_bDirWS = normalize(cross(v_nDirWS, v_tDirWS));
    v_posWS = _263;
    v_vertexColor = _t16;
}

