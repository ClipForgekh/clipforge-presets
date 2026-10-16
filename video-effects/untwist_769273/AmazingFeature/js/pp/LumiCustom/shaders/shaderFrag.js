exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float swirlStrength; // = 1.2 [0.0, 3.0] // 旋涡强度
uniform float zoomStrength; // = 0.35 [0.0, 0.8] // 缩放冲击强度
uniform float rippleStrength; // = 1.0 [0.0, 2.0] // 涟漪扰动强度
uniform float aberration; // = 0.006 [0.0, 0.03] // 色散强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getAspectDir(vec2 d) {
    vec2 a = d;
    if (ratio > 1.0) a.y /= ratio;
    else a.x *= ratio;
    return a;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;
    vec2 center = vec2(0.5);
    vec2 d = vUv - center;
    vec2 da = getAspectDir(d);
    float r = length(da);

    float swirl = strength * swirlStrength * (1.0 - smoothstep(0.0, 0.9, r)) * 2.4;
    float s = sin(swirl);
    float c = cos(swirl);
    vec2 rd = vec2(c * d.x - s * d.y, s * d.x + c * d.y);

    float scale = 1.0 + strength * zoomStrength;
    vec2 dir = normalize(da + vec2(1e-5));
    float ripple = sin(r * 26.0 - p * 10.0) * 0.0035 * strength * rippleStrength;
    vec2 uv = center + rd * scale + dir * ripple;

    float ca = strength * aberration;
    vec2 caDir = normalize(d + vec2(1e-5));
    vec2 uvR = handleUVBounds(uv + caDir * ca);
    vec2 uvG = handleUVBounds(uv);
    vec2 uvB = handleUVBounds(uv - caDir * ca);

    vec4 colR = texture2D(tDiffuse, uvR);
    vec4 colG = texture2D(tDiffuse, uvG);
    vec4 colB = texture2D(tDiffuse, uvB);

    vec3 col = vec3(colR.r, colG.g, colB.b);

    float luma = dot(col, vec3(0.299, 0.587, 0.114));
    col = mix(vec3(luma), col, p);

    float glow = 1.0 + strength * 0.22 * (1.0 - smoothstep(0.0, 1.1, r));
    col *= glow;
    col = clamp(col, 0.0, 1.0);

    float alpha = mix(0.25, 1.0, p) * colG.a;
    return vec4(col, alpha);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);

    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;

    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);

    vec4 finalColor = effectColor;

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;