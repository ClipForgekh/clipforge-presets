exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform vec2 gridCount; // = vec2(10.0, 6.0) // 面板网格数量
uniform float maxDelay; // = 0.55 [0.0, 0.9] // 面板组装最大延迟
uniform float spread; // = 1.35 [0.2, 2.5] // 面板从四周汇聚的距离
uniform float pivotPerspective; // = 1.2 [0.2, 3.0] // 相机绕场旋转透视强度

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    if (p < 0.5) {
        return 0.5 * (1.0 - sqrt(1.0 - 4.0 * p * p));
    } else {
        float t = -2.0 * p + 2.0;
        return 0.5 * (sqrt(1.0 - t * t) + 1.0);
    }
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec4 effect(vec4 texel, float p) {
    vec2 g = max(gridCount, vec2(1.0));
    vec2 cellId = floor(vUv * g);
    vec2 cellCenter = (cellId + 0.5) / g;
    vec2 local = vUv - cellCenter;

    float rnd = hash12(cellId + 0.123);
    float angleRnd = rnd * 6.2831853;
    vec2 dir = vec2(cos(angleRnd), sin(angleRnd));

    float radial = length((cellCenter - 0.5) * vec2(ratio, 1.0)) / 0.9;
    float delay = clamp(mix(0.0, maxDelay, 0.55 * rnd + 0.45 * radial), 0.0, 0.95);

    float localP = clamp((p - delay) / max(1.0 - delay, 0.0001), 0.0, 1.0);
    localP = smoothstep(0.0, 1.0, localP);

    float camYaw = (1.0 - p) * 1.5707963;

    vec2 localAR = local;
    localAR.x *= ratio;

    float c = cos(camYaw);
    float s = sin(camYaw);

    vec3 q = vec3(localAR, 0.0);
    q = vec3(c * q.x + s * q.z, q.y, -s * q.x + c * q.z);

    float persp = 1.0 / (1.0 + abs(q.z) * pivotPerspective);
    vec2 rotatedLocal = vec2(q.x * persp, q.y * persp);
    rotatedLocal.x /= ratio;

    vec2 travel = dir * (1.0 - localP) * spread;
    vec2 sampleUV = cellCenter + rotatedLocal + travel;

    float inBounds = getHardBoundaryMask(sampleUV);
    vec2 boundedUV = handleUVBounds(sampleUV);
    vec4 col = texture2D(tDiffuse, boundedUV);

    float visible = localP * inBounds;
    return vec4(col.rgb, col.a * visible);
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