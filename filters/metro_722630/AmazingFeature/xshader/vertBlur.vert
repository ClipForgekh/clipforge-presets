attribute vec3 attPosition;
attribute vec2 attUV;
varying vec2 TexCoords;

void main(void) {
    TexCoords = attUV;
    gl_Position = vec4(attPosition, 1.0);
}
