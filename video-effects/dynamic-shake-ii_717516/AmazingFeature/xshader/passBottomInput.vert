precision highp float;

attribute vec4 position;
attribute vec2 texcoord0;
// uniform vec4 u_ScreenParams;
varying highp vec2 textureCoordinate;

void main()
{
    textureCoordinate = texcoord0;
    gl_Position = sign(vec4(position.xy, 0.0, 1.0));
}
