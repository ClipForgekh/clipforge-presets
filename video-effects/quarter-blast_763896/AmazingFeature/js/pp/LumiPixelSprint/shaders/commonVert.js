exports.source=`
varying vec2 v_uv;
varying vec3 v_tangentViewPos;
varying vec3 v_tangentFragPos;
uniform vec3 u_viewPos;
void main() {
  v_uv = uv;
  v_tangentViewPos = u_viewPos;
  v_tangentFragPos = position.xyz;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
`;