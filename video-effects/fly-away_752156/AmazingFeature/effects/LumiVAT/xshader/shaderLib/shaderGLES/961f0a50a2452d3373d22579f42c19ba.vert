
uniform vec2 u_vatPos_texelSize;
uniform float u_frameCount;
uniform float u_timePosition;
uniform mediump sampler2D u_posTex;
uniform mediump sampler2D u_normTex;
uniform mat4 u_MVP;

attribute vec2 a_uv0;
attribute vec3 a_position;
varying vec2 v_uv0;
varying vec3 v_nDirWS;
varying vec3 v_posWS;
varying vec3 v_tDirWS;
varying vec3 v_bDirWS;
varying vec2 v_uv1;
varying vec4 v_vertexColor;

void main()
{
    vec2 _36 = vec2(((u_frameCount - 1.0) * u_timePosition) * (1.0 / u_vatPos_texelSize.x), 0.0) + a_uv0;
    gl_Position = u_MVP * vec4(a_position + texture2DLod(u_posTex, _36, 0.0).xyz, 1.0);
    v_uv0 = vec2(a_uv0.x, a_uv0.y);
    v_nDirWS = texture2DLod(u_normTex, _36, 0.0).xyz;
}

