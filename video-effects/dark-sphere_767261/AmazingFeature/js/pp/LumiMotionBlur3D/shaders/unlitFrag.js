exports.unlitFrag=`
precision highp float;

uniform sampler2D u_inputTex;
varying vec2 v_uv;

void main() {
    gl_FragColor = texture2D(u_inputTex, v_uv);
}
`;exports.source=exports.unlitFrag;