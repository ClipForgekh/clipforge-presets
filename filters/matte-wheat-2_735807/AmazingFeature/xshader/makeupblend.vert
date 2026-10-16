attribute vec3 attPosition; // 移动后的坐标
attribute vec2 attStandardUV; // 标准坐标
varying vec2 srcUV;
varying vec2 maskRegionUV;

uniform mat4 uMVPMatrix;
uniform mat4 maskRegionST;

highp mat4 transpose(in highp mat4 inMatrix) {
    highp vec4 i0 = inMatrix[0];
    highp vec4 i1 = inMatrix[1];
    highp vec4 i2 = inMatrix[2];
    highp vec4 i3 = inMatrix[3];

    highp mat4 outMatrix = mat4(
                 vec4(i0.x, i1.x, i2.x, i3.x),
                 vec4(i0.y, i1.y, i2.y, i3.y),
                 vec4(i0.z, i1.z, i2.z, i3.z),
                 vec4(i0.w, i1.w, i2.w, i3.w)
                 );

    return outMatrix;
}
void main() {
    gl_Position = uMVPMatrix * vec4(attPosition.xy, 0.0, 1.0);
    srcUV = 0.5 * gl_Position.xy + 0.5;
    maskRegionUV = (transpose(maskRegionST) * vec4(attStandardUV, 0., 1.)).xy;
}
