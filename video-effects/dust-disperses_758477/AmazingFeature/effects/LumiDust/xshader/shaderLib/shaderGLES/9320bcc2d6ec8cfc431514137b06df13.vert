
uniform float picture_scale;

attribute vec3 attPosition;
varying vec2 uv0;
attribute vec2 attUV;

void main()
{
    gl_Position = vec4(attPosition, 1.0);
    uv0 = attUV;
    uv0 -= vec2(0.5);
    uv0 /= vec2(picture_scale);
    uv0 += vec2(0.5);
}

