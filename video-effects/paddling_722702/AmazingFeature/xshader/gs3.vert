precision highp float;

attribute vec2 attPosition;
attribute vec2 attUV;

varying vec2 v_uv;

void main () {
    v_uv = attUV;
    gl_Position = vec4(attPosition, 0.0, 1.0);
}