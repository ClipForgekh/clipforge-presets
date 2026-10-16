exports.source=`
precision highp float;

// Receive UV from commonVert
varying vec2 vUv;

// Final composite input texture
uniform sampler2D u_inputTex;

void main() {
    // Directly sample and output the final result
    gl_FragColor = texture2D(u_inputTex, vUv);
}
`;