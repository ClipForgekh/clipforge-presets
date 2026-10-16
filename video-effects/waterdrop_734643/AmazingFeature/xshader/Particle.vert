attribute vec3 position;
attribute vec2 texcoord0;
attribute vec4 color0;
uniform mat4 u_MVP;
uniform vec2 uvTiling;
uniform vec2 uvOffset;

varying vec4 v_color;
varying vec2 v_texCoord;
void main()
{
    v_color     = color0;
    v_texCoord  = texcoord0 * uvTiling + uvOffset;

    gl_Position = u_MVP * vec4(position, 1.0);
}
