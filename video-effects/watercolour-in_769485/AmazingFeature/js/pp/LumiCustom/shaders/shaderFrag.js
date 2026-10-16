exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float bleedStrength; // = 1.1 [0.5, 1.5] // 颜色晕染强度
uniform float paperIntensity; // = 0.15 [0.0, 0.3] // 纸纹提亮强度
uniform float edgeSoftness; // = 1.2 [0.5, 2.0] // 湿边柔化力度

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

vec4 multiTapBlur(vec2 uv, vec2 step1) {
    vec4 sum = texture2D(tDiffuse, handleUVBounds(uv));
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(step1.x, 0.0)));
    sum += texture2D(tDiffuse, handleUVBounds(uv - vec2(step1.x, 0.0)));
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, step1.y)));
    sum += texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, step1.y)));
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(step1.x, step1.y)));
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(-step1.x, step1.y)));
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(step1.x, -step1.y)));
    sum += texture2D(tDiffuse, handleUVBounds(uv - vec2(step1.x, step1.y)));
    return sum / 9.0;
}

vec4 wideBlur(vec2 uv, vec2 step1) {
    vec2 stepLarge = step1 * 2.5;
    vec4 sum = texture2D(tDiffuse, handleUVBounds(uv));
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(stepLarge.x, 0.0)));
    sum += texture2D(tDiffuse, handleUVBounds(uv - vec2(stepLarge.x, 0.0)));
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, stepLarge.y)));
    sum += texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, stepLarge.y)));
    return sum / 5.0;
}

vec4 effect(vec4 texel, float progress) {
    float detail = tween(progress);
    float effectStrength = 1.0 - detail;

    float zoom = mix(1.5, 1.0, detail);
    vec2 center = vec2(0.5);
    vec2 zoomedUV = center + (vUv - center) / zoom;
    vec2 boundedUV = handleUVBounds(zoomedUV);

    vec4 baseSample = texture2D(tDiffuse, boundedUV);

    float radius = effectStrength * bleedStrength * 0.02;
    vec2 step1 = vec2(radius, radius / max(ratio, 0.0001));

    vec4 blurColor = multiTapBlur(boundedUV, step1);
    vec4 spreadColor = wideBlur(boundedUV, step1);

    float edgeAmount = clamp(dot(abs(baseSample.rgb - blurColor.rgb), vec3(0.333)) * 6.0 * edgeSoftness, 0.0, 1.0);

    vec3 bleedColor = mix(blurColor.rgb, spreadColor.rgb, clamp(effectStrength * 0.7, 0.0, 1.0));
    bleedColor = mix(vec3(dot(bleedColor, vec3(0.299, 0.587, 0.114))), bleedColor, 1.0 - 0.3 * effectStrength);
    bleedColor += edgeAmount * 0.2 * effectStrength;
    bleedColor = clamp(bleedColor, 0.0, 1.0);

    float grain = hash21(vUv * 620.0);
    float paperLift = grain * effectStrength * paperIntensity;
    vec3 wetColor = clamp(bleedColor + paperLift, 0.0, 1.0);

    vec3 finalColor = mix(wetColor, baseSample.rgb, detail);

    return vec4(finalColor, baseSample.a);
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