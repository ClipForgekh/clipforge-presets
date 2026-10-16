
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
varying vec2 v_uv0;
attribute vec2 a_uv0;
varying vec3 v_posWS;
varying vec3 v_nDirWS;
varying vec3 v_tDirWS;
varying vec3 v_bDirWS;
varying vec4 v_vertexColor;
varying vec2 v_uv1;

vec2 _f0(vec2 _p0, float _p1)
{
    return vec2(a_uv1.x * _p0.x, ((1.0 - a_uv1.y) * _p0.y) + ((mod(floor(_p1) - 1.0, u_frameCount) / u_frameCount) * _p0.y));
}

vec4 _f3(vec2 _p0)
{
    return texture2DLod(u_colTex, _p0, 0.0);
}

vec3 _f1(vec4 _p0, vec3 _p1)
{
    return normalize((cross(_p0.xyz, cross(_p0.xyz, _p1) + (_p1 * _p0.w)) * 2.0) + _p1);
}

vec3 _f2(vec4 _p0, vec3 _p1)
{
    vec3 _95 = normalize(cross(_p1, vec3(0.0, 1.0, 0.0)));
    return normalize((cross(_p0.xyz, cross(_p0.xyz, _95) + (_95 * _p0.w)) * 2.0) + _95);
}

void main()
{
    float _136 = u_boundMin.z * 10.0;
    float _147 = u_boundMax.x * (-10.0);
    vec2 param = vec2(1.0 - (ceil(_136) - _136), 1.0 - (_147 - floor(_147)));
    float param_1 = u_displayFrame;
    vec2 _161 = _f0(param, param_1);
    mediump vec4 _171 = texture2DLod(u_rotTex, _161, 0.0);
    vec4 _t9 = vec4(1.0);
    if (u_useVertexColor > 0)
    {
        vec2 param_2 = _161;
        _t9 = _f3(param_2);
    }
    mediump vec3 _190 = texture2DLod(u_colTex, _161, 0.0).xyz;
    vec4 param_3 = _171;
    vec3 param_4 = _190;
    vec3 _196 = _f1(param_3, param_4);
    vec4 param_5 = _171;
    vec3 param_6 = _196;
    vec3 _202 = _f2(param_5, param_6);
    vec3 _223 = (texture2DLod(u_posTex, _161, 0.0).xyz * vec3(-1.0, 1.0, 1.0)) + a_position;
    gl_Position = u_MVP * vec4(_223, 1.0);
    v_uv0 = vec2(a_uv0.x, a_uv0.y);
    v_posWS = _223;
    v_nDirWS = _190;
    v_tDirWS = _202;
    v_bDirWS = normalize(cross(_196, _202));
    v_vertexColor = _t9;
}

