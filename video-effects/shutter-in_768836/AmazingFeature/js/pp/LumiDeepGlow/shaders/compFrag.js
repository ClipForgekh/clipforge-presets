exports.source=`
precision highp float;

varying vec2 vUv;

uniform sampler2D tDiffuse;
uniform sampler2D tSource;
uniform float u_opacity;
uniform float u_mult;
uniform float u_gammaValue;
uniform int u_blendMode;
uniform int u_comp;
uniform vec3 u_tintColor;
uniform float u_tintMix;

const float EPS = 0.001;

float blendScreenScalar(float base, float blend) {
  return 1.0 - ((1.0 - base) * (1.0 - blend));
}

vec3 blendAdd(vec3 base, vec3 blend) {
  return min(base + blend, vec3(1.0));
}

vec3 blendScreen(vec3 base, vec3 blend) {
  return vec3(
    blendScreenScalar(base.r, blend.r),
    blendScreenScalar(base.g, blend.g),
    blendScreenScalar(base.b, blend.b)
  );
}

vec4 gammaVec(vec4 color) {
  return vec4(pow(color.rgb, vec3(1.0 / max(u_gammaValue, EPS))), color.a);
}

vec4 deGammaVec(vec4 color) {
  return vec4(pow(color.rgb, vec3(u_gammaValue)), color.a);
}

vec4 composite(vec4 a, vec4 b) {
  // Treat u_opacity as intensity multiplier for the blend layer (b)
  vec3 blendRGB = b.rgb * u_opacity;
  vec3 res;
  
  if (u_blendMode == 0) {
    // Screen: 1 - (1 - a) * (1 - blendRGB)
    // Note: If blendRGB > 1, this can go < 0? No, (1-blendRGB) becomes negative.
    // (1-a) is positive (0..1). Result > 1. This creates "Glow".
    res = vec3(1.0) - (vec3(1.0) - a.rgb) * (vec3(1.0) - blendRGB);
  } else {
    // Add
    res = a.rgb + blendRGB;
  }
  
  // For Deep Glow, we usually just want to keep the source alpha or max it
  return vec4(res, max(a.a, b.a));
}

void main() {
  vec4 top = deGammaVec(texture2D(tSource, vUv));
  vec4 bottom = deGammaVec(texture2D(tDiffuse, vUv));
  
  // Apply tint to glow (bottom layer)
  if (u_tintMix > 0.0) {
    vec3 gray = vec3(dot(bottom.rgb, vec3(0.2126, 0.7152, 0.0722)));
    vec3 tinted = gray * u_tintColor;
    bottom.rgb = mix(bottom.rgb, tinted, u_tintMix);
  }

  vec4 color;
  if (u_comp == 1) {
    color = composite(top, bottom);
  } else {
    color = bottom * u_opacity;
  }
  // Clamp only after gamma correction to avoid cutting off HDR values too early?
  // But standard displays clamp at 1.0.
  color = clamp(gammaVec(color * u_mult), 0.0, 1.0);
  gl_FragColor = color;
}
`;