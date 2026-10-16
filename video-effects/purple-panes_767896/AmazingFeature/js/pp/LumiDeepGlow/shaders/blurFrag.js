exports.source=`
precision highp float;

varying vec2 vUv;

uniform sampler2D tDiffuse;
uniform vec2 u_aspect;
uniform float u_steps;
uniform float u_stepsInt;
uniform float u_stride;
uniform float u_sigma;
uniform float u_angle;
uniform float u_gammaValue;
uniform float u_rotate;

const float PI = 3.1415926;
const float EPS = 0.001;
const int MAXSTEPS = 64;

vec3 deGamma(vec3 color) {
  return pow(color, vec3(u_gammaValue));
}

vec3 gamma(vec3 color) {
  return pow(color, vec3(1.0 / max(u_gammaValue, EPS)));
}

float getWeight(float x, float sigma) {
  return exp(-(x * x) / (2.0 * sigma * sigma)) / (sqrt(2.0 * PI) * sigma);
}

vec3 blur(float steps, vec2 dir, float stride, float sigma) {
  float totalWeight = getWeight(0.0, sigma);
  vec3 center = deGamma(texture2D(tDiffuse, vUv).rgb) * totalWeight;
  vec3 total = vec3(0.0);

  int STEPS = int(steps);
  // Remove u_stepsInt skipping, always iterate by 1 for smoothness
  for (int i = 1; i < MAXSTEPS; i++) {
    if (i >= STEPS) {
      break;
    }
    float fi = float(i);
    float weight = getWeight(fi / steps * 15.0, sigma);
    vec2 offset = dir * fi * stride;

    vec3 colorL = deGamma(texture2D(tDiffuse, vUv + offset).rgb);
    vec3 colorR = deGamma(texture2D(tDiffuse, vUv - offset).rgb);

    total += (colorL + colorR) * weight;
    totalWeight += weight * 2.0;
  }
  return (total + center) / vec3(totalWeight);
}

vec2 rotateVec(vec2 v, float a) {
  float s = sin(a);
  float c = cos(a);
  mat2 m = mat2(c, -s, s, c);
  return m * v;
}

void main() {
  float theta = u_angle / 180.0 * PI;
  vec2 ratio = u_aspect;
  vec2 dir = vec2(cos(theta), sin(theta)) / ratio;
  vec2 dirAdjusted = rotateVec(dir, radians(u_rotate));
  vec3 col = gamma(blur(u_steps, dirAdjusted, u_stride, u_sigma));
  gl_FragColor = vec4(col, 1.0);
}
`;