exports.source=`
varying vec2 vUv;
uniform float picture_scale;

void main() {
    vUv = uv;
    vec2 scaledUv = uv;
    scaledUv -= 0.5;
    scaledUv /= max(picture_scale, 0.001);
    scaledUv += 0.5;
    vUv = scaledUv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
`;