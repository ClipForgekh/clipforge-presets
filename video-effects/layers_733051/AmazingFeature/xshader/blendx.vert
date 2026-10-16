precision highp float;

uniform mat4 u_baseMat;
uniform mat4 u_baseMaskMat;
uniform mat4 u_haloMat;
uniform mat4 u_shadowMat;
uniform mat4 u_maskMat;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uvBase;
varying vec2 v_uvBaseMask;
varying vec2 v_uvHalo;
varying vec2 v_uvShadow;
varying vec2 v_uvMask;


void main () {
    vec4 uv = vec4(a_texcoord0, 0.0, 1.0);

    v_uvBase = (u_baseMat * uv).st;

    v_uvBaseMask = (u_baseMaskMat * uv).st;
    v_uvBaseMask.y = 1.0 - v_uvBaseMask.y;

    v_uvHalo = (u_haloMat * uv).st;
    v_uvHalo.y = 1.0 - v_uvHalo.y;

    v_uvShadow = (u_shadowMat * uv).st;
    v_uvShadow.y = 1.0 - v_uvShadow.y;

    v_uvMask = (u_maskMat * uv).st;
    v_uvMask.y = 1.0 - v_uvMask.y;

    gl_Position = a_position;
}
