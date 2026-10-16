exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float pageCurveAmount; // = 0.25 [0.0, 0.6] // 页面的弯曲幅度
uniform float coverLiftAmount; // = 0.8 [0.2, 1.5] // 封面翻起强度

varying vec2 vUv;

const float PI = 3.14159265;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float open = progress;
    float closure = 1.0 - open;

    vec2 uv = vUv;
    float spine = 0.5;
    float side = uv.x < spine ? -1.0 : 1.0;
    float localX = clamp(abs(uv.x - spine) * 2.0, 0.0, 1.0);

    float collapsed = mix(localX * 0.08, localX, open);

    float angleBase = closure * coverLiftAmount;
    float angleMod = mix(0.35, 1.0, localX);
    float angle = angleBase * angleMod * side;

    float x3D = collapsed * 0.5;
    float cosA = cos(angle);
    float sinA = sin(angle);

    float perspectiveStrength = 1.0 + closure * 1.5;
    float zRot = x3D * sinA * perspectiveStrength;
    float perspective = 1.0 / max(0.3, 1.0 + zRot);
    float xRot = x3D * cosA;
    float newX = spine + side * xRot * perspective;

    float baseY = uv.y - 0.5;
    float yScale = mix(0.82, 1.0, open);
    float aspectComp = ratio > 1.0 ? 1.0 / ratio : ratio;
    float bend = sin(localX * PI) * pageCurveAmount * closure;
    float hingeLift = closure * coverLiftAmount * 0.06 * (side > 0.0 ? 1.0 : 0.4) * (1.0 - localX);
    float newY = 0.5 + baseY * yScale + bend * side * 0.08 * aspectComp - hingeLift;

    vec2 sampleUV = vec2(newX, newY);
    sampleUV = handleUVBounds(sampleUV);
    vec4 openColor = texture2D(tDiffuse, sampleUV);

    vec2 coverUV = vec2(0.75 + (uv.x - spine) * 0.2, clamp(uv.y, 0.0, 1.0));
    coverUV = handleUVBounds(coverUV);
    vec4 coverColor = texture2D(tDiffuse, coverUV);
    coverColor.rgb = clamp(coverColor.rgb * vec3(0.70, 0.66, 0.60), 0.0, 1.0);

    vec4 color = mix(coverColor, openColor, open);

    float coverShadow = mix(0.45 + 0.25 * (1.0 - localX), 1.0, open);
    float pageShadow = mix(0.65 + 0.20 * (1.0 - localX), 1.0, open);
    float shading = side > 0.0 ? coverShadow : pageShadow;
    color.rgb *= shading;

    float spineHighlight = smoothstep(0.30, 0.05, abs(uv.x - spine));
    float liftHighlight = closure * 0.14;
    color.rgb += liftHighlight * spineHighlight;

    color.rgb = clamp(color.rgb, 0.0, 1.0);
    color.a = texel.a;

    return color;
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