exports.source=`
precision highp float;

varying vec2 vUv;

uniform sampler2D tDiffuse;
uniform float u_threshold;
uniform float u_thresholdSmooth;
uniform float u_greyScale;
uniform float u_gammaValue;
uniform float u_redOffset;
uniform float u_greenOffset;
uniform float u_blueOffset;
uniform int u_gamma;
uniform int u_ca;

float rgb2gray(vec3 rgb) {
  return dot(rgb, vec3(0.2126, 0.7152, 0.0722));
}

void main() {
  vec4 color = texture2D(tDiffuse, vUv);

  if (u_ca == 1) {
    vec4 texTmp;
    float r;
    float g;
    float b;

    // Red channel
    texTmp = texture2D(tDiffuse, vUv + vec2(-u_redOffset, u_redOffset));
    r = texTmp.r;

    // Green channel
    texTmp = texture2D(tDiffuse, vUv + vec2(-u_greenOffset, u_greenOffset));
    g = texTmp.g;

    // Blue channel
    texTmp = texture2D(tDiffuse, vUv + vec2(-u_blueOffset, u_blueOffset));
    b = texTmp.b;

    // Reconstruct alpha? Lua version multiplies by alpha then discards logic?
    // Lua: r = texTmp.r *= texTmp.a; -> effectively premultiplying if not already?
    // But then: color = vec4(r, g, b, 1.0); 
    // We should preserve original alpha logic or just use RGB.
    // Assuming tDiffuse is standard texture.
    
    // For now, simple RGB shift
    color = vec4(r, g, b, color.a);
  }

  float thresholdPct = 0.0;
  if (color.r < u_threshold) {
    thresholdPct = color.r / max(u_threshold, 1e-4);
    color.r = (thresholdPct * color.r) * u_thresholdSmooth;
  }
  if (color.g < u_threshold) {
    thresholdPct = color.g / max(u_threshold, 1e-4);
    color.g = (thresholdPct * color.g) * u_thresholdSmooth;
  }
  if (color.b < u_threshold) {
    thresholdPct = color.b / max(u_threshold, 1e-4);
    color.b = (thresholdPct * color.b) * u_thresholdSmooth;
  }

  if (u_gamma == 1) {
    color.rgb = pow(color.rgb, vec3(u_gammaValue));
  }

  float gray = rgb2gray(color.rgb);
  color.rgb = mix(color.rgb, vec3(gray), u_greyScale);
  gl_FragColor = color;
}
`;