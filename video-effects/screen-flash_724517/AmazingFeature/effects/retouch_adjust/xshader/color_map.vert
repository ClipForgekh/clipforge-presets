// attribute vec4 aVertexPosition;
// uniform mat4 uTextureMatrix;
// varying vec2 vTextureCoord;
// void main() 
// {
//     gl_Position = aVertexPosition;
//     vTextureCoord = (uTextureMatrix * (aVertexPosition + vec4(1.0)) / 2.0).st;
// }


precision highp float;

attribute vec3 attPosition;
attribute vec2 attUV;

varying vec2 uv;

uniform int imageWidth;
uniform int imageHeight;

void main() {
    gl_Position = vec4(attPosition,1.0);
    uv = attPosition.xy*0.5+0.5;
}
