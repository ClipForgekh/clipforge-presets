
uniform vec3 u_minValues;
uniform vec3 u_maxValues;
uniform float u_displayFrame;
uniform float u_speed;
uniform float u_frameCount;
uniform float u_yResolution;
uniform mediump sampler2D u_vatPosTex;
uniform mediump sampler2D u_vatNormTex;
uniform mat4 u_MVP;

attribute vec2 a_uv1;
attribute vec3 a_normal;
attribute vec3 a_position;
varying vec2 v_uv0;
attribute vec2 a_uv0;
varying vec3 v_posWS;
varying vec3 v_nDirWS;
varying vec3 v_tDirWS;
varying vec3 v_bDirWS;
varying vec2 v_uv1;
varying vec4 v_vertexColor;

vec3 _f0(vec3 _p0, bool _p1)
{
    vec2 _20;
    if (_p1)
    {
        _20 = vec2(1.0, -1.0);
    }
    else
    {
        _20 = vec2(u_minValues.x, u_maxValues.x);
    }
    vec2 _t0 = _20;
    vec2 _t1 = vec2(u_minValues.y, u_maxValues.y);
    vec2 _t2 = vec2(u_minValues.z, u_maxValues.z);
    return vec3(mix(_t0.x, _t0.y, _p0.x), mix(_t1.x, _t1.y, _p0.y), mix(_t2.x, _t2.y, _p0.z));
}

void main()
{
    vec2 _115 = vec2(a_uv1.x, (1.0 - a_uv1.y) + ((fract((u_displayFrame * u_speed) / u_frameCount) * (u_frameCount - 1.0)) / u_yResolution));
    vec3 param = texture2DLod(u_vatPosTex, _115, 0.0).xyz;
    bool param_1 = false;
    vec3 param_2 = texture2DLod(u_vatNormTex, _115, 0.0).xyz;
    bool param_3 = true;
    vec3 _156 = a_position + _f0(param, param_1);
    gl_Position = u_MVP * vec4(_156, 1.0);
    v_uv0 = a_uv0;
    v_posWS = _156;
    v_nDirWS = a_normal + _f0(param_2, param_3);
}

