exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float foldAngle; // = 85.0 [45.0, 89.0] // 初始折叠角度（度）

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float cubicInOut(float x) {
    x = clamp(x, 0.0, 1.0);
    return (x < 0.5) ? (4.0 * x * x * x) : (1.0 - pow(-2.0 * x + 2.0, 3.0) * 0.5);
}

vec4 effect(vec4 texel, float p) {
    float t = p * 2.0;

    if (t < 0.5) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    if (t >= 1.5) {
        return texel;
    }

    float a0 = radians(foldAngle);

    float uCenter = cubicInOut((t - 0.75) / (1.4 - 0.75));
    float uOuter  = cubicInOut((t - 0.88) / (1.4 - 0.88));

    float a1 = mix( a0, 0.0, uOuter);
    float a2 = mix(-a0, 0.0, uCenter);
    float a3 = mix( a0, 0.0, uCenter);
    float a4 = mix(-a0, 0.0, uOuter);

    float yawDeg = 0.0;
    float zPos = 0.0;

    if (t < 0.9) {
        float g = cubicInOut((t - 0.5) / (0.9 - 0.5));
        yawDeg = mix(-40.0, 20.0, g);
        zPos   = mix(-3.0, -0.5, g);
    } else if (t < 1.4) {
        float g = cubicInOut((t - 0.9) / (1.4 - 0.9));
        yawDeg = mix(20.0, 0.0, g);
        zPos   = mix(-0.5, 0.0, g);
    }

    float yaw = radians(yawDeg);
    float cosYaw = max(cos(yaw), 0.15);
    float scale = 10.0 / (10.0 - zPos);

    vec2 q;
    q.x = (vUv.x - 0.5) / (scale * cosYaw) + 0.5;
    q.y = (vUv.y - 0.5) / scale + 0.5;

    float w1 = 0.25 * max(cos(a1), 0.001);
    float w2 = 0.25 * max(cos(abs(a2)), 0.001);
    float w3 = 0.25 * max(cos(abs(a3)), 0.001);
    float w4 = 0.25 * max(cos(abs(a4)), 0.001);

    float l3 = 0.5;
    float r3 = l3 + w3;
    float r2 = 0.5;
    float l2 = r2 - w2;
    float r1 = l2;
    float l1 = r1 - w1;
    float l4 = r3;
    float r4 = l4 + w4;

    float srcU = -1.0;
    float shade = 1.0;

    if (q.x >= l1 && q.x <= r1) {
        float k = (q.x - l1) / max(r1 - l1, 0.0001);
        srcU = mix(0.0, 0.25, k);
        shade = 0.82 + 0.18 * cos(abs(a1));
    } else if (q.x >= l2 && q.x <= r2) {
        float k = (q.x - l2) / max(r2 - l2, 0.0001);
        srcU = mix(0.25, 0.5, k);
        shade = 0.82 + 0.18 * cos(abs(a2));
    } else if (q.x >= l3 && q.x <= r3) {
        float k = (q.x - l3) / max(r3 - l3, 0.0001);
        srcU = mix(0.5, 0.75, k);
        shade = 0.82 + 0.18 * cos(abs(a3));
    } else if (q.x >= l4 && q.x <= r4) {
        float k = (q.x - l4) / max(r4 - l4, 0.0001);
        srcU = mix(0.75, 1.0, k);
        shade = 0.82 + 0.18 * cos(abs(a4));
    } else {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    if (q.y < 0.0 || q.y > 1.0) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    vec2 srcUV = handleUVBounds(vec2(srcU, q.y));
    vec4 col = texture2D(tDiffuse, srcUV);

    return vec4(col.rgb * shade, col.a);
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