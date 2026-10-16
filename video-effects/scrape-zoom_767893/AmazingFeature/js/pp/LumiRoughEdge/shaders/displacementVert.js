exports.source=`
varying vec2 v_uv;
uniform float picture_scale;
void main() {
    v_uv = uv;
    v_uv -= 0.5;
    v_uv /= picture_scale;
    v_uv += 0.5;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
`;