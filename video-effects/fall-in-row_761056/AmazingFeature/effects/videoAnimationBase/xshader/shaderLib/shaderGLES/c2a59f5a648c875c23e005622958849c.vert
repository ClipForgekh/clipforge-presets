
attribute vec3 a_position;
varying vec2 uv1;
varying vec2 uv0;
attribute vec2 a_texcoord0;

void main()
{
    vec2 _t0 = a_position.xy;
    gl_Position = vec4(a_position.xy, a_position.z, 1.0);
    uv1 = vec2((_t0.x * 0.5) + 0.5, (_t0.y * 0.5) + 0.5);
    uv0 = a_texcoord0;
}

