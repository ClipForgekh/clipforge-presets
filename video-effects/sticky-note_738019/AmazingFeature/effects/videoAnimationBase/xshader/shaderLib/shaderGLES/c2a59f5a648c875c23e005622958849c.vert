
attribute vec3 a_position;
varying vec2 uv1;
varying vec2 uv0;
attribute vec2 a_texcoord0;

void main()
{
    vec2 pos = a_position.xy;
    gl_Position = vec4(a_position.xy, a_position.z, 1.0);
    uv1 = vec2(pos.x * 0.5 + 0.5, pos.y * 0.5 + 0.5);
    uv0 = a_texcoord0;
}

